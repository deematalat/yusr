
import 'package:flutter/material.dart';
import 'package:yusr/widgets/data_field.dart';
import '../helper/config/app_colors.dart';
import '../helper/config/app_text_style.dart';

class DetailsCard extends StatelessWidget {
  const DetailsCard({Key? key, required this.screenHeight, required this.cardChild}) : super(key: key);
  final double screenHeight;
   final Widget cardChild;
  @override
  Widget build(BuildContext context) {
    AppStyle appStyle = AppStyle(context);
    return   Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: cardChild,
      )
    );
  }
}
