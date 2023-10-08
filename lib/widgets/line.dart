import 'package:flutter/material.dart';

import '../helper/config/app_colors.dart';

class Line extends StatelessWidget {
  const Line({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      constraints:BoxConstraints(
          maxWidth:  screenWidth /300,
        maxHeight: screenWidth/15

      ),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            strokeAlign: BorderSide.strokeAlignCenter,
            color: AppColors.ksub,
          ),
        ),
      ),
    );
  }
}
