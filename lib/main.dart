


import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controller/Firebase_api.dart';
import 'controller/auth_controller.dart';
import 'controller/notify_controller.dart';
import 'controller/trip_controller.dart';
import 'helper/config/app_routes.dart';
import 'helper/core/cache_manager.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = new MyHttpOverrides();
  await Firebase.initializeApp();
  await FirebaseApi().initNotifcation();
  final pushNotificationManager = PushNotificationManager();
  await pushNotificationManager.init();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {

  // Theme Mode Change Start
  static final ValueNotifier<ThemeMode> themeNotifier =
  ValueNotifier(ThemeMode.light);
  // Theme Mode Change End
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //CacheManager.clearData();
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return MultiProvider(
              providers: [
                ChangeNotifierProvider<TripProvider>(
                  create: (context) => TripProvider(),
                ),
                ChangeNotifierProvider<ForgotPasswordModel>(
                  create: (context) => ForgotPasswordModel(),
                ),
                ChangeNotifierProvider<NotifyController>(
                  create: (context) => NotifyController(),
                )

              ],child: FutureBuilder<dynamic>(
            future: CacheManager.readData('plainTextToken'),
            builder: (context, snapshot) {
              print(snapshot.data);
              if (snapshot.connectionState == ConnectionState.done) {
                final String apiToken = snapshot.data ?? '';
                return MaterialApp(
                  locale: Locale('ar'),
                  debugShowCheckedModeBanner: false,
                  initialRoute: (apiToken != '') ? App.main : App.onBoarding,
                  routes: Routes().routes,
                );
              } else {
                // Handle loading state if needed
                return CircularProgressIndicator();
              }
            },
          ),
          );
        });
  }

}