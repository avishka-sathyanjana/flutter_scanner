import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobile_barcode_qrcode_scanner/screen/qr_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/widget/grid_card.dart';
import '/widget/drawer.dart';
import '/style_varible/style_screen.dart';
import '/database/auth_file.dart';
import 'location_menu_screen.dart';
import '/data_validations/dilog_massage.dart';
import 'report_secreen.dart';


class DashBord extends StatefulWidget {
  static const routeDashBord="/dash-bord";
  const DashBord({super.key});

  @override
  State<DashBord> createState() => _DashBordState();
}

class _DashBordState extends State<DashBord> with WidgetsBindingObserver{
  final int _selectIndex=2;
  final GlobalKey<ScaffoldState> _scaffoldState=GlobalKey<ScaffoldState>();
 

  void QRscannerPageNavigate()async{
      if(await AuthService().isUserLoggedIn()){
         setState(() {
            Navigator.pushNamed(context,LocationScreen.locationScreenRoute);
         });
    }else{
        print("is not login");
      }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _saveState();
    }
  }


  Future<void>_saveState()async{
    SharedPreferences preferences= await SharedPreferences.getInstance();
    await preferences.setInt('selectType',_selectIndex);
  }



  @override
  Widget build(BuildContext context) {
    List<Widget>functions=[
      GridCard(
        userDifingFunction:()=>QRscannerPageNavigate(),
        imageUrl: "assets/images/barcode-amico-blue.png",
        funcName: "Assets Scanner",
      ),
      const SizedBox(height: 10,),
      GridCard(
          userDifingFunction: ()async{
            if(await AuthService().isUserLoggedIn()){
            setState(() {
            Navigator.push(context, MaterialPageRoute(builder: (_){
                  return const ReportGenarte();
                }));
            });
            }else{
            print("is not login");
            }
          },
          imageUrl: "assets/images/report.png",
          funcName:"Genarate Reports"
      )
    ];

    return  WillPopScope(
      onWillPop: ()async{
        await showConfirmationDialog(context, "Exit","Do you want to exit !");
        if(dilogState){
          //AuthService().logOut();
          _saveState();
          SystemNavigator.pop();
          dilogState=false;
        }
        return dilogState;
      },
      child: Scaffold(
          key: _scaffoldState,
         appBar: AppBar(
           backgroundColor: colorPlate2,
           title: const Text("Dashboard",
             style: TextStyle(
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
        drawer: DrawerScreen(),
        body:Container(
           margin: const EdgeInsets.only(top: 20),
           padding: const EdgeInsets.all(10),
          child: ListView.builder(
              itemCount: functions.length,
              itemBuilder: (context,int index){
              return functions[index];
          })
        )
      ),
    );
  }
}
