import 'package:flutter_complete_guide/data/network_common.dart';
import 'package:flutter_complete_guide/models/cart.dart';
import 'package:flutter_complete_guide/models/transaction.dart';
import 'package:dio/dio.dart';

class TransactionMiddleware {
  static final TransactionMiddleware _singleton = new TransactionMiddleware._internal();

  factory TransactionMiddleware() {
    return _singleton;
  }

  TransactionMiddleware._internal();

  Future<ResponseState> getAllTransaction() async {
    try {
      var response = await NetworkCommon().dio.get('/transactions.json');
      var data = response.data as Map<String, dynamic>;
      if (data.isNotEmpty) {
        List<Transaction> transactions = [];
        data.forEach((k, v) {
          Map<String, dynamic> value = v as Map<String, dynamic>;
          if (value != null) {
            var newTransaction = Transaction.fromJson(transactionId: k, values: value);
            transactions.add(newTransaction);
          }
        });

        return ResponseSuccessState(
          statusCode: response.statusCode,
          responseData: transactions,
        );
      } else {
        return ResponseFailedState(
          statusCode: response.statusCode,
          errorMessage: 'Empty data error!',
        );
      }
    } on DioError catch (e) {
      return ResponseFailedState(
        statusCode: e.response.statusCode,
        errorMessage: e.message,
      );
    }
  }

  Future<ResponseState> addNewTransaction(Cart cart) async {
    try {
      Transaction newTransaction = cart.createNewTransaction();
      var response = await NetworkCommon().dio.post(
            '/transactions.json',
            data: newTransaction.toJson(),
          );
      var data = response.data as Map<String, dynamic>;
      String newTransactionId = data['name'] ?? '';
      if (newTransactionId.isNotEmpty) {
        var tmpTransaction = newTransaction.copyWith(id: newTransactionId);
        return ResponseSuccessState(
          statusCode: response.statusCode,
          responseData: tmpTransaction,
        );
      } else {
        return ResponseFailedState(
          statusCode: response.statusCode,
          errorMessage: 'Empty data error!',
        );
      }
    } on DioError catch (e) {
      return ResponseFailedState(
        statusCode: e.response.statusCode,
        errorMessage: e.message,
      );
    }
  }
}