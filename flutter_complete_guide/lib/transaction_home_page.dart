import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/transaction_input.dart';
import 'package:uuid/uuid.dart';

import 'transaction.dart';
import 'transaction_list.dart';

class MyHomeApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyHomeApp();
}

class _MyHomeApp extends State<MyHomeApp> {
  final _transactions = <Transaction>[
    // Transaction(
    //   id: Uuid().v1(),
    //   title: 'Shoes',
    //   amount: 15.99,
    //   date: DateTime.now(),
    // ),
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
          Card(
            child: Text('Chart here'),
          ),
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
