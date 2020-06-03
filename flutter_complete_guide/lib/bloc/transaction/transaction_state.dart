import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_complete_guide/data/network_common.dart';
import 'package:flutter_complete_guide/data/network_response_state.dart';
import 'package:flutter_complete_guide/models/transaction.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

class TransactionInitializeState extends TransactionState {}

class TransactionLoadingState extends TransactionState {}

class TransactionGetFailedState extends TransactionState {
  final ResponseFailedState responseFailed;

  TransactionGetFailedState({@required this.responseFailed});

  @override
  List<Object> get props => [responseFailed];

  @override
  String toString() =>
      'TransactionGetFailedState { transaction failed $responseFailed }';
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

// Add Transaction State

class AddingNewTransactionState extends TransactionState {}

class AddNewTransactionSuccessState extends TransactionState {}

class AddNewTransactionFailedState extends TransactionState {
  final ResponseFailedState failedState;

  AddNewTransactionFailedState({this.failedState});

  @override
  List<Object> get props => [failedState];

  @override
  String toString() =>
      'AddNewTransactionFailedState { transaction failed $failedState }';
}