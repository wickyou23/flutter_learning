import 'package:dio/dio.dart';
import 'package:flutter_complete_guide/data/network_common.dart';
import 'package:flutter_complete_guide/data/network_response_state.dart';
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
      var response =
          await NetworkCommon().dio.get('/favorite/${user.localId}.json');

      List<String> productIds = List<String>.from(response.data ?? []);
      FavoriteRepository().favoriteProducts = Set<String>.of(productIds);
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

  Future<ResponseState> updateNewFavoriteProducts() async {
    try {
      var fRepo = FavoriteRepository();
      var user = await AuthRepository().getCurrentUser();
      var response = await NetworkCommon().dio.put(
            '/favorite/${user.localId}.json123123',
            data: fRepo.favoriteProducts.toList(),
          );
      return ResponseSuccessState(
        statusCode: response.statusCode,
        responseData: fRepo.favoriteProducts,
      );
    } on DioError catch (e) {
      return ResponseFailedState(
        statusCode: e.response.statusCode,
        errorMessage: e.message,
      );
    }
  }
}
