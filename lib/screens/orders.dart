import 'package:flutter/material.dart';
import 'package:mjcoffee/enums/enums.dart';
import 'package:mjcoffee/models/models.dart';
import 'package:mjcoffee/services/services.dart';
import 'package:mjcoffee/widgets/widgets.dart';

import '../const.dart';

class OrdersScreen extends StatelessWidget {
  static String routeName = 'Orders';

  final FirestoreService _firestoreService = FirestoreService.instance;
  final AuthService _authService = AuthService.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Order>>(
      stream: _firestoreService.getUserOrders(_authService.currentUser!.uid),
      builder: (context, AsyncSnapshot<List<Order>> snapshot) {
        if (snapshot.hasError) {
          return NoItems(title: 'No Orders!');
        }
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            final orders = snapshot.data!;

            if (orders.isEmpty) {
              return NoItems(title: 'No Orders!');
            }
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];

                return ExpansionTile(
                  tilePadding: EdgeInsets.all(15),
                  leading: Icon(order.status.iconData, color: brown),
                  title: Text(
                    order.status.name.toUpperCase(),
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Order Id: ${order.id ?? ''}'),
                      Text('Updated: ${order.updated}'),
                    ],
                  ),
                  expandedAlignment: Alignment.centerLeft,
                  childrenPadding: const EdgeInsets.all(15),
                  initiallyExpanded: false,
                  children: [
                    ...order.items
                        .map(
                          (item) => CoffeeCartExtraInfo(item: item),
                        )
                        .toList(),
                    TotalAmount(cartTotal: order.total),
                  ],
                );
              },
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
