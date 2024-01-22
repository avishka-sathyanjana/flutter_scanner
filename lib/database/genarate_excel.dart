
import 'package:lecle_downloads_path_provider/lecle_downloads_path_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:excel/excel.dart';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

class GenarateExcel{
  final FirebaseFirestore _db=FirebaseFirestore.instance;
   Future<void>exportExcel()async{
     try{
          QuerySnapshot<Map<String,dynamic>>getData;
          QuerySnapshot<Map<String,dynamic>>getAssets;
          getData=await _db.collection("verify table").get();
          getAssets=await _db.collection("assetsCollection").where("Division",isEqualTo:'CDF').get();

          if(getData.docs.isNotEmpty){
            // create excel file
            var excel=Excel.createExcel();
            var sheet=excel['sheet1'];
            // add hedre row
            CellStyle cellStyle = CellStyle(
              bold: true,
              italic: true,
              fontFamily: getFontFamily(FontFamily.Comic_Sans_MS),
              rotation: 0,
              
            );
              sheet.appendRow([TextCellValue("item Name"),TextCellValue("Bar-code")]);

            // add value cel
            for(QueryDocumentSnapshot document in getData.docs){
                  sheet.appendRow([
                    TextCellValue( document['item Name'].toString()),
                    TextCellValue( document['barcode'].toString()),
                    TextCellValue(document['new code'].toString()),
                    TextCellValue(document['old code'].toString()),
                    TextCellValue(document['propuse code'].toString()),
                    TextCellValue(document['location'].toString()),
                    TextCellValue(document['curentYear'].toString()),
                    TextCellValue(document['dateTime'].toString()),
                    TextCellValue(document['remarks'].toString()),
                    TextCellValue(document['status'].toString()),
                    TextCellValue(document['systemError'].toString()),
                  ]);
            }

           //  CellStyle missItemCellStyle = CellStyle(
           //    bold: true,
           //    italic: true,
           //    underline: Underline.Single,
           //    fontSize: 16,  // Set the font size to 16 (you can adjust as needed)
           //    fontFamily: getFontFamily(FontFamily.Comic_Sans_MS),
           // // Red color
           //  );


            // sheet.appendRow([
            //   const TextCellValue('Miss item'),
            // ]);
            // var missItemCell = sheet.cell(CellIndex.indexByString("A${sheet.maxRows}"));
            // missItemCell.cellStyle = missItemCellStyle;
            //
            // var i=0;
            // for (QueryDocumentSnapshot doc in getAssets.docs) {
            //   // Ensure i is within bounds
            //   if (i < getData.docs.length) {
            //     if (doc['Barcode'].toString() != getData.docs[i]['barcode'].toString()) {
            //       sheet.appendRow([
            //         TextCellValue(doc['Description of Articles 2 (Sub item of main item)'].toString()),
            //         TextCellValue(doc['Barcode'].toString()),
            //         TextCellValue(doc['New code'].toString()),
            //         TextCellValue(doc['Old code'].toString()),
            //         TextCellValue(doc['Proposed Code'].toString()),
            //         TextCellValue(doc['Location'].toString()),
            //         TextCellValue(doc['Division'].toString()),
            //       ]);
            //     }
            //     i++; // Increment i only if it's within bounds
            //   } else {
            //     print('Warning: getData.docs index out of bounds');
            //   }
            // }
            //

            var downloadsDirectory=await DownloadsPath.downloadsDirectory();
            var excelFilePath = join(downloadsDirectory!.path, 'CDF_exl.xlsx');
            var fileBytes = excel.encode();
            File(excelFilePath)
              ..createSync(recursive: true)
              ..writeAsBytesSync(fileBytes!);

            print('Excel file exported to: $excelFilePath');
          }

     }catch(e){
       print("Error export excel:$e");
     }
   }
}