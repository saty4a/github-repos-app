import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_flutter_app/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_flutter_app/screens/login_screen.dart';
import 'package:simple_flutter_app/screens/repo_screen.dart';
import 'package:simple_flutter_app/services/auth.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final userProvider = Provider.of<UserProvider>(context);
  
    //checking if connection with firebase was established and if user is still logged in or not 
    return StreamBuilder<User?>(
      stream: authService.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
                width: 10,
                height: 10,
                child: CircularProgressIndicator(),
              );
        }
        else if (snapshot.hasData) {
            final User? user = snapshot.data;
            userProvider.setUser(user?.uid, user?.email);
            return  ReposScreen();
        }
        else {
          return LoginScreen();
        }
      },
    );
  }
}