import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class ProductItemEvent extends Equatable {
  const ProductItemEvent();

  @override
  List<Object> get props => [];
}

class SetFavoriteEvent extends ProductItemEvent {
  final bool isFavorite;

  SetFavoriteEvent({@required this.isFavorite});

  @override
  List<Object> get props => [isFavorite];

  @override
  String toString() => "SetFavorite{ isFavorite: $isFavorite}";
}
