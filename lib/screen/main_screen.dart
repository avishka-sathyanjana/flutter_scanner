
import '/qr_scanner.dart';

import '/style_varible/style_screen.dart';

import 'package:flutter/material.dart';
import '/widget/button_widget.dart';
import '/data_validations/login_validation.dart';
import '/screen/dash_bord_screen.dart';


class MainScreen extends StatefulWidget {
   //final Function startTime;
   static const mainScreenPageRoute="/main-screen";
   MainScreen();

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  late String email="";
  late  String password="";

//logo and pages hedar view
  Widget logoView(BuildContext context,String image,String hed){
    return Container(
      margin: const EdgeInsets.only(top: 70),
      child: Center(
        child: Column(
          children: [
            Container(
              child: Image.asset(image,height: 100,width: 100,),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child:  Text(hed,
                style: const TextStyle(
                    color:Colors.black,
                    fontFamily:fontRaleway,
                    fontSize: 20
                ),
              ),
            )
          ],
        ),
      ),
    );

  }

// input filed widget
  Widget inputFiled(
      BuildContext context,
      String hinttext,
      IconData icon,
      bool hideText,
      double defirent,
      Function textValue,){
    return Container(
      width:double.infinity,
      height: 50,
      margin: EdgeInsets.only(top:defirent),
      decoration:  BoxDecoration(
          border: Border.all(
              color: colorPlate2,
              width: 2
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10))
      ),
      child: TextField(
        obscureText:hideText,
        decoration:InputDecoration(
            suffixIcon:Icon(icon,color: Colors.black12,),
            contentPadding:const EdgeInsets.only(left:20,top: 10),
            hintText:hinttext,
           // errorText: showError(),
            border:const OutlineInputBorder(
              borderSide: BorderSide.none,
            )
        ),

        onChanged: (value)=>textValue(value)
      ),
    );
  }

  // validation data
  void validateData(BuildContext context){
    // add future function after
      if(!LoginValidation(email, password,context)){
          //Navigator.pushNamed(context,DashBord.routeDashBord);
        Navigator.push(context, MaterialPageRoute(builder: (_)=>const QRScanner()));
      }else{
         throw()=>Exception("error rec vest");
      }
  }

  @override
  Widget build(BuildContext context) {
    final routes= ModalRoute.of(context)?.settings.arguments as Map<String,dynamic>?;
    final Function strtTime=routes!['startTime'] as Function;
    return Scaffold(
     // backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          backgroundColor: colorPlate2,
            leading:IconButton(
               icon:const Icon(Icons.arrow_back),
                onPressed:()=>{
                  Navigator.pop(context),
                  strtTime()
                }
            ),
            title: const Text(
                "Assets Manager",
               style: TextStyle(
                  color: Colors.white,
                  fontFamily: fontRaleway,
                  fontSize:20
               ),
            ),
        ),
        body: SingleChildScrollView(
          child: Container(
             //color: colorPlate3,
            margin: const EdgeInsets.all(20),
            child: Column(
                 children: [
                   logoView(context,"assets/images/logoucsc.png","Login"),
          
                   inputFiled(context, "Enter your Email", Icons.email_outlined,false,50,(value){
                        setState(() {
                           email=value;
                        });
                   }),
          
                   inputFiled(context, "Enter your Password",Icons.content_paste_search,true,25,(value){
                        setState(() {
                           password=value;
                        });
                   }),

                   Container(
                     margin: const EdgeInsets.only(top: 25),
                     child:  InkWell(
                       onTap:(){
                          //navigate to forget password filed
                       },
                       child: const Text(
                          "Forget password?",
                         style: TextStyle(
                            fontFamily:fontRaleway,
                           fontSize: 18,
                           color: colorPlate2
                         ),
                       ),
                     ),
                   ),

                   ButtonWidget(
                       ctx: context,
                       buttonName: "Login",
                       buttonFontSize: 18,
                       buttonColor:Colors.white,
                       borderColor:colorPlate3,
                       buttonWidth:double.infinity,
                       buttonHeghit: 45,
                       validationStates:()=>validateData(context),
                   )

                 ],
          
            ),
          ),
        )
    );
  }
}
