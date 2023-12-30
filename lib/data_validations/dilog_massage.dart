import 'package:flutter/material.dart';
bool dilogState=false;
Future<void> showConfirmationDialog(BuildContext context,String head,String massage) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      // return an AlertDialog
      return AlertDialog(
        title: Text(head),
        content: Text(massage),
        actions: <Widget>[
          // "Cancel" button
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              dilogState=false;
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
          // "Accept" button
          TextButton(
            child: const Text('Accept'),
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