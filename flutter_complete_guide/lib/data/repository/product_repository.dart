import 'package:dio/dio.dart';
import 'package:flutter_complete_guide/data/network_common.dart';
import 'package:flutter_complete_guide/models/product.dart';

final Map<String, Product> _dummyData = {};

class ProductRepository {
  List<Product> get getAllStoredProduct => [..._dummyData.values.toList()];

  List<Product> get getFavoriteProduct =>
      [..._dummyData.values.toList().where((v) => v.isFavorite)];

  void setIsFavorite(String productId, bool isFavorite) {
    _dummyData.values.toList().firstWhere((v) => v.id == productId).isFavorite =
        isFavorite;
  }

  List<Product> getProductByIds(List<String> ids) {
    return _dummyData.values.toList().where((v) => ids.contains(v.id));
  }

  Product getProductById(String productId) {
    return _dummyData.values
        .toList()
        .firstWhere((v) => v.id == productId, orElse: () => null);
  }

  Future<ResponseState> getAllProduct() async {
    try {
      var response = await NetworkCommon().dio.get('/products.json');
      var data = response.data as Map<String, dynamic>;
      if (data.isNotEmpty) {
        data.forEach((k, v) {
          Map<String, dynamic> value = v as Map<String, dynamic>;
          if (value != null) {
            var newProduct = Product.fromJson(productId: k, values: value);
            _dummyData.update(k, (v) => newProduct, ifAbsent: () => newProduct);
          }
        });

        _dummyData.removeWhere((k, vl) => !data.containsKey(k));

        return ResponseSuccessState(
          statusCode: response.statusCode,
          responseData: _dummyData,
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
      var response = await NetworkCommon()
          .dio
          .post('/products.json', data: newProduct.toJson());
      var data = response.data as Map<String, dynamic>;
      String newProductId = data['name'] ?? '';
      if (newProductId.isNotEmpty) {
        var tmpProduct = newProduct.copyWith(id: newProductId);
        _dummyData.update(newProductId, (v) => tmpProduct,
            ifAbsent: () => tmpProduct);
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

  void updateProduct(Product product) {
    _dummyData.update(product.id, (v) => product, ifAbsent: () => product);
  }

  void deleteProduct(String productId) {
    _dummyData.removeWhere((k, v) => k == productId);
  }
}
