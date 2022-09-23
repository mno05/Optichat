import 'package:flutter/material.dart';

class LogController extends StatefulWidget {
  const LogController({super.key});

  @override
  State<LogController> createState() => _LogControllerState();
}

class _LogControllerState extends State<LogController> {
  bool _log = true;
  String log = "Login";
  TextEditingController _emailTec=TextEditingController();
  TextEditingController _passwordTec=TextEditingController();
  TextEditingController _nomTec=TextEditingController();
  TextEditingController _prenomTec=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Authentification")),
      body: Center(
        child: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width - 40,
              child: Center(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: ListTxtField(),
                    ),
                  ),
                ),
              ),
            ),
            TextButton(
                onPressed: () => setState(() {
                      _log = !_log;
                    }),
                child: Text(_log ? "S'inscrire" : "S'authentifier")),
            SizedBox(
              height: 5,
            ),
            ElevatedButton(onPressed: _handlelog, child: Text("Let's go")),
          ],
        )),
      ),
    );
  }

  List<Widget> ListTxtField() {
    List<Widget> listA = [
      const SizedBox(height: 30),
      TextF("Entrer votre email", _emailTec),
      TextF("Entrer votre passeword", obscure: true, _passwordTec),
      const SizedBox(height: 30),
    ];
    List<Widget> listL = [
      SizedBox(height: 20),
      TextF("Entrer votre email", _emailTec),
      TextF("Entrer votre passeword", obscure: true, _passwordTec),
      TextF("Entrer votre Nom", _nomTec),
      TextF("Entrer votre Prenom", _prenomTec),
      SizedBox(height: 20),
    ];
    if (_log) {
      return listA;
    } else {
      return listL;
    }
  }

  Widget TextF(String hint,entry, {bool obscure = false}) {
    return TextField(
      controller: entry,
      decoration: InputDecoration(
        hintText: hint,
      ),
      
      obscureText: obscure,
    );
  }

  _handlelog() {
    if (_emailTec.text!="") {
      if (_passwordTec.text!= "") {
        if (_log) {
          //TODO Methoder pour loger
        } else {
          if (_nomTec.text != "") {
            if (_prenomTec.text != "") {
              //TODO Methode pour enregistrer
          print(_emailTec.text);

            } else {
              alert("Veuiller renseigner le prenom");
            }
          } else {
            alert("Veuiller renseigner le nom");
          }
        }
      } else {
        alert("Veuiller renseigner le mot de passe");
      }
    } else {
      alert("Veuiller renseigner l'adresse email");
    }
  }

  alert(String msg) {
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
