import 'package:flutter/material.dart';

import './models/transaction.dart';
import './utils/extension.dart';

class TransactionCell extends StatelessWidget {
  final Transaction transaction;
  final Function deleteTransactionHandler;

  TransactionCell(this.transaction, this.deleteTransactionHandler);

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
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 1.0,
                ),
              ),
              child: Container(
                padding: EdgeInsets.all(4),
                child: FittedBox(
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
            IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: () => deleteTransactionHandler(transaction.id),
            )
          ],
        ),
      ),
    );
  }
}
