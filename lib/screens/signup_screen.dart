import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mimo/controllers/auth_controller.dart';
import 'package:mimo/controllers/theme_controller.dart';
import 'package:mimo/utils/responsive_helper.dart';
import 'package:mimo/widgets/custom_button.dart';
import 'package:mimo/widgets/custom_textfield.dart';
import 'package:mimo/utils/validators.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>(); 
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _nameController = TextEditingController();
    TextEditingController _confirmPasswordController = TextEditingController();

    final AuthController authController = Get.find();
     final ThemeController themeController = Get.find();

    void _signUp() async {
      if (_formKey.currentState!.validate()) {
        String name = _nameController.text.trim();
        String email = _emailController.text.trim();
        String password = _passwordController.text.trim();
        String confirmPassword = _confirmPasswordController.text.trim();

        FocusScope.of(context).unfocus(); 

        await authController.signUp(email, password, name);

        if (authController.currentUser != null) {
          Get.offNamed('/categories');
        }
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
              child: Form(
                key: _formKey, 
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(Icons.arrow_back, color: themeController.isDarkMode.value?Colors.white:Colors.black, size: 25),
                        ),
                        SizedBox(width: ResponsiveHelper.screenWidth(context) * 0.16),
                        Text('Create an Account', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: ResponsiveHelper.screenHeight(context) * 0.040),
                    CustomTextField(
                      controller: _nameController,
                      hintText: 'Full Name',
                      validator: Validators.validateName,
                    ),
                    SizedBox(height: ResponsiveHelper.screenHeight(context) * 0.014),
                    CustomTextField(
                      controller: _emailController,
                      hintText: 'Email',
                      validator: Validators.validateEmail,
                    ),
                    SizedBox(height: ResponsiveHelper.screenHeight(context) * 0.014),
                    CustomTextField(
                      controller: _passwordController,
                      hintText: 'Password',
                      validator: Validators.validatePassword, 
                    ),
                    SizedBox(height: ResponsiveHelper.screenHeight(context) * 0.014),
                    CustomTextField(
                      controller: _confirmPasswordController,
                      hintText: 'Confirm Password',
                      validator: (value) {
                        return Validators.validateConfirmPassword(value!, _passwordController.text);
                      }, 
                    ),
                    SizedBox(height: ResponsiveHelper.screenHeight(context) * 0.040),
                    Obx(() {
                      return authController.isLoading.value
                          ? CircularProgressIndicator()
                          : GestureDetector(
                              onTap: _signUp,
                              child: CustomButton(title: 'CONTINUE'),
                            );
                    }),
                    SizedBox(height: ResponsiveHelper.screenHeight(context) * 0.030),
                    Row(
                      spacing: 5,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?"),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed('/');
                          },
                          child: Obx(() => Text(
                              'Login',
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
      ),
    );
  }
}
