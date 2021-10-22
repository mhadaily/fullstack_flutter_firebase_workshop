import 'package:flutter/material.dart';

import '../../const.dart';

class TotalAmount extends StatelessWidget {
  const TotalAmount({
    Key? key,
    required this.cartTotal,
  }) : super(key: key);

  final num cartTotal;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: brown),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'total:',
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              '\$${cartTotal.toString()}',
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
    );
  }
}
