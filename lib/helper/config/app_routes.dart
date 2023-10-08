import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:yusr/views/detials_view.dart';
import 'package:yusr/views/forgetPassword_view.dart';
import 'package:yusr/views/history_view.dart';
import 'package:yusr/views/login_view.dart';
import 'package:yusr/views/main_view.dart';
import 'package:yusr/views/profile_view.dart';
import 'package:yusr/views/recover_password_view.dart';
import 'package:yusr/views/trip_page.dart';
import '../../views/home_view.dart';
import '../../views/onboarding_view.dart';
import '../../views/verify_pin_view.dart';
import '../core/route_manager.dart';


class Routes extends RouteManager {
  Routes() {
    addAll(App().routes);
  }
}

class App extends RouteManager {
  static const String name = '';
  static const String home = '${App.name}/';
  // Auth system
  static const String loginAuth = '${App.name}/login';
  static const String  onBoarding = '${App.name}/onBoarding';
  static const String  forgetPass = '${App.name}/forgetPass';
  static const String  verifyPin = '${App.name}/verifyPin';
  static const String  recoverPass = '${App.name}/recoverPass';
  static const String  main = '${App.name}/main';
  static const String  history = '${App.name}/history';
  static const String  profile = '${App.name}/profile';
  static const String  detials = '${App.name}/detials';
  static const String  tripPage = '${App.name}/tripPage';
  App() {
    addRoute(App.onBoarding, (context) => AnimatedSplashScreen(
        duration: 3000,
        splash: 'assets/images/splach.png',
        nextScreen:OnboardingScreen(),
        splashTransition: SplashTransition.slideTransition,
        pageTransitionType: PageTransitionType.fade,
        backgroundColor: Colors.white));
    addRoute(App.loginAuth, (context) => LoginView());
    addRoute(App.home, (context) => HomeView());
    addRoute(App.forgetPass, (context) => ForgetPasswordView());
    addRoute(App.verifyPin, (context) => VerifyPinView());
    addRoute(App.recoverPass, (context) => RecoverPasswordView());
    addRoute(App.main, (context) => MainScreen());
    addRoute(App.history, (context) => HistoryView());
    addRoute(App.profile, (context) => ProfileView());
    addRoute(App.detials, (context) => DetialsView());
    addRoute(App.tripPage, (context) => TripPage());
  }
}