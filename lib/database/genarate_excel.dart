
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_barcode_qrcode_scanner/style_varible/style_screen.dart';
import 'package:flutter_mobile_barcode_qrcode_scanner/widget/button_widget.dart';
import 'package:lecle_downloads_path_provider/lecle_downloads_path_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:excel/excel.dart';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import '/data_validations/login_validation.dart';
class GenerateExcel {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Color getColorHexFromStr(String hexString) {
    hexString = hexString.replaceAll("#", "");
    int val = int.parse(hexString, radix: 16);
    return Color(val);
  }

  Future<String> exportExcel(String divition,String fileName) async {
    try {
      QuerySnapshot<Map<String, dynamic>> getData;
      if(divition=="Defult"){
        getData = await _db.collection("verify test").get();
      }else{
        getData = await _db.collection("verify test").where("division",isEqualTo: divition).get();
      }


      if (getData.docs.isNotEmpty) {
        // create excel file
        var excel = Excel.createExcel();
        var sheet = excel['sheet1'];
        // add header row
        CellStyle headerCellStyle = CellStyle(
          bold: true,
          italic: true,
          fontSize: 20,
          fontFamily: getFontFamily(FontFamily.Arial),
          fontColorHex: getColorHexFromStr("#000000").toString(), // Black color

        );
        
             var hedarName=[
               'item Name',
               "Bar-code",
               "New code",
               "old code",
               "propuse code"
               ,"location",
               "curentYear",
               "dateTime",
               "remarks",
               "status",
               "systemError"];

        for (int col = 0; col < hedarName.length; col++) {
          sheet.cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex:0))
            ..cellStyle = headerCellStyle
            ..value = TextCellValue(hedarName[col]); // Set cell value
        }


        for (QueryDocumentSnapshot document in getData.docs) {
          sheet.appendRow([
            TextCellValue(document['item Name'].toString()),
            TextCellValue(document['barcode'].toString()),
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

        var downloadsDirectory = await DownloadsPath.downloadsDirectory();
        var excelFilePath = join(downloadsDirectory!.path, '$fileName.xlsx');
        var fileBytes = excel.encode();
        File(excelFilePath)
          ..createSync(recursive: true)
          ..writeAsBytesSync(fileBytes!);

        print('Excel file exported to: $excelFilePath');
        return excelFilePath;
      }else{
         return "";
      }
    } catch (e) {
      print("Error export excel: $e");
      return '';
    }
  }
}
