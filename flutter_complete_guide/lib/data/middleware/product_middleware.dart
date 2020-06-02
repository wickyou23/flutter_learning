import 'package:flutter_complete_guide/data/middleware/favorite_middleware.dart';
import 'package:flutter_complete_guide/data/network_common.dart';
import 'package:flutter_complete_guide/data/repository/favorite_repository.dart';
import 'package:flutter_complete_guide/models/product.dart';
import 'package:dio/dio.dart';

class ProductMiddleware {
  static final ProductMiddleware _singleton = new ProductMiddleware._internal();

  factory ProductMiddleware() {
    return _singleton;
  }

  ProductMiddleware._internal();

  Future<ResponseState> getAllProduct() async {
    try {
      var favoriteRepo = FavoriteRepository().favoriteProducts;
      if (favoriteRepo.isEmpty) {
        await FavoriteMiddleware().getFavoriteProduct();
      }

      var favoriteProduct = FavoriteRepository().favoriteProducts;
      var response = await NetworkCommon().dio.get('/products.json');
      var data = response.data as Map<String, dynamic>;
      if (data.isNotEmpty) {
        Map<String, Product> products = {};
        data.forEach((k, v) {
          Map<String, dynamic> value = v as Map<String, dynamic>;
          if (value != null) {
            var newProduct = Product.fromJson(productId: k, values: value)
                .copyWith(isFavorite: favoriteProduct.contains(k));
            products.update(k, (v) => newProduct, ifAbsent: () => newProduct);
          }
        });

        return ResponseSuccessState<Map<String, Product>>(
          statusCode: response.statusCode,
          responseData: products,
        );
      } else {
        return ResponseFailedState(
          statusCode: response.statusCode,
          errorMessage: 'Empty data error!',
        );
      }
    } on DioError catch (e) {
      return ResponseFailedState(
        statusCode: e.response.statusCode,
        errorMessage: e.message,
      );
    }
  }

  Future<ResponseState> addNewProduct(Product newProduct) async {
    try {
      var response = await NetworkCommon().dio.post(
            '/products.json',
            data: newProduct.toJson(),
          );
      var data = response.data as Map<String, dynamic>;
      String newProductId = data['name'] ?? '';
      if (newProductId.isNotEmpty) {
        var tmpProduct = newProduct.copyWith(id: newProductId);
        return ResponseSuccessState(
          statusCode: response.statusCode,
          responseData: tmpProduct,
        );
      } else {
        return ResponseFailedState(
          statusCode: response.statusCode,
          errorMessage: 'Empty data error!',
        );
      }
    } on DioError catch (e) {
      return ResponseFailedState(
        statusCode: e.response.statusCode,
        errorMessage: e.message,
      );
    }
  }

  Future<ResponseState> updateProduct(Product newProduct) async {
    try {
      var response = await NetworkCommon().dio.patch(
            '/favorites/${newProduct.id}.json',
            data: newProduct.toJson(),
          );
      var data = response.data as Map<String, dynamic>;
      if (data.isNotEmpty) {
        return ResponseSuccessState(
          statusCode: response.statusCode,
          responseData: newProduct,
        );
      } else {
        return ResponseFailedState(
          statusCode: response.statusCode,
          errorMessage: 'Empty data error!',
        );
      }
    } on DioError catch (e) {
      return ResponseFailedState(
        statusCode: e.response.statusCode,
        errorMessage: e.message,
      );
    }
  }

  Future<ResponseState> deleteProduct(String productId) async {
    try {
      var response = await NetworkCommon().dio.delete(
            '/products/$productId.json',
          );
      return ResponseSuccessState(
        statusCode: response.statusCode,
        responseData: productId,
      );
    } on DioError catch (e) {
      return ResponseFailedState(
        statusCode: e.response.statusCode,
        errorMessage: e.message,
      );
    }
  }

  Future<ResponseState> getProductById(String productId) async {
    try {
      var response = await NetworkCommon().dio.get(
            '/products/$productId.json',
          );
      var data = response.data as Map<String, dynamic>;
      if (data != null && data.isNotEmpty) {
        Product newProduct =
            Product.fromJson(productId: productId, values: data);
        return ResponseSuccessState(
          statusCode: response.statusCode,
          responseData: newProduct,
        );
      } else {
        return ResponseFailedState(
          statusCode: response.statusCode,
          errorMessage: 'Empty data error!',
        );
      }
    } on DioError catch (e) {
      return ResponseFailedState(
        statusCode: e.response.statusCode,
        errorMessage: e.message,
      );
    }
  }
}
