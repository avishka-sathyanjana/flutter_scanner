import 'package:flutter/material.dart';
import 'qr_scanner.dart';

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Selection Screen"),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("Qr and Barcode Scanner"),
            // backgroundColor: Colors.lightBlue,
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const QRScanner() ));
          }
        ),
      ),
    );
  }
}
