import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/Controllers/ContactController.dart';
import 'package:flutterfirebase/Controllers/MessageController.dart';
import 'package:flutterfirebase/Controllers/ProfilController.dart';

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final device = Theme.of(context).platform;
    if (device == TargetPlatform.iOS) {
      return CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            backgroundColor: Colors.blue,
            activeColor: Colors.black,
            inactiveColor: Colors.white,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.message)),
              BottomNavigationBarItem(icon: Icon(Icons.supervisor_account)),
              BottomNavigationBarItem(icon: Icon(Icons.account_circle)),
            ],
          ),
          tabBuilder: ((BuildContext context, index) {
            var controllerSelected = Controllers()[index];
            return Scaffold(
              appBar: AppBar(
                title: Text("OptiChat"),
                centerTitle: true,
              ),
              body: controllerSelected,
            );
          }));
    } else {
      return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: Text("OptiChat"),
              centerTitle: true,
              bottom: TabBar(tabs: [
                Tab(icon: Icon(Icons.message),),
                Tab(icon: Icon(Icons.supervisor_account),),
                Tab(icon: Icon(Icons.account_circle),),
              ]),
            ),
            body: TabBarView(children: Controllers()),
          ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Main'),
      ),
      body: Center(child: Text("Connecté")),
    );
  }
}

List<Widget> Controllers() {
  return [MessageController(), ContactController(), ProfilController()];
}
