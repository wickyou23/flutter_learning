import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/transaction_chart.dart';
import 'package:flutter_complete_guide/transaction_input.dart';
import 'package:flutter_complete_guide/utils/datetime_ext.dart';
import 'package:uuid/uuid.dart';

import './models/transaction.dart';
import 'transaction_list.dart';

class MyHomeApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyHomeApp();
}

class _MyHomeApp extends State<MyHomeApp> {
  final _transactions = <Transaction>[];

  void _addTransaction(String productName, double amount, DateTime dateTime) {
    final newTransaction = Transaction(
      id: Uuid().v1(),
      title: productName,
      amount: amount,
      date: dateTime,
    );

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  void _showAddTransactionWidget(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: TransactionInput(addActionHandler: _addTransaction),
        );
      },
    );
  }

  List<Transaction> get _getRecentTransactionInAWeek {
    final dateInWeek = DateTimeExt.dateInWeekByDate(DateTime.now());
    final now = DateTime.now().millisecondsSinceEpoch;
    return _transactions.where((item) {
      final milliSecond = item.date.millisecondsSinceEpoch;
      return (milliSecond >= dateInWeek.first.millisecondsSinceEpoch &&
          milliSecond <= now);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My First App'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showAddTransactionWidget(context),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          TransactionChart(_getRecentTransactionInAWeek),
          TransactionList(_transactions),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showAddTransactionWidget(context),
      ),
    );
  }
}
