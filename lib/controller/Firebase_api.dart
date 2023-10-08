import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:yusr/helper/core/cache_manager.dart';


Future<void>handleMassaging(RemoteMessage massage)async {
  print('title${massage.notification?.title}');
  print('body${massage.notification?.body}');
  print('payload${massage.data}');
}
class FirebaseApi{
  final _firebaseMassage=FirebaseMessaging.instance;
  Future<void>initNotifcation()async{
    await _firebaseMassage.requestPermission();
    final fcmToken=await _firebaseMassage.getToken();
    CacheManager.saveData("token",fcmToken );
   FirebaseMessaging.onBackgroundMessage(handleMassaging);
    print("this:fcmToken$fcmToken");
  }
}

class PushNotificationManager {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> init() async {
    if (Platform.isIOS) {
      await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
      _firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    _firebaseMessaging.getToken().then((token) {
       CacheManager.saveData('token',token);
       final fcmToken =  CacheManager.readData('token');
       print("the cach fc token $fcmToken");
      print('FCM Token: $token');
      // Send the token to your server
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('onMessage: $message');
      // Handle the message here
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('onMessageOpenedApp: $message');
      // Handle the message here
    });
  }
}



