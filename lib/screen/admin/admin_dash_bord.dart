import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../data_validations/dilog_massage.dart';
import '../../widget/drawer.dart';
import '/style_varible/style_screen.dart';
import '/widget/grid_card.dart';
import 'user_create_screen.dart';

class AdminDsh extends StatefulWidget {
  static const String addminRoute="/admin-dash";
  const AdminDsh({super.key});

  @override
  State<AdminDsh> createState() => _AdminDshState();
}

class _AdminDshState extends State<AdminDsh> {

  final GlobalKey<ScaffoldState> _scaffoldState=GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    List<Widget>card=[
        GridCard(
            userDifingFunction:(){
                  Navigator.push(context, MaterialPageRoute(builder:(_)=>const UserCreate()));
            },
            imageUrl: "assets/images/add-user.png",
            funcName:"Create user Account"
        )
    ];
    return WillPopScope(
      onWillPop: ()async{
      await showConfirmationDialog(context, "Exit","Do you want to exit !");
      if(dilogState){
        //AuthService().logOut();
        SystemNavigator.pop();
        dilogState=false;
      }
      return dilogState;
    },
      child: Scaffold(
         key: _scaffoldState,
          appBar: AppBar(
            backgroundColor: colorPlate2,
             title: const Text(
               'Admin Dash Bord',
               style: TextStyle(
                 color: Colors.white,
                 fontFamily:fontRaleway
               ),
             ),
            leading: IconButton(
              icon: const Icon(Icons.drag_indicator_outlined,color: Colors.white,),
              onPressed: (){
                _scaffoldState.currentState?.openDrawer();
              },
            ),
          ),
        drawer: DrawerScreen(),
        body:Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
                itemCount: card.length,
                itemBuilder: (context,int index){
                  return card[index];
                })
        ),

      ),
    );
  }
}
