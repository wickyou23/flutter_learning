import 'package:dio/dio.dart';
import 'package:flutter_complete_guide/data/network_common.dart';
import 'package:flutter_complete_guide/data/repository/auth_repository.dart';
import 'package:flutter_complete_guide/data/repository/favorite_repository.dart';
import 'package:flutter_complete_guide/models/product.dart';

class FavoriteMiddleware {
  static final FavoriteMiddleware _singleton = FavoriteMiddleware._internal();

  FavoriteMiddleware._internal();

  factory FavoriteMiddleware() {
    return _singleton;
  }

  Future<ResponseState> getFavoriteProduct() async {
    try {
      var user = await AuthRepository().getCurrentUser();
      var response = await NetworkCommon()
          .dio
          .get('/favorite/${user.localId}.json?auth=${user.idToken}');
      
      List<String> productIds = List<String>.from(response.data ?? []);
      FavoriteRepository().favoriteProducts = productIds;
      return ResponseSuccessState(
        statusCode: response.statusCode,
        responseData: productIds,
      );
    } on DioError catch (e) {
      return ResponseFailedState(
        statusCode: e.response.statusCode,
        errorMessage: e.message,
      );
    }
  }

  Future<ResponseState> updateFavoriteProduct(Product newProduct) async {
    var fRepo = FavoriteRepository();
    var oldFavorite = fRepo.favoriteProducts;
    try {
      var user = await AuthRepository().getCurrentUser();
      if (fRepo.contains(newProduct.id)) {
        fRepo.removeFavoriteProduct(newProduct.id);
      } else {
        fRepo.addNewFavoriteProduct(newProduct.id);
      }

      var response = await NetworkCommon().dio.put(
            '/favorite/${user.localId}.json?auth=${user.idToken}',
            data: fRepo.favoriteProducts,
          );
      return ResponseSuccessState(
        statusCode: response.statusCode,
        responseData: fRepo,
      );
    } on DioError catch (e) {
      fRepo.favoriteProducts = oldFavorite;
      return ResponseFailedState(
        statusCode: e.response.statusCode,
        errorMessage: e.message,
      );
    }
  }
}
