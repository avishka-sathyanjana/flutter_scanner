import 'package:flutter/material.dart';
import '/style_varible/style_screen.dart';

class AdminDsh extends StatefulWidget {
  const AdminDsh({super.key});

  @override
  State<AdminDsh> createState() => _AdminDshState();
}

class _AdminDshState extends State<AdminDsh> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: colorPlate2,
           title: const Text(
             'Admin Dash Bord',
             style: TextStyle(
               color: Colors.white
             ),
           ),
        ),

      body: null,

    );
  }
}
