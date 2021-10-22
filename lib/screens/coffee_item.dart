import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mjcoffee/const.dart';
import 'package:mjcoffee/models/models.dart';
import 'package:mjcoffee/services/services.dart';

class CoffeeItem extends StatelessWidget {
  CoffeeItem({
    required this.animation,
    required this.coffee,
  });

  final FirestoreService _firestoreService = FirestoreService.instance;

  final Coffee coffee;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Coffee>(
      stream: _firestoreService.getCoffee(coffee.id),
      builder: (context, AsyncSnapshot<Coffee> snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
          return SizedBox();
        }

        Coffee newCoffee = coffee;

        if (snapshot.hasData) {
          newCoffee = snapshot.data!;
        }

        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: Offset(0, 0),
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.bounceIn,
              reverseCurve: Curves.bounceOut,
            ),
          ),
          child: GestureDetector(
            child: ListTile(
              contentPadding: EdgeInsets.all(15),
              title: Text(
                newCoffee.name,
                style: Theme.of(context).textTheme.headline5,
              ),
              subtitle: Text(
                newCoffee.name,
                style: Theme.of(context).textTheme.subtitle2,
              ),
              leading: Icon(
                newCoffee.iconData,
                size: 40,
                color: brown,
              ),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
            onTap: () {
              GoRouter.of(context).goNamed(
                'details',
                params: {'id': coffee.id},
              );
            },
          ),
        );
      },
    );
  }
}
