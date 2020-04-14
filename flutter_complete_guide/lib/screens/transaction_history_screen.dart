import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/bloc/transaction/transaction_bloc.dart';
import 'package:flutter_complete_guide/bloc/transaction/transaction_state.dart';
import 'package:flutter_complete_guide/models/transaction.dart';
import 'package:flutter_complete_guide/screens/left_menu_drawer.dart';
import 'package:flutter_complete_guide/utils/extension.dart';
import 'package:flutter_complete_guide/widgets/transaction_cell.dart';

class TransactionHistoryScreen extends StatefulWidget {
  @override
  _TransactionHistoryScreenState createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Transaction History',
          style: context.theme.textTheme.title.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      drawer: Drawer(
        child: LeftMenuDrawer(),
      ),
      body: Container(
        color: Colors.grey.withPercentAlpha(0.1),
        child: BlocBuilder<TransactionBloc, TransactionState>(
          builder: (ctx, state) {
            if (state is TransactionReadyState) {
              if (state.transactionHistory.isEmpty) {
                return Center(
                  child: Text(
                    'Transaction is empty',
                    style: context.theme.textTheme.title.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              } else {
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 16.0,
                  ),
                  itemCount: state.transactionHistory.length,
                  itemBuilder: (ctx, index) {
                    Transaction item = state.transactionHistory[index];
                    return TransactionCell(
                      transaction: item,
                    );
                  },
                );
              }
            } else {
              return Center(
                child: Text(
                  'Transaction is empty',
                  style: context.theme.textTheme.title.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
