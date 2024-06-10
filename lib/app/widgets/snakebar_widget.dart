import 'package:get/get.dart';
import 'package:flutter/material.dart';

class MySnakebar {
  static void success({
    required String title,
    required String subtitle,
    Color backgroundColor = Colors.green,
    SnackPosition snackPosition = SnackPosition.BOTTOM,
    EdgeInsets margin = const EdgeInsets.only(bottom: 20, left: 20, right: 20),
    Widget? icon,
  }) {
    Get.snackbar(title, subtitle,
        snackPosition: snackPosition,
        margin: margin,
        backgroundColor: backgroundColor,
        colorText: Colors.white,
        icon: icon,
        isDismissible: true,
        duration: const Duration(seconds: 2));
  }

  static void failure({
    required String title,
    required String subtitle,
    Color backgroundColor = Colors.red,
    SnackPosition snackPosition = SnackPosition.BOTTOM,
    EdgeInsets margin = const EdgeInsets.only(bottom: 20, left: 20, right: 20),
    Widget? icon,
  }) {
    Get.snackbar(title, subtitle,
        snackPosition: snackPosition,
        margin: margin,
        backgroundColor: backgroundColor,
        colorText: Colors.white,
        icon: icon,
        isDismissible: true,
        duration: const Duration(seconds: 2));
  }
}
