import 'package:flutter/cupertino.dart';
import 'package:flutter_complete_guide/models/transaction_detail.dart';

class Transaction {
  final String id;
  final double totalMoney;
  final DateTime createDate;
  final int status;
  final List<TransactionDetail> transactionDetails;

  Transaction({
    @required this.id,
    this.totalMoney,
    this.createDate,
    this.transactionDetails,
    this.status,
  });

  Transaction copyWith({
    String id,
    double totalMoney,
    DateTime createDate,
    int status,
    List<TransactionDetail> transactionDetails,
  }) {
    return Transaction(
      id: id ?? this.id,
      totalMoney: totalMoney ?? this.totalMoney,
      createDate: createDate ?? this.createDate,
      transactionDetails: transactionDetails ?? this.transactionDetails,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> transactionDetailJS =
        List<Map<String, dynamic>>();
    transactionDetails.forEach((v) {
      transactionDetailJS.add(v.toJson());
    });

    return {
      'totalMoney': this.totalMoney,
      'createDate': this.createDate.millisecondsSinceEpoch,
      'status': this.status,
      'transactionDetails': transactionDetailJS,
    };
  }

  factory Transaction.fromJson({
    @required String transactionId,
    @required Map<String, dynamic> values,
  }) {
    int milisecond = values['createDate'] as int ?? 0;
    DateTime createDate = DateTime.fromMillisecondsSinceEpoch(milisecond);
    List<dynamic> transactionDetailJS =
        values['transactionDetails'] as List<dynamic>;
    List<TransactionDetail> transactionDetail = [];
    transactionDetailJS?.forEach((v) {
      if (v is Map<String, dynamic>) {
        transactionDetail.add(TransactionDetail.fromJson(values: v));
      }
    });

    return Transaction(
      id: transactionId,
      totalMoney: values['totalMoney'],
      createDate: createDate,
      status: values['status'],
      transactionDetails: transactionDetail,
    );
  }
}
