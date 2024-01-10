
import 'package:cloud_firestore/cloud_firestore.dart';

class LocalDataStro{

  final String barcode;
  final String assetsType;
  final String divition;
  final String location;
  final String itemName;
  final String newCode;
  final String newCodeLast;
  final String oldCode;
  final String oldCodeLast;
  final String propuseCode;
  final String propuseCodeLast;

  LocalDataStro({
    required this.barcode,
    required this.assetsType,
    required this.divition,
    required this.location,
    required this.itemName,
    required this.newCode,
    required this.newCodeLast,
    required this.oldCode,
    required this.oldCodeLast,
    required this.propuseCode,
    required this.propuseCodeLast

  });


  factory LocalDataStro.fromFirestore(DocumentSnapshot doc) {
   // Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
   // print("data collection${data}");

    return LocalDataStro(
      barcode: doc['Barcode'].toString(),
      assetsType: doc['Asset Type'].toString(),
      divition: doc['Division'].toString(),
      location: doc['Location'].toString(),
      itemName: doc['Description of Articles 2 (Sub item of main item)'].toString(),
      newCode: doc['New code'].toString(),
      newCodeLast: doc['NewCode-last'].toString(),
      oldCode: doc['Old code'].toString(),
      oldCodeLast: doc['Oldcode-last'].toString(),
      propuseCode: doc['Proposed Code'].toString(),
      propuseCodeLast: doc['Proposed Code'].toString(),
    );

  }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'id':id,
  //     'barcode': barcode,
  //     'assetsType': assetsType,
  //     'divition': divition,
  //     'location': location,
  //     'itemName': itemName,
  //     'newCode': newCode,
  //     'newCodeLast': newCodeLast,
  //     'oldCode': oldCode,
  //     'oldCodeLast': oldCodeLast,
  //     'propuseCode': propuseCode,
  //     'propuseCodeLast': propuseCodeLast,
  //   };
  // }



}