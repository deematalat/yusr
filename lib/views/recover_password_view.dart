import 'dart:async';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../helper/config/app_text.dart';
import '../helper/config/app_text_style.dart';
import '../widgets/app_header.dart';
import '../widgets/connectivity_banner.dart';
import '../widgets/elevated_btn.dart';
import '../widgets/fields/ml_password_field.dart';


class RecoverPasswordView extends StatefulWidget {
  const RecoverPasswordView({Key? key}) : super(key: key);

  @override
  State<RecoverPasswordView> createState() => _RecoverPasswordViewState();
}

class _RecoverPasswordViewState extends State<RecoverPasswordView> {

  final _recoverPassFormKey = GlobalKey<FormState>();

  DateTime? _currentBackPressTime;

  // controllers
  final _passwordCtrl = TextEditingController();
  final _confirmPassCtrl = TextEditingController();

  // show password
  bool passwordVisible = true;


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

    //
    super.initState();
  }


  String? _validateConfirmPassword(String? val) {
    if (val == null || val.isEmpty) {
      return 'Confirm is required';
    }
    if (_passwordCtrl.value.text != val) {
      return 'Confirmation password does not match';
    }
    return null;
  }

  @override
  void dispose() {
    _passwordCtrl.dispose();
    _confirmPassCtrl.dispose();
    internetSubscription.cancel();
    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    AppStyle appStyle = AppStyle(context);
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            AppHeader(screenHeight: screenHeight,),
            SizedBox(height: screenHeight * 0.05,),
            Form(
              key: _recoverPassFormKey,
              child: SizedBox(
                height: screenHeight * 0.70,
                width: double.infinity,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    Text(
                        AppText.newPass,
                        style:appStyle.blackFont24,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: screenHeight/40,),
                    Text(
                      AppText.newPassSlogen,
                      style:appStyle.grayFont18,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: screenHeight/20,),
                    _buildPasswordField(appStyle),
                    SizedBox(height: screenHeight/20,),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock_open,
                          size: 20,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                          icon: Icon(
                              passwordVisible ? Icons.visibility : Icons
                                  .visibility_off),
                        ),
                        labelText: AppText.confirmPass,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Color(0xFF8F8996))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Color(0xFF0E497A))),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.red)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Color(0xFF8F8996))),
                      ),
                      controller: _confirmPassCtrl,
                      autovalidateMode: AutovalidateMode
                          .onUserInteraction,
                      validator: _validateConfirmPassword,
                    ),
                    SizedBox(height: screenHeight/20,),
                    _buildLVerifyButton(screenWidth,screenHeight)

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordField(AppStyle appStyle) {
    return mlPasswordField(
      controller: _passwordCtrl,
      labelText: AppText.password,
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

