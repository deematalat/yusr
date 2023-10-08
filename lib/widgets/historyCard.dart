
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yusr/widgets/rich_text.dart';
import 'package:yusr/widgets/tripstatuslist.dart';
import '../controller/trip_controller.dart';
import '../helper/config/app_colors.dart';
import '../helper/config/app_routes.dart';
import '../helper/config/app_text.dart';
import '../helper/config/app_text_style.dart';
import '../helper/core/route_manager.dart';
import '../models/trip_model.dart';
import 'elevated_btn.dart';

class HistoryCard extends StatefulWidget {
  const HistoryCard({Key? key, required this.screenHeight, required this.screenWidth, required this.trip}) : super(key: key);
  final double screenHeight;
  final double screenWidth;
  final Trip trip;

  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  Future<String>? tripStatus;
  @override
  Widget build(BuildContext context) {

    AppStyle appStyle = AppStyle(context);
    return  Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text("حجز الخاص برحلة رقم ${widget.trip.id}",style: appStyle.blueFont22,textAlign: TextAlign.start,),
            Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RowTextWidget(
                        main:"اسم العميل:",
                        sub:widget.trip.fullname,
                        mainStyle:appStyle.blackFont16,
                        subStyle: appStyle.blueFont16,
                        textAlign: TextAlign.end),
                    Icon(Icons.person,color:AppColors.kblue,
                      textDirection:TextDirection.rtl,),
                  ],
                ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RowTextWidget(
                    main:AppText.startPoint,
                    sub:widget.trip.startAddress.split('، ')[1],
                    mainStyle:appStyle.blackFont16,
                    subStyle: appStyle.blueFont16,
                    textAlign: TextAlign.end),
                Icon(Icons.location_on,color:AppColors.kblue,textDirection:TextDirection.rtl,),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RowTextWidget(
                    main:"تاريخ الانتهاء",
                    sub:widget.trip.dateTour,
                    mainStyle:appStyle.blackFont16,
                    subStyle: appStyle.blueFont16,
                    textAlign: TextAlign.end),
                Icon(Icons.date_range_rounded,color:AppColors.kblue,textDirection:TextDirection.rtl,),
              ],
            ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      child:RowTextWidget(
                          main:AppText.endPoint,
                          sub:widget.trip.endAddress.split('، ')[1],
                          mainStyle:appStyle.blackFont16,
                          subStyle: appStyle.blueFont16,
                          textAlign: TextAlign.start),
                    ),
                    Icon(Icons.ios_share,color:AppColors.kblue,textDirection:TextDirection.rtl,),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmallElevatedBtn(onPress: () {
                  Nav.toNamed(context,App.detials,arguments: widget.trip);
                }, widget:Text(AppText.more,style:appStyle.whiteFont16,),
                  screenWidth:widget.screenWidth,screenHeigth: widget.screenHeight,),
                Consumer<TripProvider>(
                    builder: (context, cart, child) {
                      return Text(
                        TripStatus[int.parse(widget.trip.status)]
                        ,style: appStyle.greenFont24,textAlign: TextAlign.start,);
                    }),
              ],
            )

          ],
        ),
      ),
    );
  }
}
