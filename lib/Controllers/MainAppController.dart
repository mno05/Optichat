import 'package:flutter/material.dart';
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Main'),),
      body: Center(child: Text("Connecté")),
    );
  }
}