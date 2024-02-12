import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {

  String? _userId;
  String? _email;

  String? get userId => _userId;
  String? get email => _email;

  //storing user id and email.
  void setUser(String? userId, String? email) {
    _userId = userId;
    _email = email;
    notifyListeners();
  }

  //removing user id and email.
  void clearUser() {
    _userId = null;
    _email = null;
    notifyListeners();
  }

}