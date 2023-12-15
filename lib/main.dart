
import 'dart:async';
import 'package:flutter/material.dart';
import 'style_varible/style_screen.dart';
import 'screen/main_screen.dart';
import 'screen/dash_bord_screen.dart';

void main() {
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
      routes: {
        "/":(ctx)=>const MyHomePage(),
        MainScreen.mainScreenPageRoute:(ctx)=>MainScreen(),
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
  late Timer _timer;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();

  }

  void startTimer(){
    _timer=Timer.periodic(const Duration(seconds:4), (timer) {
         // Navigator.push(context, MaterialPageRoute(builder: (_){
         //     return MainScreen(startTime: startTimer);
         // }));

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












