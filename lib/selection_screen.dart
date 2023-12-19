import 'package:flutter/material.dart';
import 'package:flutter_mobile_barcode_qrcode_scanner/qr_scanner.dart';

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Selection Screen"),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("Qr and Barcode Scanner"),
            // backgroundColor: Colors.lightBlue,
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => QRScanner() ));
          }
        ),
      ),
    );
  }
}
