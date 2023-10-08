import 'package:flutter/material.dart';
import '../helper/config/app_routes.dart';
import '../helper/config/config.dart';
import '../helper/core/route_manager.dart';
import '../models/auth/login_request_model.dart';
import '../services/auth_service.dart';
import '../widgets/elevated_btn.dart';
import '../widgets/fields/ml_password_field.dart';
import '../widgets/fields/ml_text_field.dart';
import '../widgets/widgets.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool keyboardIsVisible = false;
  double keyboardHeight = 0.0;


  Future<void> _loginUser(String phone, String password) async {
    if (mounted) {
      final response = await _authService.login(
          LoginRequestModel(phone: phone, password: password), context);
      print("this response $response");
      if (response != null) {
        Nav.toNamed(context, App.main);
      } else
        Nav.toNamed(context, App.loginAuth);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    AppStyle appStyle = AppStyle(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(child:
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16,
              vertical: 50),
          child: Form(
            key: _formKey,
            child: SizedBox(
                height: screenHeight * 0.70,
                width: double.infinity,
                child:
             ListView(
              children: [
                // Header and Logo
                _buildHeader(screenWidth, screenHeight, appStyle),

                SizedBox(height: screenHeight / 20),

                // Welcome Text
                _buildWelcomeText(appStyle),

                SizedBox(height: screenHeight / 50),

                // Login Via Text
                Text(AppText.loginVia, style: appStyle.blueFont22,textAlign: TextAlign.center,),

                SizedBox(height: screenHeight / 30),

                // Phone Number Field
                _buildPhoneNumberField(appStyle),

                SizedBox(height: screenHeight / 50),

                // Password Field
                _buildPasswordField(appStyle),

                SizedBox(height: screenHeight / 90),

                // Forgot Password Text
                _buildForgotPasswordText(appStyle),

                SizedBox(height: screenHeight / 30),

                // Login Button
                _buildLoginButton(screenWidth,screenHeight),

              ],
            ),),
          ),
        ),
      ),),
    );
  }

  // Widget functions for building UI components
  Widget _buildHeader(double screenWidth, double screenHeight, AppStyle appStyle) {
    return Column(
      children: [
        Image.asset(
          "assets/images/yusr-logo.png",
          width: screenWidth / 1.5,
          height: screenHeight / 8,
        ),
      ],
    );
  }

  Widget _buildWelcomeText(AppStyle appStyle) {
    return RowTextWidget(
      textAlign:TextAlign.center,
      main: AppText.welcomeToApp,
      sub: AppText.appName,
      mainStyle: appStyle.blackFont26,
      subStyle: appStyle.blueFont32,
    );
  }

  Widget _buildPhoneNumberField(AppStyle appStyle) {
    return mlTextField(
      controller: _phoneController,
      labelText: AppText.phoneNumber,
    );
  }

  Widget _buildPasswordField(AppStyle appStyle) {
    return   mlPasswordField(
      controller: _passwordController,
      labelText: AppText.password,
    );
  }

  Widget _buildForgotPasswordText(AppStyle appStyle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InkWell(
            onTap: (){
              Nav.to(context,App.forgetPass);
            },
            child:
            Text(AppText.forgetPassword, style: appStyle.blueFont22)),
      ],
    );
  }

  Widget _buildLoginButton(screenWidth,screenHeigth) {
    AppStyle appStyle = AppStyle(context);
    return ElevatedBtn(
      onPress: () {
        if(_formKey.currentState!.validate())
        _loginUser(_phoneController.text, _passwordController.text);
      },
      widget: Text(AppText.login, style: appStyle.whiteFont26),
      screenWidth:screenWidth, screenHeigth: screenHeigth ,
    );
  }
}
