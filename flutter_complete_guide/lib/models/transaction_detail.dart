import 'package:flutter/foundation.dart';

class TransactionDetail {
  final String productId;
  final String productName;
  final int quantity;
  final double totalMoney;

  TransactionDetail({
    @required this.productId,
    this.productName,
    this.quantity,
    this.totalMoney,
  });

  Map<String, dynamic> toJson() {
    return {
      'productId': this.productId,
      'productName': this.productName,
      'quantity': this.quantity,
      'totalMoney': this.totalMoney,
    };
  }

  factory TransactionDetail.fromJson({
    @required Map<String, dynamic> values,
  }) {
    return TransactionDetail(
      productId: values['productId'],
      productName: values['productName'],
      quantity: values['quantity'],
      totalMoney: values['totalMoney'],
    );
  }
}