
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yusr/helper/config/app_text.dart';
import '../controller/auth_controller.dart';
import '../helper/config/app_routes.dart';
import '../helper/config/app_text_style.dart';
import '../helper/core/route_manager.dart';
import '../widgets/app_header.dart';
import '../widgets/elevated_btn.dart';
import '../widgets/fields/ml_text_field.dart';


class ForgetPasswordView extends StatelessWidget {
   ForgetPasswordView({Key? key}) : super(key: key);
  final TextEditingController phoneController = TextEditingController();

   void resetPassword(String emailOrPhoneNumber,context) {
     final model = Provider.of<ForgotPasswordModel>(context);
     if (!model.isPasswordResetSuccessful) {
       model.resetPassword(emailOrPhoneNumber, context);
     }
     if(model.isPasswordResetSuccessful){
       Nav.toNamed(context,App.verifyPin,arguments:emailOrPhoneNumber);
     }
   }



  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    AppStyle appStyle = AppStyle(context);
    return
    Scaffold(
      backgroundColor: Colors.white,
     body: SafeArea(child:Column(
       children: [
     ListTile(
     title: Center(child: Image.asset('assets/images/yusr-logo.png',height:screenHeight/12,)),
      leading:BackButton(color: Colors.black,onPressed: (){
        Nav.toNamed(context,App.loginAuth);
      },) ,
    ),
         Padding(padding:EdgeInsets.only(
           left: 16,right: 16,top: 60
         ),
         child:
         Column(
           children: [
             Text(AppText.areforgetPassword,style:appStyle.blackFont24,),
             SizedBox(height: screenHeight/40,),
             Text(AppText.sendMassSlogen,
               style:appStyle.grayFont18,
               textAlign:TextAlign.center,),
             SizedBox(height: screenHeight/20,),
             _buildPhoneNumberField(appStyle),
             SizedBox(height: screenHeight/20,),
             _buildSendButton(context,screenWidth,screenHeight),
           ],
         ),
         ),

       ],
     ),
     ),
    );
  }
  Widget _buildPhoneNumberField(AppStyle appStyle) {
    return mlTextField(
      controller: phoneController,
      labelText: AppText.phoneNumber,
    );
  }
  Widget _buildSendButton(context,screenWidth,screenHeigth) {
    AppStyle appStyle = AppStyle(context);
    return ElevatedBtn(
      onPress: () async {
         resetPassword(phoneController.text,context);
      },
      widget: Text(AppText.send, style: appStyle.whiteFont26), screenWidth:screenWidth ,
      screenHeigth:screenHeigth ,
    );
  }
}



