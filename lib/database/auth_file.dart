import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/model_data/AssetsData.dart';

class AuthService{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final FirebaseFirestore _db=FirebaseFirestore.instance;
  // make assets table
  final CollectionReference collectionReference=FirebaseFirestore.instance.collection('assets');
  bool isLogin=false;

  Future<User?>signInWithEmailAndPassword(String email,String password)async{
    try{
      UserCredential userCredential= await _auth.signInWithEmailAndPassword(
          email: email,
          password:password
      );
      return userCredential.user;
    }catch(e){
       print("Error sing in ");
       return null;
    }

  }
  //currently login
  Future<bool> isUserLoggedIn() async {
    User? user = _auth.currentUser;
    return user != null;
  }

  //sing out function
 void logOut(){
    _auth.signOut();
}
//is login or not check
  Future<bool> isLoginCheck() async {
    final Completer<bool> completer = Completer<bool>();
     _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        completer.complete(true);
       // isLogin=true;
      } else {
        completer.complete(false);
        //isLogin=false;
      }
    });
    return completer.future;
  }

  // upload the data file to firebase
Future<void>uploadUserDataFormJson(Map<String,dynamic>assetsData)async{
    await collectionReference.add(assetsData);
}

//fetch data assets collection
Future<AssetsVarify>getAssets(String AssetsId)async{
    final snapShot=await _db.collection("assets").where("Asset ID",isEqualTo: AssetsId).get();
    return snapShot.docs.map((e) => AssetsVarify(
        assetsItemeName:e["Name of the Item"],
        mainAssetsType:e["Main Asset Type"],
        itemCode:e["Asset ID"],
        Division:e["Division"],
        location:e["Location"])
    ).single;
}


}