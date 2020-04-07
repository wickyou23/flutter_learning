import 'package:flutter/foundation.dart';
import 'package:flutter_complete_guide/redux/product/product_state.dart';

class AppState {
  final ProductState productState;

  AppState({
    @required this.productState,
  });

  factory AppState.initial() {
    return AppState(productState: ProductState.initDefault());
  }
}
