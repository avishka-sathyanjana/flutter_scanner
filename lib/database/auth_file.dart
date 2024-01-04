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
  final CollectionReference collectionNewDataFile =FirebaseFirestore.instance.collection("assets_data");
  final CollectionReference assetsDataNew =FirebaseFirestore.instance.collection("assetsNewDB");
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
    await assetsDataNew.add(assetsData);
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
Future<List<AssetsVarify>>getAssets(String assetsId ,String itemOption)async{

  try {
       QuerySnapshot<Map<String, dynamic>> snapshot;
       QuerySnapshot<Map<String, dynamic>>verifySnap;
       //get caret year..............
       DateTime curent=DateTime.now();
       String curentYear=curent.year.toString();
        if(itemOption=='1'){
            snapshot = await _db
              .collection("assetsNewDB")
              .where("NewCode-last",isEqualTo:assetsId.toString())
              .get();
            //get data vrefiy table
            verifySnap=await _db.
            collection("verify table").
            where("newCode",isEqualTo:assetsId).
            where("curentYear",isEqualTo:curentYear).get();

        }else if(itemOption=='2'){
           snapshot = await _db
              .collection("assetsNewDB")
              .where("ProposedCode-Last", isEqualTo:assetsId.toString())
              .get();

           //get data vrefiy table
           verifySnap=await _db.
           collection("verify table").
           where("popuseCode",isEqualTo:assetsId).
           where("curentYear",isEqualTo:curentYear).get();

        }else if(itemOption=='3'){

            snapshot = await _db
              .collection("assetsNewDB")
              .where("Oldcode-last", isEqualTo:assetsId.toString())
              .get();

            //get data vrefiy table
            verifySnap=await _db.
            collection("verify table").
            where("oldCode",isEqualTo:assetsId).
            where("curentYear",isEqualTo:curentYear).get();
          print("new daata${snapshot.docs.length}");
        }else{

             snapshot = await _db
              .collection("assetsNewDB")
              .where("Barcode",isEqualTo:int.parse(assetsId))
              .get();

             //get data vrefiy table
             verifySnap=await _db.
             collection("verify table").
             where("assets code",isEqualTo:assetsId).
             where("curentYear",isEqualTo:curentYear).get();

          print("new daata${snapshot.docs.length}");
        }


      //
      // verifySnap=await _db.
      //   collection("verify table").
      //   where("assets code",isEqualTo:assetsId).
      //   where("curentYear",isEqualTo:curentYear).get();
      //  print("new daata${snapshot.docs.length}");


    if (snapshot.docs.isNotEmpty && verifySnap.docs.isEmpty) {

      return  Future.value( snapshot.docs.map((document) {
        return AssetsVarify(
            assetsItemeName: document["Description of Articles 2 (Sub item of main item)"],
            mainAssetsType:document['Asset Type'] ,
            itemCode:document['Barcode'].toString() ,
            Division:document['Division'],
            location:document['Location'],
            newCode: document['NewCode-last'],
            oldCode: document['Oldcode-last'],
            propuseCode: document['ProposedCode-Last'],
            isNotverifyCurentYear: true
        );
      }).toList()
      );
     
    } else if(verifySnap.docs.isNotEmpty&&verifySnap.docs.isNotEmpty){

        return Future.value( snapshot.docs.map((document) {
          return AssetsVarify(
              assetsItemeName: document["Description of Articles 2 (Sub item of main item)"],
              mainAssetsType:document['Asset Type'] ,
              itemCode:document['Barcode'].toString(),
              Division:document['Division'],
              location:document['Location'],
              newCode: document['NewCode-last'],
              oldCode: document['Oldcode-last'],
              propuseCode: document['ProposedCode-Last'],
              allredyVerify: true
          );
        }).toList()
        );
    } else {
      // Handle the case where no matching document is found
      return Future.value([]); // Or throw an exception, or handle it as appropriate
    }
  } catch (e) {
    print("Error in getAssets: $e");
    // Handle the error or rethrow it based on your requirements
    return Future.value([]); // Or throw an exception, or handle it as appropriate
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
Future<void>verifyTable(
    String assetsCode,
    String location,
    String remarks,
    String states,
    String itemNewCode,
    String itemOldCode,
    String itemPropuseCode)async{
    String userId=getUserId();
    DateTime curent=DateTime.now();
    String curentYear=curent.year.toString();
    Timestamp dateTime=Timestamp.fromDate(curent);
    Map<String,dynamic>data={
      'assets code':assetsCode,
      'newCode':itemNewCode,
      'oldCode':itemOldCode,
      'popuseCode':itemPropuseCode,
      'dateTime':curent.toString(),
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