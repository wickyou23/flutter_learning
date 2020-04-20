import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_complete_guide/data/network_common.dart';
import 'package:flutter_complete_guide/models/product.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductLoadedState extends ProductState {
  final List<Product> products;
  final bool isFavoriteFilter;

  const ProductLoadedState({
    @required this.products,
    this.isFavoriteFilter = false,
  });

  @override
  List<Object> get props => [products];

  @override
  String toString() => 'ProductLoaded { todos: $products }';
}

class AddingNewProductState extends ProductState {}

class AddedNewProductState extends ProductState {}

class AddFailedNewProductState extends ProductState {
  final ResponseFailedState failedState;

  AddFailedNewProductState({@required this.failedState});

  @override
  List<Object> get props => [failedState];

  @override
  String toString() => 'AddFailedNewProductState { failed: $failedState }';
}

class UpdatingProductState extends ProductState {}

class UpdatedProductState extends ProductState {}

class DeletingProductState extends ProductState {}

class DeletedProductState extends ProductState {}
