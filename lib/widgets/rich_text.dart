import 'package:flutter/material.dart';

class RichTextWidget extends StatelessWidget {
  const RichTextWidget(
      {Key? key,
      required this.main,
      required this.sub,
      required this.mainStyle,
      required this.subStyle,
      required this.textAlign})
      : super(key: key);
  final String main;
  final String sub;
  final TextAlign textAlign;
  final TextStyle mainStyle;
  final TextStyle subStyle;
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      textAlign: textAlign,
      TextSpan(
        children: [
          TextSpan(
            text: main,
            style: mainStyle,
          ),
          TextSpan(
            text: ' ',
            style: TextStyle(
              overflow: TextOverflow.ellipsis,
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'Almarai',
              fontWeight: FontWeight.w700,
              height: 0,
            ),
          ),
          TextSpan(
            text: sub,
            style: subStyle,
          ),
        ],
      ),
    );
  }
}

class RowTextWidget extends StatelessWidget {
  const RowTextWidget(
      {Key? key,
      required this.main,
      required this.sub,
      required this.mainStyle,
      required this.subStyle,
      required this.textAlign})
      : super(key: key);
  final String main;
  final String sub;
  final TextAlign textAlign;
  final TextStyle mainStyle;
  final TextStyle subStyle;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return  Row(
      mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal:1),
            constraints: BoxConstraints(
              maxWidth: screenWidth/2,
              maxHeight:  screenHeight/10,
            ),
            child: Text(
              sub,
              style: subStyle,
              textDirection:TextDirection.rtl ,
              textAlign: TextAlign.end,
            ),),

        Text(
           main,
            style: mainStyle,
            textAlign: TextAlign.end,
          ),
        ],
    );
  }
}
