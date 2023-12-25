// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:kid_quest/questions.dart';

class ShapeQuiz extends StatefulWidget {
  const ShapeQuiz({super.key});

  @override
  _ShapeQuizState createState() => _ShapeQuizState();
}

class _ShapeQuizState extends State<ShapeQuiz> {
  late List<QuizQuestion> allQuestions;
  late List<QuizQuestion> selectedQuestions;
  int currentQuestionIndex = 0;

  @override
  void initState() {
    super.initState();
    // Initialize all questions
    allQuestions = [
      // Add your 30 questions here
      QuizQuestion(
        question: 'What shape is a pizza?',
        options: const ['Circle', 'Square', 'Triangle', 'Rectangle'],
        correctAnswerIndex: 0,
        onAnswerSelected: (bool isCorrect) {
          if (isCorrect) {
            print('Correct answer!');
            // Handle correct answer logic
          } else {
            print('Incorrect answer!');
            // Handle incorrect answer logic
          }
        },
      ),
      // Add more questions...
    ];

    // Shuffle questions and select the first 10
    selectedQuestions = List.from(allQuestions);
    selectedQuestions.shuffle();
    selectedQuestions = selectedQuestions.take(10).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shape Quiz'),
      ),
      body: ListView.builder(
        itemCount: selectedQuestions.length,
        itemBuilder: (context, index) {
          if (index == currentQuestionIndex) {
            // Show the current question
            return QuizQuestionWidget(
              question: selectedQuestions[index],
              onAnswerSelected: (isCorrect) {
                // Handle the answer and move to the next question
                if (isCorrect) {
                  print('Correct answer!');
                } else {
                  print('Incorrect answer!');
                }
                moveToNextQuestion();
              },
            );
          } else {
            // Hide questions that are not the current one
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  void moveToNextQuestion() {
    setState(() {
      currentQuestionIndex++;
      if (currentQuestionIndex < selectedQuestions.length) {
        // Move to the next question if available
        // Reset feedback text for the new question
      } else {
        // All questions answered, you can show a completion screen or navigate somewhere else
        print('All questions answered!');
      }
    });
  }
}

class QuizQuestionWidget extends StatelessWidget {
  final QuizQuestion question;
  final Function(bool) onAnswerSelected;

  const QuizQuestionWidget({
    Key? key,
    required this.question,
    required this.onAnswerSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Other widgets related to QuizQuestionWidget
          Text(
            question.question,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          // Other widgets related to QuizQuestionWidget
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: ShapeQuiz(),
  ));
}
