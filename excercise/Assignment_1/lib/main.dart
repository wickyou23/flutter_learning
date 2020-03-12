import 'package:flutter/material.dart';
import 'package:flutter_assigment/text_control.dart';
import 'package:flutter_assigment/text_output.dart';

void main() => runApp(AssigmentPage());

class AssigmentPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AssigmentPage();
}

class _AssigmentPage extends State<AssigmentPage> {
  var _mainText = 'The Frist Assigment';

  void _changeTextHandler() {
    setState(() {
      _mainText = 'I\'m a iOS native developer\n(Swift & Objective-C)';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Assigment Page'),
        ),
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextOutput(_mainText),
              TextControl(_changeTextHandler),
            ],
          ),
        ),
      ),
    );
  }
}
