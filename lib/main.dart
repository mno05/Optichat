import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CongoChat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _handleAuth(),
    );
  }
}
Widget _handleAuth(){
  return StreamBuilder(builder:(BuildContext (context, snapshot) {
    if (snapshot.hasData){

    }else{

    }
  }) , stream: FirebaseAuth.instance.authStateChanges());
}

