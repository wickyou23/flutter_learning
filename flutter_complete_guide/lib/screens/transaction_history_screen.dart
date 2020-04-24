import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/bloc/transaction/transaction_bloc.dart';
import 'package:flutter_complete_guide/bloc/transaction/transaction_event.dart';
import 'package:flutter_complete_guide/bloc/transaction/transaction_state.dart';
import 'package:flutter_complete_guide/models/transaction.dart';
import 'package:flutter_complete_guide/screens/left_menu_drawer.dart';
import 'package:flutter_complete_guide/utils/extension.dart';
import 'package:flutter_complete_guide/widgets/transaction_cell.dart';

class TransactionHistoryScreen extends StatefulWidget {
  @override
  _TransactionHistoryScreenState createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  GlobalKey<RefreshIndicatorState> _refreshStateKey =
      GlobalKey<RefreshIndicatorState>();
  Completer<void> _completer;
  List<Transaction> _transactionHistory = [];
  bool _isFristLoadingTransaction = true;

  @override
  void initState() {
    super.initState();
    _completer = Completer<void>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshStateKey.currentState.show();
      _isFristLoadingTransaction = true;
      context.bloc<TransactionBloc>().add(GetAllTransactionEvent());
    });
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
        child: BlocConsumer<TransactionBloc, TransactionState>(
          listener: (_, state) {
            if (state is TransactionReadyState) {
              _completer.complete();
              _completer = Completer<void>();
              _isFristLoadingTransaction = false;
            }
          },
          buildWhen: (_, cur) {
            return (cur is TransactionReadyState);
          },
          builder: (_, state) {
            if (state is TransactionReadyState) {
              _transactionHistory = state.transactionHistory;
            }

            return RefreshIndicator(
              key: _refreshStateKey,
              child: _transactionHistory.isEmpty
                  ? Center(
                      child: _isFristLoadingTransaction
                          ? Container()
                          : Text(
                              'Transaction is empty',
                              style: context.theme.textTheme.title.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 16.0,
                      ),
                      itemCount: _transactionHistory.length,
                      itemBuilder: (ctx, index) {
                        Transaction item = _transactionHistory[index];
                        return TransactionCell(
                          transaction: item,
                        );
                      },
                    ),
              onRefresh: () async {
                context.bloc<TransactionBloc>().add(GetAllTransactionEvent());
                return _completer.future;
              },
            );
          },
        ),
      ),
    );
  }
}
