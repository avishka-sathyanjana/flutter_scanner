import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '/model_data/AssetsData.dart';

class AuthService{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final FirebaseFirestore _db=FirebaseFirestore.instance;
  // make assets table
  final CollectionReference collectionReference=FirebaseFirestore.instance.collection('assets');
  final CollectionReference collectionRefLocation=FirebaseFirestore.instance.collection('location');
  final CollectionReference collectionVerfyTable=FirebaseFirestore.instance.collection("verify table");
  final CollectionReference collectionIssuesTable=FirebaseFirestore.instance.collection("Issue");
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
    await collectionRefLocation.add(assetsData);
}
  //upload the location json file
  Future<void>uploadLocation(Map<String,dynamic>location)async{
    await collectionReference.add(location);
  }
  //get user id ........................
  String getUserId(){
    User? user=FirebaseAuth.instance.currentUser;
    if(user !=null){
      return user.uid;
    }else{
      return "no user sing in";
    }
  }


//fetch data assets collection.........................
Future<List<AssetsVarify>>getAssets(String AssetsId)async{
  try {
    var snapshot = await _db
        .collection("assets")
        .where("Asset ID", isEqualTo:AssetsId)
        .get();

    //get caret year..............
    DateTime curent=DateTime.now();
    String curentYear=curent.year.toString();

    var verifySnap=await _db.
        collection("verify table").
        where("assets code",isEqualTo:AssetsId).
        where("curentYear",isEqualTo:curentYear).get();


    if (snapshot.docs.isNotEmpty &&verifySnap.docs.isEmpty) {

      return snapshot.docs.map((document) {
        return AssetsVarify(
            assetsItemeName: document["Name of the Item"],
            mainAssetsType:document['Main Asset Type'] ,
            itemCode:document['Asset ID'],
            Division:document['Division'],
            location:document['Location'],
            isNotverifyCurentYear: true
        );
      }).toList();
     
    } else if(verifySnap.docs.isNotEmpty&&verifySnap.docs.isNotEmpty){

        return snapshot.docs.map((document) {
          return AssetsVarify(
              assetsItemeName: document["Name of the Item"],
              mainAssetsType:document['Main Asset Type'] ,
              itemCode:document['Asset ID'],
              Division:document['Division'],
              location:document['Location'],
              allredyVerify: true
          );
        }).toList();

    } else {
      // Handle the case where no matching document is found
      return []; // Or throw an exception, or handle it as appropriate
    }
  } catch (e) {
    print("Error in getAssets: $e");
    // Handle the error or rethrow it based on your requirements
    return []; // Or throw an exception, or handle it as appropriate
  }
}

//feach location collection.................
Future<List<AssetsLocation>>getLocation(String locationCode)async{
    try{
      var snapShot= await _db.collection("location").
      where("Location Code",isEqualTo: locationCode).get();

      if(snapShot.docs.isNotEmpty){
          return snapShot.docs.map((value){
               return AssetsLocation(
                   locationId:value["L_ID"],
                   locationCode:value["Location Code"]
               );
         }).toList();
      }else{
        return [];
      }
    }catch(e){
      print("Error:$e");
      return [];
    }
}
//verify data table.......................
Future<void>verifyTable(String assetsCode,String location,String remarks,String states)async{
    String userId=getUserId();
    DateTime curent=DateTime.now();
    String curentYear=curent.year.toString();
    Timestamp dateTime=Timestamp.fromDate(curent);
    Map<String,dynamic>data={
      'assets code':assetsCode,
      'date time':dateTime,
      'location':location,
      'remarks':remarks,
      'statas':states,
      'curentYear':curentYear,
      'user id':userId,
    };
    
    collectionVerfyTable.add(data).then((DocumentReference documentRef){
      print("data save firebase:$documentRef");
    }).catchError((onError){
      print("Error data save:$onError");
    });


}
//add issues  data for table
  Future<void>addIssues(
      String issueType,
      String itemCategory,
      String itemCondition,
      String itemType,
      String location,
      String model,
      String remarks,
      String assetsCode,
      String previouseCode,
      )async{
    String userId=getUserId();
    DateTime curent=DateTime.now();
    String curentYear=curent.year.toString();
    Timestamp dateTime=Timestamp.fromDate(curent);
    Map<String,dynamic>data={
      'IssueType':issueType,
      'ItemCategory':itemCategory,
      'ItemCondition':itemCondition,
      'ItemType':itemType,
      'Location':location,
      'curentYear':curentYear,
      'Model':model,
      'Remarks':remarks,
      'assetsCode':assetsCode,
      'dateTime':dateTime,
      'previousCode':previouseCode,
      'userId':userId


    };

    collectionIssuesTable.add(data).then((DocumentReference documentRef){
      print("data save firebase:$documentRef");
    }).catchError((onError){
      print("Error data save:$onError");
    });


  }



}