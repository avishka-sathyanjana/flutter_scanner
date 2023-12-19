import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:qr_flutter/qr_flutter.dart';

class ResultScreen extends StatelessWidget {

  final String code;
  final Function() closeScreen;

  const ResultScreen({super.key, required this.closeScreen, required this.code});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
              onPressed: (){
                closeScreen();
                Navigator.pop(context);
              },
              icon : const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.black87,
              )),
          centerTitle: true,
          title: const Text(
            "QR Scanner 2",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              letterSpacing: 1,
            ),
          ),
        ),
        body:  Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // f// to generate the qr code
                // QrImageView(
                //   data: code,
                //   version: QrVersions.auto,
                //   size: 320,
                //   gapless: false,
                // ),
                Text(
                  code,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(
                    height: 10
                ),
                const Text(
                  "Results",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(
                    height: 10
                ),

                SizedBox(
                    width: MediaQuery.of(context).size.width - 100,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),

                      onPressed: (){},

                      child: const Text(
                        "Copy",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          letterSpacing: 1,
                        ),
                      ),
                    )
                )



              ],
            )

        )
    );
  }
}
