
import 'package:flutter/material.dart';
import 'package:yusr/helper/config/app_colors.dart';

import '../helper/config/app_text_style.dart';

class DataField extends StatelessWidget {
  const DataField({Key? key, required this.screenHeight, required this.screenWidth, required this.text, required this.color, required this.title}) : super(key: key);
  final double screenHeight;
  final double screenWidth;
  final String text;
  final Color color;
   final String title;
  @override
  Widget build(BuildContext context) {
    AppStyle appStyle = AppStyle(context);
    return Container(child:Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: screenWidth/5,
            maxHeight:  screenHeight/20,
          ),
          decoration: ShapeDecoration(
            color: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: Center(child: Text(text,style:appStyle.whiteFont16,),),
        ),
        Text(title,style:appStyle.blackFont24 ,),
      ],
    ),padding: EdgeInsets.symmetric(vertical: 5),)  ;
  }
}
