import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'models/models.dart';

final Color darkBrown = Color(0xFFA26E47);
final Color lightBrown = Color(0xFFF9E8D4);
final Color brown = Color(0xFF9C5700);
final Color facebookColor = Color(0xFF4867AA);

class ApiPath {
  static String get coffees => 'Coffees';
  static String coffee(String id) => 'Coffees/$id';
  static String get users => 'Users';
  static String user(String uid) => 'Users/$uid';
  static String userCart(String uid) => 'Users/$uid/Cart';
  static String userCartItem(String uid, String cid) => 'Users/$uid/Cart/$cid';
  static String get orders => 'Orders';
  static String get logs => 'Logs';
  static String userTokens(String uid) => 'Users/$uid/Tokens';
  static String userToken(String uid, String tokenId) =>
      'Users/$uid/Tokens/$tokenId';
}

final List<Coffee> coffees = [
  Coffee(
      id: '1',
      icon: FontAwesomeIcons.coffee.codePoint,
      name: "Espresso ",
      price: 8),
  Coffee(
      id: '1',
      icon: FontAwesomeIcons.mugHot.codePoint,
      name: "Cappuccino",
      price: 10),
  Coffee(
      id: '1',
      icon: FontAwesomeIcons.cocktail.codePoint,
      name: "Mocha",
      price: 12),
  Coffee(
      id: '1',
      icon: FontAwesomeIcons.beer.codePoint,
      name: "Americano",
      price: 7),
  Coffee(
    id: '1',
    icon: FontAwesomeIcons.cocktail.codePoint,
    name: "Italian Macchiato",
    price: 5,
  ),
  Coffee(
      id: '1',
      icon: FontAwesomeIcons.coffee.codePoint,
      name: "Flat White",
      price: 3),
  Coffee(
    id: '1',
    icon: FontAwesomeIcons.mugHot.codePoint,
    name: "American Affogato",
    price: 11,
  ),
  Coffee(
      id: '1',
      icon: FontAwesomeIcons.coffee.codePoint,
      name: "Long Black",
      price: 4),
  Coffee(
      id: '1',
      icon: FontAwesomeIcons.mugHot.codePoint,
      name: "Latte",
      price: 12),
  Coffee(
    id: '1',
    icon: FontAwesomeIcons.cocktail.codePoint,
    name: "American Espresso",
    price: 9,
  ),
  Coffee(
      id: '1',
      icon: FontAwesomeIcons.beer.codePoint,
      name: "CAFÈ AU LAIT.",
      price: 10),
  Coffee(
      id: '1',
      icon: FontAwesomeIcons.coffee.codePoint,
      name: "AFFÈ MOCHA.",
      price: 12),
  Coffee(
      id: '1',
      icon: FontAwesomeIcons.beer.codePoint,
      name: "Americano",
      price: 7),
  Coffee(
    id: '1',
    icon: FontAwesomeIcons.cocktail.codePoint,
    name: "Double Exspersso",
    price: 5,
  ),
];
