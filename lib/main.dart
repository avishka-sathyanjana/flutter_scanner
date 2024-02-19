//
// import 'dart:async';
// import 'dart:io';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'style_varible/style_screen.dart';
// import 'screen/main_screen.dart';
// import 'screen/dash_bord_screen.dart';
// import 'screen/qr_scanner.dart';
// import 'screen/location_menu_screen.dart';
// import 'screen/scanner_menu_screen.dart';
//
//
// Future<void> main()async {
//   WidgetsFlutterBinding.ensureInitialized();
//   Platform.isAndroid ? await Firebase.initializeApp(
//     options: const FirebaseOptions(
//         apiKey: "AIzaSyD2cOSKS72wDJpJI6rucYyUt_oJFmgR1JU",
//         appId: "1:24402428387:android:324208609dea95166520d6",
//         messagingSenderId: "24402428387",
//         projectId:'ucsc-erp-next')
//   ):await Firebase.initializeApp();
//
//
//   runApp(const MyApp());
//
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         colorScheme:ColorScheme.fromSeed(seedColor: colorPlate1),
//         textTheme: const TextTheme(
//           displayMedium: TextStyle(
//             fontFamily: fontRobotoCondensed
//           ),
//           displaySmall: TextStyle(
//             fontFamily: fontRobotoCondensed,
//           )
//         )
//       ),
//       initialRoute:"/",
//       // routes table
//       routes: {
//         "/":(ctx)=>MainScreen(),
//         //QRScanner.QRScannerRoute:(ctx)=>const QRScanner(),
//         DashBord.routeDashBord:(ctx)=>const DashBord(),
//         LocationScreen.locationScreenRoute:(ctx)=>const LocationScreen(),
//
//       },
//     );
//   }
// }
//
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
//   void startTimer(){
//     _timer=Timer.periodic(const Duration(seconds:4), (timer) {
//       Navigator.pushNamed(context,MainScreen.mainScreenPageRoute,arguments: {
//         "startTime":startTimer
//       });
//       _timer.cancel();
//     });
//   }
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

import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final FirebaseAuth auth=FirebaseAuth.instance;
  final FirebaseFirestore _db=FirebaseFirestore.instance;
  final CollectionReference collectionUser=FirebaseFirestore.instance.collection('User');


   void checkLogin() async{
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

  @override
  void initState() {
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
     home: isLoginRememberUser?const DashBord():(isLoginRememberAdmin?const AdminDsh():MainScreen()),
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
