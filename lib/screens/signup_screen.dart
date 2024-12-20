import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mimo/controllers/theme_controller.dart';
import 'package:mimo/utils/responsive_helper.dart';
import 'package:mimo/widgets/custom_button.dart';
import 'package:mimo/widgets/custom_textfield.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _nameController = TextEditingController();
    TextEditingController _confirmPasswordController = TextEditingController();
    final ThemeController themeController = Get.find();

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
                  Row(
                    children: [
                    Icon(Icons.arrow_back,color: Colors.black,size: 25,),
                    SizedBox(width: ResponsiveHelper.screenWidth(context) *  0.16,),
                    Text('Create an Account',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                  ],),
                   SizedBox(
                      height: ResponsiveHelper.screenHeight(context) * 0.040),
                  CustomTextField(
                      controller: _nameController, hintText: 'Full Name'),
                  SizedBox(
                      height: ResponsiveHelper.screenHeight(context) * 0.014),
                  CustomTextField(
                      controller: _emailController, hintText: 'Email'),
                  SizedBox(
                      height: ResponsiveHelper.screenHeight(context) * 0.014),
                  CustomTextField(
                      controller: _passwordController, hintText: 'Password'),
                   SizedBox(
                      height: ResponsiveHelper.screenHeight(context) * 0.014),
                  CustomTextField(
                      controller: _confirmPasswordController, hintText: 'Confirm Password'),    
                  SizedBox(
                      height: ResponsiveHelper.screenHeight(context) * 0.040),
                  CustomButton(title: 'CONTINUE'),
                  SizedBox(
                      height: ResponsiveHelper.screenHeight(context) * 0.030),
                  Row(
                    spacing: ResponsiveHelper.screenWidth(context) * 0.010,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?"),
                      GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Login',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.black,fontWeight: FontWeight.bold),
                          ))
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
