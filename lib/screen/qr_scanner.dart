import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../sql_local_db/sql_helper.dart';
import '/screen/results_screen.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '/database/auth_file.dart';
import 'result_screen_new.dart';
import '/provider/location_state.dart';
import 'package:provider/provider.dart';


const bgColor = Color(0xfffafafa);

class QRScanner extends StatefulWidget {
  static const QRScannerRoute="/QR-route";
  //const QRScanner({required this.locaton});

  @override
  State<QRScanner> createState() => _QRScannerState();
}
class _QRScannerState extends State<QRScanner> {

  bool isScanComplete = false;
  final FirebaseAuth _auth=FirebaseAuth.instance;

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
        leading: IconButton(
          icon: Icon(Icons.arrow_back,),
              onPressed: ()async{
                 if( await AuthService().isLoginCheck()){
                   setState(() {
                    // AuthService().logOut();
                      Navigator.pop(context);

                   });
                 }
              },
        ),
      ), //
      body: Container(
        //color: Colors.red,
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

            // scanner part ......................
            Expanded(
                flex: 4,
                // scanner widget
                child: MobileScanner(
                  allowDuplicates: true,
                  onDetect: (barcode, args)async{
                    if(!isScanComplete){
                      String code = barcode.rawValue ?? '---';
                      isScanComplete = true;
                      //String dropData=Provider.of<DropDwonData>(context,listen: false).value;
                     // var result=await AuthService().getAssets(code,'');
                      await DatabaseHelpr().database;
                      var result =await DatabaseHelpr().searchByBarcode(code);
                       setState(() {
                         Navigator.push(context, MaterialPageRoute(
                             builder: (context) =>ResultPage(activeScanner: closeScreen,assetsData:result)
                         ));
                       });
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
