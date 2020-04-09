import 'package:flutter_complete_guide/models/cart_item.dart';
import 'package:uuid/uuid.dart';

class Cart {
  final String id;
  final Map<String, CartItem> cartItems;

  int get quantity =>
      cartItems.values.toList().fold(0, (rs, v) => rs + v.quantity);

  Cart()
      : this.id = Uuid().toString(),
        this.cartItems = {};

  Cart._internal(this.id, this.cartItems);

  Cart copyWith() {
    return Cart._internal(this.id, this.cartItems);
  }

  double getSumMoney() {
    return cartItems.values.toList().fold(0, (rs, v) => rs += v.getSumMoney());
  }
}
