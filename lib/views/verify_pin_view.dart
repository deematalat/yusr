import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:yusr/helper/config/config.dart';
import '../controller/auth_controller.dart';
import '../helper/config/app_text_style.dart';
import '../helper/core/route_manager.dart';
import '../services/auth_service.dart';
import '../widgets/app_header.dart';
import '../widgets/connectivity_banner.dart';
import '../widgets/elevated_btn.dart';


class VerifyPinView extends StatefulWidget {
  const VerifyPinView({Key? key}) : super(key: key);

  @override
  State<VerifyPinView> createState() => _VerifyPinViewState();
}

class _VerifyPinViewState extends State<VerifyPinView> {

  final _verifyPinFormKey = GlobalKey<FormState>();

  // controllers
  final _num1Ctrl = TextEditingController();
  final _num2Ctrl = TextEditingController();
  final _num3Ctrl = TextEditingController();
  final _num4Ctrl = TextEditingController();



  void verifyCode(String _code,context,phone) {
    final model = Provider.of<ForgotPasswordModel>(context);
    if (!model.isCodeVerified) {
      model.verifyCode(context, _code,phone);
    }
    if(model.isCodeVerified){
      Nav.to(context,App.recoverPass);
    }


  }

  // has internet
  late StreamSubscription internetSubscription;

  @override
  initState() {
    internetSubscription =
        InternetConnectionChecker().onStatusChange.listen((status) {
          final hasInternet = status == InternetConnectionStatus.connected;
          if (!hasInternet) {
            connectivityBanner(context, 'No internet connection.',
                    () =>
                    ScaffoldMessenger.of(context).hideCurrentMaterialBanner()
            );
          } else {
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
          }
        });
    //
    super.initState();
  }


  @override
  void dispose() {
    _num1Ctrl.dispose();
    _num2Ctrl.dispose();
    _num3Ctrl.dispose();
    _num4Ctrl.dispose();
    internetSubscription.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    AppStyle appStyle = AppStyle(context);
    final String?  _userPhone = ModalRoute.of(context)!.settings.arguments as String;
    print(_userPhone);
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: ListView(
            children: [
              AppHeader(screenHeight:screenHeight,),
              SizedBox(height: screenHeight/20,),
              Form(
                key: _verifyPinFormKey,
                child: Container(
                  width:screenWidth,
                  height: screenHeight,
                  padding: const EdgeInsets.only(
                      left: 24, right: 24, bottom: 100),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(18, 20, 18, 0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(
                                    right: screenWidth* 0.06),
                                alignment: Alignment.center,
                                child:  Column(
                                  children: [
                                    Text(
                                     AppText.verify,
                                      style:appStyle.blackFont24
                                    ),
                                    SizedBox(height: screenHeight/40,),
                                    Text(
                                        AppText.verifySlogen +_userPhone!,
                                        style:appStyle.grayFont18,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              SizedBox(height: screenHeight/20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 68,
                                    width: 64,
                                    child: TextFormField(
                                      controller: _num1Ctrl,
                                      autofocus: true,
                                      cursorColor: Colors.black,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(1),
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color:Color(0xFF0E497A), width: 1),
                                        ),
                                      ),
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .headline6,
                                      onChanged: (textVal) {
                                        if (textVal.length == 1) {
                                          FocusScope.of(context).nextFocus();
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 68,
                                    width: 64,
                                    child: TextFormField(
                                      controller: _num2Ctrl,
                                      cursorColor: Colors.black,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(1),
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFF0E497A), width: 1),
                                        ),
                                      ),
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .headline6,
                                      onChanged: (textVal) {
                                        if (textVal.length == 1) {
                                          FocusScope.of(context).nextFocus();
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 68,
                                    width: 64,
                                    child: TextFormField(
                                      controller: _num3Ctrl,
                                      cursorColor: Colors.black,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(1),
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFF0E497A), width: 1),
                                        ),
                                      ),
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .headline6,
                                      onChanged: (textVal) {
                                        if (textVal.length == 1) {
                                          FocusScope.of(context).nextFocus();
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 68,
                                    width: 64,
                                    child: TextFormField(
                                      controller: _num4Ctrl,
                                      cursorColor: Colors.black,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(1),
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFF0E497A), width: 1),
                                        ),
                                      ),
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .headline6,
                                      onChanged: (textVal) {
                                        if (textVal.length == 1) {
                                          FocusScope.of(context).nextFocus();
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20,),
                              _buildLVerifyButton(screenWidth,screenHeight),
                            ],
                          ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLVerifyButton(screenWidth,screenHeigth) {
    AppStyle appStyle = AppStyle(context);
    return ElevatedBtn(
      onPress: () {

      },
      widget: Text(AppText.confirm, style: appStyle.whiteFont26),
      screenWidth:screenWidth, screenHeigth: screenHeigth ,
    );
  }
}


