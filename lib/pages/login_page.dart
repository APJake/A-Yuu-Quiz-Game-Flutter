import 'package:ayuu_quiz/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/accessories/components.dart';
import '../network/authentification.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController controller = LoginController();

  _loginGoogle() async {
    controller.makeLoggingIn();

    Authentification().signInWithGoogle().then((user) {
      controller.stopLoggingIn();

      if (user != null) {
        Get.off(() => HomePage());
      }
    }).catchError((err) {
      errorSnackbar(err.toString());
      controller.stopLoggingIn();
    });
  }

  _loading() => const Center(
        child: CircularProgressIndicator(),
      );
  _loginField() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Please sign in",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            ElevatedButton(
                onPressed: () {
                  _loginGoogle();
                },
                child: const Text("Login with Google"))
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          Obx(() => controller.isLoggingIn.isTrue ? _loading() : _loginField()),
    );
  }
}
