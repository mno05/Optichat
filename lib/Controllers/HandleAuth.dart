import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/Controllers/LogController.dart';
import 'package:flutterfirebase/Controllers/MainAppController.dart';
class HandleAuth extends StatelessWidget {
  const HandleAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return MainApp();
        } else {
          return const LogController();
        }
      }),
      stream: FirebaseAuth.instance.authStateChanges());
  }
}