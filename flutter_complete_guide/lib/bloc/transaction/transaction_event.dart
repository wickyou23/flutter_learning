import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_complete_guide/models/cart.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class AddNewTransactionEvent extends TransactionEvent {
  final Cart cart;

  AddNewTransactionEvent({@required this.cart});

  @override
  List<Object> get props => [cart];

  @override
  String toString() => 'AddNewTransactionEvent { cart $cart }';
}

class GetAllTransactionEvent extends TransactionEvent {}