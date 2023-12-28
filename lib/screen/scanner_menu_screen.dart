import 'package:flutter/material.dart';
import '/screen/result_screen_new.dart';
import 'qr_scanner.dart';
import '/database/auth_file.dart';


class ScannerMenuScreen extends StatelessWidget {
  static const scannerMenuScreenRoute="/scannerMenu-route";
  final String locationCode;
  final String writeLocation;
  ScannerMenuScreen({required  this.locationCode,this.writeLocation=''});

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
  String writeCode='';

  // void getDataAssetsItem()async{
  //   try{
  //     print("heeeeeeeeeeeeeeeeeeeeee");
  //     var result=await AuthService().getAssets("");
  //     print("result list ${result[0].assetsItemeName}");
  //     if(result.isNotEmpty){
  //       setState(() {
  //
  //       });
  //       print("length result array ${result.length}");
  //     }
  //
  //   }catch(e){
  //     print("Error:$e");
  //   }
  //
  // }

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
               print("asssssssssssssssss${assetsCode.text}");
                var result= await AuthService().getAssets(assetsCode.text);
                print("active code");
               setState(() {
                 Navigator.push(context, MaterialPageRoute(builder: (_){
                   return ResultPage( activeScanner: () {  },assetsDate:result,);
                 }));
               });
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