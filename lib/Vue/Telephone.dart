import 'package:flutter/material.dart';
import 'package:flutterfirebase/Model/DefaulValues.dart';
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
                    "Ex:+243817524267",
                    num,
                    Number: true,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ButtonValider(
                        context,
                        text: "Valider",
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Telephone(page: 1),
                              ));
                        },
                      ),
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
                    "Ex:706407",
                    num,
                    Number: true,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ButtonValider(
                        context,
                        text: "Login",
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Telephone(page: 1),
                              ));
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
}
