import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mjcoffee/helpers/helpers.dart';

import 'cart_item.dart';
import '../../enums/enums.dart';
part 'order.g.dart';

@JsonSerializable(explicitToJson: true)
class Order {
  const Order({
    required this.items,
    this.id,
    required this.status,
    required this.userId,
    required this.created,
    required this.updated,
  });

  final List<CartItem> items;

  final OrderStatus status;
  // order id
  final String? id;
  // user id
  final String userId;

  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  final DateTime created;

  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  final DateTime updated;

  bool get isReady => status == OrderStatus.ready;

  num get total => items
      .map(
        (item) => getCartItemTotal(
          count: item.quantity,
          price: item.coffee.price,
          additions: item.additions.length,
          size: item.size.index,
          sugar: item.sugar.index,
        ),
      )
      .reduce((value, element) => value + element);

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);

  static DateTime _fromJson(Timestamp timestamp) => timestamp.toDate();
  static FieldValue _toJson(DateTime time) => FieldValue.serverTimestamp();
}
