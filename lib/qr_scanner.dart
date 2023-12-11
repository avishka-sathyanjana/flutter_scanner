import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_barcode_qrcode_scanner/results_screen.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

const bgColor = Color(0xfffafafa);

class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();
}
class _QRScannerState extends State<QRScanner> {

  bool isScanComplete = false;

  void closeScreen(){
    isScanComplete = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "QR Scanner",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            letterSpacing: 1,
          ),
        ),
      ), //
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // header part
            const Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Place the QR code inside the frame to scan",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          letterSpacing: 1,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Scanning will happen automatically",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          letterSpacing: 1,
                        ),
                      ),
                    ]
                )
            ),

            // scanner part
            Expanded(
                flex: 4,
                child: MobileScanner(
                  allowDuplicates: true,
                  onDetect: (barcode, args){
                    if(!isScanComplete){
                      String code = barcode.rawValue ?? '---';
                      isScanComplete = true;
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => ResultScreen(
                            closeScreen: closeScreen,
                            code: code,
                          )
                      ));
                  }
                  },
                )
            ),
            const SizedBox(
                height: 30
            ),

            const Expanded(
              child:  Text(
                "UCSC-ERP",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  letterSpacing: 1,
                ),
              ),
            ),
          ],//children
        ),
      ),
    );
  }


}// QRScanner
