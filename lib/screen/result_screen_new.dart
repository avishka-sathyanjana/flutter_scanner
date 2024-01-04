import 'package:flutter/material.dart';
import 'package:flutter_mobile_barcode_qrcode_scanner/screen/location_menu_screen.dart';
import '/style_varible/style_screen.dart';
import '/widget/button_widget.dart';
import '/widget/condition_dropdown.dart';
import '/model_data/AssetsData.dart';
import 'issue-screen.dart';
import '/database/auth_file.dart';
import '/data_validations/login_validation.dart';
import 'scanner_menu_screen.dart';
import 'package:provider/provider.dart';
import '/provider/location_state.dart';
import '/data_validations/dilog_massage.dart';


class ResultPage extends StatefulWidget {
  //final String location;
  final Function() activeScanner;
  List<AssetsVarify>assetsData=[];

   ResultPage({required this.activeScanner,required this.assetsData});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  final TextEditingController _remarks=TextEditingController();
  String getLocation='';
  bool wornigState=false;
  bool locationError=false;
  bool unSccsesFull=false;
  String itemCode = '';
  String itemName = '';
  String itemCategory = '';
  String itemDivition = '';
  String ItemLastCheck = '';
  String itemLocation = '';
  String itemNewCode='';
  String itemOldCode='';
  String itemPopuseCode='';


  void assingData(){
    itemCode=widget.assetsData[0].itemCode;
    itemName=widget.assetsData[0].assetsItemeName;
    itemCategory=widget.assetsData[0].mainAssetsType;
    itemLocation=widget.assetsData[0].location;
    itemDivition=widget.assetsData[0].Division;
    itemNewCode=widget.assetsData[0].newCode;
    itemOldCode=widget.assetsData[0].oldCode;
    itemPopuseCode=widget.assetsData[0].propuseCode;


  }



