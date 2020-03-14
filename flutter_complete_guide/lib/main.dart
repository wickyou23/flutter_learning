import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/transaction_list.dart';
import 'package:uuid/uuid.dart';

import 'transaction.dart';
import 'transaction_input.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyApp();
}

class _MyApp extends State<StatefulWidget> {
  final _transactions = <Transaction>[
    Transaction(
      id: Uuid().v1(),
      title: 'Shoes',
      amount: 15.99,
      date: DateTime.now(),
    ),
  ];

  void _addTransaction(String productName, double amount) {
    final newTransaction = Transaction(
      id: Uuid().v1(),
      title: productName,
      amount: amount,
      date: DateTime.now(),
    );

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My First App'),
        ),
        body: Column(
          children: <Widget>[
            Card(
              child: Text('Chart here'),
            ),
            TransactionInput(
              addActionHandler: _addTransaction,
            ),
            TransactionList(_transactions),
          ],
        ),
      ),
    );
  }
}
