import 'package:flutter/material.dart';

import './models/transaction.dart';
import './utils/datetime_ext.dart';

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
                  color: Theme.of(context).primaryColor,
                  width: 2.0,
                ),
              ),
              child: Text(
                '\$${transaction.amount.toString()}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).primaryColor,
                  fontSize: 17,
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'Product: ${transaction.title}',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Order date: ${transaction.date.csToString('dd/MM/yyyy hh:mm')}',
                      style: TextStyle(fontSize: 13),
                    ),
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