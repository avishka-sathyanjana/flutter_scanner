import 'package:flutter/material.dart';
import 'package:flutter_mobile_barcode_qrcode_scanner/style_varible/style_screen.dart';
bool dilogState=false;
Future<void> showConfirmationDialog(BuildContext context,String head,String massage) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      // return an AlertDialog
      return AlertDialog(
        backgroundColor:Colors.white,
        elevation: 4,
        shadowColor: Colors.white,
        title: Text(head),
        content: Text(massage),
        actions: <Widget>[
          // "Cancel" button
          TextButton(
            child: const Text('No'),
            onPressed: () {
              dilogState=false;
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
          // "Accept" button
          TextButton(
            child: const Text('Yes'),
            onPressed: () {
              dilogState=true;
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}