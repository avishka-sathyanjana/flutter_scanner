
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import '../data_validations/login_validation.dart';
import '/style_varible/style_screen.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '/database/genarate_excel.dart';
import '/widget/serach_drop.dart';
import '/widget/button_widget.dart';
import 'package:open_file_plus/open_file_plus.dart';
import '/data_validations/loding_bar.dart';


class ReportGenarte extends StatefulWidget {
  const ReportGenarte({super.key});

  @override
  State<ReportGenarte> createState() => _ReportGenarteState();
}

class _ReportGenarteState extends State<ReportGenarte> {
  final _keyFrom=GlobalKey<FormState>();
  final TextEditingController _controller=TextEditingController();

  final List<String> items = [
            "Defult",
            "ACA",
            "ADM",
            "APB",
            "APB -Southwing",
            "CDF",
            "CSC",
            "DIR",
            "EDC",
            "ELC",
            "ENG",
            "EXM",
            "FIN",
            "LIB",
            "MTC",
            "NOC",
            "PDC",
            "PRP",
            "QAC",
            "SDU",
            "ED",
            "ADMTC",

  ];

  String? selectedValue;
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    textEditingController.dispose();
    super.dispose();
  }

  Widget serachDrop(double menuSize){
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: const Text(
          'Select divition',
          style: TextStyle(
            fontSize: 16,
            color:Colors.black,
          ),
        ),
        items: items
            .map((item) => DropdownMenuItem(
          value: item,
          child: Text(
            item,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ))
            .toList(),
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            selectedValue = value;
          });
        },
        buttonStyleData: ButtonStyleData(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            border: BoxBorder.lerp(
               Border.all(color: colorPlate2, width: 2.0),
                Border.all(color:colorPlate2, width: 2.0),
                0.5, // Interpolation factor (0.0 to 1.0)
           ),
          ),
          height: 60,
          width:double.infinity,
          padding: const EdgeInsets.only(left: 12)
          
        ),
        dropdownStyleData: const DropdownStyleData(
          maxHeight: 300,
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
        ),
        dropdownSearchData: DropdownSearchData(
          searchController: textEditingController,
          searchInnerWidgetHeight: 50,
          searchInnerWidget: Container(
            height: 60,
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 4,
              right: 8,
              left: 8,
            ),
            child: TextFormField(
              expands: true,
              maxLines: null,
              controller: textEditingController,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                hintText: 'Search for an item...',
                hintStyle: const TextStyle(fontSize: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          searchMatchFn: (item, searchValue) {
            return item.value.toString().contains(searchValue);
          },
        ),
        //This to clear the search value when you close the menu
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            textEditingController.clear();
          }
        },
      ),
    );
  }


  Future<void> openFile(String path) async {
    String filePath = path;
     await OpenFile.open(filePath);

  }

  @override
  Widget build(BuildContext context) {
    Size screenSize=MediaQuery.of(context).size;
    double width=screenSize.width;
    double hehgit=screenSize.height;
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: colorPlate2,
         title: const Text(
           "Reports",style: TextStyle(
           fontSize: 20,
           fontFamily: fontRaleway,
           color: Colors.white
         ),
         ),
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child:Form(
          key: _keyFrom,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            
                ClipRRect(
                    child: Image.asset("assets/images/reports.png",height:hehgit/4,width:width ,fit:BoxFit.cover,),
                   ),
            
               SizedBox(
                 height: hehgit/12,
               ),
                serachDrop(hehgit/5),
                SizedBox(
                  height: hehgit/16,
                ),
                SizedBox(
                  width: width,
                  height: 60,
                  child: Container(
                     decoration: BoxDecoration(
                      border: Border.all(
                         color: colorPlate2,
                         width: 2,
                      ),
                       borderRadius: BorderRadius.circular(10)
                     ),
                    child: TextField(
                        controller:_controller ,
                        decoration:const InputDecoration(
                            contentPadding:EdgeInsets.only(left:20,top: 10),
                            hintText:"Enter your File Name",
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: fontRaleway,
                              fontSize: 15
                            ),
                            // errorText: showError(),
                            border:OutlineInputBorder(
                              borderSide: BorderSide.none,
                            )
                        ),
                    ),
                  ),
                ),
                SizedBox(
                  height: hehgit/10,
                ),
                ButtonWidget(
                    ctx: context,
                    buttonName:"Get Report",
                    buttonFontSize:15,
                    buttonColor: Colors.white,
                    borderColor:colorPlate2,
                    textColor: Colors.black,
                    buttonWidth:width/3,
                    buttonHeight: 60,
                    buttonRadius:15,
                    validationStates: ()async{
                      if( selectedValue!=null&& selectedValue!.isNotEmpty && _controller.text.isNotEmpty){
                          showLoadingDialog(context);//make load bar
                          var reslut= await GenerateExcel().exportExcel(selectedValue!,_controller.text);
                               setState(() {
                                 activate=false;
                                 showLoadingDialog(context);
                               });
                               //stop the load bar
                            if(reslut.isNotEmpty){
                              await openFile(reslut.toString()); //ope the froder
                              activate=true; //active load bar
                            }else{
                              setState(() {
                                activate=true;// active lod bar
                                showError(
                                    context,
                                    "Empty Recodes",
                                     "Error",
                                      Icons.error,
                                      colorPlate3,
                                      Colors.red,
                                      Colors.red
                                   );
                                });
                            }

                       }else{
                         showError(
                             context,
                             "Field is empty",
                             "error",
                             Icons.error,
                             colorPlate3,
                             Colors.red,
                             Colors.red
                         );
                       }
            
                    })

              ],
            ),
          ),
        ),
      )
    );
  }
}




