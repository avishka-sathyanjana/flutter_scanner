import 'package:flutter/material.dart';
import 'package:flutter_mobile_barcode_qrcode_scanner/style_varible/style_screen.dart';
import '../widget/button_widget.dart';
import '/screen/result_screen_new.dart';
import 'qr_scanner.dart';
import '/database/auth_file.dart';
import '/data_validations/login_validation.dart';
import 'issue-screen.dart';
import '/widget/custom_dropdwon.dart';
import 'package:provider/provider.dart';
import '/provider/location_state.dart';


class ScannerMenuScreen extends StatefulWidget {
  static const scannerMenuScreenRoute="/scannerMenu-route";
  //final String location;

 // ScannerMenuScreen({});

  @override
  State<ScannerMenuScreen> createState() => _ScannerMenuScreenState();
}

class _ScannerMenuScreenState extends State<ScannerMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Menu'),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column( // Wrap the list of widgets with a Column
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Consumer<LocationProvider>(
                            builder: (context, locationProvider, child) {
                              return Text(
                                'Current Location:     ${locationProvider.location}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              );
                            },
                          ),
                          const Text(
                            'Number of Items Scanned :     ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),


                  SizedBox(height: 10,),
                  Image.asset(
                    'assets/images/barcode_scan.jpg',
                    width: 200, // Set the width as Zneeded
                    height: 200, // Set the height as needed

                  ),
                  ButtonWidget(
                    ctx: context,
                    buttonName: "Scan Bar Code",
                    buttonFontSize: 20,
                    buttonColor: Colors.transparent,
                    borderColor: Colors.pink,
                    textColor: Colors.pink,
                    buttonWidth: 220,
                    buttonHeight: 40,
                    buttonRadius: 15,
                    validationStates: () {
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QRScanner()
                          ),
                        );
                      });
        
                    },
                  ),
                  // add a space
                  const SizedBox(height: 20),
        
                  //add text 'Or'
                  const Text('OR',style: TextStyle(
                    fontFamily: fontRaleway,
                    fontSize: 18,
                  ),),
        
                  const SizedBox(height: 10),
                  // add a button
        
                  //     adding the input form
                   ItemForm(),
                ]
              //
            )
        ),
      ),
    );
  }
}

class ItemForm extends StatefulWidget{
  //final String locationCode;
  //const ItemForm({required this.locationCode});

  @override
  State<ItemForm> createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
  final TextEditingController assetsCode=TextEditingController();
  //String writeCode='';



  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),

      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Item Code category',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 6,),
            const DropDwon(),
            const SizedBox(height: 6,),
            const Text(
              'Enter the Item Code',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: assetsCode,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                // contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                labelText: 'Item Code',
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ButtonWidget(
                      ctx: context,
                      buttonName: 'Report',
                      buttonFontSize: 20.0,
                      buttonColor: Colors.orangeAccent,
                      borderColor: Colors.orangeAccent,
                      textColor: Colors.white,
                      buttonWidth: 150.0,
                      buttonHeight: 50.0,
                      buttonRadius: 10.0,
                      validationStates: (){
                         Navigator.push(context,MaterialPageRoute(builder: (_)=>const IssueScreen()));
                      },
                    ),
                    ButtonWidget(
                      ctx: context,
                      buttonName: 'Check',
                      buttonFontSize: 20.0,
                      buttonColor: Colors.blueAccent,
                      borderColor: Colors.blueAccent,
                      textColor: Colors.white,
                      buttonWidth: 150.0,
                      buttonHeight: 50.0,
                      buttonRadius: 10.0,
                      validationStates: ()async{
                        String dropValue=Provider.of<DropDwonData>(context,listen: false).value;
                        print("hsfghf$dropValue");
                        if(assetsCode.text.isNotEmpty && dropValue.isNotEmpty){
                          var result= await AuthService().getAssets(assetsCode.text,dropValue);
                          setState(() {
                            Navigator.push(context, MaterialPageRoute(builder: (_){
                              return ResultPage( activeScanner: () {  },assetsData:result,);
                            }));
                          });
                        }else if(assetsCode.text.isNotEmpty&&dropValue.isEmpty){
                          setState(() {
                             showError(context,"select item category");
                          });
                        }
                        else{
                          setState(() {
                            showError(context,"Item code is empty");
                          });
                        }

                      },
                    ),
                  ]

              ),
            ),
          ]
      ),
    );
  }
}
