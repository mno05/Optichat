import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/Model/FirebaseHelper.dart';
import 'package:flutterfirebase/Vue/Email.dart';
import 'package:flutterfirebase/Vue/LogView.dart';
import 'package:flutterfirebase/Vue/Telephone.dart';
import 'package:flutterfirebase/Vue/widgets/BascisWidgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LogController extends StatefulWidget {
  const LogController({super.key});

  @override
  State<LogController> createState() => _LogControllerState();
}

class _LogControllerState extends State<LogController> {
  TextEditingController NumberPone = TextEditingController();
  TextEditingController Code = TextEditingController();

  User? user;
 

  @override
  Widget build(BuildContext context) {
    return LogView(
      signInWithGoogle: signInWithGoogle,
      SignWithNumber: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Telephone(page: 0),));
      },
      signINWitEmail: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Email(),));
      },
      signInWithFacebook: signInWithFacebook,
    );
  }

  //Les méthodes de connections
  void signInWithGoogle() {
    try {
      BasicsWidgets.Load(context);
      FirebaseHelper().signInWithGoogle().then((UserCredential) {
        BasicsWidgets.BackLoad(context);
        user = UserCredential.user;
        print(user);
      });
    } on Error catch (e) {
      print(e);
    }
  }

  void signInWithFacebook() {
    try {
      BasicsWidgets.Load(context);
      FirebaseHelper().signInWithFacebook().then((UserCredential) {
        BasicsWidgets.BackLoad(context);
        user = UserCredential.user;
        print(user);
      });
    } on Error catch (e) {
      print(e);
    }
  }

}