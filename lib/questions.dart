// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:vibration/vibration.dart';

class QuizQuestion extends StatefulWidget {
  final String imagePath;
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final Function(bool) onAnswerSelected;

  const QuizQuestion({
    Key? key,
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    required this.onAnswerSelected,
    this.imagePath = '',
  }) : super(key: key);

  @override
  State<QuizQuestion> createState() => _QuizQuestionState();
}

class _QuizQuestionState extends State<QuizQuestion> {
  late String feedbackText;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    feedbackText = '';
    timer = Timer(const Duration(seconds: 3), () {
      setState(() {
        feedbackText = ''; // Reset the feedback text
        // Add logic to load the next question here
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Optional Image
        if (widget.imagePath.isNotEmpty) ...[
          Image.asset(widget.imagePath.trim(),
              height: 150, width: 150, fit: BoxFit.cover),
          const SizedBox(height: 16),
        ],
        // Question Text
        Text(
          widget.question,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        // Answer Options in a 2x2 Grid
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            children: List.generate(widget.options.length, (index) {
              return buildAnswerSquare(context, index, widget.options[index]);
            }),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          feedbackText,
          style: TextStyle(
            fontSize: 16,
            color:
                feedbackText.startsWith('Correct') ? Colors.green : Colors.red,
          ),
        ),
      ],
    );
  }

  Widget buildAnswerSquare(BuildContext context, int index, String option) {
    double boxSize =
        MediaQuery.of(context).size.width / 0.1; // Adjust the divisor as needed

    return InkWell(
      onTap: () {
        // Handle the selected answer, you can compare index with correctAnswerIndex
        if (index == widget.correctAnswerIndex) {
          print('Correct answer!');
          showCorrectFeedback();
        } else {
          print('Incorrect answer!');
          showIncorrectFeedback();
        }
      },
      child: Container(
        margin: const EdgeInsets.all(8), // Add margin for spacing
        width: boxSize,
        height: boxSize,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            option,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  void moveToNextQuestion(bool isCorrect) {
    setState(() {
      widget.onAnswerSelected(
          isCorrect); // Notify the parent widget about the answer
      feedbackText = '';
    });
  }

  void showIncorrectFeedback() async {
    setState(() {
      feedbackText =
          'Incorrect, the answer was ${widget.options[widget.correctAnswerIndex]}';
    });
    await Vibration.vibrate(duration: 500);
    playIncorrectSound();
  }

  void playIncorrectSound() async {
    final player = AudioCache();
    player.play('sounds/wrongAnswer.mp3');
  }

  void showCorrectFeedback() async {
    setState(() {
      feedbackText =
          'Correct, the answer is ${widget.options[widget.correctAnswerIndex]}';
    });
    await Vibration.vibrate(duration: 500);
    playCorrectSound();
  }

  void playCorrectSound() {
    final player = AudioCache();
    player.play('sounds/correctAnswer.mp3');
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
      ),
      body: QuizQuestion(
        imagePath: "images/paris.png",
        question: 'What is the capital of France?',
        options: const ['Paris', 'Berlin', 'Madrid', 'Rome'],
        correctAnswerIndex: 0,
        onAnswerSelected: (isCorrect) {
          print('Answer selected: $isCorrect');
        },
      ),
    ),
  ));
}
