import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yusr/controller/trip_controller.dart';
import '../helper/config/app_colors.dart';
import '../helper/config/app_text_style.dart';
import '../models/trip_model.dart';
import '../widgets/address_widget.dart';
import '../widgets/app_header.dart';
import '../widgets/data_field.dart';
import '../widgets/detialsCard.dart';
import '../widgets/drop_btn.dart';
import '../widgets/tripstatuslist.dart';

class  DetialsView extends StatefulWidget {
  const  DetialsView({Key? key}) : super(key: key);

  @override
  State<DetialsView> createState() => _DetialsViewState();
}

class _DetialsViewState extends State<DetialsView> {
  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    final Trip?  trip = ModalRoute.of(context)!.settings.arguments as Trip?;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    AppStyle appStyle = AppStyle(context);
    return
      Scaffold(
        backgroundColor: Colors.white,
          bottomNavigationBar:BottomAppBar(
            color: Colors.white,
            padding: EdgeInsets.all(20),
            child:ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.kgreen,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: Size(screenWidth,screenHeight/14),
              ),
              onPressed: () {  },
              child:Consumer<TripProvider>(
                builder: (context, model, child) {
                  return DropDownBtn(
                    trip: trip,
                  );
                },
              )
            ),
          ),
        body: SafeArea(
             child: ListView(
              children: [
                AppHeader(screenHeight: screenHeight),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("حجز الخاص برحلة رقم ${trip?.id}",style: appStyle.blackFont26,textAlign: TextAlign.end,),
                      DetailsCard(screenHeight: screenHeight,
                        cardChild:Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(':حول العميل',style:appStyle.blueFont24,),
                            DataField(screenHeight:screenHeight,
                              screenWidth: screenHeight,
                              text:trip?.fullname??'', color: AppColors.kprimary,
                              title: ':اسم العميل',),
                            DataField(screenHeight:screenHeight,
                              screenWidth: screenHeight,
                              text: trip?.phone??'', color: AppColors.kprimary,
                              title: 'رقم الهاتف:',),
                            DataField(screenHeight:screenHeight,
                              screenWidth: screenHeight,
                              text: trip?.notes??'', color: AppColors.kprimary,
                              title: ':ملحوظات',),
                          ],
                        ),
                      ),
                      SizedBox(height:screenHeight/60,),
                      DetailsCard(screenHeight: screenHeight,
                        cardChild:Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(':بيانات الرحلة',style:appStyle.blueFont24,),
                            DataField(screenHeight:screenHeight,
                              screenWidth: screenHeight,
                              text: trip?.dateTour??"", color:AppColors.kprimary,
                              title: ':تاريخ الانطلاق',),
                            DataField(screenHeight:screenHeight,
                              screenWidth: screenHeight,
                              text: '', color: AppColors.kprimary,
                              title: 'موعد الانطلاق:',),
                            DataField(screenHeight:screenHeight,
                              screenWidth: screenHeight,
                              text: trip?.timeDateTour??"", color: AppColors.kprimary,
                              title: ':الوقت المستغرق',),
                          ],
                        ),
                      ),
                      SizedBox(height:screenHeight/60,),
                      DetailsCard(screenHeight: screenHeight,
                        cardChild:Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(':معلومات اضافية',style:appStyle.blueFont24,),
                            DataField(screenHeight:screenHeight,
                              screenWidth: screenHeight,
                              text: trip?.cost??"", color: AppColors.kgreen,
                              title: ':تكلفة الرحلة',),


                                SizedBox(height:screenHeight/40,),
                                Text(':مكان الانطلاق',style:appStyle.blackFont24 ,textAlign: TextAlign.end,),
                                SizedBox(height:screenHeight/40,),
                                AddressWidget(address:trip?.startAddress,),


                            SizedBox(height:screenHeight/40,),
                            Text(':مكان انتهاء ',style:appStyle.blackFont24 ,textAlign: TextAlign.end,),
                            SizedBox(height:screenHeight/40,),
                            AddressWidget(address:trip?.endAddress,start:trip?.startLat,end:trip?.endLat,),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]
        ),
           ),
      );
  }
}
