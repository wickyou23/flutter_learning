import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionInput extends StatefulWidget {
  final void Function(String, double, DateTime) addActionHandler;

  TransactionInput({@required this.addActionHandler});

  @override
  _TransactionInputState createState() => _TransactionInputState();
}

class _TransactionInputState extends State<TransactionInput> {
  final _productTFController = TextEditingController();
  final _amountTFController = TextEditingController();
  DateTime _selectedDate;

  void _checkCondition() {
    final productName = _productTFController.text;
    final amount = double.tryParse(_amountTFController.text) ?? -1;

    if (productName.isEmpty || amount < 0) {
      return;
    }

    widget.addActionHandler(
      productName,
      amount,
      _selectedDate
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((selectedDate) {
      if (selectedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = selectedDate;
      });
    });
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
                controller: _productTFController,
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
                controller: _amountTFController,
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
            SizedBox(
              height: 5,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(_selectedDate == null
                      ? 'No date chosen!'
                      : 'Date chosen: ${DateFormat.yMd().format(_selectedDate)}'),
                ),
                FlatButton(
                  padding: EdgeInsets.all(0),
                  textColor: Theme.of(context).primaryColor,
                  child: Text(
                    'Choose Date',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: _presentDatePicker,
                ),
              ],
            ),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              child: Text('Add Transaction'),
              onPressed: () => _checkCondition(),
            ),
          ],
        ),
      ),
    );
  }
}
