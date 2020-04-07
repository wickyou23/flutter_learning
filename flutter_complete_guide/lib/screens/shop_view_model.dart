import 'dart:async';

import 'package:flutter_complete_guide/models/product.dart';
import 'package:flutter_complete_guide/redux/action_report.dart';
import 'package:flutter_complete_guide/redux/app_state.dart';
import 'package:flutter_complete_guide/redux/product/product_action.dart';
import 'package:redux/redux.dart';

class ShopViewModel {
  final Map<String, Product> products;
  final Function(Product) setFavorite;

  ShopViewModel({
    this.products,
    this.setFavorite
  });

  static ShopViewModel fromStore(Store<AppState> store) {
    return ShopViewModel(
      products: store.state.productState.products ?? [],
      setFavorite: (product) {
        final Completer<ActionReport> completer = Completer<ActionReport>();
        store.dispatch(SetFavoriteAction(product: product, completer: completer));
        completer.future.then((status) {});
      },
    );
  }
}