import 'package:flutter/material.dart';
import 'package:flutter_mobile_barcode_qrcode_scanner/database/auth_file.dart';
import '/widget/button_widget.dart';
import '/widget/condition_dropdown.dart';
import '/widget/issue_dropdown.dart';
import '/model_data/drop_dwon_data.dart';
import 'package:provider/provider.dart';
import '/provider/location_state.dart';
import '/data_validations/login_validation.dart';
import '/data_validations/dilog_massage.dart';


class IssueScreen extends StatefulWidget {
  const IssueScreen({super.key});

  @override
  State<IssueScreen> createState() => _IssueScreenState();
}

class _IssueScreenState extends State<IssueScreen> {
  final _formKey = GlobalKey<FormState>();
  // Define variables to store form data
  String?selectedValue;
  String?selectedValue1;
  // String issueType='';
  // String? itemCondition;
  String? itemType;
  String? itemCategory;
  String? previousItemCodes;
  String?assetsCode;
  String? model;
  String? condition;
  String?location;
  String? remarks;

  Widget dropDwon(BuildContext context,String selectedValue){
    return  DropdownButtonFormField<String>(
      value: selectedValue,
      onChanged: (String ?value) {
        if (value != null) {
          setState(() {
            selectedValue = value;
          });
        }
      },
      items:const[
        DropdownMenuItem<String>(
          value: 'Good',
          child: Text('Good'),
        ),
        DropdownMenuItem<String>(
          value:'Repairable',
          child: Text('Repairable'),
        ),
        DropdownMenuItem<String>(
          value: 'Defective',
          child: Text('Defective'),
        ),
      ],
      decoration: const InputDecoration(
        labelText: 'Select an option',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        // Validation logic for the dropdown
        if (value == null || value.isEmpty) {
          return 'Please select an option';
        }
        return null; // Return null for no validation error
      },
    );
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text('Issue Form'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
          
                children: [
                  // Issue Type
                  SizedBox(height: 20,),
                  DropdownButtonFormField<String>(
                    value: selectedValue,
                    onChanged: (String? value) {
                      setState(() {
                        selectedValue = value;
                      });
                    },
                    items:const[
                      DropdownMenuItem<String>(
                        value: 'good',
                        child: Text('good'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'reversible',
                        child: Text('reversible'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Defective',
                        child: Text('Defective'),
                      ),
                    ],
                    decoration: const InputDecoration(
                      labelText: 'Item Condition',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      // Validation logic for the dropdown
                      if (value == null || value.isEmpty) {
                        return 'Please select an option';
                      }
                      return null; // Return null for no validation error
                    },
                  ),

                  SizedBox(height: 20,),
                  DropdownButtonFormField<String>(
                    value: selectedValue1,
                    onChanged: (String? value) {
                      setState(() {
                        selectedValue1 = value;
                      });
                    },
                    items:const[
                      DropdownMenuItem<String>(
                        value: 'No item code',
                        child: Text('No item code'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Duplicate Item code',
                        child: Text('Duplicate Item code'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Wrong Item code',
                        child: Text('Wrong Item code'),
                      ),
                    ],
                    decoration: const InputDecoration(
                      labelText: 'Issue type empty',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      // Validation logic for the dropdown
                      if (value == null || value.isEmpty) {
                        return 'Please select an option';
                      }
                      return null; // Return null for no validation error
                    },
                  ),

                  // Item Condition

                  const SizedBox(height: 10),
                  // Item Type
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Item Type',
                        border: OutlineInputBorder()
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the item type';
                      }
                      return null;
                    },
                    onSaved: (value) => itemType = value,
                  ),
                  const SizedBox(height: 20),
          
                  // Item Category

                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Item Category', border: OutlineInputBorder()),
                    onSaved: (value) => itemCategory = value,
                  ),
                  const SizedBox(height: 20),
                  // assets code
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Item Codes', border: OutlineInputBorder()),
                    onSaved: (value) => assetsCode = value,
                  ),
                  const SizedBox(height: 20),
                  
                  // Previous Item Codes
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Previous Item Codes', border: OutlineInputBorder()),
                    onSaved: (value) => previousItemCodes = value,
                  ),
                  
                  const SizedBox(height: 20),
          
                  // Model
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Model', border: OutlineInputBorder()),
                    onSaved: (value) => model = value,
                  ),
                  const SizedBox(height: 20),
                     //location
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Location',  border: OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter location';
                      }
                      return null;
                    },
                    onSaved: (value) => remarks = value,
                  ),

                  const SizedBox(height: 20,),
                  // Remarks
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Remarks',  border: OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter remarks';
                      }
                      return null;
                    },
                    onSaved: (value) => location = value,
                  ),
                  const SizedBox(height: 20),
                  // Submit Button
                  ButtonWidget(
                      ctx: context,
                      buttonName: 'Submit Report',
                      buttonFontSize: 20,
                      buttonColor: Colors.orangeAccent,
                      borderColor: Colors.orange,
                      textColor: Colors.white,
                      buttonWidth: 300,
                      buttonHeight: 50,
                      buttonRadius: 10,
                      validationStates: ()async{
                        if (_formKey.currentState!.validate()) {
                           _formKey.currentState!.save();
                             // String issueType=Provider.of<DropDwonIssue>(context,listen: false).issueType;
                              //String itemCondition=Provider.of<DropDwonCondition>(context,listen: false).itemCondition;
                               await showConfirmationDialog(context,"Add Issue !","Do you add issue !");

                               if(dilogState){
                                 await AuthService().addIssues(
                                     selectedValue!,
                                     itemCategory! ,
                                     selectedValue1!,
                                     itemType!,
                                     location!,
                                     model!,
                                     remarks!,
                                     assetsCode!,
                                     previousItemCodes!);

                                     setState(() {
                                       Navigator.pop(context);
                                     });

                               }

                        }
                      }
                  ),

                ],
              ),
            ),
            //Create a form to insert issue details
          ),
        ),
    );
  }
}
