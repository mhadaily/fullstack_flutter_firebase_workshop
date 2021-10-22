import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mjcoffee/enums/enums.dart';
import 'package:mjcoffee/models/models.dart';

import '../../const.dart';

class FirestoreService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // Singleton setup: prevents multiple instances of this class.
  FirestoreService._();
  static final FirestoreService _service = FirestoreService._();
  factory FirestoreService() => _service;

  static FirestoreService get instance => _service;

  Future<void> registerUserToken({
    required String token,
    required String userId,
  }) async {
    final path = ApiPath.userTokens(userId);
    final DocumentReference doc =
        _firebaseFirestore.collection(path).doc(token);
    doc.set(
      {
        'token': token,
        'platform': Platform.operatingSystem,
        'created': FieldValue.serverTimestamp(),
      },
    );
  }

  Future<void> deleteUserToken({
    required String token,
    required String userId,
  }) async {
    final path = ApiPath.userToken(userId, token);

    final DocumentReference doc = _firebaseFirestore.doc(path);

    doc.delete();
  }

  Future<void> deleteUserCartItem({
    required String userId,
    required String cartId,
  }) async {
    final path = ApiPath.userCartItem(userId, cartId);
    final DocumentReference document = _firebaseFirestore.doc(path);
    await document.delete();
  }

  Stream<List<CartItem>> getUserCart(String userId) {
    final path = ApiPath.userCart(userId);
    final CollectionReference collection = _firebaseFirestore.collection(path);

    return collection.snapshots().map(
          (QuerySnapshot event) => event.docs.map(
            (snapshot) {
              final Map<String, dynamic> data =
                  snapshot.data()! as Map<String, dynamic>;
              data['id'] = snapshot.id;
              return CartItem.fromJson(data);
            },
          ).toList(),
        );
  }

  Future<void> addLog({
    required Activity activity,
    required String userId,
  }) async {
    final String path = ApiPath.logs;
    final CollectionReference collection = _firebaseFirestore.collection(path);

    final log = UserLog(
      activity: activity,
      created: DateTime.now(),
      userId: userId,
    );

    await collection.add(log.toJson());
  }

  Future<void> addToUserCart(String userId, CartItem cartItem) async {
    final String path = ApiPath.userCart(userId);
    final CollectionReference collection = _firebaseFirestore.collection(path);

    await collection.add(cartItem.toJson());
  }

  Stream<List<Coffee>> getCoffees() {
    final String path = ApiPath.coffees;
    final CollectionReference collection = _firebaseFirestore.collection(path);

    return collection.snapshots().map<List<Coffee>>(
          (event) => event.docs.map<Coffee>(
            (snapshot) {
              final Map<String, dynamic> data =
                  snapshot.data()! as Map<String, dynamic>;
              data['id'] = snapshot.id;
              return Coffee.fromJson(data);
            },
          ).toList(),
        );
  }

  Stream<Coffee> getCoffee(String id) {
    final String path = ApiPath.coffee(id);
    final Stream<DocumentSnapshot> snapshots =
        _firebaseFirestore.doc(path).snapshots();

    return snapshots.map(
      (DocumentSnapshot snapshot) {
        final Map<String, dynamic> data =
            snapshot.data()! as Map<String, dynamic>;

        data['id'] = snapshot.id;

        return Coffee.fromJson(data);
      },
    );
  }

  Future<FirestoreUser> getUser(String userId) async {
    final String path = ApiPath.user(userId);
    final DocumentSnapshot document = await _firebaseFirestore.doc(path).get();

    final Map<String, dynamic> json = document.data()! as Map<String, dynamic>;

    return FirestoreUser.fromJson(json);
  }

  Future<void> setUserLastLoginTimestamp(String userId) async {
    try {
      final String path = ApiPath.user(userId);
      final DocumentReference document = _firebaseFirestore.doc(path);

      // If no document exists yet, the update will fail.
      // await document.update({
      //   'lastLogin': FieldValue.serverTimestamp(),
      // });

      /// If no document exists yet, it will be created!.
      await document.set(
        {
          'lastLogin': FieldValue.serverTimestamp(),
        },
        SetOptions(merge: true),
      );
    } catch (e) {
      print('Create User Error!');
      // log in error reporting system like crashlytics
      // Handle errors gracefully as we did in module 3
    }
  }

  Future<void> setUserRoles(String userId, List<UserRole> roles) async {
    try {
      final String path = ApiPath.user(userId);
      final DocumentReference document = _firebaseFirestore.doc(path);
      await document.set(
        {
          'roles': roles.map((role) => role.name).toList(),
        },
        SetOptions(merge: true),
      );
    } catch (e) {
      print('Create User Error!');
      // log in error reporting system like crashlytics
      // Handle errors gracefully as we did in module 3
    }
  }

  Future<void> createUser(String uid, List<UserRole> roles) async {
    try {
      final String path = ApiPath.users;
      final CollectionReference collection =
          _firebaseFirestore.collection(path);

      final DocumentSnapshot document = await collection.doc(uid).get();

      // do not overwrite data if user exists
      if (!document.exists) {
        // Returns a `DocumentReference` with the provided path.
        // If no [path] is provided, an auto-generated ID is used.
        final DocumentReference newDocument = collection.doc(uid);

        // Sets data on the document, overwriting any existing data. If the document
        // does not yet exist, it will be created.
        await newDocument.set(
          {
            'roles': roles.map((role) => role.name).toList(),
          },
          SetOptions(merge: true),
        );
      }
    } catch (e) {
      print('Create User Error!');
      // log in error reporting system like crashlytics
    }
  }

  Stream<List<Order>> getUserOrders(String userId) {
    final String path = ApiPath.orders;
    final Query query = _firebaseFirestore
        .collection(path)
        .where('userId', isEqualTo: userId)
        .orderBy('updated', descending: true);

    return query.snapshots().map(
      (QuerySnapshot querySnapshot) {
        return querySnapshot.docs.map(
          (QueryDocumentSnapshot snapshot) {
            final Map<String, dynamic> data =
                snapshot.data()! as Map<String, dynamic>;

            data['id'] = snapshot.id;

            return Order.fromJson(data);
          },
        ).toList();
      },
    );
  }

  Future<String> submitOrder(String uid, List<CartItem> cartItems) async {
    final String ordersPath = ApiPath.orders;
    final CollectionReference orderCollection =
        _firebaseFirestore.collection(ordersPath);
    final order = Order(
      items: cartItems,
      userId: uid,
      status: OrderStatus.pending,
      created: DateTime.now(),
      updated: DateTime.now(),
    );
    // place an order
    final DocumentReference orderCreated =
        await orderCollection.add(order.toJson());
    // clear user cart
    final String userCartPath = ApiPath.userCart(uid);
    final CollectionReference cartCollection =
        _firebaseFirestore.collection(userCartPath);

    for (CartItem item in cartItems) {
      await cartCollection.doc(item.id).delete();
    }
    return orderCreated.id;
  }
}
