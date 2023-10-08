import 'package:flutter/material.dart';

import '../controller/Firebase_api.dart';
import '../helper/config/app_text.dart';
import '../helper/config/app_text_style.dart';
import '../helper/config/config.dart';
import '../helper/core/route_manager.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    super.initState();
  }
  Widget _buildCard(double screenWidth, double screenHeight, AppStyle appStyle,context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: 70,
        top: 40,
      ),
      width: screenWidth,
      height: screenHeight / 2,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(34),
            topRight: Radius.circular(34),
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('assets/images/yusr-logo.png', width: screenWidth / 1.5),
          Text(
            AppText.onBoardingWelcome,
            textAlign: TextAlign.center,
            style: appStyle.blackFont24,
          ),
          Text(
            AppText.slogen,
            textAlign: TextAlign.center,
            style: appStyle.grayFont18,
          ),
          _buildButton(screenWidth,screenHeight,context),
        ],
      ),
    );
  }

  Widget _buildButton(double screenWidth, double screenHeight,context) {
    return GestureDetector(
      onTap: () {
        Nav.to(context, App.loginAuth);
      },
      child: Container(
        width: screenWidth / 4,
        height: screenHeight / 10,
        decoration: ShapeDecoration(
          color: Color(0xFF243D52),
          shape: CircleBorder(),
        ),
        child: Center(
          child: Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
            size: 28,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    AppStyle appStyle = AppStyle(context);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: -27,
              child: Container(
                width: screenWidth,
                height: screenHeight / 1.8,
                decoration: BoxDecoration(
                  color: Color(0x4C020202),
                  image: DecorationImage(
                    image: AssetImage('assets/images/onboarding.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              top: screenHeight/2.1,
              child: _buildCard(screenWidth, screenHeight, appStyle,context),
            ),
          ],
        ),
      ),
    );
  }
}
