import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mjcoffee/enums/enums.dart';
import 'package:mjcoffee/helpers/helpers.dart';
import 'package:mjcoffee/models/models.dart';
import 'package:mjcoffee/services/services.dart';
import 'package:mjcoffee/widgets/widgets.dart';

import '../const.dart';

class MenuDetails extends StatefulWidget {
  const MenuDetails({
    required this.id,
  });

  final String id;

  @override
  _MenuDetailsState createState() => _MenuDetailsState();
}

class _MenuDetailsState extends State<MenuDetails> {
  final FirestoreService _firestoreService = FirestoreService.instance;
  final AuthService _authService = AuthService.instance;
  final AnalyticsService _analyticsService = AnalyticsService.instance;

  int quantity = 1;
  CoffeeCupSize size = CoffeeCupSize.medium;
  CoffeeSugarCube sugar = CoffeeSugarCube.no;
  List<CoffeeAddition> additions = [CoffeeAddition.cake];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Coffee>(
      stream: _firestoreService.getCoffee(widget.id),
      builder: (context, AsyncSnapshot<Coffee> snapshot) {
        if (snapshot.hasError) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasData) {
          final Coffee coffee = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: Text(coffee.name),
            ),
            body: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 4,
                  color: lightBrown,
                  child: Icon(
                    coffee.iconData,
                    size: 120,
                    color: brown,
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 20,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CoffeeCount(
                          price: coffee.price,
                          notifyValue: (int count) {
                            setState(() {
                              quantity = count;
                            });
                          },
                        ),
                        Divider(height: 3),
                        CoffeeSize(
                          onPressed: (CoffeeCupSize cupSize) {
                            setState(() {
                              size = cupSize;
                            });
                          },
                          size: size,
                          icon: coffee.iconData,
                        ),
                        Divider(height: 3),
                        CoffeeSugar(
                          sugar: sugar,
                          onPressed: (CoffeeSugarCube sugarSize) {
                            setState(() {
                              sugar = sugarSize;
                            });
                          },
                        ),
                        Divider(height: 3),
                        CoffeeAdditions(
                          additions: additions,
                          onPressed: (List<CoffeeAddition> coffeeAdditions) {
                            setState(() {
                              additions = coffeeAdditions;
                            });
                          },
                        ),
                        Divider(height: 3),
                        TotalAmount(cartTotal: total(coffee.price)),
                        CommonButton(
                          onPressed: () async {
                            ScaffoldMessenger.of(context).showSnackBar(
                              loadingSnackBar(
                                text: "Adding to Cart...",
                              ),
                            );

                            await _firestoreService.addToUserCart(
                              _authService.currentUser!.uid,
                              CartItem(
                                coffee: coffee,
                                size: size,
                                sugar: sugar,
                                quantity: quantity,
                                additions: additions,
                              ),
                            );

                            await _analyticsService.logAddToCart(
                              itemId: coffee.id,
                              itemName: coffee.name,
                              itemCategory: 'Coffees',
                              quantity: quantity,
                            );

                            ScaffoldMessenger.of(context).hideCurrentSnackBar();

                            final snackBar = SnackBar(
                              backgroundColor: Colors.green,
                              content: Text('Added to cart!'),
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);

                            GoRouter.of(context).pushNamed('menu');
                          },
                          text: 'Add to cart',
                          highlighColor: true,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  num total(price) {
    return getCartItemTotal(
      count: quantity,
      price: price,
      additions: additions.length,
      size: size.index,
      sugar: sugar.index,
    );
  }
}
