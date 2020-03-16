import 'package:flutter/material.dart';

class TransactionInput extends StatefulWidget {
  final void Function(String, double) addActionHandler;

  TransactionInput({@required this.addActionHandler});

  @override
  _TransactionInputState createState() => _TransactionInputState();
}

class _TransactionInputState extends State<TransactionInput> {
  final productTFController = TextEditingController();
  final amountTFController = TextEditingController();

  void _checkCondition() {
    final productName = productTFController.text;
    final amount = double.tryParse(amountTFController.text) ?? -1;

    if (productName.isEmpty || amount < 0) {
      return;
    }

    widget.addActionHandler(
      productName,
      amount,
    );

    Navigator.of(context).pop();
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
                  hintText: 'Product name',
                  hintStyle: TextStyle(fontSize: 15),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.only(left: 8, right: 8),
                  focusColor: Theme.of(context).primaryColor,
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
                  hintText: 'Amount',
                  hintStyle: TextStyle(fontSize: 15),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.only(left: 8, right: 8),
                  focusColor: Theme.of(context).primaryColor,
                ),
                onSubmitted: (_) => _checkCondition(),
              ),
            ),
            FlatButton(
              padding: EdgeInsets.all(0),
              textColor: Theme.of(context).primaryColor,
              child: Text('Add Transaction'),
              onPressed: () => _checkCondition(),
            ),
          ],
        ),
      ),
    );
  }
}
