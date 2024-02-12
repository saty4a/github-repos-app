import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_flutter_app/constants.dart';
import 'package:simple_flutter_app/providers/user_provider.dart';
import 'package:simple_flutter_app/screens/registration_screen.dart';
import 'package:simple_flutter_app/services/auth.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({super.key});

  //we are sending user email and password to firebase authentication and storing the email and userid received after the authentication
  Future<void> _signIn({
    required context,
  }) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      if (emailValidatorRegExp.hasMatch(email)) {
        final user = await authService.login(email, password);
        if (user != null) {
          userProvider.setUser(user.uid, user.email);
          Navigator.pushReplacementNamed(
              context, '/repo'); // Navigate to RepoScreen
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to sign in')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Check your email')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All fields are required')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: const Center(child: Text('Login')),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(screenSize.width * 0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: screenSize.height * 0.1),
                buildEmailFormField(),
                SizedBox(height: screenSize.height * 0.02),
                buildPasswordForField(),
                SizedBox(height: screenSize.height * 0.04),
                SizedBox(
                  width: screenSize.width * 0.3,
                  child: ElevatedButton(
                  onPressed: () => _signIn(
                    context: context,
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                          backgroundColor:const Color(0xFFFF7643),
                          foregroundColor: Colors.white,
                      textStyle: const TextStyle(color: Colors.white)
                      ),
                  child: const Text('Login'),
                ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterationScreen()),
                    );
                  },
                  child: const Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: _emailController,
      decoration: const InputDecoration(
        labelText: "Email",
        labelStyle: TextStyle(color: Colors.white),
        hintText: "Enter your email",
        hintStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      ),
      style:const TextStyle(color: Colors.white),
    );
  }

  TextFormField buildPasswordForField() {
    return TextFormField(
      controller: _passwordController,
      decoration: const InputDecoration(
          labelText: 'Password',
          labelStyle: TextStyle(color: Colors.white),
          hintText: "Enter your password",
          hintStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder( borderSide: BorderSide(color: Colors.white) ),
          fillColor: Colors.white
      ),
      style:const TextStyle(color: Colors.white),
      obscureText: true,
    );
  }
}
