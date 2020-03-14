import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import './transaction.dart';
import './transaction_cell.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyApp();
}

class _MyApp extends State<StatefulWidget> {
  final transactions = <Transaction>[
    Transaction(
      id: Uuid().v1(),
      title: 'Shoes',
      amount: 15.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: Uuid().v1(),
      title: 'Bags',
      amount: 25.99,
      date: DateTime.now(),
    ),
  ];

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

            Column(children: <Widget>[
              TransactionCell(transactions[0]),
              TransactionCell(transactions[1]),
            ],)
          ],
        ),
      ),
    );
  }
}
