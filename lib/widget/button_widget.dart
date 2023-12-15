import 'package:flutter/material.dart';
import '/style_varible/style_screen.dart';


class ButtonWidget extends StatefulWidget {
  final BuildContext ctx;
  final String buttonName;
  final double buttonFontSize;
  final Color  buttonColor;
  final Color  borderColor;
  final double buttonWidth;
  final double buttonHeghit;
  final Function validationStates;



  ButtonWidget({
    required this.ctx,
    required this.buttonName,
    required this.buttonFontSize,
    required this.buttonColor,
    required this.borderColor,
    required this.buttonWidth,
    required this.buttonHeghit,
    required this.validationStates});

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width:widget.buttonWidth,
      height: widget.buttonHeghit,
      margin: const EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(12)
      ),
      child: ElevatedButton(
        onPressed:()=>widget.validationStates(),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(widget.buttonColor),
          elevation: MaterialStateProperty.all<double>(0), // Remove elevation
          shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(
                  color:widget.borderColor,
                  width: 2
              )
          )),

        ),
        child:Text(widget.buttonName,style: TextStyle(
            fontSize:widget.buttonFontSize,
            fontFamily:fontRaleway,
            color: colorPlate2
        ),),
      ),
    );
  }
}
