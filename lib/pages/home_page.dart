import 'package:ayuu_quiz/components/buttons/big_button.dart';
import 'package:ayuu_quiz/controllers/home_controller.dart';
import 'package:ayuu_quiz/helper/game_type.dart';
import 'package:ayuu_quiz/pages/settings_page.dart';
import 'package:ayuu_quiz/pages/simple_math_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late FirebaseAnalytics analytics;
  late HomeController _controller;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  @override
  void initState() {
    analytics = FirebaseAnalytics.instance;
    _controller = HomeController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // _controller.listenUser();
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UserPoint(
                  users: users,
                  userId: FirebaseAuth.instance.currentUser?.uid ?? "",
                ),
                IconButton(
                    onPressed: () {
                      Get.to(() => SettingsPage());
                    },
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.deepOrange,
                    )),
              ],
            ),
          ),
          const SizedBox(height: 40),
          const Text("Choose the game:"),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BigButton(
                child: const Icon(
                  Icons.add,
                  size: 40,
                ),
                onTap: () {
                  Get.to(() => const SimpleMathPage(
                        quizType: GameType.MATH_ADD,
                        difficulty: 2,
                      ));
                },
                color: Colors.cyan,
              ),
              const SizedBox(width: 20),
              BigButton(
                child: const Icon(
                  Icons.remove,
                  size: 40,
                ),
                onTap: () {
                  Get.to(() => const SimpleMathPage(
                      quizType: GameType.MATH_SUB, difficulty: 2));
                },
                color: Colors.yellow,
              )
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BigButton(
                child: const Icon(
                  Icons.close,
                  size: 40,
                ),
                onTap: () {
                  Get.to(() => const SimpleMathPage(
                      quizType: GameType.MATH_MUL, difficulty: 1));
                },
                color: Colors.pinkAccent,
              ),
              const SizedBox(width: 20),
              BigButton(
                child: const Text("/",
                    style:
                        TextStyle(fontSize: 35, fontWeight: FontWeight.w500)),
                onTap: () {
                  Get.to(() => const SimpleMathPage(
                      quizType: GameType.MATH_DIV, difficulty: 1));
                },
                color: Colors.orangeAccent,
              )
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BigButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.emoji_symbols,
                      size: 40,
                    ),
                    SizedBox(height: 10),
                    Text("2x")
                  ],
                ),
                onTap: () {
                  Get.to(() => const SimpleMathPage(
                      quizType: GameType.MATH_ALL, difficulty: 1));
                },
                color: Colors.blue,
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    ));
  }
}

class UserPoint extends StatelessWidget {
  final CollectionReference users;
  final String userId;
  const UserPoint({
    Key? key,
    required this.users,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(userId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text(
            "Points: ${data['points']}",
            style: const TextStyle(
                fontSize: 20,
                color: Colors.deepOrange,
                fontWeight: FontWeight.w900),
          );
        }

        return const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              color: Colors.deepOrange,
            ));
      },
    );
  }
}
