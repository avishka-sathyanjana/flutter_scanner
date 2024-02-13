import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../data_validations/dilog_massage.dart';
import '../../widget/drawer.dart';
import '/style_varible/style_screen.dart';
import '/widget/grid_card.dart';

class AdminDsh extends StatefulWidget {
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

            },
            imageUrl: "assets/images/add-user.png",
            funcName:"Create user"
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
          appBar: AppBar(
            backgroundColor: colorPlate2,
             title: const Text(
               'Admin Dash Bord',
               style: TextStyle(
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
