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

class ValidatingCartState extends CartState {}

class ValidatedCartState extends CartState {
  final List<String> productIdsRemoved;
  final bool isEmptyCart;

  ValidatedCartState({this.productIdsRemoved, this.isEmptyCart});

  @override
  List<Object> get props => [productIdsRemoved, isEmptyCart];

  @override
  String toString() =>
      'ValidateCartState { ProductId $productIdsRemoved - isEmptyCart $isEmptyCart}';
}

class CartClearState extends CartState {}
