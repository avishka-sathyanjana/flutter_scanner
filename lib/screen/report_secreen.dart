
import 'package:flutter/material.dart';
import 'package:flutter_mobile_barcode_qrcode_scanner/style_varible/style_screen.dart';

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
        child: Text("genarate Reports"),
      ),
    );
  }
}
