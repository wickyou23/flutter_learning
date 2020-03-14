import 'package:flutter/material.dart';

import 'transaction.dart';
import 'transaction_cell.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: ListView.builder(
          itemBuilder: (ctx, idx) {
            return TransactionCell(transactions[idx]);
          },
          itemCount: transactions.length,
        ),
      ),
    );
  }
}
