import 'package:flutter/material.dart';

// DropdownMenuEntry labels and values for the first dropdown menu.
enum ConditionLabel {

  noCode('No item code', Colors.red),
  duplicateItem('Duplicate Item code', Colors.orange),
  wrongItem('Wrong Item code', Colors.brown),
  ;

  const ConditionLabel(this.label, this.color);
  final String label;
  final Color color;
}

class IssueDropdown extends StatefulWidget {
  const IssueDropdown({super.key});

  @override
  State<IssueDropdown> createState() => _ConditionDropdownState();
}

class _ConditionDropdownState extends State<IssueDropdown> {
  final TextEditingController colorController = TextEditingController();
  ConditionLabel? selectedColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      // width infinity
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: DropdownMenu<ConditionLabel>(
            width: 350,
            initialSelection: ConditionLabel.noCode,
            controller: colorController,
            requestFocusOnTap: false,
            label: const Text('Issue Type'),
            onSelected: (ConditionLabel? color) {
              setState(() {
                selectedColor = color;
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
