import 'package:flutter/material.dart';
import 'package:flutter_mobile_barcode_qrcode_scanner/screen/qr_scanner.dart';
import '/widget/grid_card.dart';
import '/widget/drawer.dart';
import '/style_varible/style_screen.dart';
import '/database/auth_file.dart';
class DashBord extends StatefulWidget {
  static const routeDashBord="/dash-bord";
  const DashBord({super.key});

  @override
  State<DashBord> createState() => _DashBordState();
}

class _DashBordState extends State<DashBord> {
  final GlobalKey<ScaffoldState> _scaffoldState=GlobalKey<ScaffoldState>();

  void QRscannerPageNavigate()async{
      if(await AuthService().isUserLoggedIn()){
         setState(() {
            Navigator.pushNamed(context, QRScanner.QRScannerRoute);
         });
    }else{
        print("is not login");
      }


  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        key: _scaffoldState,
       appBar: AppBar(
         backgroundColor: colorPlate2,
         title: const Text("Dash Bord",style: TextStyle(
               fontFamily: fontRaleway,
               fontSize: 18,
               color: Colors.white
           ),
         ),
         leading: IconButton(
           icon: const Icon(Icons.drag_indicator_outlined),
           onPressed: (){
              _scaffoldState.currentState?.openDrawer();
           },
         ),

       ),
      drawer: const DrawerScreen(),
      body:Container(
         margin: EdgeInsets.only(top: 20),
         padding: EdgeInsets.all(10),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
             // childAspectRatio: 3/2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
          ),
          itemCount: 1,
          itemBuilder: (context,index){
              return GridCard(
                 userDifingFunction:QRscannerPageNavigate,
                 imageUrl: "assets/images/qrimage.jpeg",
                 funcName: "Item Scanner",
              );

          },
        
        ),
      )
    );
  }
}
