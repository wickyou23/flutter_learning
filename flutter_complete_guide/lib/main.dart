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
  final _questions = const [
    {
      'questionText': 'What\'s your favorite color?',
      'answers': ['Red', 'Green', 'Blue', 'Yellow'],
    },
    {
      'questionText': 'What\'s your favorite animal?',
      'answers': ['Snake', 'Dog', 'Cat', 'Elephant'],
    },
  ];

  void _answerQuestion() {
    setState(() {
      _indexQuestion += 1;
      if (_indexQuestion >= _questions.length) {
        _indexQuestion = 0;
      }
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
                child: Column(
                  children: [
                    QuestionText(_questions[_indexQuestion]['questionText']),
                    ...(_questions[_indexQuestion]['answers'] as List<String>)
                        .map((text) => AnswerButton(
                              title: text,
                              selectedHandler: _answerQuestion,
                            ))
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
