
import 'package:flutter/material.dart';
import 'package:yusr/helper/core/route_manager.dart';

class AppHeader extends StatelessWidget {
  const AppHeader( {Key? key, required this.screenHeight}) : super(key: key);
  final double screenHeight;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Center(child: Image.asset('assets/images/yusr-logo.png',height:screenHeight/12,)),
      leading:BackButton(color: Colors.black,onPressed: (){
        Nav.close(context);
      },) ,
    );
  }
}
