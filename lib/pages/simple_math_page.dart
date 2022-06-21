import 'package:ayuu_quiz/components/buttons/option_button.dart';
import 'package:ayuu_quiz/controllers/simple_math_controller.dart';
import 'package:ayuu_quiz/network/user_firestore.dart';
import 'package:ayuu_quiz/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SimpleMathPage extends StatefulWidget {
  final int quizType;
  final int difficulty;
  final int numberOfQuiz;
  final int milliseconds;
  const SimpleMathPage({
    Key? key,
    required this.quizType,
    this.difficulty = 1,
    this.numberOfQuiz = 10,
    this.milliseconds = 3500,
  }) : super(key: key);

  @override
  State<SimpleMathPage> createState() => _SimpleMathPageState();
}

class _SimpleMathPageState extends State<SimpleMathPage>
    with TickerProviderStateMixin {
  late SimpleMathController controller;
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = SimpleMathController(
        difficulty: widget.difficulty,
        size: widget.numberOfQuiz,
        quizType: widget.quizType,
        userId: FirebaseAuth.instance.currentUser!.uid,
        pointPerQuestion: 1);
    animationController = AnimationController(
      duration: Duration(milliseconds: widget.milliseconds),
      vsync: this,
    );
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.next();
        if (controller.isOver.isFalse) {
          animationController.reset();
          animationController.forward();
        }
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    controller.dispose();
    animationController.dispose();
    super.dispose();
  }

  nextQuestion() {
    controller.next();
  }

  animationStart() {
    animationController.forward().whenComplete(() {
      if (controller.isOver.isFalse) {
        animationStart();
      }
    });
  }

  Widget _currentResult() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("${controller.currentPosition} / ${controller.size}"),
            Text("Your score: ${controller.points.toString()}"),
          ],
        ),
      );

  Widget _options(List<double> options) => Container(
        height: 350,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: options
                .map((number) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: OptionButton(
                          text: number.toInt().toString(),
                          onTap: () {
                            controller.answer(number);
                            controller.next();
                            animationController.reset();
                            animationController.forward();
                          }),
                    ))
                .toList()),
      );

  Widget _quizField() => SafeArea(
        child: Obx(
          () => (controller.currentQuiz.value != null)
              ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LinearProgressIndicator(
                        value: animationController.value,
                        minHeight: 5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _currentResult(),
                    const SizedBox(height: 40),
                    Text(
                      controller.currentQuiz.value?.question ?? "",
                      style: const TextStyle(
                          fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                    _options(controller.currentQuiz.value?.options ?? [])
                  ],
                )
              : _loading(),
        ),
      );

  Widget _overPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Your score is ${controller.points.value}",
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                controller.reset();
              },
              child: const Text("Try again")),
          const SizedBox(height: 10),
          ElevatedButton(
              onPressed: () {
                Get.off(() => HomePage());
              },
              child: const Text("Back to HOME")),
        ],
      ),
    );
  }

  Widget _startPage() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "စုစုပေါင်း ${widget.numberOfQuiz} ပုဒ်ဖြေရပါမယ်\nစဥ်းစားချိန် တစ်ပုဒ်ကို ${widget.milliseconds / 1000} စက္ကန့်",
              textAlign: TextAlign.center,
            ),
            const Text(
              "Ready ပဲလား?",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
                onPressed: () {
                  controller.start();
                  animationController.reset();
                  animationController.forward();
                },
                child: const Text("Start Now")),
            const SizedBox(height: 20),
            const Text(
              "When you pause/stop while it is running, you will lose 10 points from your score",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );

  _loading() => const Center(
        child: CircularProgressIndicator(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.close, color: Colors.black),
            onPressed: () => Get.back(),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Obx(
          () => (controller.isStarted.value)
              ? (controller.currentQuiz.value != null)
                  ? _quizField()
                  : _loading()
              : (controller.isOver.value)
                  ? _overPage()
                  : _startPage(),
        ));
  }
}
