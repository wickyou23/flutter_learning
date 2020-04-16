import 'package:flutter_complete_guide/bloc/repository/product_repository.dart';
import 'package:flutter_complete_guide/models/cart.dart';
import 'package:flutter_complete_guide/models/cart_item.dart';
import 'package:flutter_complete_guide/models/product.dart';

Cart _myCard = Cart();

class CartRepository {
  Cart get currentCart => _myCard;

  void addProduct(Product product, {int quantity = 1}) {
    final int innerQuantity = (quantity == 0) ? 1 : quantity;
    _myCard.cartItems.update(
      product.id,
      (v) {
        v.quantity += innerQuantity;
        return v;
      },
      ifAbsent: () => CartItem(
        productId: product.id,
        quantity: innerQuantity,
      ),
    );
  }

  void removeProduct(Product product, {int quantity = 1}) {
    if (_myCard.cartItems.containsKey(product.id)) {
      _myCard.cartItems.update(
        product.id,
        (v) {
          v.quantity -= (quantity == 0) ? 1 : quantity;
          return v;
        },
      );

      _myCard.cartItems.removeWhere((k, v) => v.quantity == 0);
    }
  }

  void forceRemoveProduct(Product product) {
    _myCard.cartItems.removeWhere((k, v) => k == product.id);
  }

  List<String> validateCartItem() {
    ProductRepository productRep = ProductRepository();
    List<String> cartItemRemoved = List<String>();
    for (String productId in _myCard.cartItems.keys.toList()) {
      var findProduct = productRep.getProductById(productId);
      if (findProduct == null) {
        cartItemRemoved.add(productId);
      }
    }
    
    if (cartItemRemoved.isNotEmpty) {
      _myCard.cartItems.removeWhere((k, v) => cartItemRemoved.contains(k));
    }

    return cartItemRemoved;
  }

  void clear() {
    _myCard = Cart();
  }
}
