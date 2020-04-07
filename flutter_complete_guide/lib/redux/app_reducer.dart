import 'package:flutter_complete_guide/redux/product/product_reducer.dart';

import 'app_state.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    productState: productReducer(state.productState, action),
  );
}