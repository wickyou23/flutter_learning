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
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(100),
        ),
        // child: RaisedButton(
        //   child: Text(
        //     title,
        //     style: TextStyle(
        //       color: Colors.white,
        //     ),
        //   ),
        //   // color: Colors.blue,
        //   onPressed: selectedHandler,
        // ),
      ),
    );
  }
}
