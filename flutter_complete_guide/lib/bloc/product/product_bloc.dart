import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_complete_guide/bloc/product/product_event.dart';
import 'package:flutter_complete_guide/bloc/product/product_state.dart';
import 'package:flutter_complete_guide/bloc/repository/product_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc({@required this.productRepository});

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is ProductFilterFavoriteEvent) {
      yield* _mapToFilterFavoriteEvent();
    } else if (event is ProductFilterAllEvent) {
      yield* _mapToFilterAllEvent();
    }
  }

  @override
  ProductState get initialState =>
      ProductLoadedState(products: productRepository.getAllProduct);

  @override
  Future<void> close() {
    print('ProductBloc closed');
    return super.close();
  }

  Stream<ProductState> _mapToFilterFavoriteEvent() async* {
    yield ProductLoadedState(
      products: productRepository.getFavoriteProduct,
      isFavoriteFilter: true,
    );
  }

  Stream<ProductState> _mapToFilterAllEvent() async* {
    yield ProductLoadedState(
      products: productRepository.getAllProduct,
      isFavoriteFilter: false,
    );
  }
}
