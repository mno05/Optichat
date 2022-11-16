import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/Model/FirebaseHelper.dart';
import 'package:flutterfirebase/Model/MyUser.dart';

class ProfilController extends StatefulWidget {
  const ProfilController({super.key});

  @override
  State<ProfilController> createState() => _ProfilControllerState();
}

class _ProfilControllerState extends State<ProfilController> {
  User? user = FirebaseAuth.instance.currentUser;
  MyUser? myUser;
  //  intialisation de myUser

  @override
  void initState() {
    FirebaseHelper().getUser("1").then(((value) {
      setState(() {
        this.myUser = value;
      });
    }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (myUser == null)
        ? Column(
            children: [
              Center(
                child: Text("Profil : ${user!.email}"),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    setState(() {});
                  },
                  child: Text("Changer"))
            ],
          )
        : Scaffold(
            appBar: AppBar(title: Text(myUser!.prenom)),
            body: Center(child: Text("2")),
          );
  }
}
