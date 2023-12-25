// ignore_for_file: avoid_print, unused_local_variable

import 'package:flutter/material.dart';

void main() {
  runApp(const KidQuestApp());
}

class KidQuestApp extends StatelessWidget {
  const KidQuestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: KidQuestHomeScreen(),
    );
  }
}

class KidQuestHomeScreen extends StatelessWidget {
  const KidQuestHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            //toast one more to leave the application
          },
          onDoubleTap: () {
            // Handle double tap on the back button to exit the application
            Navigator.of(context).pop();
          },
          child: const Icon(Icons.arrow_back),
        ),
        title: const Text('KidQuest'),
        actions: [
          IconButton(
            onPressed: () {
              // Handle the profile icon click
              // Navigate to the profile screen or perform any other action
            },
            icon: const CircleAvatar(
              // You can customize the appearance of the profile icon here
              child: Icon(Icons.person),
            ),
          ),
        ],
      ),
      
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        
        children: [
          const SizedBox(height: 50),
          // Yellow container with "Total Points" text and the number zero
          Container(
            decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(16.0),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Total Points',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  '0',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue, // You can adjust the color as needed
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          // Smaller squares in a 2x2 grid
          LayoutBuilder(
            builder: (context, constraints) {
              final squareSize = constraints.maxWidth / 2 - 8;

              return GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                shrinkWrap: true,
                children: [
                  buildCurvedSquare('Shapes', Icons.star),
                  buildCurvedSquare('Numbers', Icons.format_list_numbered),
                  buildCurvedSquare('Alphabet', Icons.text_format),
                  buildCurvedSquare('Placeholder', Icons.person),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildCurvedSquare(String label, IconData icon, {double size=100}) {
    return InkWell(
      onTap: () {
        // Handle the tap for each square
        // You can navigate to corresponding screens or perform actions
        print('Clicked $label');
      },
      child: Container(
        width: 5,
        height: 5,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: Colors.white),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
