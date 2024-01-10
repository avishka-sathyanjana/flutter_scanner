


import 'dart:async';


import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '/model_data/local_db.dart';
import '/database/get_local_data.dart';

class DatabaseHelpr{
 static Database ?_database;

 Future<Database>get database async {
   if(_database !=null)return _database!;
   _database =await initDatabse();
   return _database!;
 }

  Future<Database> initDatabse()async {
   final path=join(await getDatabasesPath(),'assets.db');
   return   await openDatabase(path,version: 1,onCreate: _createDatabse);
  }


  FutureOr<void> _createDatabse(Database db, int version)async {
   // create table stro assets data ........
    await db.execute('''
      CREATE TABLE assetsDB (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        barcode TEXT,
        assetsType TEXT,
        divition TEXT,
        location TEXT,
        itemName TEXT,
        newCode TEXT,
        newCodeLast TEXT,
        oldCode TEXT,
        oldCodeLast TEXT,
        propuseCode TEXT,
        propuseCodeLast TEXT
      )
    ''');
  }
// insert data .............
  Future<void>insertData(List<LocalDataStro>dataList)async{
     final db=await database;
     try{
         for(LocalDataStro data in dataList){
           await db.insert("assetsDB", {
             'barcode':data.barcode ,
             'assetsType':data.assetsType,
             'divition':data.divition,
             'location':data.location ,
             'itemName':data.itemName ,
             'newCode':data.newCode ,
             'newCodeLast':data.newCodeLast ,
             'oldCode':data.oldCode ,
             'oldCodeLast':data.oldCodeLast ,
             'propuseCode':data.propuseCode ,
             'propuseCodeLast':data.propuseCodeLast
           });

         }
     }catch(e){
       print("Error insert data:$e");
     }
  }

  Future<List<Map<String, dynamic>>> searchByBarcode(String barcode) async {
    final Database db = await database;
    List<Map<String,dynamic>>result=[];
    try{
        var data= db.query(
          "assetsDB",
           where: 'barcode = ?',
           whereArgs: [barcode],
        );

        return data;

    }catch(e){
      print("searching error:${e}");
      return result;
    }

  }


}