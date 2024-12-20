import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  var isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    final brightness = WidgetsBinding.instance.window.platformBrightness;
    isDarkMode.value = brightness == Brightness.dark;
    WidgetsBinding.instance.window.onPlatformBrightnessChanged = () {
      final brightness = WidgetsBinding.instance.window.platformBrightness;
      isDarkMode.value = brightness == Brightness.dark;
    };
  }

  ThemeMode get theme => isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }
}
