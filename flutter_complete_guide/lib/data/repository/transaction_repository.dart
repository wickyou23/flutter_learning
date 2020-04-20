import 'package:flutter_complete_guide/models/cart.dart';
import 'package:flutter_complete_guide/models/transaction.dart';

List<Transaction> _transactionHistory = [];

class TransactionRepository {
  List<Transaction> get allTransaction => [..._transactionHistory];

  void addNewTransaction(Cart cart) {
    List<TransaciontDetail> transactionDetails = cart.cartItems.values.map(
      (v) => TransaciontDetail(
        productId: v.product.id,
        productName: v.product.title,
        totalMoney: v.getSumMoney(),
        quantity: v.quantity,
      ),
    ).toList();

    final Transaction newTransaction = Transaction(
      createDate: DateTime.now(),
      totalMoney: cart.getSumMoney(),
      status: 1,
      transactionDetails: transactionDetails,
    );

    _transactionHistory.add(newTransaction);
  }
}
