import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/answer_button.dart';
import 'package:flutter_complete_guide/question_text.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyApp();
}

class _MyApp extends State<StatefulWidget> {
  var _indexQuestion = 0;
  var _questions = [
    'What\'s your favorite color?',
    'What\'s your favorite animal?',
  ];

  void _answerQuestion() {
    setState(() {
      _indexQuestion += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My First App'),
        ),
        body: Column(
          children: [
            QuestionText(_questions[_indexQuestion]),
            AnswerButton(
              title: 'Answer 1',
              selectedHandler: _answerQuestion,
            ),
            AnswerButton(
              title: 'Answer 2',
              selectedHandler: _answerQuestion,
            ),
            AnswerButton(
              title: 'Answer 3',
              selectedHandler: _answerQuestion,
            ),
          ],
        ),
      ),
    );
  }
}
