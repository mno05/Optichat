import 'package:flutter/material.dart';
import 'package:flutterfirebase/Model/DefaulValues.dart';
import 'package:flutterfirebase/Model/FirebaseHelper.dart';
import 'package:flutterfirebase/Vue/widgets/BascisWidgets.dart';
import 'package:flutterfirebase/Vue/widgets/ButtonValider.dart';
import 'package:flutterfirebase/Vue/widgets/TextF.dart';
import 'package:google_fonts/google_fonts.dart';

class Email extends StatefulWidget {
  const Email({super.key});

  @override
  State<Email> createState() => _EmailState();
}

class _EmailState extends State<Email> {
  TextEditingController _emailTec = TextEditingController();
  TextEditingController _passwordTec = TextEditingController();
  TextEditingController _nomTec = TextEditingController();
  TextEditingController _prenomTec = TextEditingController();
  bool _log = true;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Def.defColor,
        shadowColor: Def.defColor,
        centerTitle: true,
        title: Text(
          "Se connecter par Email",
          style: GoogleFonts.nunito(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            margin: EdgeInsets.only(top: height * 0.14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: ListTxtField(context),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> ListTxtField(context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    List<Widget> listAuth = [
      TextF("Email", _emailTec, email: true),
      TextF("Mot de passe", obscure: true, _passwordTec),
      SizedBox(height: height * 0.02),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonValider(
            context,
            text: "Login",
            onTap: _handlelog,
          ),
        ],
      ),
      Container(
        margin: const EdgeInsets.only(bottom: 0),
        child: TextButton(
          onPressed: () {
            setState(() {
              _log = false;
            });
          },
          child: Text(
            "Creer un compte",
            style: GoogleFonts.nunito(
              color: Colors.black54,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      )
    ];
    List<Widget> listLog = [
      TextF("Email", _emailTec, email: true),
      TextF("Mot de passe", obscure: true, _passwordTec),
      TextF("Nom", _nomTec),
      TextF("Prenom", _prenomTec),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonValider(
            context,
            text: "Create",
            onTap: _handlelog,
          )
        ],
      ),
    ];
    if (_log) {
      return listAuth;
    } else {
      return listLog;
    }
  }

  void _handlelog() {
    BasicsWidgets.Load(context);
    if (_emailTec.text != "") {
      if (_passwordTec.text != "") {
        if (_log) {
          FirebaseHelper()
              .handleSignIn(_emailTec.text, _passwordTec.text)
              .then((User) {
            Navigator.pop(context);
            Navigator.pop(context);

            print(User);
          }).catchError((err) {
            print(err.toString());
            switch (err.toString()) {
              case "[firebase_auth/invalid-email] The email address is badly formatted.":
                BasicsWidgets.alert(
                    "Votre addresse email est invalide, veuillez vérifier l'orthographe",
                    context,
                    Titre: "L'email entré est invalide");
                break;
              case "[firebase_auth/unknown] com.google.firebase.FirebaseException: An internal error has occurred. [ Network is unreachable ]":
                BasicsWidgets.alert(
                    "Optichat n'arrive pas à se connecter. Veullez verifier votre connection internet.",
                    context,
                    Titre: "Problème de connection");
                break;
              case "[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.":
                BasicsWidgets.alert(
                    "Votre addresse email n'est pas reconnue, veuillez créer un compte.",
                    context,
                    Titre: "L'addresse email non reconnu");
                break;
              case "[firebase_auth/wrong-password] The password is invalid or the user does not have a password.":
                BasicsWidgets.alert(
                    "Le mot de passé entré est incorrecte ou a été modifié.",
                    context,
                    Titre: "Mot de passe incorrect");
                break;
              case "[firebase_auth/email-already-in-use] The email address is already in use by another account.":
                BasicsWidgets.alert(
                    "L'addresse email est déjà utilisée par un notre compte",
                    context,
                    Titre: "Addres email usilisée");
                break;

              default:
                BasicsWidgets.alert(err.toString(), context);
            }
          });
        } else {
          if (_nomTec.text != "") {
            if (_prenomTec.text != "") {
              FirebaseHelper()
                  .handleCreate(_emailTec.text, _passwordTec.text,
                      _prenomTec.text, _nomTec.text)
                  .then((user) {
                Navigator.pop(context);
                Navigator.pop(context);

                print(user);
              }).catchError((err) {
                print(err.toString());
                switch (err.toString()) {
                  case "[firebase_auth/invalid-email] The email address is badly formatted.":
                    BasicsWidgets.alert(
                        "Votre addresse email est invalide, veuillez vérifier l'orthographe",
                        context,
                        Titre: "L'email entré est invalide");
                    break;
                  case "[firebase_auth/weak-password] Password should be at least 6 characters":
                    BasicsWidgets.alert(
                        "Le mot de passe doit containir au minimum 6 characters.",
                        context,
                        Titre: "Mot de passe invalide");
                    break;
                  default:
                    BasicsWidgets.alert(err.toString(), context);
                }
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
