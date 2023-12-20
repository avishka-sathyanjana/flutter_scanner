import 'package:flutter/material.dart';
import '/widget/drawer.dart';
import '/style_varible/style_screen.dart';
import '/database/auth_file.dart';
class DashBord extends StatefulWidget {
  static const routeDashBord="/dash-bord";
  const DashBord({super.key});

  @override
  State<DashBord> createState() => _DashBordState();
}

class _DashBordState extends State<DashBord> {
  final GlobalKey<ScaffoldState> _scaffoldState=GlobalKey<ScaffoldState>();
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        key: _scaffoldState,
       appBar: AppBar(
         backgroundColor: colorPlate2,
         title: const Text("Dash Bord",style: TextStyle(
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
      drawer: const DrawerScreen(),
      body:GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3/2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
        ),
        itemCount: 6,
        itemBuilder: (context,index){

        },

      )
    );
  }
}
