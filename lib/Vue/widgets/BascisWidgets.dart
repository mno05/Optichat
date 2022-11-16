import 'package:flutter/material.dart';
class BasicsWidgets{
  static alert(String msg, BuildContext context) {
    String Titre = "Erreur";
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: ((context) {
          return AlertDialog(
            title: Text(Titre),
            content: Text(msg),
            actions: [
              TextButton(
                  onPressed: (() => Navigator.of(context).pop()),
                  child: Text("OK"))
            ],
          );
        }));
  }
}