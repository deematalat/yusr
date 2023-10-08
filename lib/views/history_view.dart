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

class HistoryView extends StatefulWidget {
  const HistoryView({Key? key}) : super(key: key);
  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  late StreamSubscription internetSubscription;

  PageController _pageController = PageController(initialPage:0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }


  ForgotPasswordModel authService = ForgotPasswordModel();
  int pageNum = 0;

  @override
  initState() {
    internetSubscription =
        InternetConnectionChecker().onStatusChange.listen((status) {
          final hasInternet = status == InternetConnectionStatus.connected;
          if (!hasInternet) {
            connectivityBanner(context, 'No internet connection.',
                    () => ScaffoldMessenger.of(context).hideCurrentMaterialBanner());
          } else {
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
          }
        });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tripProvider = Provider.of<TripProvider>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    AppStyle appStyle = AppStyle(context);
    tripProvider.fetchAndSortTripsHistory(context, 4);
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        SizedBox(
          height: screenHeight / 60,
        ),
        Text(
          AppText.history,
          style: appStyle.blackFont32,
          textAlign: TextAlign.end,
        ),
        Text(
          AppText.sortBy,
          style: appStyle.grayFont20,
          textAlign: TextAlign.end,
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
                    child: Text('اسبوع ',
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
                    child: Text('امس',
                        style: pageNum == 1
                            ? appStyle.whiteFont16
                            : appStyle.blueFont16)),
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
                      'اليوم',
                      style: pageNum == 0
                          ? appStyle.whiteFont16
                          : appStyle.blueFont16,
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
              _buildTripList(1, context),

              // Page 2: Tomorrow
              _buildTripList(2, context),
              // Page 3: Specific Date
              _buildTripList(4, context),
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
      future: tripProvider.fetchAndSortTripsHistory(context, sort_by_option), // Implement this method
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
}


