import 'package:flutter/material.dart';
import '../widget/button_widget.dart';
import '/screen/result_screen_new.dart';
import 'qr_scanner.dart';
import '/database/auth_file.dart';
import '/data_validations/login_validation.dart';
import 'issue-screen.dart';


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
      body: Center(

          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonWidget(
                  ctx: context,
                  buttonName: "Scan Item Code",
                  buttonFontSize: 20,
                  buttonColor: Colors.transparent,
                  borderColor: Colors.indigoAccent,
                  textColor: Colors.blueAccent,
                  buttonWidth: 250,
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
                const SizedBox(height: 30),

                //add text 'Or'
                const Text('Or'),

                const SizedBox(height: 30),
                // add a button

                //     adding the input form
                 ItemForm(),
              ]
            //
          )
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

            Container(
              child: Padding(
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
                        buttonName: 'Submit',
                        buttonFontSize: 20.0,
                        buttonColor: Colors.blueAccent,
                        borderColor: Colors.blue,
                        textColor: Colors.white,
                        buttonWidth: 150.0,
                        buttonHeight: 50.0,
                        buttonRadius: 10.0,
                        validationStates: ()async{
                          if(assetsCode.text.isNotEmpty){
                            var result= await AuthService().getAssets(assetsCode.text);
                            setState(() {
                              Navigator.push(context, MaterialPageRoute(builder: (_){
                                return ResultPage( activeScanner: () {  },assetsDate:result,);
                              }));
                            });
                          }else{
                            setState(() {
                              showError(context,"Item code is empty");
                            });
                          }

                        },
                      ),
                    ]

                ),
              ),
            ),


          ]
      ),
    );
  }
}
