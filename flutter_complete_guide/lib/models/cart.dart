import 'package:flutter_complete_guide/models/cart_item.dart';
import 'package:flutter_complete_guide/models/transaction.dart';
import 'package:flutter_complete_guide/models/transaction_detail.dart';
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

  CartItem getCartItemByProductId(String productId) {
    return cartItems.values.firstWhere((v) => v.productId == productId,
        orElse: () {
      return null;
    });
  }

  Transaction createNewTransaction() {
    List<TransactionDetail> transactionDetails = this.cartItems.values
        .map(
          (v) => TransactionDetail(
            productId: v.product.id,
            productName: v.product.title,
            totalMoney: v.getSumMoney(),
            quantity: v.quantity,
          ),
        )
        .toList();

    final Transaction newTransaction = Transaction(
      id: Uuid().toString(),
      createDate: DateTime.now(),
      totalMoney: this.getSumMoney(),
      status: 1,
      transactionDetails: transactionDetails,
    );

    return newTransaction;
  }
}
