
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/Controllers/HandleAuth.dart';
import 'package:flutterfirebase/Model/DefaulValues.dart';
import 'package:flutterfirebase/Model/FirebaseHelper.dart';
import 'package:flutterfirebase/Vue/widgets/BascisWidgets.dart';
import 'package:flutterfirebase/Vue/widgets/ButtonValider.dart';
import 'package:flutterfirebase/Vue/widgets/TextF.dart';
import 'package:google_fonts/google_fonts.dart';

class Telephone extends StatefulWidget {
  final int page;
  const Telephone({super.key, required this.page});

  @override
  State<Telephone> createState() => _TelephoneState();
}

class _TelephoneState extends State<Telephone> {
  TextEditingController num = TextEditingController();
  TextEditingController smsCode = TextEditingController();
  late String verificationId;
  String otp = "", authStatus = "";
  bool IsSix = false;
  String valideCode = "";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: widget.page,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Def.defColor,
          shadowColor: Def.defColor,
          title: Text(
            "Connexion par Téléphone",
            style: GoogleFonts.nunito(fontWeight: FontWeight.bold),
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextF(
                    // onChanged:(numR) {
                    //     if(numR.length==6){
                    //       setState(() {
                    //     valideCode = "C'est valide";
                    //       });
                    //   }else{
                    //     setState(() {
                    //       valideCode="Pas valide";
                    //     });
                    //   }
                    
                    // },
                    "Ex:+243817524267",
                    num,
                    Number: true,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ButtonValider(context, text: "Valider",
                       onTap: () async {
                        BasicsWidgets.Load(context);

                        String phoneNumber;
                        String otp, authStatus = "";
                        await FirebaseAuth.instance.verifyPhoneNumber(
                          // phoneNumber: num.text,
                          phoneNumber: "+243817524267",
                          timeout: const Duration(seconds: 45),
                          verificationCompleted:
                              (AuthCredential authCredential) {
                            setState(() {
                              authStatus =
                                  "Your account is successfully verified";
                            });
                          },
                          verificationFailed:
                              (FirebaseAuthException authException) {
                            setState(() {
                              authStatus = "Authentication failed";
                            });
                          },
                          codeSent: (String verId, int? forceCodeResent) {
                            verificationId = verId;
                            setState(() {
                              authStatus = "OTP has been successfully send";
                              // print(verId+"Send laaaaaaaaaaaaaaaaaaaaa");
                            });
                            otpDialogBox(context).then((value) {});
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => Telephone(page: 1),
                            //     ));
                          },
                          codeAutoRetrievalTimeout: (String verId) {
                            verificationId = verId;
                            setState(() {
                              authStatus = "TIMEOUT";
                            });
                          },
                        );
                      }),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "Nous avons envoyer un code de vérification à votre numéro. Veuillez introduire le code envoyé",
                      style: GoogleFonts.nunito(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  TextF(
                    onChanged: (numR) {
                         if(numR.length==6){
                          setState(() {
                        valideCode = "C'est valide";
                          });
                      }else{
                        setState(() {
                          valideCode="Pas valide";
                        });
                      }
                    
                    },
                    "Ex:706407",
                    smsCode,
                    Number: true,
                  ),
                  Text(valideCode),
                    Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ButtonValider(
                              context,
                              text: "Login",
                              onTap: () {
                                signIn(smsCode.text).then((value) {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                });
                                // await FirebaseAuth.instance.signInWithCredential(
                                //     PhoneAuthProvider.credential(
                                //   verificationId: verificationId,
                                //   smsCode: smsCode.text,
                                // ));
                                // print(verificationId+"verifier laaaaaaaaaaaaaaaaaaaaaaaaaa");
                                print("Bonjourrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
                              },
                            ),
                          ],
                        )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  otpDialogBox(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Nous avons envoyer un code de vérification à votre numéro. Veuillez introduire le code envoyé",
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextF(
                "Ex:706407",
                smsCode,
                Number: true,
              ),
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              ButtonValider(
                context,
                text: "Login",
                onTap: () {
                  BasicsWidgets.Load(context);
                  signIn(smsCode.text).then((value) {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HandleAuth(),));
                  });
                  // await FirebaseAuth.instance.signInWithCredential(
                  //     PhoneAuthProvider.credential(
                  //   verificationId: verificationId,
                  //   smsCode: smsCode.text,
                  // ));
                  // print(verificationId+"verifier laaaaaaaaaaaaaaaaaaaaaaaaaa");
                  print("Bonjourrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
                },
              ),
            ],
          );
        });
  }

  Future<UserCredential> signIn(String otp) async {
   return  await FirebaseAuth.instance
        .signInWithCredential(PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    ));
  }
}
