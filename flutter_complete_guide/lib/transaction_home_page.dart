import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/transaction_chart.dart';
import 'package:flutter_complete_guide/transaction_input.dart';
import 'package:uuid/uuid.dart';

import './models/transaction.dart';
import 'transaction_list.dart';
import './utils/extension.dart';

class MyHomeApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyHomeApp();
}

class _MyHomeApp extends State<MyHomeApp> {
  final _transactions = <Transaction>[];
  bool _isShowChart = false;

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

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((item) => item.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final _mQueryData = MediaQuery.of(context);
    final _isLanscape = _mQueryData.orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text('My First App'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _showAddTransactionWidget(context),
        ),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (_isLanscape)
              Container(
                margin: EdgeInsets.only(left: 15),
                child: Row(
                  children: <Widget>[
                    Text("Show Chart: "),
                    Switch(
                        value: _isShowChart,
                        onChanged: (isOn) {
                          setState(() {
                            _isShowChart = isOn;
                          });
                        })
                  ],
                ),
              ),
            if (_isShowChart || !_isLanscape)
              Container(
                margin: EdgeInsets.symmetric(horizontal: (_isLanscape) ? 10 : 5),
                height:
                    (_mQueryData.contentHeight - appBar.preferredSize.height) *
                        ((_isLanscape) ? 0.75 : 0.25),
                child: TransactionChart(_getRecentTransactionInAWeek),
              ),
            if (!_isShowChart || !_isLanscape)
              Container(
                height:
                    (_mQueryData.contentHeight - appBar.preferredSize.height) *
                        0.75,
                child: TransactionList(_transactions, _deleteTransaction),
              ),
          ],
        ),
      ),
      floatingActionButton: (_isShowChart && _isLanscape) ? null : FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showAddTransactionWidget(context),
      ),
    );
  }
}
