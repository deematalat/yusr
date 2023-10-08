import 'dart:async';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rive/rive.dart';
import 'package:yusr/helper/config/app_text.dart';

import '../controller/auth_controller.dart';
import '../controller/trip_controller.dart';
import '../helper/config/app_colors.dart';
import '../helper/config/app_text_style.dart';
import '../helper/core/cache_manager.dart';
import '../models/trip_model.dart';

import '../services/auth_service.dart';
import '../services/trip_service.dart';
import '../widgets/connectivity_banner.dart';
import '../widgets/home_card.dart';
import '../widgets/line.dart';
import '../widgets/rich_text.dart';
import '../widgets/shimmer.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late StreamSubscription internetSubscription;

  PageController _pageController = PageController(initialPage:0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  int sort=0;

  ForgotPasswordModel authService = ForgotPasswordModel();
  int pageNum = 0;

  @override
  initState() {
    if(mounted)
    internetSubscription =
        InternetConnectionChecker().onStatusChange.listen((status) {
      final hasInternet = status == InternetConnectionStatus.connected;
      if (mounted) {
      if (!hasInternet) {

        if (mounted) {
        connectivityBanner(context, 'No internet connection.',
            () => ScaffoldMessenger.of(context).hideCurrentMaterialBanner());}
      } else {
        if (mounted) {
        ScaffoldMessenger.of(context).hideCurrentMaterialBanner();}
      }
    }});

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final tripProvider = Provider.of<TripProvider>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    AppStyle appStyle = AppStyle(context);
    tripProvider.fetchAndSortTrips(context, 4);
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        SizedBox(
          height: screenHeight / 60,
        ),
        userName(appStyle),
        SizedBox(
          height: screenHeight / 60,
        ),
        Text(
          AppText.allTrips,
          style: appStyle.blackFont32,
          textAlign: TextAlign.end,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(onPressed:(){
              _showItemDialog(context,appStyle,tripProvider);
            }, icon:Icon(Icons.filter_list_rounded,color:AppColors.ksub,size:40,)),
            Text(
              AppText.sortBy,
              style: appStyle.grayFont20,
              textAlign: TextAlign.end,
            ),
          ],
        ),
        Container(
          height: screenHeight / 10,
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          pageNum == 2 ? AppColors.kprimary : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      _pageController.animateToPage(2,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    },
                    child: Text(
                        sort==0?'اسبوع ': 'جاري تنفيذها',
                        textAlign: TextAlign.end,
                        style: pageNum == 2
                            ? appStyle.whiteFont16
                            : appStyle.blueFont16)),
              ),
              Line(),
              Expanded(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          pageNum == 1 ? AppColors.kprimary : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      _pageController.animateToPage(1,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    },
                    child: Text(
                        sort==0?'امس':'بانتظار التحرك',
                        style: pageNum == 1
                            ? appStyle.whiteFont16
                            : appStyle.blueFont16,textAlign: TextAlign.end,)),
              ),
              Line(),
              Expanded(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          pageNum == 0 ? AppColors.kprimary : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      _pageController.animateToPage(0,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    },
                    child: Text(
                     sort==0? 'اليوم':'قيد المعالحة',
                      style: pageNum == 0
                          ? appStyle.whiteFont16
                          : appStyle.blueFont16,
                        textAlign: TextAlign.end
                    )),
              ),
            ],
          ),
        ),
        Container(
          constraints: BoxConstraints(maxHeight:screenHeight*5, maxWidth: 400),
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                // Handle page changes and update the selected date
                if (index == 0) {
                  pageNum = index;
                } else if (index == 1) {
                  pageNum = index;
                } else {
                  pageNum = index;
                }
              });
            },
            children: [
              // Page 1: Today
              (sort==0)?
              _buildTripList(1, context):
              _buildTripListByStatus(1,context),
              // Page 2: Tomorrow
              (sort==0)?
              _buildTripList(2, context):
              _buildTripListByStatus(2,context),

              // Page 3: Specific Date

              (sort==0)?
              _buildTripList(4, context):
              _buildTripListByStatus(3,context),


            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTripList(int sort_by_option, context,) {
    final tripProvider = Provider.of<TripProvider>(context,listen: false);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    AppStyle appStyle = AppStyle(context);
    if (!mounted) {
      return Container();
    }
    return FutureBuilder<List<Trip>?>(
      future: tripProvider.fetchAndSortTrips(context, sort_by_option), // Implement this method
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return buildShimmerLoading();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Container(
            padding: EdgeInsets.all(60),
            child: Column(
              children: [
                Text(
                  "لا يوجد رحلات متوفرة!",
                  style: appStyle.blackFont26,
                ),
                RiveAnimation.asset(
                  'assets/5514-10878-completed-trip.riv',
                  useArtboardSize: true,
                ),
              ],
            ),
          );
        } else {
          // Display the list of trips based on the fetched data
          return ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) => SizedBox(
              height: screenHeight / 60,
            ),
            itemBuilder: (context, index) => HomeCard(
              screenHeight: screenHeight,
              screenWidth: screenWidth,
              trip: snapshot.data![index],
            ),
            itemCount: snapshot.data!.length,
          );
        }
      },
    );
  }
  Widget _buildTripListByStatus(int sort_by_option, context,) {
    final tripProvider = Provider.of<TripProvider>(context,listen: false);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    AppStyle appStyle = AppStyle(context);
    if (!mounted) {
      return Container();
    }
    return FutureBuilder<List<Trip>?>(
      future: tripProvider.fetchAndSortTripsByStatus(context, sort_by_option), // Implement this method
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return buildShimmerLoading();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Container(
            padding: EdgeInsets.all(60),
            child: Column(
              children: [
                Text(
                  "لا يوجد رحلات متوفرة!",
                  style: appStyle.blackFont26,
                ),
                RiveAnimation.asset(
                  'assets/5514-10878-completed-trip.riv',
                  useArtboardSize: true,
                ),
              ],
            ),
          );
        } else {
          // Display the list of trips based on the fetched data
          return ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) => SizedBox(
              height: screenHeight / 60,
            ),
            itemBuilder: (context, index) => HomeCard(
              screenHeight: screenHeight,
              screenWidth: screenWidth,
              trip: snapshot.data![index],
            ),
            itemCount: snapshot.data!.length,
          );
        }
      },
    );
  }
  void _showItemDialog(BuildContext context,appStyle,tripProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('تصنيف حسب',style:appStyle.blueFont26,),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                sort=0;
                tripProvider.fetchAndSortTrips(context,1);
                setState(() {

                });// Implement thi
                Navigator.pop(context, 'الوقت');
              },
              child: Text('الوقت',style: appStyle.blackFont16,textAlign: TextAlign.end),
            ),
            SimpleDialogOption(
              onPressed: () {
                // Handle the second item selection here.
                sort=1;
                tripProvider.fetchAndSortTripsByStatus(context,1);
                setState(() {

                });// Implement thi
                Navigator.pop(context, 'الحالة');

              },
              child: Text('الحالة',style: appStyle.blackFont16,textAlign: TextAlign.end,),
            ),
          ],
        );
      },
    ).then((selectedValue) {
      // This code will execute after the dialog is dismissed.
      if (selectedValue != null) {
        // You can handle the selected value here.
        print('Selected Item: $selectedValue');
      }
    });
  }
}

Widget userName(appStyle) {
  return FutureBuilder(
      future: CacheManager.readData('user_name'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Display a loading indicator or placeholder here.
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Handle error state
          return Text('Error reading data: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data.isEmpty) {
          // Handle case when the data is empty or not available
          return Text("No user name available.");
        } else {
          // Data is available, update _userName
          String? _userName = snapshot.data;
          print(_userName);
          return SizedBox(
              child: RowTextWidget(
            main: AppText.homeWelcome,
            sub:  _userName!,
            mainStyle: appStyle.grayFont26,
            subStyle: appStyle.blueFont26,
            textAlign: TextAlign.end,
          ));
        }
      });
}
