import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_complete_guide/models/transaction.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

class TransactionReadyState extends TransactionState {
  final List<Transaction> transactionHistory;

  TransactionReadyState({@required this.transactionHistory});

  @override
  List<Object> get props => [transactionHistory];

  @override
  String toString() =>
      'TransactionReadyState { transaction $transactionHistory }';
}

class AddNewTransactionSuccessState extends TransactionState {}