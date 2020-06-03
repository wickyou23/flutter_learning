import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_complete_guide/data/network_response_state.dart';
import 'package:flutter_complete_guide/models/product.dart';

abstract class ProductItemState extends Equatable {
  const ProductItemState();

  @override
  List<Object> get props => [];
}

class ProductItemReadyState extends ProductItemState {
  final Product product;

  ProductItemReadyState({@required this.product});

  @override
  List<Object> get props => [product];

  @override
  String toString() => 'ProductItemReadyState { product $product }';
}

class ProductItemUpdatedState extends ProductItemState {
  final Product product;

  ProductItemUpdatedState({@required this.product});

  @override
  List<Object> get props => [product];

  @override
  String toString() => 'ProductItemUpdatedState { product $product }';
}

class ProductItemSetFavoriteFailedState extends ProductItemState {
  final ResponseFailedState responseErrorState;

  ProductItemSetFavoriteFailedState({@required this.responseErrorState});

  @override
  List<Object> get props => [responseErrorState];

  @override
  String toString() => "ProductItemSetFavoriteFailedState{ isFavorite: $responseErrorState}";
}