
import 'package:flutter/material.dart';
import 'package:flutter_mobile_barcode_qrcode_scanner/model_data/drop_dwon_data.dart';
import 'package:flutter_mobile_barcode_qrcode_scanner/style_varible/style_screen.dart';
import 'package:multi_dropdown/enum/app_enums.dart';
import 'package:multi_dropdown/models/chip_config.dart';
import 'package:multi_dropdown/models/network_config.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:multi_dropdown/widgets/hint_text.dart';
import 'package:multi_dropdown/widgets/selection_chip.dart';
import 'package:multi_dropdown/widgets/single_selected_item.dart';
import '../provider/location_state.dart';
import 'package:provider/provider.dart';
import '/model_data/drop_dwon_data.dart';


class DropDwon extends StatefulWidget {
  const DropDwon({super.key});

  @override
  State<DropDwon> createState() => _DropDwonState();
}

class _DropDwonState extends State<DropDwon> {
  final MultiSelectController _controller=MultiSelectController();
  @override
  Widget build(BuildContext context) {

    return Container(
      width:double.infinity,
      height: 65,
      child: MultiSelectDropDown(
        inputDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0), // Set border radius
          border: Border.all(
            color: Colors.black54, // Set border color
            width: 1.0,
            // Set border width
          ),


        ),

        showClearIcon:false,
        controller:_controller,
        onOptionSelected: (options) {
          if(options.isNotEmpty){
            print(options.single.value);
            Provider.of<DropDwonData>(context,listen: false).dropValue(options.single.value);
          }else{
            Provider.of<DropDwonData>(context, listen: false).dropValue('');
          }

        },
        onOptionRemoved:(index,option){
          Provider.of<DropDwonData>(context, listen: false).dropValue('');
        },
        options: const <ValueItem>[
          ValueItem(label: 'New code', value: '1'),
          ValueItem(label: 'Proposed Code', value: '2'),
          ValueItem(label: 'Old code', value: '3'),
        ],
        maxItems: 1,
        //disabledOptions: const [ValueItem(label: 'Option 1', value: '1')],
        selectionType: SelectionType.multi,
        chipConfig: const ChipConfig(wrapType: WrapType.wrap),
        dropdownHeight: 150,
        optionTextStyle: const TextStyle(fontSize: 16,fontFamily: fontRaleway),
        selectedOptionIcon: const Icon(Icons.check_circle),
        hint: "select",
        hintStyle: const TextStyle(color: Colors.black,fontSize: 15),
      ),
    );
  }
}
