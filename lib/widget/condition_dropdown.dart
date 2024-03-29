import 'package:flutter/material.dart';
import '../data_validations/login_validation.dart';
import '/screen/result_screen_new.dart';
import 'package:provider/provider.dart';
import '/provider/location_state.dart';

// DropdownMenuEntry labels and values for the first dropdown menu.
enum ConditionLabel {
  good('Good', Colors.blue),
  repair('Repairable', Colors.orange),
  defective('Defective', Colors.red);

  const ConditionLabel(this.label, this.color);
  final String label;
  final Color color;
}

class ConditionDropdown extends StatefulWidget {
  static String assetsStates='';
  final double size;
  const ConditionDropdown({required this.size});

  @override
  State<ConditionDropdown> createState() => _ConditionDropdownState();
}

class _ConditionDropdownState extends State<ConditionDropdown> {
  final TextEditingController colorController = TextEditingController();
  //String dropdownData='';
  ConditionLabel? selectedColor;

  void printStaticVerible(){
      setState(() {
          ConditionDropdown.assetsStates=colorController.text;
      });
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: DropdownMenu<ConditionLabel>(
            width:widget.size,
            initialSelection: ConditionLabel.good,
            controller: colorController,
            requestFocusOnTap: false,
            label: const Text('Item Condition'),
            onSelected: (ConditionLabel? color) {
              setState(() {
                selectedColor = color;
                  printStaticVerible();
                  Provider.of<DropDwonCondition>(context,listen: false).updateValue(colorController.text);

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
        ),
      ],
    );
  }
}
