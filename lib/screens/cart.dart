import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mjcoffee/models/models.dart';
import 'package:mjcoffee/services/services.dart';
import 'package:mjcoffee/widgets/widgets.dart';

class CartScreen extends StatelessWidget {
  static String routeName = 'Shops';

  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  final FirestoreService _firestoreService = FirestoreService.instance;
  final AuthService _authService = AuthService.instance;
  final AnalyticsService _analyticsService = AnalyticsService.instance;
  final InAppMessagingService _fipm = InAppMessagingService.instance;

  @override
  Widget build(BuildContext context) {
    final String userId = _authService.currentUser!.uid;

    return StreamBuilder<List<CartItem>>(
      stream: _firestoreService.getUserCart(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return NoItems();
          }

          if (snapshot.hasData) {
            print('cartScreen');
            print(snapshot.data);
            final List<CartItem> items = snapshot.data ?? [];
            if (items.isEmpty) {
              return NoItems();
            }

            final num cartTotal = items
                .map((item) => item.total)
                .reduce((value, element) => value + element);

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                children: [
                  Expanded(
                    child: AnimatedList(
                      key: listKey,
                      initialItemCount: items.length,
                      itemBuilder: (
                        context,
                        index,
                        Animation<double> animation,
                      ) {
                        final CartItem item = items[index];

                        return Dismissible(
                          key: Key(item.id ?? '$index'),
                          background: Container(color: Colors.red[700]),
                          onDismissed: (direction) {
                            if (items.length == 1) {
                              _fipm.triggerEvent('remove_and_empty_basket');
                            }
                            // _analyticsService.logRemoveItem(
                            //   itemId: item.coffee.id,
                            //   itemName: item.coffee.name,
                            // );
                            _firestoreService.deleteUserCartItem(
                              userId: userId,
                              cartId: item.id!,
                            );
                            listKey.currentState!.removeItem(
                              index,
                              (context, animation) => SizedBox(),
                            );
                          },
                          direction: DismissDirection.endToStart,
                          child: TextButton(
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                const EdgeInsets.all(8.0),
                              ),
                            ),
                            onPressed: () {},
                            child: ListTile(
                              title: Text(item.coffee.name),
                              leading: Text('${item.quantity}  x'),
                              trailing: Text('\$${item.total.toString()}'),
                              subtitle: CoffeeCartExtraInfo(item: item),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  TotalAmount(cartTotal: cartTotal),
                  SizedBox(height: 20),
                  CommonButton(
                    text: 'Send Order',
                    highlighColor: true,
                    onPressed: () async {
                      final String orderId =
                          await _firestoreService.submitOrder(userId, items);

                      await _analyticsService.logPlaceOrder(
                        orderId: orderId,
                        coffees: items.map((item) => item.id).toList(),
                        total: cartTotal,
                        quantity: items.length,
                      );

                      GoRouter.of(context).goNamed('menu');
                    },
                  ),
                ],
              ),
            );
          }
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
