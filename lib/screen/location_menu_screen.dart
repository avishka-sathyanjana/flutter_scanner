import 'package:flutter/material.dart';
import '/style_varible/style_screen.dart';
import '../widget/button_widget.dart';
import 'results_screen.dart';
import 'scanner_menu_screen.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '/database/auth_file.dart';
import '/data_validations/login_validation.dart';
import 'package:provider/provider.dart';
import '/provider/location_state.dart';
import '/data_validations/loding_bar.dart';

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
      body: Center(
        
              child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        
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
              
                   const SizedBox(height: 30),
              
                 if (isQrScannerVisible)
                  Flexible(
                     fit:FlexFit.loose,
                      child: MobileScanner(
                        allowDuplicates: true,
                        onDetect: (barcode, args) async {
                          if (!isScanComplete) {
                            code = barcode.rawValue ?? '---';
                            isScanComplete = true;
                            var result = await AuthService().getLocation(code);
                            if (result.isEmpty) {
                              setState(() {
                                showError(context, "Invalid Location","Error",Icons.error,colorPlate3,Colors.red,Colors.red);
                                isScanComplete = false;
                                code = '';
                              });
                            } else {
                              setState(() {
                                Provider.of<LocationProvider>(context,listen: false).updateLocation(code);
                                Navigator.push(context, MaterialPageRoute(builder: (_) {
                                  return ScannerMenuScreen();
                                }));
                                  
                                code = ''; // code verible null after route
                              });
                            }
                          }
                        },
                      )

                  ),
              
              //add text 'Or'
        
                    !isQrScannerVisible?const Text('OR',
                     style: TextStyle(
                       fontFamily: fontRaleway,
                         fontSize: 20,
                         color: Colors.black),
                   ):SizedBox(),
        
              //     adding the input form
                   !isQrScannerVisible?LocationForm():SizedBox(),
                      ]
              
                    ),
        
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
    return  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter your location',
                style: TextStyle(fontSize: 20),
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
              const SizedBox(height:40),
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
                           showLoadingDialog(context);
                           var result = await AuthService().getLocation(locationCode.text);

                          setState(() {
                            activate=false;
                            showLoadingDialog(context);
                          });

                        if (result.isEmpty) {
                          setState(() {
                            activate=true;
                            showError(context, "Invalid location ","Error",Icons.error,colorPlate3,Colors.red,Colors.red);
                          });
                        } else {
                          setState((){

                            Provider.of<LocationProvider>(context,listen: false).updateLocation(locationCode.text);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ScannerMenuScreen()),
                            );
                            activate=true;
                            showError(context,"Valid Location","valid",Icons.offline_pin_sharp,Colors.green,Colors.white,Colors.black);

                          });

                        }
                      } else if (locationCode.text.isEmpty) {
                        setState(() {
                          showError(context, "Item code is empty","Error",Icons.error,colorPlate3,Colors.red,Colors.red);
                        });
                      }
                    },
                  ),
                ),
              ),
            ]),
      );
  }
}
