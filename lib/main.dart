
import 'dart:async';
import 'dart:io';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
   bool isLoginRemember=false;
   //bool checkLogOut= AuthService().isUserLoggedIn() as bool;
  final FirebaseAuth auth=FirebaseAuth.instance;

  void checkLogin()async{
    print("call back..........");
    auth.authStateChanges().listen((User?user) {
      if(user!=null && mounted){
        setState(() {
          isLoginRemember=true;
        });
      }
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }
  @override
  Widget build(BuildContext context) {

   // isLoginRemember=Provider.of<IsLoginRemember>(context,listen: false).value;
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
     home: isLoginRemember?const DashBord():MainScreen(),
      // routes table
      routes: {
        MainScreen.mainScreenPageRoute:(ctx)=>MainScreen(),
        DashBord.routeDashBord:(ctx)=>const DashBord(),
        LocationScreen.locationScreenRoute:(ctx)=>const LocationScreen(),

      },
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   late Timer _timer; // set timer function for splash screen
//
//    @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   //  startTimer();
//
//   }
// //time function, this function execute after navigate main_screen page after 4 second
// //   void startTimer(){
// //     _timer=Timer.periodic(const Duration(seconds:4), (timer) {
// //       Navigator.pushNamed(context,MainScreen.mainScreenPageRoute,arguments: {
// //         "startTime":startTimer
// //       });
// //       _timer.cancel();
// //     });
// //   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:  Container(
//            child: Center(
//               child: ClipRRect(
//                    borderRadius: const BorderRadius.all(Radius.circular(12)),
//                 child: Image.asset("assets/images/logoucsc.png",
//                 ),
//               ),
//            ),
//         ),
//
//     );
//   }
// }
//
//
//
//








