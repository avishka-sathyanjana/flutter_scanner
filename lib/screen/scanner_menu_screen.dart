import 'package:flutter/material.dart';
import '/screen/result_screen_new.dart';
import 'qr_scanner.dart';
import '/database/auth_file.dart';
import '/data_validations/login_validation.dart';


class ScannerMenuScreen extends StatelessWidget {
  static const scannerMenuScreenRoute="/scannerMenu-route";
  final String locationCode;

  ScannerMenuScreen({required  this.locationCode});

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
                ElevatedButton(

                  child: const Text('Scan Using Camera'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const QRScanner()
                      ),
                    );
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
  const ItemForm({Key? key});

  @override
  State<ItemForm> createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
  final TextEditingController assetsCode=TextEditingController();
  //String writeCode='';



  @override
  Widget build(BuildContext context){
    return Column(
        children: [
          const Text(
            'Enter the Item Code',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical:20),
            child: TextField(
              controller: assetsCode,
               decoration: const InputDecoration(
                border: OutlineInputBorder(),
                // contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                labelText: 'Item Code',
              ),
            ),

          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: ()async{
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
            child: const Text('Submit'),
          ),
        ]
    );
  }
}
