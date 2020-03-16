import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/transaction_chart_bar.dart';
import 'package:intl/intl.dart';

import './utils/datetime_ext.dart';
import './models/transaction.dart';

class TransactionChart extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionChart(this.transactions);

  List<Map<String, Object>> get groupedTransaction {
    final now = DateTime.now();
    final dateFormatE = DateFormat.E();
    final groupAmount = <String, double>{};
    double totalAmount = 0;
    for (var item in transactions) {
      final dateString = item.date.csToString('yyyy-MM-dd');
      var total = groupAmount[dateString] ?? 0;
      total += item.amount;
      groupAmount[dateString] = total;
      totalAmount += item.amount;
    }

    return DateTimeExt.dateInWeekByDate(now).map((date) {
      final dateStr = date.csToString('yyyy-MM-dd');
      final double amount = groupAmount[dateStr] ?? 0;
      final double percent = amount == 0 ? 0 : amount / totalAmount;
      return {
        'day': dateFormatE.format(date),
        'amount': amount,
        'percent': percent,
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ...groupedTransaction.map((item) => TransactionBar(
                  (item['day'] as String),
                  (item['amount'] as double),
                  (item['percent'] as double),
                ))
          ],
        ),
      ),
    );
  }
}
