import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  final Function selectedHandler;
  final String title;

  AnswerButton({this.title, this.selectedHandler});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: EdgeInsets.all(16),
      child: Container(
        child: RaisedButton(
          textColor: Colors.white,
          child: Text(
            title,
          ),
          color: Colors.blue,
          onPressed: selectedHandler,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    );
  }
}