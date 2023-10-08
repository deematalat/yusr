import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import '../helper/config/api_endpoints.dart';
import '../helper/core/cache_manager.dart';
import '../helper/core/http_manager.dart';
import '../models/auth/login_request_model.dart';
import '../models/auth/login_response_model.dart';
import '../models/userProfile_model.dart';
import 'package:http/http.dart'as http;

class AuthService {
  MLApi mlApi = MLApi();
  bool isLoggedIn() {
    // Check if the user is logged in
    // Return true if logged in, false otherwise
    return true;
  }

  Future<LoginResponseModel?> login(LoginRequestModel model,
      BuildContext context) async {
    try {
      final response = await mlApi.postData(model.toJson(),
          ApiEndpoint.login);
      var jsonData = jsonDecode(response.body);
      print("this mode$jsonData");
      if (jsonData['status'] == 200) {
        CacheManager.saveData("api_token", jsonData['data']['accessToken']['tokenable_id']);
        CacheManager.saveData("plainTextToken", jsonData['data']['plainTextToken']);
        CacheManager.saveData("user_name", jsonData['data']['accessToken']['name']);
        final plainTextToken = await CacheManager.readData("plainTextToken");
          print("this plainTextToken $plainTextToken");
        return LoginResponseModel.fromJson(jsonData);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("${jsonData['message']}"),
        ));
        return null;
      }
    } catch (e) {
         print( "this e$e");
      return null;
    }
  }
  Future<bool> forgetPassword(String emailOrPhoneNumber,context) async {
    final response = await  mlApi.postData({'emailOrPhoneNumber': emailOrPhoneNumber}, ApiEndpoint.forgetPass);
    var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return true; // Password reset request was successful
    } else {
      // Handle non-200 status codes gracefully
      print("Reset failed with status code: ${response['message']}");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("${jsonData['message']}"),
      ));
      return false; // Password reset request failed
    }
  }
  Future<bool> resetPassword(String password,String passwordConfirm,context) async {
    final response = await  mlApi.postData({'password': password,'password_confirmation':passwordConfirm},
        ApiEndpoint.resetPass);
    var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return true; // Password reset request was successful
    } else {
      // Handle non-200 status codes gracefully
      print("Reset failed with status code: ${response['message']}");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("${jsonData['message']}"),
      ));
      return false; // Password reset request failed
    }
  }
  Future<bool> verifyCode(String code,String phone,context) async {
    final response = await  mlApi.postData({'otp':code,'phone':phone}, ApiEndpoint.verifyCode);
    var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return true;
    } else {
      // Handle non-200 status codes gracefully
      print("Verify failed with status code: ${response['message']}");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("${jsonData['message']}"),
      ));
      return false;
    }
  }

  Future<User?>? fetchUserData(BuildContext context) async {
try{
    final response = await mlApi.getData("${ApiEndpoint.profile}?password_api=AaIMWSJIO21890");
    var jsonData = jsonDecode(response.body);
    print("this mode$jsonData");
    if (response.statusCode == 200) {
      if (jsonData['status'] == 200) {
        final  Data = jsonData['data']['user'];
          return User.fromJson(Data);

      } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("${response.statusCode}"),
      ));
      // You can choose to throw an error here or return a default User instance.
      throw Exception("Failed to fetch user data");
    }
  }} catch (e) {
  if (e is SocketException) {
    print("No network connection");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("No network connection. Please check your internet connection."),
      ),
    );
  } else {
    print("Error: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("An error occurred while making the request. Please try again."),
      ),
    );
  }
}
}
  Future<void> updateProfile(Map<String, dynamic> updateData,BuildContext context) async {
    final response = await mlApi.putData(ApiEndpoint.profileUpdate, updateData);
    var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      // Handle the response data as needed
      print(data);
    } else {
      // Handle errors here

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("${jsonData['message']}"),
      ));

    }
  }

}