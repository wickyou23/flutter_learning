import 'package:flutter/material.dart';
import 'question_text.dart';
import 'answer_button.dart';

class Quiz extends StatelessWidget {
  final Map<String, dynamic> qAndA;
  final Function answerQuestionHandler;

  Quiz(this.qAndA, this.answerQuestionHandler);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        QuestionText(
          qAndA['questionText'],
        ),
        ...(qAndA['answers'] as List<Map<String, dynamic>>)
            .map((hash) => AnswerButton(
                  title: hash['text'] as String,
                  selectedHandler: () => answerQuestionHandler(hash['score'] as num),
                )),
      ],
    );
  }
}
