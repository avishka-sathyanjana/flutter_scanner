import 'package:flutter/material.dart';
import '../style_varible/style_screen.dart';



class ButtonWidget extends StatefulWidget {
  final BuildContext ctx;
  final String buttonName;
  final double buttonFontSize;
  final Color  buttonColor;
  final Color  borderColor;
  final Color textColor;
  final double buttonWidth;
  final double buttonHeight;
  final double buttonRadius;
  final Function validationStates;


  ButtonWidget({
    required this.ctx,
    required this.buttonName,
    required this.buttonFontSize,
    required this.buttonColor,
    required this.borderColor,
    required this.textColor,
    required this.buttonWidth,
    required this.buttonHeight,
    required this.buttonRadius,
    required this.validationStates});

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width:widget.buttonWidth,
      height: widget.buttonHeight,
      margin: const EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(widget.buttonRadius)
      ),
      child: ElevatedButton(
        onPressed:()=>widget.validationStates(),// call back function when execute the button
        style: ButtonStyle(
          // button style
          backgroundColor: MaterialStateProperty.all<Color>(widget.buttonColor),
          elevation: MaterialStateProperty.all<double>(0), // Remove elevation
          shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.buttonRadius),
              side: BorderSide(
                  color:widget.borderColor,
                  width: 2
              )
          )),

        ),
        child:Text(widget.buttonName,style: TextStyle(
            fontSize:widget.buttonFontSize,
            fontFamily:fontRaleway,
            color: widget.textColor,
            fontWeight: FontWeight.w700
        ),),
      ),
    );
  }
}
