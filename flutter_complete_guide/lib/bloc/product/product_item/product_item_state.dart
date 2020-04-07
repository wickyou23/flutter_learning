import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_complete_guide/models/product.dart';

abstract class ProductItemState extends Equatable {
  const ProductItemState();

  @override
  List<Object> get props => [];
}

class ProductItemUpdated extends ProductItemState {
  final Product product;

  ProductItemUpdated({@required this.product});

  @override
  List<Object> get props => [product];

  @override
  String toString() => 'ProductItemUpdated { product $product }';
}