import 'package:flutter/material.dart';

class TransactionInput extends StatelessWidget {
  final productTFController = TextEditingController();
  final amountTFController = TextEditingController();
  final void Function(String, double) addActionHandler;

  TransactionInput({@required this.addActionHandler});

  void _checkCondition() {
    final productName = productTFController.text;
    final amount = double.tryParse(amountTFController.text) ?? -1;

    if (productName.isEmpty || amount < 0) {
      return;
    }

    addActionHandler(
      productName,
      amount,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        color: Colors.grey.withAlpha(25),
        padding: EdgeInsets.only(left: 8, right: 8, top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[],
              ),
            ),
            Container(
              height: 45,
              color: Colors.white,
              child: TextField(
                controller: productTFController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Product name',
                  labelStyle: TextStyle(fontSize: 12),
                ),
                onSubmitted: (_) => FocusScope.of(context).nextFocus(),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 45,
              color: Colors.white,
              child: TextField(
                controller: amountTFController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  labelText: 'Amount',
                  labelStyle: TextStyle(fontSize: 12),
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (_) => _checkCondition(),
              ),
            ),
            FlatButton(
              padding: EdgeInsets.all(0),
              textColor: Colors.blue,
              child: Text('Add Transaction'),
              onPressed: () => _checkCondition(),
            ),
          ],
        ),
      ),
    );
  }
}
