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
            width: 100,
            height: 300,
            //color: colorPlate2,
            child: Stack(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(widget.imageUrl
                      ,fit: BoxFit.cover,
                    )

                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: 182,
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
                            fontSize: 16,
                            fontFamily: fontRaleway,
                            color: colorPlate2
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
