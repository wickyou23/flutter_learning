import 'package:flutter/foundation.dart';
import 'package:flutter_complete_guide/bloc/repository/product_repository.dart';
import 'package:flutter_complete_guide/models/product.dart';

class CartItem {
  final String productId;
  int quantity;
  Product _product;

  CartItem({
    @required this.productId,
    this.quantity = 1,
  });

  CartItem copyWith({
    @required String productId,
    int quantity,
  }) {
    return CartItem(
      productId: productId,
      quantity: quantity ?? 1,
    );
  }

  Product get product {
    if (_product == null) {
      final ProductRepository productRep = ProductRepository();
      _product = productRep.getProductById(productId);
    }

    return _product;
  }

  double getSumMoney() {
    return product.price * quantity;
  }
}
