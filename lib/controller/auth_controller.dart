

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/userProfile_model.dart';
import '../services/auth_service.dart';

class ForgotPasswordModel extends ChangeNotifier {
  bool _isPasswordResetSuccessful = false;
  AuthService authService=AuthService();
  bool get isPasswordResetSuccessful => _isPasswordResetSuccessful;
  String _code = '';
  bool _isCodeVerified = false;
  late String _codeError;
  String get code => _code;
  bool get isCodeVerified => _isCodeVerified;
  String get codeError => _codeError;
  late Future<User?>? _user;
   Future<User?>? get  user => _user;

  void resetPassword(String emailOrPhoneNumber,context) async
  {

    _isPasswordResetSuccessful = await authService.forgetPassword(emailOrPhoneNumber,context);
    notifyListeners();
  }
  void userInfo(context) async
  {
    _user =  authService.fetchUserData(context);
    notifyListeners();
  }

  void setCode(String code) {
    _code = code;
  }

  Future<void> verifyCode(context,code,phone) async {

    if (await authService.verifyCode(_code,context,phone)) {
      _isCodeVerified = true;
      _codeError = '';
    } else {
      _isCodeVerified = false;
      _codeError = 'Invalid code. Please try again.';
    }
    notifyListeners();
  }


}


