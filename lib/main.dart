import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/Controllers/LogController.dart';
import 'package:flutterfirebase/Controllers/MainAppController.dart';
import 'package:flutterfirebase/Model/DefaulValues.dart';
import 'package:flutterfirebase/Vue/SplashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Def.defColor,
      ),
      title: 'Optichat',
      home: SplashScreen(),
    );
  }
}
