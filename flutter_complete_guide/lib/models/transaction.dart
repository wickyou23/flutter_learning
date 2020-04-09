import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class Transaction {
  final String id;
  final double totalMoney;
  final DateTime createDate;
  final int status;
  final List<TransaciontDetail> transactionDetails;

  Transaction({
    this.totalMoney,
    this.createDate,
    this.transactionDetails,
    this.status,
  }) : this.id = Uuid().toString();
}

class TransaciontDetail {
  final String productId;
  final String productName;
  final int quantity;
  final double totalMoney;

  TransaciontDetail({
    @required this.productId,
    this.productName,
    this.quantity,
    this.totalMoney,
  });
}