  Widget errorMessage(
      BuildContext context,
      String errorHead,
      String errorType,
      Color boderColor){
    return  Container(
      height: 110,
      margin: const EdgeInsets.only(top: 13),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.orange[100],
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: boderColor,
          width: 4,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             Text(
                errorHead,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                softWrap:true,
              ),

            const SizedBox(height: 8),
            Text(
              errorType,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  //we can map assets details this function
  bool assetsDataState(){
    if(widget.assetsData.isEmpty){
     // print("heeeeeeeeeeeeeeeeeeeee");
      unSccsesFull=true;
      return false;

    }else if(widget.assetsData[0].isNotverifyCurentYear){
         // print("hhhhhhhhhhhhhhhhhhhhhhhhhhh");
        if(widget.assetsData[0].location.toString()==getLocation){
            setState(() {
              assingData();
              wornigState=false;
              locationError=false;
              unSccsesFull=false;

            });
        } else{

          setState(() {
             assingData();
            locationError=true;
            //unSccsesFull=true;

          });
        }

      return true;

    }else if(widget.assetsData[0].allredyVerify){
         if(widget.assetsData[0].location.toString()==getLocation){
           setState(() {
             assingData();
             wornigState=true;
             locationError=false;
           });
         }else if(widget.assetsData[0].location.toString()!=getLocation){
           setState(() {
             assingData();
             wornigState=true;
             locationError=true;
           });
         }

      return true;
    }else{
     // print("heeeeeewwwwwwwwwwwwwww");
      wornigState =false;
      return false;
    }

  }
//add assets data verify .......................
  void verfiyData(BuildContext context)async{
    if(assetsDataState()&&!wornigState&&!locationError){
        if(ConditionDropdown.assetsStates.isNotEmpty) {
          await showConfirmationDialog(context,"Verify !", "Do you verify assets ?");
          if(dilogState){
              setState(() {
                AuthService().verifyTable(
                    itemCode,
                    itemLocation,
                    _remarks.text
                    ,ConditionDropdown.assetsStates ,
                    itemNewCode,
                    itemOldCode,
                    itemPopuseCode,
                );

                 itemCode = '';
                 itemName = '';
                 itemCategory = '';
                 itemDivition = '';
                 ItemLastCheck = '';
                 itemLocation = '';
                 itemNewCode='';
                 itemOldCode='';
                 itemPopuseCode='';
                 ConditionDropdown.assetsStates='';
                Navigator.pop(context);
              });
          }
        //pop scanner page
        }else{
           showError(context,"Select assets state");
        }
    }else{
      print("worning data save");
    }
  }
  
  void navigeateReportPage(BuildContext context)async{
   await showConfirmationDialog(context,"Issue !","Do you report issue ?");
   if(dilogState){
     setState(() {
       Navigator.push(context,MaterialPageRoute(builder: (_)=>const IssueScreen()));
     });
   }else{
     print("Accept cansel");
   }

  }

  @override
  Widget build(BuildContext context) {
    getLocation=Provider.of<LocationProvider>(context).location;
      return Scaffold(
          appBar: AppBar(
            backgroundColor: colorPlate2,
            leading: IconButton(
                icon: const Icon(Icons.arrow_back,color: Colors.white,),
               onPressed: (){
                    widget.activeScanner();
                    Navigator.pop(context);
               },
            ),
            title: const Text("Assets Diesels",style: TextStyle(
               color:Colors.white,
               fontFamily: fontRaleway,
               fontSize: 18
            ),),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  // successful container
                  assetsDataState()?Container(
                      height: 320,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(197, 255, 225, 0.6705882352941176),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.tealAccent,
                          width: 4,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Scan Successful !',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                //center
                              ),
                            ),
                            const SizedBox(height: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Item Code: $itemCode',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height:7,),
                                Text(
                                  'Item Name: $itemName',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontFamily: fontRaleway
                                  ),
                                ),
                                const SizedBox(height:7,),
                                Text(
                                  'Location: $itemLocation',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontFamily: fontRaleway
                                  ),
                                ),
                                const SizedBox(height: 7,),
                                Text(
                                  'Item Category: $itemCategory',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontFamily: fontRaleway
                                  ),
                                ),
                                const SizedBox(height:7,),
                                Text(
                                  'Item Divition: $itemDivition',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontFamily: fontRaleway
                                  ),
                                ),
                                const SizedBox(height: 4,),
                                // Text(
                                //   'Item Last Check: $ItemLastCheck',
                                //   style: const TextStyle(
                                //     fontSize: 16,
                                //     color: Colors.black,
                                //     fontFamily: fontRaleway
                                //   ),
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ):

                  errorMessage(context,'Scan Unsuccessful !','No Item Found !',Colors.red),
                  if(!locationError&&wornigState)
                     errorMessage(context,"Warning !","Already Verified Item",Colors.orangeAccent)
                  else if(locationError&&wornigState)
                    errorMessage(context,"Warning !","Already Verified Item but Invalid Location",Colors.orangeAccent)
                  else if(locationError&&!wornigState)
                      errorMessage(context,"Warning !","Invalid Location", Colors.orangeAccent),
                  Container(
                      height: 200,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const SizedBox(
                                height: 16.0), // Add some space between fields

                            ConditionDropdown(size: 380,),

                            // Remarks Text Input
                            Expanded(
                              child: TextFormField(
                                maxLines: null,
                                controller: _remarks,
                                 minLines: 3,
                                  decoration: const InputDecoration(
                                  labelText: 'Remarks',
                                  border: OutlineInputBorder(),

                                ),
                              ),
                            ),
                          ],
                        ),
                      )),

                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal:10.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            (unSccsesFull||locationError||wornigState)?ButtonWidget(
                              ctx: context,
                              buttonName: 'Report',
                              buttonFontSize: 20.0,
                              buttonColor: Colors.orangeAccent,
                              borderColor: const Color.fromRGBO(253, 203, 0, 1.0),
                              textColor: Colors.white,
                              buttonWidth: 170.0,
                              buttonHeight: 50.0,
                              buttonRadius: 10.0,
                              validationStates: ()=>navigeateReportPage(context)
                            ):
                            ButtonWidget(
                              ctx: context,
                              buttonName: 'Verify',
                              buttonFontSize: 20.0,
                              buttonColor: Colors.greenAccent,
                              borderColor: const Color.fromRGBO(41, 255, 137, 1.0),
                              textColor: Colors.white,
                              buttonWidth: 170.0,
                              buttonHeight: 50.0,
                              buttonRadius: 10.0,
                              validationStates: ()=>verfiyData(context)
                            ),
                          ]

                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        );

  }
}
