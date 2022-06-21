import 'package:ayuu_quiz/components/buttons/button.dart';
import 'package:ayuu_quiz/network/authentification.dart';
import 'package:ayuu_quiz/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var isLogginOut = false;

  _settingPage() => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Button(
                isLoading: isLogginOut,
                text: "LOG OUT",
                onTap: () async {
                  setState(() {
                    isLogginOut = true;
                  });
                  await Authentification().signOut();

                  setState(() {
                    isLogginOut = false;
                  });
                  Get.offAll(LoginPage());
                },
                icon: Icons.logout,
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _settingPage());
  }
}
