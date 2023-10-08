import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helper/core/cache_manager.dart';
import '../services/notify_service.dart';
import '../widgets/customNotifcation.dart';


class NotifyController with ChangeNotifier {
 static List <CustomNotification> customNotification=[];
  NotifyService notifyService=NotifyService();
      NotifyController(){
        loadNotifications();
      }
  Future<void> sendWebNotification(String title, String massage,context) async {
    int ableID = await CacheManager.readData('api_token');
     final fcmToken = await CacheManager.readData('token');
    await notifyService.storeDeviceToken({
      "token":fcmToken!,
    },context );
    await notifyService.sendWebNotification(title, massage,context);
    customNotification.add(
      CustomNotification(title: title, message: massage)
    );
    saveNotifications();
    notifyListeners();
  }

 void saveNotifications() async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   await prefs.setStringList('customNotifications', customNotification
       .map((notification) => jsonEncode(notification.toJson()))
       .toList());
 }

 void loadNotifications() async {
   SharedPreferences prefs = await SharedPreferences.getInstance();

   List<String>? jsonData = prefs.getStringList('customNotifications');
   if (jsonData != null) {
     customNotification = jsonData
         .map((json) => CustomNotification.fromJson(jsonDecode(json)))
         .toList();
   }
   notifyListeners();
 }
}
