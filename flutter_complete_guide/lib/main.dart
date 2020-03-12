import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/quiz.dart';

import 'result.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyApp();
}

class _MyApp extends State<StatefulWidget> {
  var _indexQuestion = 0;
  var _totalScore = 0;
  final _questions = const [
    {
      'questionText': 'What\'s your favorite color?',
      'answers': [
        {'text': 'Red', 'score': 3},
        {'text': 'Green', 'score': 8},
        {'text': 'Blue', 'score': 1},
        {'text': 'Yellow', 'score': 4}
      ],
    },
    {
      'questionText': 'What\'s your favorite animal?',
      'answers': [
        {'text': 'Snake', 'score': 3},
        {'text': 'Dog', 'score': 8},
        {'text': 'Cat', 'score': 1},
        {'text': 'Elephant', 'score': 4}
      ],
    },
  ];

  void _answerQuestion(num score) {
    _totalScore += score;
    setState(() {
      _indexQuestion += 1;
    });
  }

  void _resetQuiz() {
    setState(() {
      _indexQuestion = 0;
      _totalScore = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('My First App'),
          ),
          body: Stack(
            children: [
              Opacity(
                child: Container(
                  width: double.infinity,
                  child: Image.asset(
                    'images/background_image.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                opacity: 0.7,
              ),
              Container(
                child: (_indexQuestion < _questions.length)
                    ? Quiz(_questions[_indexQuestion], _answerQuestion)
                    : Result(_totalScore, _resetQuiz),
              ),
            ],
          )),
    );
  }
}
