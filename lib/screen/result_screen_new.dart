import 'package:flutter/material.dart';
import '/widget/button_widget.dart';
import '/widget/condition_dropdown.dart';



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var itemCode = '123456789';
    var itemName = 'Laptop';
    var itemCategory = '1000';
    var itemModel = '2021';
    var ItemLastCheck = '2021-09-01';
    var itemType = 'Electronics';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // add appbar

      home: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 230,
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(197, 255, 225, 0.6705882352941176),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.greenAccent,
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
                              Text(
                                'Item Name: $itemName',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'Item Type: $itemType',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'Item Category: $itemCategory',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'Item Model: $itemModel',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'Item Last Check: $ItemLastCheck',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    height: 100,
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
                  ),

// this container is for warning
                  Container(
                    height: 80,
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(
                          255, 234, 171, 0.8666666666666667),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.orangeAccent,
                        width: 4,
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Warning !',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Duplicate Item Found',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

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
                              validationStates: () {
                                // Callback function when the button is pressed
                                print('Button clicked!');
                              },
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
        ),
      ),
    );
  }
}
