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

class RemoveProductState extends CartState {
  final String productId;

  RemoveProductState({@required this.productId});

  @override
  List<Object> get props => [productId];

  @override
  String toString() => 'RemoveProductState { ProductId $productId }';
}

class ValidateCartState extends CartState {}

class ValidateCartDoneState extends CartState {
  final List<String> productsNameRemoved;
  final bool isEmptyCart;

  ValidateCartDoneState({this.productsNameRemoved, this.isEmptyCart});

  @override
  List<Object> get props => [productsNameRemoved, isEmptyCart];

  @override
  String toString() =>
      'ValidateCartDoneState { ProductId $productsNameRemoved - isEmptyCart $isEmptyCart}';
}

class CartClearState extends CartState {}
