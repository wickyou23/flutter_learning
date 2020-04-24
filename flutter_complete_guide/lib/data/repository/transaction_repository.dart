import 'package:flutter_complete_guide/models/cart.dart';
import 'package:flutter_complete_guide/models/transaction.dart';

List<Transaction> _transactionHistory = [];

class TransactionRepository {
  List<Transaction> get allTransaction => [..._transactionHistory];

  void addNewTransaction(Cart cart) {
    _transactionHistory.add(cart.createNewTransaction());
  }
}
