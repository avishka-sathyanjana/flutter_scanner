import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/style_varible/style_screen.dart';
// import 'package:qr_flutter/qr_flutter.dart';

class ResultScreen extends StatelessWidget {

  final String code;
  final Function() closeScreen;

  const ResultScreen({super.key, required this.closeScreen, required this.code});

   Widget Cardview(BuildContext context ,String title,String subTitle){
      return
        Card(
          color: Colors.white,
          elevation: 0,
          child: Container(
              width: double.infinity,
              height: 100,
              margin:EdgeInsets.only(top: 20) ,
              decoration: BoxDecoration(
                  border: Border.all(color: colorPlate2,width: 2),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Adjust the padding as needed
                //titleAlignment:ListTileTitleAlignment.center,
                title: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 15,
                      fontFamily: fontRaleway,
                      color: colorPlate2
                  ),

                ),
                subtitle: Text(subTitle,
                  style: const TextStyle(
                      fontFamily: fontRaleway,
                      color: Colors.black26
                  ),
                ),
                trailing: const Icon(Icons.verified_user),
              )
          ),
        );
   }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: colorPlate2,
          leading: IconButton(
              onPressed: (){
                closeScreen();
                Navigator.pop(context);
              },
              icon : const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.black87,
              )),
          //centerTitle: true,
          title: const Text(
            "Assets Details",
            style: TextStyle(
              fontSize: 18,
              fontFamily: fontRaleway,
              color: Colors.white,
              letterSpacing: 1,
            ),
          ),
        ),
        body:SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(15),
            child: Column(
               crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  Card(
                    elevation: 3,
                    color: Colors.white,
                    margin: EdgeInsets.only(top: 40),
                    child: Container(
                      width: double.infinity,
                       height: 150,
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.start,
                         children: [
                           SizedBox(width: 10,),
                           Container(
                             height: 120,
                               width: 120,
                               child: Image.asset("assets/images/scaneer.png",fit:BoxFit.fill,)
                           ),
                           SizedBox(width:10,),
                           const Expanded(
                             child: Padding(
                               padding: EdgeInsets.all(14),
                               child: Column(
                                 children: [
                                   Text("Item is exist here. Item identification was successful.",
                                         style: TextStyle(
                                            fontFamily: fontRobotoCondensed,
                                           fontWeight: FontWeight.w600,
                                           fontSize: 16,
                                           color: Colors.black87,
                                           //overflow: TextOverflow.clip
                                         ),
                                        // softWrap:false,
                                         maxLines: 3,
                                         overflow: TextOverflow.ellipsis,
                                       ),
          
                                 ],
                               ),
                             ),
                           )
          
                         ],
                       )
                    ),
                  ),
              Cardview(context,"Assets Item Name","Round Table"),
              Cardview(context,"Main Assets Type","Table"),
              Cardview(context,"Item Code","ucsc/FFF/00123"),
              Cardview(context,"Exist Division","Research lab"),
              Cardview(context,"Location","ucsc Research lab"),
          
              ],
            ),
          ),
        )

    );
  }
}
