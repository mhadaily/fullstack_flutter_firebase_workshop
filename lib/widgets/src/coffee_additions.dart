import 'package:flutter/material.dart';
import 'package:mjcoffee/enums/enums.dart';

class CoffeeAdditions extends StatelessWidget {
  CoffeeAdditions({
    Key? key,
    required this.additions,
    required this.onPressed,
    this.lessSpace = false,
  }) : super(key: key);

  final List<CoffeeAddition> additions;
  final bool lessSpace;
  final Function(List<CoffeeAddition>) onPressed;

  get hasCake {
    return additions.contains(CoffeeAddition.cake);
  }

  get hasIceCream {
    return additions.contains(CoffeeAddition.icecream);
  }

  get hasCheese {
    return additions.contains(CoffeeAddition.cheese);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        if (!lessSpace) ...[
          Text(
            "Additions",
            style: TextStyle(
              color: Colors.grey.shade700,
            ),
          ),
          SizedBox(width: 14),
        ],
        IconButton(
          icon: Icon(
            CoffeeAddition.cake.iconData,
            color: getColor(hasCake),
          ),
          onPressed: () {
            toggle(hasCake, CoffeeAddition.cake);
          },
        ),
        IconButton(
          icon: Icon(
            CoffeeAddition.icecream.iconData,
            color: getColor(additions.contains(CoffeeAddition.icecream)),
          ),
          onPressed: () {
            toggle(hasIceCream, CoffeeAddition.icecream);
          },
        ),
        IconButton(
          icon: Icon(
            CoffeeAddition.cheese.iconData,
            color: getColor(additions.contains(CoffeeAddition.cheese)),
          ),
          onPressed: () {
            toggle(hasCheese, CoffeeAddition.cheese);
          },
        ),
      ],
    );
  }

  getColor(bool isSelected) {
    return isSelected ? Colors.brown.shade800 : Colors.grey.shade400;
  }

  toggle(bool selected, CoffeeAddition addition) {
    if (selected) {
      final newList = additions.where((item) => item != addition).toList();
      onPressed(newList);
    } else {
      final newList = [...additions, addition];
      onPressed(newList);
    }
  }
}
