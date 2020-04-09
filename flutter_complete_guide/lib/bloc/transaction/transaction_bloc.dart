import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/bloc/cart/cart_bloc.dart';
import 'package:flutter_complete_guide/bloc/cart/cart_event.dart';
import 'package:flutter_complete_guide/bloc/repository/transaction_repository.dart';
import 'package:flutter_complete_guide/bloc/transaction/transaction_event.dart';
import 'package:flutter_complete_guide/bloc/transaction/transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepository repository;
  final CartBloc cartBloc;

  TransactionBloc({
    @required this.repository,
    this.cartBloc,
  });

  @override
  TransactionState get initialState =>
      TransactionReadyState(transactionHistory: repository.allTransaction);

  @override
  Stream<TransactionState> mapEventToState(TransactionEvent event) async* {
    if (event is AddNewTransacionEvent) {
      yield* _mapToAddNewTransacionEvent(event);
    }
  }

  Stream<TransactionState> _mapToAddNewTransacionEvent(
      AddNewTransacionEvent event) async* {
    repository.addNewTransaction(event.cart);
    yield AddNewTransactionSuccessState();
    cartBloc.add(ClearCardEvent());
  }
}
