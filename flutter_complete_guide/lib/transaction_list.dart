import 'package:flutter/material.dart';

import './models/transaction.dart';
import 'transaction_cell.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransactionHandler;

  TransactionList(this.transactions, this.deleteTransactionHandler);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: transactions.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  height: 50,
                  width: 50,
                  child: Image.asset(
                    'assets/images/empty_data.png',
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'No transactions',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey.withAlpha((255 * 0.7).toInt()),
                  ),
                ),
              ],
            )
          : Container(
              child: ListView.builder(
                itemBuilder: (ctx, idx) {
                  return TransactionCell(transactions[idx], deleteTransactionHandler);
                },
                itemCount: transactions.length,
              ),
            ),
    );
  }
}
