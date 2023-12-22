import 'package:flutter/material.dart';
import 'package:flutter_mobile_barcode_qrcode_scanner/location_menu_screen.dart';
import 'package:flutter_mobile_barcode_qrcode_scanner/qr_scanner.dart';
import 'package:flutter_mobile_barcode_qrcode_scanner/selection_screen.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Navigation',
    home: LocationScreen()
  ));
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          )),
      title: "QR Scanner",
      home:SelectionScreen(), // to create the scelloton of the app
      debugShowCheckedModeBanner: false,
    );
  }
}
