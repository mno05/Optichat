import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/Model/FirebaseHelper.dart';
import 'package:flutterfirebase/Vue/LogView.dart';
import 'package:flutterfirebase/Vue/widgets/BascisWidgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LogController extends StatefulWidget {
  const LogController({super.key});

  @override
  State<LogController> createState() => _LogControllerState();
}

class _LogControllerState extends State<LogController> {
  TextEditingController NumberPone = TextEditingController();
  TextEditingController Code = TextEditingController();

  User? user;
  bool _log = true;
  String log = "Login";
  TextEditingController _emailTec = TextEditingController();
  TextEditingController _passwordTec = TextEditingController();
  TextEditingController _nomTec = TextEditingController();
  TextEditingController _prenomTec = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LogView();
  }

  List<Widget> ListTxtField() {
    List<Widget> listAuth = [
      const SizedBox(height: 30),
      TextF("Entrer votre email", _emailTec, email: true),
      TextF("Entrer votre passeword", obscure: true, _passwordTec),
      const SizedBox(height: 30),
    ];
    List<Widget> listLog = [
      SizedBox(height: 20),
      TextF("Entrer votre email", _emailTec, email: true),
      TextF("Entrer votre passeword", obscure: true, _passwordTec),
      TextF("Entrer votre Nom", _nomTec),
      TextF("Entrer votre Prenom", _prenomTec),
      SizedBox(height: 20),
      Row(
        children: [
          Text("Se connecter avec :"),
          IconButton(
              onPressed: () {
                try {
                  BasicsWidgets.Load(context);
                  FirebaseHelper().signInWithGoogle().then((UserCredential) {
                    BasicsWidgets.BackLoad(context);
                    user = UserCredential.user;
                    print(user);
                  });
                } on Error catch (e) {
                  print(e);
                }
              },
              icon: Icon(
                Icons.g_mobiledata_rounded,
                size: 45,
                color: Colors.blueAccent,
              )),
          SizedBox(
            width: 5,
          ),
          IconButton(
              onPressed: () {
                try {
                  BasicsWidgets.Load(context);
                  FirebaseHelper().signInWithFacebook().then((UserCredential) {
                    BasicsWidgets.BackLoad(context);
                    user = UserCredential.user;
                    print(user);
                  });
                } on Error catch (e) {
                  print(e);
                }
              },
              icon: Icon(
                Icons.facebook_rounded,
                size: 35,
                color: Colors.blueAccent,
              )),
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: ((context) {
                      return AlertDialog(
                        title: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text("Entrer votre numéro de téléphone"),
                        ),
                        actions: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child:
                                TextF("Number phone", Number: true, NumberPone),
                          ),
                          Padding(
                              padding: EdgeInsets.all(10),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  FirebaseHelper()
                                      .SignWithNumber(NumberPone.text)
                                      .then((f) {
                                    showDialog(
                                        context: context,
                                        builder: ((context) {
                                          return AlertDialog(
                                            title: Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                  "Veuillez renseigner le code envoyer à votre numéro"),
                                            ),
                                            actions: [
                                              Padding(
                                                padding: EdgeInsets.all(10),
                                                child: TextF(
                                                    "Code reçu",
                                                    Number: true,
                                                    Code),
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.all(10),
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      FirebaseHelper()
                                                          .SignWithNumber(
                                                              NumberPone.text,
                                                              code: Code.text);
                                                    },
                                                    child: Text("Valider"),
                                                  ))
                                            ],
                                          );
                                        }));
                                  });
                                },
                                child: Text("Valider"),
                              ))
                        ],
                      );
                    }));
              },
              icon: Icon(
                Icons.phone_android,
                size: 35,
                color: Colors.blueAccent,
              )),
        ],
      )
    ];
    if (_log) {
      return listAuth;
    } else {
      return listLog;
    }
  }

  Widget TextF(String hint, entry,
      {bool obscure = false, bool email = false, bool Number = false}) {
    return TextField(
      controller: entry,
      keyboardType: (email)
          ? TextInputType.emailAddress
          : (Number)
              ? TextInputType.phone
              : TextInputType.text,
      decoration: InputDecoration(
        hintText: hint,
      ),
      obscureText: obscure,
    );
  }

  _handlelog() {
    if (_emailTec.text != "") {
      if (_passwordTec.text != "") {
        if (_log) {
          FirebaseHelper()
              .handleSignIn(_emailTec.text, _passwordTec.text)
              .then((User) {
            print(User);
          }).catchError((err) {
            BasicsWidgets.alert(err.toString(), context);
          });
        } else {
          if (_nomTec.text != "") {
            if (_prenomTec.text != "") {
              FirebaseHelper()
                  .handleCreate(_emailTec.text, _passwordTec.text,
                      _prenomTec.text, _nomTec.text)
                  .then((user) {
                print(user);
              });
              print(_emailTec.text);
            } else {
              BasicsWidgets.alert("Veuiller renseigner le prenom", context);
            }
          } else {
            BasicsWidgets.alert("Veuiller renseigner le nom", context);
          }
        }
      } else {
        BasicsWidgets.alert("Veuiller renseigner le mot de passe", context);
      }
    } else {
      BasicsWidgets.alert("Veuiller renseigner l'adresse email", context);
    }
  }
}
