import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final num score;
  final Function resetHandler;

  Result(this.score, this.resetHandler);

  String get resultText {
    String tmpText;
    if (score >= 7) {
      tmpText = 'You are so good!';
    } else {
      tmpText = 'You are so bad!';
    }

    return tmpText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            resultText,
            style: TextStyle(fontSize: 30, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          FlatButton(
            child: Text('Reset Quiz',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                )),
            onPressed: resetHandler,
          )
        ],
      ),
    );
  }
}
