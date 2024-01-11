import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/provider/location_state.dart';
import '/data_validations/login_validation.dart';

// DropdownMenuEntry labels and values for the first dropdown menu.
enum ConditionLabel {

  newCode('New code', Colors.red),
  proposeCode('Proposed Code', Colors.orange),
  oldCode('Old code', Colors.brown),
  barCode('Barcode', Colors.teal),
  ;

  const ConditionLabel(this.label, this.color);
  final String label;
  final Color color;
}

class IssueDropdown extends StatefulWidget {
  final double width;
  const IssueDropdown({required this.width});

  @override
  State<IssueDropdown> createState() => _ConditionDropdownState();
}

class _ConditionDropdownState extends State<IssueDropdown> {
  final TextEditingController colorController = TextEditingController();
  ConditionLabel? selectedColor;

   void validate(BuildContext context){
     if(colorController.text.isNotEmpty){
       Provider.of<DropDwonIssue>(context,listen: false).updateValue(colorController.text);
     }else{
       showError(context, "Issue type empty");
     }
   }

  @override
  Widget build(BuildContext context) {
    return Container(
      width:widget.width,
      child: DropdownMenu<ConditionLabel>(
              width:360,
              initialSelection: ConditionLabel.newCode,
              controller: colorController,
              requestFocusOnTap:true,
              label: const Text('Code Type'),
              onSelected: (ConditionLabel? color) {
                setState(() {
                  selectedColor = color;
                   validate(context);
                });
              },

              dropdownMenuEntries: ConditionLabel.values
                  .map<DropdownMenuEntry<ConditionLabel>>(
                      (ConditionLabel color) {
                    return DropdownMenuEntry<ConditionLabel>(
                      value: color,
                      label: color.label,
                      enabled: color.label != 'Grey',
                      style: MenuItemButton.styleFrom(
                        foregroundColor: color.color,
                      ),
                    );
                  }).toList(),

      ),
    );
  }
}
