import 'package:flutter_complete_guide/data/repository/base_repository.dart';

Set<String> _favoriteProducts = {};

class FavoriteRepository implements BaseRepository {
  Set<String> get favoriteProducts {
    return _favoriteProducts;
  }

  set favoriteProducts(Set<String> newFavorite) {
    _favoriteProducts = newFavorite;
  }

  bool contains(String productId) {
    return _favoriteProducts.contains(productId);
  }

  void addNewFavoriteProduct(String productId) {
    _favoriteProducts.add(productId);
  }

  void removeFavoriteProduct(String productId) {
    _favoriteProducts.removeWhere((element) => element == productId);
  }

  @override
  void clean() {
    _favoriteProducts = {};
  }
}
