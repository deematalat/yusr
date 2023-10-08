import 'package:flutter/material.dart';

class ElevatedBtn extends StatelessWidget {
  const ElevatedBtn({Key? key, required this.onPress,required this.widget, required this.screenWidth, required this.screenHeigth}) : super(key: key);
  final Function()? onPress;
  final Widget? widget;
  final double screenWidth;
  final double screenHeigth;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF2A4257),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        minimumSize: Size(screenWidth,screenHeigth/14),
      ),
      onPressed: onPress,
      child: widget,
    );
  }
}

class SmallElevatedBtn extends StatelessWidget {
  const SmallElevatedBtn({Key? key, required this.onPress,required this.widget, required this.screenWidth, required this.screenHeigth}) : super(key: key);
  final Function()? onPress;
  final Widget? widget;
  final double screenWidth;
  final double screenHeigth;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF2A4257),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        minimumSize: Size(screenWidth/20,screenHeigth/20),
      ),
      onPressed: onPress,
      child: widget,
    );
  }
}
