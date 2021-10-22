import 'package:flutter/material.dart';
import 'package:mjcoffee/enums/enums.dart';

class CoffeeSize extends StatelessWidget {
  CoffeeSize({
    Key? key,
    required this.icon,
    required this.size,
    this.lessSpace = false,
    required this.onPressed,
  }) : super(key: key);

  final IconData icon;
  final CoffeeCupSize size;
  final bool lessSpace;
  final Function(CoffeeCupSize) onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        if (!lessSpace) ...[
          Text(
            "Size",
            style: TextStyle(
              color: Colors.grey.shade700,
            ),
          ),
          SizedBox(width: 50),
        ],
        IconButton(
          icon: Icon(
            icon,
            color: getColor(size == CoffeeCupSize.small),
            size: CoffeeCupSize.small.iconSize,
          ),
          onPressed: () {
            onPressed(CoffeeCupSize.small);
          },
        ),
        IconButton(
          icon: Icon(
            icon,
            color: getColor(size == CoffeeCupSize.medium),
            size: CoffeeCupSize.medium.iconSize,
          ),
          onPressed: () {
            onPressed(CoffeeCupSize.medium);
          },
        ),
        IconButton(
          icon: Icon(
            icon,
            color: getColor(size == CoffeeCupSize.large),
            size: CoffeeCupSize.large.iconSize,
          ),
          onPressed: () {
            onPressed(CoffeeCupSize.large);
          },
        ),
      ],
    );
  }

  getColor(bool isSelected) {
    return isSelected ? Colors.brown.shade800 : Colors.grey.shade400;
  }
}
