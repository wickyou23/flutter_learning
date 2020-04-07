import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_complete_guide/bloc/product/product_event.dart';
import 'package:flutter_complete_guide/bloc/product/product_state.dart';
import 'package:flutter_complete_guide/bloc/repository/product_repository.dart';
import 'package:flutter_complete_guide/models/product.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc({@required this.productRepository});

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    // if (event is SetFavoriteEvent) {
    //   yield* _mapToSetFavoriteEvent(event);
    // }
  }

  @override
  ProductState get initialState =>
      ProductLoadedState(products: this.productRepository.getAllProduct);

  @override
  Future<void> close() {
    return super.close();
  }
}
