import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/transaction.dart';
import 'package:intl/intl.dart';

class TransactionCell extends StatelessWidget {
  final Transaction transaction;

  TransactionCell(this.transaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      child: Card(
        child: Row(
          children: <Widget>[
            Container(
              width: 80,
              alignment: AlignmentDirectional.center,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.purple,
                  width: 2.0,
                ),
              ),
              child: Text(
                '${transaction.amount.toString()}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.purple,
                  fontSize: 18,
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text('Product: ${transaction.title}'),
                    SizedBox(
                      height: 5,
                    ),
                    Text('Order date: ${transaction.date.csToString('dd/MM/yyyy hh:mm')}'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension DateTime_Ext on DateTime {
  String csToString(String formatString) {
    var format = DateFormat(formatString);
    return format.format(this);
  }
}