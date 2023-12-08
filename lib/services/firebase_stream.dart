import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectopia/screens/lobby_screen.dart';
import 'package:projectopia/screens/login_screen.dart';
import 'package:projectopia/screens/verify_email_screen.dart';

class FirebaseStream extends StatelessWidget {
  const FirebaseStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return const Scaffold(
              body: Center(child: Text('Ошибка Firebase Stream!')),
            );
          } else if (snapshot.hasData) {
            if (!snapshot.data!.emailVerified) {
              return const VerifyEmailScreen();
            }
            return const Lobby();
          } else {
            return const LoginScreen();
          }
        }));
  }
}
