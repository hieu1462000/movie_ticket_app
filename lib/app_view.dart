import 'package:flutter/material.dart';
import 'package:movie_ticket/models/auth_user_model.dart';
import 'package:movie_ticket/views/screens/auth_screen.dart';
import 'package:movie_ticket/views/screens/home_screen.dart';
import 'package:provider/provider.dart';

class AppView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthUserModel?>(context);

    if (user == null) {
      return AuthScreen();
    } else {
      print(user);
      return HomeScreen();
    }
  }
}
