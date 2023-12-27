import 'package:flutter/material.dart';

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
  const ConditionDropdown({super.key});

  @override
  State<ConditionDropdown> createState() => _ConditionDropdownState();
}

class _ConditionDropdownState extends State<ConditionDropdown> {
  final TextEditingController colorController = TextEditingController();
  ConditionLabel? selectedColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: DropdownMenu<ConditionLabel>(
            initialSelection: ConditionLabel.good,
            controller: colorController,
            requestFocusOnTap: false,
            label: const Text('Item Condition'),
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
