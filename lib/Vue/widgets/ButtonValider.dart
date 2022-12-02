import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class ButtonValider extends StatelessWidget {
  BuildContext context;
  String text;
  VoidCallback onTap;
  ButtonValider(this.context, {required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return InkWell(
      child: Container(
        width: width * 0.4,
        height: height * 0.06,
        decoration: BoxDecoration(
            color: Colors.amber.shade600,
            borderRadius: BorderRadius.circular(20)),
        child: Center(
            child: Text(
          text,
          style: GoogleFonts.nunito(
            color: Colors.white,
            fontSize: width * 0.05,
            fontWeight: FontWeight.bold,
          ),
        )),
      ),
      onTap: onTap,
    );
  }
  }