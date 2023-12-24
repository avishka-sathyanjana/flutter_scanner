
import 'dart:async';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'style_varible/style_screen.dart';
import 'screen/main_screen.dart';
import 'screen/dash_bord_screen.dart';
import 'screen/qr_scanner.dart';


Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid ? await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyBc_Q8ZRWVeWt4kOuH4C4yPsVX7z3kOpGw",
        appId: "1:139431044319:android:8baf3eb0b00c4f1680f56a",
        messagingSenderId: "139431044319",
        projectId:'ucsc-erp-d6ceb')
  ):await Firebase.initializeApp();


  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      initialRoute:"/",
      // routes table
      routes: {
        "/":(ctx)=>MainScreen(),
        QRScanner.QRScannerRoute:(ctx)=>const QRScanner(),
        DashBord.routeDashBord:(ctx)=>const DashBord()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Timer _timer; // set timer function for splash screen

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
  //  startTimer();

  }
//time function, this function execute after navigate main_screen page after 4 second
  void startTimer(){
    _timer=Timer.periodic(const Duration(seconds:4), (timer) {
      Navigator.pushNamed(context,MainScreen.mainScreenPageRoute,arguments: {
        "startTime":startTimer
      });
      _timer.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
           child: Center(
              child: ClipRRect(
                   borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: Image.asset("assets/images/logoucsc.png",
                ),
              ),
           ),
        ),

    );
  }
}












