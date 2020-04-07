import 'package:flutter_complete_guide/models/product.dart';
import 'package:flutter_complete_guide/redux/product/product_action.dart';
import 'package:flutter_complete_guide/redux/product/product_state.dart';
import 'package:redux/redux.dart';

final productReducer = combineReducers<ProductState>([
  TypedReducer<ProductState, SetFavoriteAction>(_setFavorite),
]);

ProductState _setFavorite(ProductState state, SetFavoriteAction action) {
  state.products.update(
    action.product.id,
    (v) => action.product,
    ifAbsent: () => action.product,
  );

  return state.copyWith(products: state.products);
}
