import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mimo/controllers/theme_controller.dart';
import 'package:mimo/utils/responsive_helper.dart';
import 'package:mimo/widgets/custom_button.dart';
import 'package:mimo/widgets/custom_textfield.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();

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
                    Text('Forgot Password',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                  ],),
                  SizedBox(
                      height: ResponsiveHelper.screenHeight(context) * 0.040),
                  CustomTextField(
                      controller: _emailController, hintText: 'Email'),
                   SizedBox(
                      height: ResponsiveHelper.screenHeight(context) * 0.014),
                  Row(children: [
                    Expanded(child: Text('Enter the email address you used to create your account and we will email you a link to reset your password.',textAlign: TextAlign.center,))
                  ],),
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
                            'Register',
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
