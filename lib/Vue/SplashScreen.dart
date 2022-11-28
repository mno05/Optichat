import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterfirebase/Controllers/HandleAuth.dart';
import 'package:flutterfirebase/Model/DefaulValues.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                HandleAuth(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) => child),
      );
    });
    return Scaffold(
      backgroundColor: Def.defColor,
      body: Center(
        child: Hero(
          transitionOnUserGestures: true,
          tag: 'Icon',
          child: Container(
                width: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("Icons/ChatIcon.png"),
                    Text(
                      "OptiChat",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
              ),
        ),
      ),
    );
  }
}
