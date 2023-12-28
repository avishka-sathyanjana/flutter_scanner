import 'package:flutter/material.dart';
import 'package:flutter_mobile_barcode_qrcode_scanner/widget/button_widget.dart';
import 'results_screen.dart';
import 'scanner_menu_screen.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '/database/auth_file.dart';
import '/data_validations/login_validation.dart';

String code = '';
final TextEditingController locationCode = TextEditingController();
String getLocationCode = '';

class LocationScreen extends StatefulWidget {
  static const locationScreenRoute = "/locationScreen-page";
  const LocationScreen({Key? key});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  bool isQrScannerVisible = false;
  bool isScanComplete = false;

  changeButtonState(BuildContext context) {
    setState(() {
      isQrScannerVisible = !isQrScannerVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Current Location'),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          if (!isQrScannerVisible)
            Image.asset(
              'assets/images/qr_scan.png',
              width: 200, // Set the width as needed
              height: 300, // Set the height as needed
            ),

          if (!isQrScannerVisible)
            ButtonWidget(
                ctx: context,
                buttonName: "Scan Location",
                buttonFontSize: 20,
                buttonColor: Colors.transparent,
                borderColor: Colors.indigoAccent,
                textColor: Colors.blueAccent,
                buttonWidth: 200,
                buttonHeight: 40,
                buttonRadius: 15,
                validationStates: () => changeButtonState(context)),

          if (isQrScannerVisible)
            ButtonWidget(
                ctx: context,
                buttonName: "Close Camera",
                buttonFontSize: 20,
                buttonColor: Colors.transparent,
                borderColor: Colors.red,
                textColor: Colors.red,
                buttonWidth: 200,
                buttonHeight: 40,
                buttonRadius: 15,
                validationStates: () => changeButtonState(context)),
          //
          // setState(() {
          //   isQrScannerVisible = !isQrScannerVisible;
          // });

          const SizedBox(height: 30),

          if (isQrScannerVisible)
            Expanded(
                flex: 4,
                child: MobileScanner(
                  allowDuplicates: true,
                  onDetect: (barcode, args) async {
                    if (!isScanComplete) {
                      code = barcode.rawValue ?? '---';
                      isScanComplete = true;
                      var result = await AuthService().getLocation(code);
                      if (result.isEmpty) {
                        setState(() {
                          showError(context, "Invalid Location");
                          isScanComplete = false;
                        });
                      } else {
                        setState(() {
                          Navigator.push(context, MaterialPageRoute(builder: (_) {
                            return ScannerMenuScreen(
                              locationCode: code,
                              writeLocation: locationCode.text,
                            );
                          }));
                        });
                      }
                    }
                  },
                )),

          //add text 'Or'
          const Text('Or'),

          const SizedBox(height: 10),
          // add a button

          //     adding the input form
          const LocationForm(),
        ]
                //
                )),
      ),
    );
  }
}

class LocationForm extends StatefulWidget {
  const LocationForm({Key? key});

  @override
  State<LocationForm> createState() => _LocationFormState();
}

class _LocationFormState extends State<LocationForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter your location',
              style: TextStyle(fontSize: 20),
              //change the alignment to left
            ),
            const SizedBox(height: 20),
            TextField(
              controller: locationCode,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                // contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                labelText: 'Location ID',
              ),
            ),

            // submit button
            Container(
              margin: const EdgeInsets.only(bottom: 30),
              child: Center(
                child: ButtonWidget(
                  ctx: context,
                  buttonName: "Submit Location",
                  buttonFontSize: 20,
                  buttonColor: Colors.blueAccent,
                  borderColor: Colors.indigoAccent,
                  textColor: Colors.white,
                  buttonWidth: 250,
                  buttonHeight: 50,
                  buttonRadius: 10,
                  validationStates: () async {
                    //call filter function
                    if (locationCode.text.isNotEmpty && code.isEmpty) {
                      var result =
                          await AuthService().getLocation(locationCode.text);
                      if (result.isEmpty) {
                        setState(() {
                          showError(context, "Invalid location ");
                        });
                      } else {
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ScannerMenuScreen(
                                      locationCode: code,
                                      writeLocation: locationCode.text,
                                    )),
                          );
                        });
                      }
                    }
                  },
                ),
              ),
            ),

          ]),
    );
  }
}
