import 'package:flutter/material.dart';
import 'package:mjcoffee/services/services.dart';

import '../models/models.dart';
import 'coffee_item.dart';

class MenuList extends StatefulWidget {
  static String routeName = 'MenuList';

  @override
  _MenuListState createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  final FirestoreService _firestoreService = FirestoreService.instance;
  List<Coffee> _items = [];

  @override
  void initState() {
    super.initState();

    _loadItems();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: listKey,
      initialItemCount: _items.length,
      itemBuilder: (context, index, Animation<double> animation) {
        return CoffeeItem(
          coffee: _items[index],
          animation: animation,
        );
      },
    );
  }

  Future<void> _loadItems() async {
    final coffees = await _firestoreService.getCoffees().first;

    for (Coffee item in coffees) {
      await Future.delayed(Duration(milliseconds: 80));
      _items.add(item);
      if (listKey.currentState != null) {
        listKey.currentState!.insertItem(_items.length - 1);
      }
    }
  }
}
