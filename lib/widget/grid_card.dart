import 'package:flutter/material.dart';
import '/style_varible/style_screen.dart';

class GridCard extends StatefulWidget {
  final Function userDifingFunction;
  final String imageUrl;
  final String funcName;

   GridCard({required this.userDifingFunction,required this.imageUrl,required this.funcName});

  @override
  State<GridCard> createState() => _GridCardState();
}

class _GridCardState extends State<GridCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>widget.userDifingFunction(),
      child: Card(
        elevation: 4,
        color: Colors.white,
        child: Container(
            width: double.infinity,
            height: 200,
            //color: colorPlate2,
            child: Stack(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(widget.imageUrl,
                      width: double.infinity,
                      height:180,


                    )

                ),
                Positioned(
                  bottom: 0,
                  child: Center(
                    child: Container(
                      width: 400,
                      height: 40,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
                          color: Colors.white,
                          shape: BoxShape.rectangle
                      ),
                      child: Center(
                        child: Text(
                          widget.funcName,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: fontRaleway,
                              color: colorPlate2
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
        ),
      ),
    );
  }
}
