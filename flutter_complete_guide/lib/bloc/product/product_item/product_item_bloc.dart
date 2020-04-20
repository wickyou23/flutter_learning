import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_complete_guide/bloc/product/product_bloc.dart';
import 'package:flutter_complete_guide/bloc/product/product_event.dart';
import 'package:flutter_complete_guide/bloc/product/product_item/product_item_event.dart';
import 'package:flutter_complete_guide/bloc/product/product_state.dart';
import 'package:flutter_complete_guide/data/repository/product_repository.dart';
import 'package:flutter_complete_guide/models/product.dart';

class ProductItemBloc extends Bloc<ProductItemEvent, Product> {
  ProductRepository _productRepository;
  Product product;
  ProductBloc productBloc;

  ProductItemBloc({
    @required this.product,
    @required this.productBloc,
  }) {
    _productRepository = ProductRepository();
  }

  @override
  Product get initialState => product;

  @override
  Stream<Product> mapEventToState(ProductItemEvent event) async* {
    if (event is SetFavoriteEvent) {
      yield* _mapToSetFavoriteEvent(event);
    }
  }

  @override
  Future<void> close() {
    print('ProductItemBloc { product: ${product.id} } closed');
    return super.close();
  }

  Stream<Product> _mapToSetFavoriteEvent(SetFavoriteEvent event) async* {
    _productRepository.setIsFavorite(product.id, event.isFavorite);
    product.isFavorite = event.isFavorite;
    product = product.copyWith(isFavorite: event.isFavorite);
    var crProductState = productBloc.state;
    if (crProductState is ProductLoadedState &&
        crProductState.isFavoriteFilter) {
      productBloc.add(ProductFilterFavoriteEvent());
    }
    else {
      yield product;
    }
  }
}
