
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '/model_data/AssetsData.dart';
import '/model_data/local_db.dart';
import '/sql_local_db/sql_helper.dart';

class LocalFeach{
  final FirebaseFirestore _db=FirebaseFirestore.instance;
  final FirebaseAuth _auth=FirebaseAuth.instance;

  Future<void>getAssetsCollection()async{
    List<LocalDataStro>assetsList=[];
    var list=[];

    try{
      QuerySnapshot querySnapshot=await _db.collection("assetsCollection").get();


      for(DocumentSnapshot doc in querySnapshot.docs){
           // print("data collection${doc['Barcode']}");
           LocalDataStro localDataStro=LocalDataStro.fromFirestore(doc);
           assetsList.add(localDataStro);
             //list.add(doc);
      }
          print("complete assing data");
          print("complete assing data length${assetsList.length}");
        if(assetsList.isNotEmpty){
            await DatabaseHelpr().insertData(assetsList);
        }else{
          print("error list is empty");
        }
    }catch(e){
      print("Error get collection:$e");

    }
  }

}