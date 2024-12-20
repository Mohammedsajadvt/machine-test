
import 'package:flutter/material.dart';
import 'package:mimo/screens/categories_screen.dart';
import 'package:mimo/screens/forgot_password_screen.dart';
import 'package:mimo/screens/login_screen.dart';
import 'package:mimo/screens/settings_screen.dart';
import 'package:mimo/screens/signup_screen.dart';

class AppRoutes {
  static const String login = '/';
  static const String signup = '/register';
  static const String forgotPassword = '/forgotpassword';
  static const String setting = "/settings";
  static const String categories = "/categories";

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
      case  setting:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case categories:
        return MaterialPageRoute(builder: (_) =>  CategoriesScreen());            
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}