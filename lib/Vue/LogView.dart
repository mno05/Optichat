import 'package:flutter/material.dart';
import 'package:flutterfirebase/Model/DefaulValues.dart';
import 'package:flutterfirebase/Vue/Deleyed_animation.dart';
import 'package:google_fonts/google_fonts.dart';

class LogView extends StatefulWidget {
  const LogView({super.key});

  @override
  State<LogView> createState() => _LogViewState();
}

class _LogViewState extends State<LogView> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.height;

    return Scaffold(
      // appBar: AppBar(title: const Text("Authentification")),
      body: Center(

        child: SingleChildScrollView(
            child: Column(
              
          children: [
            Hero(
              transitionOnUserGestures: true,
              tag: 'Icon',
              child: Container(
                width: width * 0.15,
                height: height * 0.2,
                child: Column(
                  children: [
                    Image.asset("Icons/ChatIcon.png"),
                    Text(
                      "OptiChat",
                      style: TextStyle(
                        color: Def.defColor,
                        fontWeight: FontWeight.bold,
                        fontSize: width * 0.03,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            DelayedAnimation(
              delay: 100,
              child: Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Text(
                  "Rejoinnez la majorité des congolais et utiliser OptiChat",
                  style: GoogleFonts.nunito(
                    fontSize: width * 0.02,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),

            DelayedAnimation(
              delay: 800,
              child: Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Text(
                  "Connectez vous par",
                  style: GoogleFonts.nunito(fontSize: width * 0.03,fontWeight: FontWeight.bold),
                ),
              ),
            ),
            DelayedAnimation(
              delay: 1200,
              child: ContactButton(context,
                  color: Def.defColor,
                  icon: Icons.mail_outline_outlined,
                  text: "Email"),
            ),
            DelayedAnimation(
              delay: 1500,
              child: ContactButton(context,
                  color: Colors.white, IsGoogle: true, text: "Google"),
            ),
            DelayedAnimation(
              delay: 1800,
              child: ContactButton(context,
                  color: Colors.blue.shade800,
                  icon: Icons.facebook,
                  text: "Facebook"),
            ),
            DelayedAnimation(
              delay: 2300,
              child: ContactButton(context,
                  color: Colors.amber.shade600,
                  icon: Icons.phone,
                  text: "TELEPHONE"),
            ),
            //   TextButton(
            //       onPressed: () => setState(() {
            //             _log = !_log;
            //           }),
            //       child: Text(_log ? "S'inscrire" : "S'authentifier")),
            //   SizedBox(height: 5),

            //   ElevatedButton(onPressed: _handlelog, child: Text("Let's go")),
          ],
        )),
      ),
    );
  }

  Widget ContactButton(BuildContext context,
      {required Color color,
      IconData? icon,
      bool IsGoogle = false,
      required String text}) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      child: Container(
        height: height * 0.07,
        width: width / 1.05,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: color,
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 167, 160, 160),
              blurRadius: 5,
              offset: Offset(3, 3),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (IsGoogle)
                ? Container(
                    height: width * 0.07,
                    width: width * 0.07,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("Icons/google.png"))),
                  )
                : Icon(
                    icon,
                    color: Colors.white,
                    size: width * 0.07,
                  ),
            SizedBox(width: 10),
            Text(
              text,
              style: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                  color: (IsGoogle) ? Colors.black : Colors.white,
                  fontSize: width * 0.045),
            ),
          ],
        ),
      ),
      onTap: (() {
        print('Tape');
      }),
    );
  }
}
