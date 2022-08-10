import 'package:ebook/home_screen.dart';
import 'package:ebook/login_screen.dart';
import 'package:ebook/signup_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case "/home":
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case "/login":
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case "/signup":
        return MaterialPageRoute(builder: (_) => SignupScreen());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute<dynamic>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
