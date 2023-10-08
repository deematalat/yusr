
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yusr/controller/trip_controller.dart';
import 'package:yusr/helper/config/app_colors.dart';
import 'package:yusr/widgets/tripstatuslist.dart';
import 'package:yusr/widgets/widgets.dart';
import '../helper/config/app_routes.dart';
import '../helper/config/app_text.dart';
import '../helper/config/app_text_style.dart';
import '../helper/core/route_manager.dart';
import '../models/trip_model.dart';
import 'elevated_btn.dart';

class HomeCard extends StatefulWidget {
  const HomeCard({Key? key, required this.screenHeight, required this.screenWidth, required this.trip}) : super(key: key);
  final double screenHeight;
  final double screenWidth;
  final   Trip trip;

  @override
  State<HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  Future<String>? tripStatus;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    AppStyle appStyle = AppStyle(context);
    return   Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.end,
          children: [
               Text("حجز الخاص برحلة رقم ${widget.trip.id}",style: appStyle.blueFont22,textAlign: TextAlign.start,),
                SizedBox(height:widget.screenHeight/80,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RowTextWidget(
                        main:AppText.tripTime,
                        sub: widget.trip.timeDateTour,
                        mainStyle:appStyle.blackFont16,
                        subStyle: appStyle.blueFont16,
                        textAlign: TextAlign.end),
                    Icon(Icons.lock_clock,color:AppColors.kblue,textDirection:TextDirection.rtl,),
                  ],
                ),
                Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(child:
                RowTextWidget(
                    main:AppText.startPoint,
                    sub: widget.trip.startAddress.split('، ')[1],
                    mainStyle:appStyle.blackFont16,
                    subStyle: appStyle.blueFont16,
                    textAlign: TextAlign.end),),
                Icon(Icons.location_on,color:AppColors.kblue,textDirection:TextDirection.rtl,),
              ],
            ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RowTextWidget(
                        main:AppText.endPoint,
                        sub: widget.trip.endAddress.split('، ')[1],
                        mainStyle:appStyle.blackFont16,
                        subStyle: appStyle.blueFont16,
                        textAlign: TextAlign.end),
                    Icon(Icons.ios_share,color:AppColors.kblue,textDirection:TextDirection.rtl,),
                  ],
                ),
                Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              SmallElevatedBtn(onPress: () {
                Nav.toNamed(context,App.detials,arguments:widget.trip);
              }, widget:Text(AppText.more,style:appStyle.whiteFont16,),
                screenWidth:widget.screenWidth,screenHeigth: widget.screenHeight,),
          Consumer<TripProvider>(
    builder: (context, cart, child) {
      return Text(
        TripStatus[int.parse(widget.trip.status)]
        ,style: appStyle.greenFont24,textAlign: TextAlign.start,);
    }),

            ],)

          ],
        ),
      ),
    );
  }
}
