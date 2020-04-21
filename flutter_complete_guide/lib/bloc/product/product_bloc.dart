import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_complete_guide/bloc/product/product_event.dart';
import 'package:flutter_complete_guide/bloc/product/product_state.dart';
import 'package:flutter_complete_guide/data/network_common.dart';
import 'package:flutter_complete_guide/data/repository/product_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc({@required this.productRepository});

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is ProductFilterFavoriteEvent) {
      yield* _mapToFilterFavoriteEvent();
    } else if (event is ProductFilterAllEvent) {
      yield* _mapToFilterAllEvent();
    } else if (event is AddNewProductEvent) {
      yield* _mapToAddNewProductEvent(event);
    } else if (event is UpdateProductEvent) {
      yield* _mapToUpdateProductEvent(event);
    } else if (event is DeleteProductEvent) {
      yield* _mapToDeleteProductEvent(event);
    } else if (event is GetAllProductEvent) {
      yield* _mapToGetAllProductEvent(event);
    }
  }

  @override
  ProductState get initialState =>
      ProductLoadedState(products: productRepository.getAllStoredProduct);

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
      products: productRepository.getAllStoredProduct,
      isFavoriteFilter: false,
    );
  }

  Stream<ProductState> _mapToAddNewProductEvent(
      AddNewProductEvent event) async* {
    var crState = state;
    if (crState is ProductLoadedState) {
      yield AddingNewProductState();
      var response = await productRepository.addNewProduct(event.newProduct);
      if (response is ResponseSuccessState) {
        yield AddedNewProductState();
      } else {
        yield AddFailedNewProductState(
            failedState: response as ResponseFailedState);
      }

      yield ProductLoadedState(
        products: productRepository.getAllStoredProduct,
        isFavoriteFilter: crState.isFavoriteFilter,
      );
    }
  }

  Stream<ProductState> _mapToUpdateProductEvent(
      UpdateProductEvent event) async* {
    var crState = state;
    if (crState is ProductLoadedState) {
      yield UpdatingProductState();
      productRepository.updateProduct(event.product);
      yield UpdatedProductState();
      yield ProductLoadedState(
        products: productRepository.getAllStoredProduct,
        isFavoriteFilter: crState.isFavoriteFilter,
      );
    }
  }

  Stream<ProductState> _mapToDeleteProductEvent(
      DeleteProductEvent event) async* {
    var crState = state;
    if (crState is ProductLoadedState) {
      yield DeletingProductState();
      productRepository.deleteProduct(event.productId);
      yield DeletedProductState();
      yield ProductLoadedState(
        products: productRepository.getAllStoredProduct,
        isFavoriteFilter: crState.isFavoriteFilter,
      );
    }
  }

  Stream<ProductState> _mapToGetAllProductEvent(
      GetAllProductEvent event) async* {
    var crState = state;
    var isFavoriteFilter = false;
    if (crState is ProductLoadedState) {
      isFavoriteFilter = crState.isFavoriteFilter;
    }
    yield ProductLoadingState();
    var respState = await this.productRepository.getAllProduct();
    var crResponseState = respState;
    if (crResponseState is ResponseSuccessState) {
      var products = crResponseState.responseData as Map<String, dynamic>;
      yield ProductLoadedState(
        products: products.values.toList(),
        isFavoriteFilter: isFavoriteFilter,
      );
    } else if (crResponseState is ResponseFailedState) {
      yield ProductLoadFailedState(failedState: crResponseState);
      yield ProductLoadedState(
        products: [],
        isFavoriteFilter: isFavoriteFilter,
      );
    }
  }
}
