import "package:flutter/material.dart";

class MessageController extends StatefulWidget {
  const MessageController({super.key});

  @override
  State<MessageController> createState() => _MessageControllerState();
}

class _MessageControllerState extends State<MessageController> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Message"),);
    

  }
}