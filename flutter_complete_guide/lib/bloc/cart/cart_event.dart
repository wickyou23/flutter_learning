import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_complete_guide/models/product.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class _CartBaseEvent extends CartEvent {
  final Product product;

  _CartBaseEvent({@required this.product});

  @override
  List<Object> get props => [product];
}

class AddProductToCartEvent extends _CartBaseEvent {
  final int quantity;
  AddProductToCartEvent({@required Product product, this.quantity = 1})
      : assert(quantity > 0),
        super(product: product);

  @override
  String toString() => 'AddProductEvent {product ${product.id}}';
}

class RemoveProductToCartEvent extends _CartBaseEvent {
  RemoveProductToCartEvent({@required Product product})
      : super(product: product);

  @override
  String toString() => 'RemoveProductEvent {product ${product.id}}';
}

class ForceRemoveProductToCartEvent extends _CartBaseEvent {
  ForceRemoveProductToCartEvent({@required Product product})
      : super(product: product);

  @override
  String toString() => 'ForceRemoveProductEvent {product ${product.id}}';
}

class ClearCardEvent extends CartEvent {}
