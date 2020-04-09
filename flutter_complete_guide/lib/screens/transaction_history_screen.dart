import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/bloc/transaction/transaction_bloc.dart';
import 'package:flutter_complete_guide/bloc/transaction/transaction_state.dart';
import 'package:flutter_complete_guide/models/transaction.dart';
import 'package:flutter_complete_guide/screens/left_menu_drawer.dart';
import 'package:flutter_complete_guide/utils/extension.dart';

class TransactionHistory extends StatefulWidget {
  @override
  _TransactionHistoryState createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction History'),
      ),
      drawer: Drawer(
        child: LeftMenuDrawerState(),
      ),
      body: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (ctx, state) {
          if (state is TransactionReadyState) {
            if (state.transactionHistory.isEmpty) {
              return Center(
                child: Text('Transaction is empty'),
              );
            } else {
              return ListView.builder(
                itemCount: state.transactionHistory.length,
                itemBuilder: (ctx, index) {
                  Transaction item = state.transactionHistory[index];
                  return ListTile(
                    title: Text('Payment'),
                    subtitle: Text(
                      item.createDate.csToString('dd-MM-yyyy HH:mm a'),
                    ),
                    trailing: Text('\$${item.totalMoney.toStringAsFixed(2)}'),
                  );
                },
              );
            }
          } else {
            return Center(
              child: Text('Transaction is empty'),
            );
          }
        },
      ),
    );
  }
}
