import 'package:flutter/material.dart';
import 'package:get/get.dart';

void errorSnackbar(message) => Get.snackbar("Error", message,
    colorText: Colors.white,
    backgroundColor: Colors.red,
    snackPosition: SnackPosition.BOTTOM);

void infoSnackbar(title, message) => Get.snackbar(title, message,
    backgroundColor: Colors.black,
    colorText: Colors.white,
    snackPosition: SnackPosition.BOTTOM);
