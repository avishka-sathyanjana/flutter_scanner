import 'package:flutter/material.dart';

class DashBord extends StatefulWidget {
  static const routeDashBord="/dash-bord";
  const DashBord({super.key});

  @override
  State<DashBord> createState() => _DashBordState();
}

class _DashBordState extends State<DashBord> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
       body: Center(
         child: Text("this adash bord"),
       ),
    );
  }
}
