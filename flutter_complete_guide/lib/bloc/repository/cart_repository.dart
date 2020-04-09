import 'package:flutter_complete_guide/bloc/repository/product_repository.dart';
import 'package:flutter_complete_guide/models/cart.dart';
import 'package:flutter_complete_guide/models/cart_item.dart';
import 'package:flutter_complete_guide/models/product.dart';

Cart _myCard = Cart();

class CartRepository {
  Cart get currentCart => _myCard;

  void addProduct(Product product) {
    _myCard.cartItems.update(
      product.id,
      (v) {
        v.quantity += 1;
        return v;
      },
      ifAbsent: () => CartItem(productId: product.id),
    );
  }

  void removeProduct(Product product) {
    if (_myCard.cartItems.containsKey(product.id)) {
      _myCard.cartItems.update(
        product.id,
        (v) {
          v.quantity -= 1;
          return v;
        },
      );

      _myCard.cartItems.removeWhere((k, v) => v.quantity == 0);
    }
  }

  void forceRemoveProduct(Product product) {
    _myCard.cartItems.removeWhere((k, v) => k == product.id);
  }

  void clear() {
    _myCard = Cart();
  }
}
