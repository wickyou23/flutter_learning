import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/bloc/cart/cart_bloc.dart';
import 'package:flutter_complete_guide/bloc/cart/cart_event.dart';
import 'package:flutter_complete_guide/data/middleware/transaction_middleware.dart';
import 'package:flutter_complete_guide/data/network_common.dart';
import 'package:flutter_complete_guide/data/repository/transaction_repository.dart';
import 'package:flutter_complete_guide/bloc/transaction/transaction_event.dart';
import 'package:flutter_complete_guide/bloc/transaction/transaction_state.dart';
import 'package:flutter_complete_guide/models/transaction.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepository repository;
  final CartBloc cartBloc;

  TransactionBloc({
    @required this.repository,
    this.cartBloc,
  });

  @override
  TransactionState get initialState => TransactionInitializeState();

  @override
  Stream<TransactionState> mapEventToState(TransactionEvent event) async* {
    if (event is AddNewTransactionEvent) {
      yield* _mapToAddNewTransacionEvent(event);
    } else if (event is GetAllTransactionEvent) {
      yield* _mapToGetAllTransacionEvent();
    }
  }

  Stream<TransactionState> _mapToAddNewTransacionEvent(
      AddNewTransactionEvent event) async* {
    // Used to save to db or local memory
    // repository.addNewTransaction(event.cart);
    yield AddingNewTransactionState();
    var resp = await TransactionMiddleware().addNewTransaction(event.cart);
    if (resp is ResponseSuccessState<Transaction>) {
      yield AddNewTransactionSuccessState();
      cartBloc.add(ClearCardEvent());
    } else if (resp is ResponseFailedState) {
      yield AddNewTransactionFailedState(failedState: resp);
      yield TransactionInitializeState();
    }
  }

  Stream<TransactionState> _mapToGetAllTransacionEvent() async* {
    yield TransactionLoadingState();
    var resp = await TransactionMiddleware().getAllTransaction();
    if (resp is ResponseSuccessState<List<Transaction>>) {
      yield TransactionReadyState(transactionHistory: resp.responseData);
    } else if (resp is ResponseFailedState) {
      yield TransactionGetFailedState(responseFailed: resp);
      yield TransactionReadyState(transactionHistory: []);
    }
  }
}
