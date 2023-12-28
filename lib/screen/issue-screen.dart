import 'package:flutter/material.dart';
import 'package:master_flutter/widget/button_widget.dart';
import 'package:master_flutter/widget/condition_dropdown.dart';
import 'package:master_flutter/widget/issue_dropdown.dart';

class IssueScreen extends StatefulWidget {
  const IssueScreen({super.key});

  @override
  State<IssueScreen> createState() => _IssueScreenState();
}

class _IssueScreenState extends State<IssueScreen> {
  final _formKey = GlobalKey<FormState>();
  // Define variables to store form data
  String? issueType;
  String? itemType;
  String? itemCategory;
  String? previousItemCodes;
  String? model;
  String? condition;
  String? remarks;

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
                mainAxisAlignment: MainAxisAlignment.start,
          
                children: [
                  // Issue Type
                  const IssueDropdown(),

                  // Item Condition
                  const ConditionDropdown(),
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
          
                  // Previous Item Codes
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Previous Item Codes', border: OutlineInputBorder()),
                    onSaved: (value) => previousItemCodes = value,
                  ),
                  const SizedBox(height: 20),
          
                  // Model
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Model', border: OutlineInputBorder()),
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Please enter the model';
                    //   }
                    //   return null;
                    // },
                    onSaved: (value) => model = value,
                  ),
                  const SizedBox(height: 20),

                  // Remarks
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Remarks',  border: OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter remarks';
                      }
                      return null;
                    },
                    onSaved: (value) => remarks = value,
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
                      validationStates: (){
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          // Process the form data, e.g., send it to an API
                          // You can access the entered data using the variables defined above
                          // After processing, you can navigate back or do other actions
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
