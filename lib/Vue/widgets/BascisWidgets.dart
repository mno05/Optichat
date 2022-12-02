import 'package:flutter/material.dart';
import 'package:flutterfirebase/Model/DefaulValues.dart';

class BasicsWidgets {
  static alert(String msg, BuildContext context,{Titre="Message"}) {
    Navigator.pop(context);
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

  static Load(BuildContext context) {
    showDialog(
        context: context,
        builder: ((context) {
          return Center(
            child: Container(
              padding: EdgeInsets.all(10),
              height: 60,
              width: 60,
              decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              ),
              child: CircularProgressIndicator(
                color: Def.defColor,
              ),
            ),
          );
        }));
  }

  static BackLoad(BuildContext context) {
    Navigator.pop(context);
  }
}
