import 'package:flutter/material.dart';

class ContactController extends StatefulWidget {
  const ContactController({super.key});

  @override
  State<ContactController> createState() => _ContactControllerState();
}

class _ContactControllerState extends State<ContactController> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Contact"),);
  }
}