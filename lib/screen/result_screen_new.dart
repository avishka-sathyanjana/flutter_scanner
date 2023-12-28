import 'package:flutter/material.dart';
import '/style_varible/style_screen.dart';
import '/widget/button_widget.dart';
import '/widget/condition_dropdown.dart';
import '/model_data/AssetsData.dart';
import 'issue-screen.dart';


class ResultPage extends StatefulWidget {
  final Function() activeScanner;
   List<AssetsVarify>assetsDate=[];

   ResultPage({required this.activeScanner,required this.assetsDate});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  String itemCode = '';
  String itemName = '';
  String itemCategory = '';
  String itemDivition = '';
  String ItemLastCheck = '';
  String itemLocation = '';


  Widget errorMassage(BuildContext context){
    return  Container(
      height: 120,
      margin: const EdgeInsets.only(top: 13),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 190, 190, 0.7019607843137254),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Colors.redAccent,
          width: 4,
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Scan Unsuccessful !',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'No Item Found !',
              style: TextStyle(
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
    if(widget.assetsDate.isEmpty){

      return false;

    }else{
      setState(() {

          itemCode=widget.assetsDate[0].itemCode;
          itemName=widget.assetsDate[0].assetsItemeName;
          itemCategory=widget.assetsDate[0].mainAssetsType;
          itemLocation=widget.assetsDate[0].location;
          itemDivition=widget.assetsDate[0].Division;

      });
      return true;

    }

  }
  
  void navigeateReportPage(BuildContext context){
    setState(() {
        Navigator.push(context,MaterialPageRoute(builder: (_)=>const IssueScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {

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
                        color: Color.fromRGBO(197, 255, 225, 0.6705882352941176),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: colorPlate2,
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
                            SizedBox(height: 12),
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
                                const SizedBox(height: 4,),
                                Text(
                                  'Item Name: $itemName',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontFamily: fontRaleway
                                  ),
                                ),
                                const SizedBox(height: 4,),
                                Text(
                                  'Location: $itemLocation',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontFamily: fontRaleway
                                  ),
                                ),
                                const SizedBox(height: 4,),
                                Text(
                                  'Item Category: $itemCategory',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontFamily: fontRaleway
                                  ),
                                ),
                                SizedBox(height: 4,),
                                Text(
                                  'Item Divition: $itemDivition',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontFamily: fontRaleway
                                  ),
                                ),
                                const SizedBox(height: 4,),
                                Text(
                                  'Item Last Check: $ItemLastCheck',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontFamily: fontRaleway
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ):

                  errorMassage(context),



                  // the data inserting part
                  Container(
                      height: 200,
                      width: double.infinity,

                      // decoration: BoxDecoration(
                      //     // // color: Colors.green,
                      //     // border: Border.all(
                      //     //   color: Colors.black87,
                      //     //   width: 4,
                      //     // ),
                      //     // borderRadius: BorderRadius.circular(5)
                      //   ),

                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const SizedBox(
                                height: 16.0), // Add some space between fields
                            Row(
                              // Add some space between fields
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: const Text("Enter Item Condition"),
                                ),
                                const SizedBox(width: 16.0), // Adjust the width as needed
                                const ConditionDropdown(),
                              ],
                            ),

                            // Remarks Text Input
                            Expanded(
                              child: TextFormField(
                                maxLines: null,
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
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ButtonWidget(
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
                            ),
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
                              validationStates: () {
                                // Callback function when the button is pressed
                                print('Button clicked!');
                              },
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
