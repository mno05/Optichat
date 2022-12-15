import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutterfirebase/Model/MyUser.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseHelper {
  final auth = FirebaseAuth.instance;
  Future<User?> handleSignIn(String email, String password) async {
    final sign =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    final User? user = sign.user;
    return user;
  }

  Future<User?> handleCreate(
      String email, String password, String nom, String prenom) async {
    final sign = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    final User user = sign.user!;
    String Uid = user.uid;

    Map map = {"Uid": Uid, "prenom": prenom, "nom": nom};

    addUser(Uid, map);

    return user;
  }

  static final entryPoint = FirebaseDatabase.instance.ref();
  final entry_user = entryPoint.child("Users");

  addUser(String Uid, Map map) {
    entry_user.child(Uid).set(map);
  }

  Future<MyUser> getUser(String uid) async {
    DatabaseEvent event = await entry_user.child(uid).once();
    MyUser user = MyUser(event.snapshot);
    return user;
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await auth.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  Future<String> SignWithNumber(String Number,{String? code}) async {
   late String smsCode;
   String authStatus="";

    await auth.verifyPhoneNumber(
      phoneNumber: Number,
      verificationCompleted: (PhoneAuthCredential credential) async {
      
      await auth.signInWithCredential(credential);
      
      },
      codeAutoRetrievalTimeout: (String verificationId) {

      },
      codeSent: (String verificationId, int? forceResendingToken) async{
        if(code!=null){
         smsCode = code;
    // Create a PhoneAuthCredential with the code
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);

    // Sign the user in (or link) with the credential
    await auth.signInWithCredential(credential);
        }
        else{
          smsCode="Pas";
        }
      },
      verificationFailed: (FirebaseAuthException error) {},
      
    );
    return smsCode;
  }
}
