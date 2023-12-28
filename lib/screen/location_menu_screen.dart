import 'package:flutter/material.dart';
import 'results_screen.dart';
import 'scanner_menu_screen.dart';
import 'package:mobile_scanner/mobile_scanner.dart';


 String code='';
 final TextEditingController locationCode=TextEditingController();
 String getLocationCode='';

class LocationScreen extends StatefulWidget {
  static const locationScreenRoute="/locationScreen-page";
  const LocationScreen({Key? key});

  @override
  _LocationScreenState createState() => _LocationScreenState();

}

class _LocationScreenState extends State<LocationScreen> {

  bool isQrScannerVisible = false;
  bool isScanComplete = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
      ),
      body: Center(

          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(

                  child: const Text('Scan Location'),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => const SecondRoute()
                    //   ),
                    // );

                    setState(() {
                      isQrScannerVisible = !isQrScannerVisible;
                    });


                  },
                ),

                const SizedBox(height: 30),

                if (isQrScannerVisible)
                  Expanded(
                      flex: 4,
                      child: MobileScanner(
                        allowDuplicates: true,
                        onDetect: (barcode, args){
                          if(!isScanComplete){
                             code = barcode.rawValue ?? '---';
                             isScanComplete = true;
                            print("code =========>$code");

                            Navigator.push(context, MaterialPageRoute(builder: (_){
                                return ScannerMenuScreen(locationCode: code,);
                            }));

                          }
                        },
                      )
                  ),

                //add text 'Or'
                const Text('Or'),

                const SizedBox(height: 30),
                // add a button

                //     adding the input form
                const LocationForm(),
              ]
            //
          )
      ),
    );
  }
}

class LocationForm extends StatefulWidget{
  const LocationForm({Key? key});

  @override
  State<LocationForm> createState() => _LocationFormState();
}

class _LocationFormState extends State<LocationForm> {
  @override
  Widget build(BuildContext context){
    return Column(
        children: [
          const Text(
            'Enter your location',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),

           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical:20),
            child: TextField(
              controller: locationCode,
              onChanged: (value){
                    setState(() {
                        getLocationCode=value;

                    });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                // contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                labelText:'Location ID',
              ),
            ),

          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: (){
              //call filter function
              if(getLocationCode.isNotEmpty&&code.isEmpty){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  ScannerMenuScreen(
                        locationCode: code,
                        writeLocation: getLocationCode,
                      )
                  ),
                );
              }

            },
            child: const Text('Submit'),
          ),
        ]
    );
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
        child: ElevatedButton(
          //go to the previous window
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}