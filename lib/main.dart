
import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'style_varible/style_screen.dart';
import 'screen/main_screen.dart';
import 'screen/dash_bord_screen.dart';
import 'screen/qr_scanner.dart';
import 'screen/location_menu_screen.dart';
import 'screen/scanner_menu_screen.dart';
import 'package:provider/provider.dart';
import 'provider/location_state.dart';
import 'model_data/login_remember.dart';
import '/database/auth_file.dart';
import '/screen/admin/admin_dash_bord.dart';

Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid ? await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyD2cOSKS72wDJpJI6rucYyUt_oJFmgR1JU",
          appId: "1:24402428387:android:324208609dea95166520d6",
          messagingSenderId: "24402428387",
          projectId:'ucsc-erp-next')
  ):await Firebase.initializeApp();

  runApp(
      MultiProvider(
          providers:[
            ChangeNotifierProvider(create: (context)=>LocationProvider()),
            ChangeNotifierProvider(create: (context)=>DropDwonIssue()),
            ChangeNotifierProvider(create: (context)=>DropDwonCondition()),
            ChangeNotifierProvider(create: (context)=>DropDwonData()),
            ChangeNotifierProvider(create: (context)=>IsLoginRemember())

          ],
          child: const MyApp()
      )
  );

}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoginRememberUser=false;
  bool isLoginRememberAdmin=false;
  int  loginState=0;
  final FirebaseAuth auth=FirebaseAuth.instance;
  final FirebaseFirestore _db=FirebaseFirestore.instance;
  final CollectionReference collectionUser=FirebaseFirestore.instance.collection('User');


  Future<void> checkLogin()async{
    print("call back..........");

    auth.authStateChanges().listen((User? user) {
      print('callllllllllllllllll');
      String? email = user?.email.toString();
      print("email$email");
      var snapshot =  _db.collection('User').where("email", isEqualTo: email).get();

      snapshot.then((value){
        if (value.docs.isEmpty) {
          print('No documents found for the user with email: $email');
          return;
        }

        if (value.docs.length > 1) {
          // Handle case where multiple documents are found (shouldn't happen in your case)
          print('Multiple documents found for the user with email: $email');
          return;
        }

        var doc = value.docs.single;
        if (doc['type'].toString() == 'admin') {
          if (user != null && mounted) {
            setState(() {
              isLoginRememberAdmin = true;
            });
          }
        } else {
          if (user != null && mounted) {
            setState(() {
              isLoginRememberUser = true;
            });
          }
        }
      });
    });
  }

  Future<void>checkUser()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    setState(() {
        loginState=preferences.getInt('selectType')?? 0;
        print("state$loginState");
    });
  }



  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    //checkLogin();
    checkUser();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme:ColorScheme.fromSeed(seedColor: colorPlate1),
          textTheme: const TextTheme(
              displayMedium: TextStyle(
                  fontFamily: fontRobotoCondensed
              ),
              displaySmall: TextStyle(
                fontFamily: fontRobotoCondensed,
              )
          )
      ),

     // home:isLoginRememberUser?const DashBord():(isLoginRememberAdmin?const AdminDsh():MainScreen()),
      home: loginState==1?const AdminDsh():(loginState==2?const DashBord():MainScreen()),
      // routes table
      routes: {
        MainScreen.mainScreenPageRoute:(ctx)=>MainScreen(),
        DashBord.routeDashBord:(ctx)=>const DashBord(),
        LocationScreen.locationScreenRoute:(ctx)=>const LocationScreen(),
        AdminDsh.addminRoute:(ctx)=>const AdminDsh()

      },
    );
  }
}








