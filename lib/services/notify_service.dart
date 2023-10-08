import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../helper/core/cache_manager.dart';
import '../helper/core/http_manager.dart';

class NotifyService{


  Future<void> storeDeviceToken( Map<String, dynamic> updateData,
      BuildContext context) async {
    try {
      MLApi mlApi = MLApi();
      final response = await mlApi.postData(updateData,
           'https://yusrapp.com/api/store-token?password_api=AaIMWSJIO21890');
      var jsonData = jsonDecode(response.body);
      print("this mode$jsonData");
      if (jsonData['status'] == 200) {

         print("request response is ${jsonData['data']['DeviceToken']}");

      } else {

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("${jsonData['message']}"),
        ));
        return null;
      }
    } catch (e) {

      return null;
    }
  }

  Future<void> sendWebNotification(String title, String massage,context) async {
    final apiToken = await CacheManager.readData("api_token");
    final plainTextToken = await CacheManager.readData("plainTextToken");
    print(apiToken is int);
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $plainTextToken'

    };
    final url = Uri.parse('https://yusrapp.com/api/send-web-notification/$apiToken');
    var request = http.Request('POST',url);
    request.body=jsonEncode({'title': title, 'body': massage,'password_api':"AaIMWSJIO21890"});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(response.stream.bytesToString());
      print("notification send successfully");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("${response.reasonPhrase}"),
      ));
    }
  }

}