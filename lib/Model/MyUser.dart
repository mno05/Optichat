import 'package:firebase_database/firebase_database.dart';

class MyUser{
  String? Uid;
  late String prenom;
  late String nom;
  late String imageUrl;
  late String initiales;
  
  MyUser(DataSnapshot Snapshot){
    Uid = Snapshot.key;
    dynamic map = Snapshot.value;
    prenom= map["prenom"];
    nom= map["nom"];
    imageUrl= map["imageUrl"];

    if(prenom!=null && prenom.length >0){
      initiales=prenom[0];
      
    }
  if(nom.isNotEmpty){
    if(initiales.isNotEmpty){
    initiales+=nom[0];
    }
    else{
      initiales=nom[0];
    }
  }
  } 
  Map toMap(){
    return {
      "Uid" : Uid,
      "prenom" : prenom,
      "nom" : nom,
      "imageUrl" : imageUrl
    };
  }
}