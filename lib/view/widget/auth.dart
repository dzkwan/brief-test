import 'package:brieftest/view/login_screen.dart';
import 'package:brieftest/view/maintabbar_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return MainTabbar();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
