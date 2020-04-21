import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_complete_guide/bloc/product/product_bloc.dart';
import 'package:flutter_complete_guide/bloc/product/product_event.dart';
import 'package:flutter_complete_guide/bloc/product/product_item/product_item_event.dart';
import 'package:flutter_complete_guide/bloc/product/product_item/product_item_state.dart';
import 'package:flutter_complete_guide/bloc/product/product_state.dart';
import 'package:flutter_complete_guide/data/middleware/product_middleware.dart';
import 'package:flutter_complete_guide/data/network_common.dart';
import 'package:flutter_complete_guide/data/repository/product_repository.dart';
import 'package:flutter_complete_guide/models/product.dart';

class ProductItemBloc extends Bloc<ProductItemEvent, ProductItemState> {
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
  ProductItemState get initialState => ProductItemReadyState(product: this.product);

  @override
  Stream<ProductItemState> mapEventToState(ProductItemEvent event) async* {
    if (event is SetFavoriteEvent) {
      yield* _mapToSetFavoriteEvent(event);
    }
  }

  @override
  Future<void> close() {
    print('ProductItemBloc { product: ${product.id} } closed');
    return super.close();
  }

  Stream<ProductItemState> _mapToSetFavoriteEvent(SetFavoriteEvent event) async* {
    product.isFavorite = event.isFavorite;
    product = product.copyWith(isFavorite: event.isFavorite);
    yield ProductItemReadyState(product: product);
    // Used to save to db or local memory
    // var response = await _productRepository.setIsFavorite(product);
    var response = await ProductMiddleware().updateFavoriteProduct(product);
    if (response is ResponseFailedState) {
      product = product.copyWith(isFavorite: !event.isFavorite);
      yield ProductItemSetFavoriteFailedState(responseErrorState: response);
      yield ProductItemReadyState(product: product);
    }
    
    var crProductState = productBloc.state;
    if (crProductState is ProductLoadedState &&
        crProductState.isFavoriteFilter) {
      productBloc.add(ProductFilterFavoriteEvent());
    }
  }
}
