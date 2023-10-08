import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import '../controller/trip_controller.dart';
import '../helper/config/app_colors.dart';
import '../helper/config/app_text.dart';
import '../helper/config/app_text_style.dart';
import '../models/trip_model.dart';
import '../widgets/home_card.dart';
import '../widgets/line.dart';
import '../widgets/rich_text.dart';
import '../widgets/shimmer.dart';

class TripPage extends StatefulWidget {
  @override
  _TripPageState createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  PageController _pageController = PageController(initialPage: 0);
  final TripProvider tripService = TripProvider();
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
 int pageNum=0;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    AppStyle appStyle = AppStyle(context);
    return Column(
        children: [
          Container(
            child:Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:pageNum==0?AppColors.kprimary:Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed:(){
                         _pageController.animateToPage(0,
                             duration: Duration(milliseconds: 300),
                             curve: Curves.easeInOut);
                      }, child:Text('اليوم',style:pageNum==0?appStyle.whiteFont16:appStyle.blueFont16,)),
                ),
                Line(),
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:pageNum==1?AppColors.kprimary:Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed:(){
                        _pageController.animateToPage(1,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut);
                      }, child:Text('امس',style:pageNum==1?appStyle.whiteFont16:appStyle.blueFont16)),
                ),
                Line(),
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:pageNum==2?AppColors.kprimary:Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed:(){
                        _pageController.animateToPage(2,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut);
                      }, child: Text('اسبوع ',style:pageNum==2?appStyle.whiteFont16:appStyle.blueFont16)),
                ),
              ],
            ),
          ),
          CustomScrollView(
            slivers:[ PageView(
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
                _buildTripList(1,context),
                // Page 2: Tomorrow
                _buildTripList(2,context),
                // Page 3: Specific Date
                _buildTripList(4,context),
              ],
            ),
    ]
          ),
        ],
    );
  }

  Widget _buildTripList(int  sort_by_option,context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    AppStyle appStyle = AppStyle(context);
     tripService.fetchAndSortTrips(context,sort_by_option);
    return FutureBuilder<List<Trip>?>(
      future:tripService.trips,  // Implement this method
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return  buildShimmerLoading();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return   Container(
            padding: EdgeInsets.all(60),
            child: Column(
              children: [
                Text("لا يوجد رحلات متوفرة!",
                  style: appStyle.blackFont26,),
                RiveAnimation.asset(
                  'assets/5514-10878-completed-trip.riv',
                  useArtboardSize: true,
                ),
              ],
            ),
          );
        } else {
          // Display the list of trips based on the fetched data
          return Expanded(
            child: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context,index)=>HomeCard(
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                  trip:snapshot.data![index],
                ),
                 childCount: snapshot.data!.length,

            ),
            ),
          );
        }
      },
    );
  }


}
