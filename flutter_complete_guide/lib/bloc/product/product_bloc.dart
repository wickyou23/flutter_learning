import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_complete_guide/bloc/product/product_event.dart';
import 'package:flutter_complete_guide/bloc/product/product_state.dart';
import 'package:flutter_complete_guide/data/middleware/product_middleware.dart';
import 'package:flutter_complete_guide/data/network_common.dart';
import 'package:flutter_complete_guide/data/repository/product_repository.dart';
import 'package:flutter_complete_guide/models/product.dart';

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
  ProductState get initialState => ProductReadyState();

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
      // Used to save to db or local memory
      // var response = await productRepository.addNewProduct(event.newProduct);
      var response = await ProductMiddleware().addNewProduct(event.newProduct);
      if (response is ResponseSuccessState<Product>) {
        yield AddedNewProductState();
        crState.products.add(response.responseData);
      } else {
        yield AddFailedNewProductState(
            failedState: response as ResponseFailedState);
      }

      // Used to save to db or local memory
      // yield ProductLoadedState(
      //   products: productRepository.getAllStoredProduct,
      //   isFavoriteFilter: crState.isFavoriteFilter,
      // );

      yield ProductLoadedState(
        products: crState.products,
        isFavoriteFilter: crState.isFavoriteFilter,
      );
    }
  }

  Stream<ProductState> _mapToUpdateProductEvent(
      UpdateProductEvent event) async* {
    var crState = state;
    if (crState is ProductLoadedState) {
      yield UpdatingProductState();
      // Used to save to db or local memory
      // var response = await productRepository.updateProduct(event.product);
      var response = await ProductMiddleware().updateProduct(event.product);
      if (response is ResponseSuccessState<Product>) {
        yield UpdatedProductState();
        var idx = crState.products.indexWhere((v) => v.id == response.responseData.id);
        if (idx != -1) {
          crState.products[idx] = response.responseData;
        }
      }
      
      // Used to save to db or local memory
      // yield ProductLoadedState(
      //   products: productRepository.getAllStoredProduct,
      //   isFavoriteFilter: crState.isFavoriteFilter,
      // );

      yield ProductLoadedState(
        products: crState.products,
        isFavoriteFilter: crState.isFavoriteFilter,
      );
    }
  }

  Stream<ProductState> _mapToDeleteProductEvent(
      DeleteProductEvent event) async* {
    var crState = state;
    if (crState is ProductLoadedState) {
      yield DeletingProductState(productId: event.productId);
      // Used to save to db or local memory
      // var response = await productRepository.deleteProduct(event.productId);
      var response = await ProductMiddleware().deleteProduct(event.productId);
      if (response is ResponseSuccessState<String>) {
        yield DeletedProductState();
        crState.products.removeWhere((v) => v.id == response.responseData);
      }
      
      // Used to save to db or local memory
      // yield ProductLoadedState(
      //   products: productRepository.getAllStoredProduct,
      //   isFavoriteFilter: crState.isFavoriteFilter,
      // );

      yield ProductLoadedState(
        products: crState.products,
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
    // Used to save to db or local memory
    // var respState = await this.productRepository.getAllProduct();
    var respState = await ProductMiddleware().getAllProduct();
    var crResponseState = respState;
    if (crResponseState is ResponseSuccessState<Map<String, dynamic>>) {
      var products = crResponseState.responseData;
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
