import 'package:get/get.dart';

class LoginController extends GetxController {
  RxBool isLoggingIn = false.obs;
  void makeLoggingIn() {
    _setLogin(true);
  }

  void stopLoggingIn() {
    _setLogin(false);
  }

  void _setLogin(bool logginIn) {
    isLoggingIn.value = logginIn;
  }
}
