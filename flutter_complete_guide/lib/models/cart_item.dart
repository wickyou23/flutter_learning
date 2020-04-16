import 'package:flutter/foundation.dart';
import 'package:flutter_complete_guide/bloc/repository/product_repository.dart';
import 'package:flutter_complete_guide/models/product.dart';

class CartItem {
  final String productId;
  final String productName;
  int quantity;
  Product product;

  CartItem({
    @required this.productId,
    this.productName = '',
    this.quantity = 1,
  }) {
    this.product = _getProductById(this.productId);
  }

  CartItem copyWith({
    String productName,
    int quantity,
  }) {
    return CartItem(
      productId: this.productId,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
    );
  }

  Product _getProductById(String productId) {
    final ProductRepository productRep = ProductRepository();
    return productRep.getProductById(productId);
  }

  double getSumMoney() {
    return (product?.price ?? 0) * quantity;
  }
}
