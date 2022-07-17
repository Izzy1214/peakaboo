// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:peak_app/auth/login_page.dart';
import 'package:peak_app/auth/register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  // initially show the login page
  bool showLoginPage = true;
  void toggleScreens() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(showRegPage: toggleScreens);
    } else {
      return RegPage(showLoginPage: toggleScreens);
    }
  }
}
