import 'package:equatable/equatable.dart';
import 'package:flutter_complete_guide/models/product.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class ProductFilterAllEvent extends ProductEvent {}

class ProductFilterFavoriteEvent extends ProductEvent {}

class GetAllProductEvent extends ProductEvent {}

class AddNewProductEvent extends ProductEvent {
  final Product newProduct;

  AddNewProductEvent({this.newProduct});

  @override
  List<Object> get props => [newProduct];

  @override
  String toString() => 'AddNewProductEvent { newProduct: ${newProduct.id} }';
}

class UpdateProductEvent extends ProductEvent {
  final Product product;

  UpdateProductEvent({this.product});

  @override
  List<Object> get props => [product];

  @override
  String toString() => 'UpdateProductEvent { product: ${product.id} }';
}

class DeleteProductEvent extends ProductEvent {
  final String productId;

  DeleteProductEvent({this.productId});

  @override
  List<Object> get props => [productId];

  @override
  String toString() => 'DeleteProductEvent { product: $productId }';
}