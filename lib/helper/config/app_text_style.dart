import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:yusr/helper/config/app_colors.dart';

class AppStyle {
  final double screenWidth;
  final double screenHeight;

  AppStyle(BuildContext context)
      : screenWidth = MediaQuery.of(context).size.width,
        screenHeight = MediaQuery.of(context).size.height;

  TextStyle get blackFont26 => TextStyle(
    color: Color(0xFF000000),
    fontSize: (screenWidth < 400) ? 24 : 26,
    fontFamily: 'Almarai',
    fontWeight: FontWeight.w600,

  );

  TextStyle get blueFont32 => TextStyle(
    color: Color(0xFF193147),
    fontSize: (screenWidth < 400) ? 28 :32 ,
    fontFamily: 'Almarai',
    fontWeight: FontWeight.w700,

  );
  TextStyle get blackFont32 => TextStyle(
    color:  Colors.black,
    fontSize: (screenWidth < 400) ? 28 :32 ,
    fontFamily: 'Almarai',
    fontWeight: FontWeight.w700,

  );
  TextStyle get  blueFont24 => TextStyle(
    color: Color(0xFF0E497A),
    fontSize:(screenWidth < 400) ? 20 : 24,
    fontFamily: 'Almarai',
    fontWeight: FontWeight.w700,

  );

  TextStyle get blueFont22 => TextStyle(
    color: Color(0xFF0E497A),
    fontSize: (screenWidth < 400) ? 18 : 22,
    fontFamily: 'Almarai',
    fontWeight: FontWeight.w500,

  );

  TextStyle get  blackFont22 => TextStyle(
    color: Color(0xFF000000),
    fontSize: (screenWidth < 400) ? 18 : 22,
    fontFamily: 'fonts',
    fontWeight: FontWeight.w500,

    letterSpacing: 0.12,
  );

  TextStyle get  grayFont18 => TextStyle(
    color: Color(0xFF8F8996),
    fontSize:(screenWidth < 400) ? 14 : 18,
    fontFamily: 'fonts',
    fontWeight: FontWeight.w400,

  );
  TextStyle get  grayFont20 => TextStyle(
    color: Color(0xFF8F8996),
    fontSize: (screenWidth < 400) ? 16 : 20,
    fontFamily: 'fonts',
    fontWeight: FontWeight.w700,
    height: 0,
  );
  TextStyle get  grayFont24 => TextStyle(
    color: Color(0xFF8F8996),
    fontSize:(screenWidth < 400) ? 20 : 24,
    fontFamily: 'fonts',
    fontWeight: FontWeight.w700,
    height: 0,
  );
  TextStyle get  grayFont26 => TextStyle(
    color: Color(0xFF8F8996),
    fontSize:(screenWidth < 400) ? 22 : 26,
    fontFamily: 'fonts',
    fontWeight: FontWeight.w700,
    height: 0,
  );

  TextStyle get  whiteFont26 => TextStyle(
    color: Colors.white,
    fontSize: (screenWidth < 400) ? 22 : 26,
    fontFamily: 'Almarai',
    fontWeight: FontWeight.w700,

  );
  TextStyle get  blueFont26 => TextStyle(
    color: AppColors.kblue,
    fontSize: (screenWidth < 400) ? 22 : 28,
    fontFamily: 'Almarai',
    fontWeight: FontWeight.w700,

  );
  TextStyle get  whiteFont16 => TextStyle(
    color: Colors.white,
    fontSize: (screenWidth < 400) ? 12 : 16,
    fontFamily: 'Almarai',
    fontWeight: FontWeight.w700,

  );
  TextStyle get  greenFont24 => TextStyle(
    color:  Color(0xFF22A315),
    fontSize: (screenWidth < 400) ? 22 : 24,
    fontFamily: 'Almarai',
    fontWeight: FontWeight.w700,

  );
  TextStyle get  blackFont24 =>  TextStyle(
    color: Color(0xFF000000),
    fontSize: (screenWidth < 400) ? 20 : 24,
    fontFamily: 'Almarai',
    fontWeight: FontWeight.w700,
    height: 0.08,
    letterSpacing: -0.48,
  );
  TextStyle get  blackFont16 =>  TextStyle(
    color: Colors.black,
    fontSize:(screenWidth < 400) ? 12 : 16,
    fontFamily: 'fonts',
    fontWeight: FontWeight.w600,
    height: 0,
  );
  TextStyle get  blueFont14 =>  TextStyle(
    color: Color(0xFF0E497A),
    fontSize: 14,
    fontFamily: 'Almarai',
    fontWeight: FontWeight.w400,
    height: 0,
  );
  TextStyle get  blueFont16 =>  TextStyle(
    color: Color(0xFF0E497A),
    fontSize: (screenWidth < 400) ? 12 : 16,
    fontFamily: 'Almarai',
    fontWeight: FontWeight.w400,
    height: 0,
  );
}
