import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_complete_guide/models/cart.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartReadyState extends CartState {
  final Cart cart;

  CartReadyState({@required this.cart});

  @override
  List<Object> get props => [cart];

  @override
  String toString() => 'CartReadyState { Cart ${cart.id} }';
}

class CartClearState extends CartState {}