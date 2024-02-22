import 'package:flutter/material.dart';
import 'package:flutter_mobile_barcode_qrcode_scanner/screen/dash_bord_screen.dart';
import 'package:provider/provider.dart';
import '/widget/button_widget.dart';
import '/style_varible/style_screen.dart';
import '/database/auth_file.dart';
import '/screen/main_screen.dart';
import '/provider/location_state.dart';
import '/model_data/login_remember.dart';
import 'package:shared_preferences/shared_preferences.dart';
class DrawerScreen extends StatefulWidget {

  DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {

  Widget ListTileView(String title,String subTitle,IconData icon){
    return  Padding(
      padding: const EdgeInsets.only(left: 12),
      child: ListTile(
        title: Text(title,style: const TextStyle(
            fontSize: 15,
            color: colorPlate2,
            fontFamily: fontRaleway
        ),),
        subtitle: Text(subTitle,style: const TextStyle(
            fontFamily: fontRaleway,
            fontSize: 15,
            color: Colors.black26
        ),),
        trailing: Icon(icon,color: colorPlate2,),
      ),
    );
  }

  Widget DraweNavigate(String pageName,Function navegate,IconData icon){
    return  Padding(
      padding: const EdgeInsets.only(left: 12),
      child: ListTile(
        leading: Icon(icon,size: 30,color: colorPlate2,),
        title:Text(pageName,style: const TextStyle(
            fontSize: 18,
            fontFamily: fontRaleway
        ),),
        onTap: ()=>navegate,
      ),
    );

  }

  void Logout()async{
    print("line 56");
     SharedPreferences preferences =await SharedPreferences.getInstance();
    //  await preferences.remove('selectType');
    print("line 59");

      setState(() {
        print('line 62');
        preferences.setInt('selectType', 0);
        AuthService().logOut();
         Navigator.pushReplacementNamed(context, MainScreen.mainScreenPageRoute);
      });


  }

  @override
  Widget build(BuildContext context) {
    Size screenSize=MediaQuery.of(context).size;
    double screenWidth=screenSize.width;
    double screenHeight=screenSize.height;
    return Drawer(
        elevation: 3,
        width:screenWidth/1.7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            Padding(
              padding: EdgeInsets.only(top: 70),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset("assets/images/logoucsc.png",height: 100,width: 100,),
              ),
            ),
            const SizedBox(height: 30,),
            ListTileView("Name","Dhanusha",Icons.portrait_rounded),
            ListTileView("Email","2020cs186@stu.ucsc.cmb.ac.lk",Icons.email),

            const SizedBox(height: 80,),

            DraweNavigate("Help", (){}, Icons.help),
            const SizedBox(height: 0,),
            DraweNavigate("Edite profile", (){}, Icons.edit_calendar),
            SizedBox(height: screenHeight/7,),
           ButtonWidget(
               ctx:context,
               buttonName:"Logout",
               buttonFontSize: 16,
               buttonColor:Colors.white,
               borderColor:colorPlate2,
               buttonWidth:150,
               buttonHeight:40,
               buttonRadius: 8.0,
               textColor: colorPlate2,
               validationStates:()=>Logout()
           )

        ],
      ) ,
    );
  }
}
