import 'package:flutter/material.dart';

class TransactionBar extends StatelessWidget {
  final String weekDay;
  final double amount;
  final double percent;

  TransactionBar(this.weekDay, this.amount, this.percent);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraint) {
        return Column(
          children: <Widget>[
            Container(
              height: constraint.maxHeight * 0.15,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  '\$${this.amount.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
            SizedBox(
              height: constraint.maxHeight * 0.05,
            ),
            ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              child: Container(
                width: 10,
                height: constraint.maxHeight * 0.6,
                color: Colors.grey.withAlpha((255 * 0.4).toInt()),
                child: FractionallySizedBox(
                  alignment: AlignmentDirectional.bottomEnd,
                  heightFactor: percent,
                  child: Container(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: constraint.maxHeight * 0.05,
            ),
            Container(
              height: constraint.maxHeight * 0.15,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(this.weekDay),
              ),
            ),
          ],
        );
      },
    );
  }
}
