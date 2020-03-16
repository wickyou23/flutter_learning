import 'package:flutter/material.dart';

class TransactionBar extends StatelessWidget {
  final String weekDay;
  final double amount;
  final double percent;

  TransactionBar(this.weekDay, this.amount, this.percent);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('\$${this.amount.toStringAsFixed(2)}'),
        SizedBox(
          height: 5,
        ),
        ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          child: Container(
            width: 10,
            height: 60,
            color: Colors.grey.withAlpha((255 * 0.4).toInt()),
            child: FractionallySizedBox(
              heightFactor: percent,
              child: Container(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(this.weekDay),
      ],
    );
  }
}
