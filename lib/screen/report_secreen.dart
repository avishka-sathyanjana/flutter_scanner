
import 'package:flutter/material.dart';
import '/style_varible/style_screen.dart';
import '/database/genarate_excel.dart';

class ReportGenarte extends StatefulWidget {
  const ReportGenarte({super.key});

  @override
  State<ReportGenarte> createState() => _ReportGenarteState();
}

class _ReportGenarteState extends State<ReportGenarte> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: colorPlate2,
         title: const Text(
           "Reports",style: TextStyle(
           fontSize: 20,
           fontFamily: fontRaleway,
           color: Colors.white
         ),
         ),
      ),
      body: Center(
        child:ElevatedButton(onPressed: () async{
          await GenarateExcel().exportExcel();
        },
        child: const Text("reports"),
        ),
      ),
    );
  }
}
