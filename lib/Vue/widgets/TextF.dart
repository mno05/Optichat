import 'package:flutter/material.dart';
class TextF extends StatelessWidget {
  String? hint; 
  TextEditingController? entry;
  bool obscure = false; 
  bool email = false; 
  bool Number = false;
   TextF(this.hint, this.entry,{super.key,this.obscure=false,this.email=false,this.Number=false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, top: 8, bottom: 8),
      margin: EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black12,
      ),
      child: TextField(
        controller: entry,
        keyboardType: (email)
            ? TextInputType.emailAddress
            : (Number)
                ? TextInputType.phone
                : TextInputType.text,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
        ),
        obscureText: obscure,
      ),
    );
  }
  }