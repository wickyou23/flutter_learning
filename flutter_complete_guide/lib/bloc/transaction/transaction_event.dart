import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_complete_guide/models/cart.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class AddNewTransacionEvent extends TransactionEvent {
  final Cart cart;

  AddNewTransacionEvent({@required this.cart});

  @override
  List<Object> get props => [cart];

  @override
  String toString() => 'AddNewTransacionEvent { cart $cart }';
}