
import 'package:flutter/material.dart';
import 'package:mimo/screens/forgot_password_screen.dart';
import 'package:mimo/screens/login_screen.dart';
import 'package:mimo/screens/signup_screen.dart';

class AppRoutes {
  static const String login = '/';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgotpassword';
  static const String bottomnavbar = "/bottomnavbar";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case signup:
        return MaterialPageRoute(
          builder: (_) => const SignupScreen()
        );
      case  forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());    
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}