import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mimo/common/theme.dart';
import 'package:mimo/controllers/auth_controller.dart';
import 'package:mimo/controllers/theme_controller.dart';
import 'package:mimo/controllers/todo_controller.dart';
import 'package:mimo/firebase_options.dart';
import 'package:mimo/routes/app_routes.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  Get.put(ThemeController());
  Get.put(TodoController());
  Get.put(AuthController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeController themeController = Get.find();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Firebase GetX  Todo App',
        theme: themeController.isDarkMode.value?darkTheme:lightTheme,
        darkTheme: darkTheme,
        themeMode: themeController.theme,
        initialRoute: AppRoutes.categories,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}
