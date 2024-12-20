import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mimo/controllers/auth_controller.dart';
import 'package:mimo/controllers/theme_controller.dart';
import 'package:mimo/utils/responsive_helper.dart';
import 'package:mimo/widgets/custom_button.dart';
import 'package:mimo/widgets/custom_textfield.dart';
import 'package:mimo/utils/validators.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    final AuthController authController = Get.find();
    final ThemeController themeController = Get.find();

    void _login() async {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      String? emailError = Validators.validateEmail(email);
      String? passwordError = Validators.validatePassword(password);

      if (emailError != null || passwordError != null) {
        Get.snackbar('Error', emailError ?? passwordError!,
            snackPosition: SnackPosition.BOTTOM);
        return;
      }

      await authController.login(email, password);

      if (authController.currentUser != null) {
        Get.offNamed('/categories');
      } else {
        Get.snackbar('Error', 'Login failed. Please try again.',
            snackPosition: SnackPosition.BOTTOM);
      }
    }

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(
                  top: ResponsiveHelper.screenWidth(context) * 0.400,
                  right: ResponsiveHelper.screenWidth(context) * 0.080,
                  left: ResponsiveHelper.screenWidth(context) * 0.080),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                      height: ResponsiveHelper.screenHeight(context) * 0.040),
                  CustomTextField(
                      controller: _emailController, hintText: 'Email'),
                  SizedBox(
                      height: ResponsiveHelper.screenHeight(context) * 0.014),
                  CustomTextField(
                      controller: _passwordController, hintText: 'Password'),
                  SizedBox(
                      height: ResponsiveHelper.screenHeight(context) * 0.010),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/forgotpassword');
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                      height: ResponsiveHelper.screenHeight(context) * 0.040),
                  Obx(() {
                    return authController.isLoading.value
                        ? CircularProgressIndicator()
                        : GestureDetector(
                            onTap: () {
                              _login();
                            },
                            child: CustomButton(
                              title: 'CONTINUE',
                            ),
                          );
                  }),
                  SizedBox(
                      height: ResponsiveHelper.screenHeight(context) * 0.030),
                  Row(
                    spacing: 5,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?"),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/register');
                        },
                        child: Obx(() => Text(
                              'Register',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: themeController.isDarkMode.value
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
