import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_complete_guide/models/product.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductLoadedState extends ProductState {
  final List<Product> products;

  const ProductLoadedState({@required this.products});

  @override
  List<Object> get props => [products];

  @override
  String toString() => 'ProductLoaded { todos: $products }';
}