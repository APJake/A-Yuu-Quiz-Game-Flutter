import 'package:flutter/material.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Timer"),
          const SizedBox(height: 20),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: () {}, child: const Text("Start"))
        ],
      ),
    );
  }
}
