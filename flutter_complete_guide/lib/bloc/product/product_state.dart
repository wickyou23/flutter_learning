import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_complete_guide/data/network_common.dart';
import 'package:flutter_complete_guide/models/product.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

//Get Product State

class ProductReadyState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductLoadFailedState extends ProductState {
  final ResponseFailedState failedState;

  const ProductLoadFailedState({@required this.failedState});

  @override
  List<Object> get props => [failedState];

  @override
  String toString() => 'ProductLoadFailedState { failed: $failedState }';
}

class ProductLoadedState extends ProductState {
  final List<Product> products;
  final List<Product> allProduct;
  final bool isFavoriteFilter;

  const ProductLoadedState({
    @required this.products,
    @required this.allProduct,
    this.isFavoriteFilter = false,
  });

  @override
  List<Object> get props => [products];

  @override
  String toString() => 'ProductLoaded { products: $products }';
}

//Add State

class AddingNewProductState extends ProductState {}

class AddedNewProductState extends ProductState {}

class AddFailedNewProductState extends ProductState {
  final ResponseFailedState failedState;

  const AddFailedNewProductState({@required this.failedState});

  @override
  List<Object> get props => [failedState];

  @override
  String toString() => 'AddFailedNewProductState { failed: $failedState }';
}

//Update State

class UpdatingProductState extends ProductState {}

class UpdatedProductState extends ProductState {}

//Delete State

class DeletingProductState extends ProductState {
  final String productId;

  const DeletingProductState({
    @required this.productId,
  });

  @override
  List<Object> get props => [productId];

  @override
  String toString() => 'DeletingProductState { productId: $productId }';
}

class DeletedProductState extends ProductState {}
