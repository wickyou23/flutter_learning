import 'package:flutter_complete_guide/data/middleware/favorite_middleware.dart';
import 'package:flutter_complete_guide/data/middleware/product_middleware.dart';
import 'package:flutter_complete_guide/data/network_common.dart';
import 'package:flutter_complete_guide/data/network_response_state.dart';
import 'package:flutter_complete_guide/models/product.dart';

final Map<String, Product> _dummyData = {};

class ProductRepository {
  List<Product> get getAllStoredProduct => [..._dummyData.values.toList()];

  List<Product> get getFavoriteProduct =>
      [..._dummyData.values.toList().where((v) => true)];

  List<Product> getProductByIds(List<String> ids) {
    return _dummyData.values.toList().where((v) => ids.contains(v.id));
  }

  Product getProductById(String productId) {
    return _dummyData.values
        .toList()
        .firstWhere((v) => v.id == productId, orElse: () => null);
  }

  // Future<ResponseState> setIsFavorite(Product product) async {
  //   var response = await FavoriteMiddleware().updateFavoriteProduct(product);
  //   var crResponse = response;
  //   if (crResponse is ResponseSuccessState<Product>) {
  //     return crResponse;
  //   } else {
  //     return crResponse;
  //   }
  // }

  Future<ResponseState> getAllProduct() async {
    var response = await ProductMiddleware().getAllProduct();
    var crResponse = response;
    if (crResponse is ResponseSuccessState<Map<String, Product>>) {
      crResponse.responseData.forEach((k, vl) {
        _dummyData.update(k, (_) => vl, ifAbsent: () => vl);
      });

      _dummyData
          .removeWhere((k, _) => !crResponse.responseData.keys.contains(k));
      return crResponse.copyWith(responseData: _dummyData);
    } else {
      return response;
    }
  }

  Future<ResponseState> addNewProduct(Product newProduct) async {
    var response = await ProductMiddleware().addNewProduct(newProduct);
    if (response is ResponseSuccessState<Product>) {
      _dummyData.update(
        response.responseData.id,
        (_) => response.responseData,
        ifAbsent: () => response.responseData,
      );
      return response;
    } else {
      return response;
    }
  }

  Future<ResponseState> updateProduct(Product product) async {
    var response = await ProductMiddleware().updateProduct(product);
    if (response is ResponseSuccessState<Product>) {
      _dummyData.update(
        response.responseData.id,
        (v) => response.responseData,
        ifAbsent: () => response.responseData,
      );
      return response;
    } else {
      return response;
    }
  }

  Future<ResponseState> deleteProduct(String productId) async {
    var response = await ProductMiddleware().deleteProduct(productId);
    if (response is ResponseSuccessState<String>) {
      _dummyData.removeWhere((k, v) => k == response.responseData);
      return response;
    } else {
      return response;
    }
  }
}