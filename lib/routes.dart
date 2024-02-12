import 'package:flutter/material.dart';
import 'package:simple_flutter_app/screens/login_screen.dart';
import 'package:simple_flutter_app/screens/registration_screen.dart';
import 'package:simple_flutter_app/screens/repo_screen.dart';
import 'package:simple_flutter_app/screens/splash.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      '/': (context) => const SplashScreen(),
      '/login': (context) => LoginScreen(),
      '/register': (context) => RegisterationScreen(),
      '/repo': (context) =>  ReposScreen(),
    };
  }
}