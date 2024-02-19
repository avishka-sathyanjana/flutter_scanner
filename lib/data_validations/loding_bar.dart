import 'package:flutter/material.dart';

bool activate = true;
Future<void> showLoadingDialog(BuildContext context) async {
  if (activate) {
    showDialog(context: context, builder: (context){
       return const Center(
         child: CircularProgressIndicator(
           color: Colors.white,
           strokeWidth: 6,
         ),
       );
    });
  } else {
    Navigator.of(context).pop();
  }
}
