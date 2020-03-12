import 'package:flutter/material.dart';

class TextControl extends StatelessWidget {
  final Function pressHandler;

  TextControl(this.pressHandler);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: EdgeInsets.all(20),
      child: RaisedButton(
        color: Colors.blue,
        textColor: Colors.white,
        child: Text(
          'Click here to change text',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
        ),
        onPressed: pressHandler,
      ),
    );
  }
}
