import 'package:flutter/material.dart';

class CoffeeCount extends StatefulWidget {
  CoffeeCount({
    Key? key,
    this.price,
    this.notifyValue,
  }) : super(key: key);

  final num? price;
  final Function(int)? notifyValue;

  @override
  _CoffeeCountState createState() => _CoffeeCountState();
}

class _CoffeeCountState extends State<CoffeeCount> {
  int count = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        OutlinedButton(
          onPressed: () {
            if (count > 1) {
              setState(() {
                count = count - 1;
              });
            }
            widget.notifyValue!(count);
          },
          child: Icon(Icons.remove),
          style: ButtonStyle(
            side: MaterialStateProperty.all<BorderSide>(
              BorderSide(color: Colors.grey.shade600),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 20),
        Text(
          "$count",
          style: TextStyle(
            color: Colors.brown.shade800,
            fontSize: 26,
          ),
        ),
        SizedBox(width: 20),
        OutlinedButton(
          onPressed: () {
            setState(() {
              count = count + 1;
            });
            widget.notifyValue!(count);
          },
          child: Icon(Icons.add),
          style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.all(0)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            ),
            side: MaterialStateProperty.all<BorderSide>(
              BorderSide(
                color: Colors.grey.shade600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
