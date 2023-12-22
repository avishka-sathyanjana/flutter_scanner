import 'package:flutter/material.dart';
import 'package:flutter_mobile_barcode_qrcode_scanner/qr_scanner.dart';


class ScannerMenuScreen extends StatelessWidget {
  const ScannerMenuScreen({super.key});

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

class ItemForm extends StatelessWidget{
  const ItemForm({Key? key});

  @override
  Widget build(BuildContext context){
    return Column(
        children: [
          const Text(
            'Enter the Item Code',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical:20),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                // contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                labelText: 'Item Code',
              ),
            ),

          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: (){

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