import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class ProductFilterAllEvent extends ProductEvent {}

class ProductFilterFavoriteEvent extends ProductEvent {}


