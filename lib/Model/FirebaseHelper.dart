import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseHelper{

  final auth = FirebaseAuth.instance;
  Future<User?> handleSignIn(String email, String password) async{
    final sign = await auth.signInWithEmailAndPassword(email: email, password: password);
    final User? user = sign.user;
    return user;
  }
    Future<User?> handleCreate(String email, String password,String nom, String prenom) async{
    final sign = await auth.createUserWithEmailAndPassword(email: email, password: password);
    final User user = sign.user!;
    String Uid = user.uid;

    Map map = {
      "Uid":Uid,
      "prenom": prenom,
      "nom":nom
    };

    addUser(Uid, map);

    return user;
  }
  static final entryPoint = FirebaseDatabase.instance.ref();
   final entry_user = entryPoint.child("users");

  addUser(String Uid, Map map){
    entry_user.child(Uid).set(map);
  }


}
