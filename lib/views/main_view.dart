

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yusr/helper/config/app_colors.dart';
import 'package:yusr/views/home_view.dart';
import 'package:yusr/views/profile_view.dart';
import '../controller/trip_controller.dart';
import '../widgets/nbtn_widget.dart';
import 'history_view.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const  route='/mainScreen';
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex=2;
  List <NavigationButtonScreens> screens = <NavigationButtonScreens>
  [
    const NavigationButtonScreens(body:ProfileView()),
    const NavigationButtonScreens (body:HistoryView()),
    const NavigationButtonScreens(body: HomeView()),
  ];
  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar:BottomNavigationBar(
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
              icon:Icon(Icons.person_outlined),
              activeIcon:Icon(Icons.person),
              label: 'البروفيل'
          ),
          BottomNavigationBarItem(
              icon:Icon(Icons.history_edu),
              activeIcon:Icon(Icons.history_edu),
              label: 'الارشيف'
          ),
          BottomNavigationBarItem(
            icon:Icon(Icons.home_outlined),
            activeIcon:Icon(Icons.home_filled),
            label: 'الرئيسة',
          ),

        ],
        onTap:(index){
          setState(() {
            currentIndex = index;
          });
        },
        currentIndex: currentIndex,
        selectedFontSize:14,
        unselectedFontSize:12,
        selectedItemColor:AppColors.kprimary,
        unselectedItemColor:AppColors.ksub,
      ),
      body: SafeArea(
        child: Padding(padding: EdgeInsets.symmetric(horizontal: 16),
        child:SingleChildScrollView(
          child:Column(
          children: [
            SizedBox(height: screenHeight/60,),
            ListTile(
              title: Center(child: Image.asset('assets/images/yusr-logo.png',height:screenHeight/12,)),
            ),
            screens[currentIndex].body,
          ],
        ) ,),),
      )
    );
  }
}


// if i wanna safe the current size for item card but resizeToAvoidBottomInset: false, to scaffold