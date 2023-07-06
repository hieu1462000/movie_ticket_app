import 'package:flutter/material.dart';
import 'package:movie_ticket/views/screens/register_screen.dart';
import 'package:movie_ticket/views/screens/sign_in_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool showSignIn = true;
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignInScreen(
        swapView: toggleView,
      );
    } else {
      return RegisterScreen(
        swapView: toggleView,
      );
    }
  }
}
