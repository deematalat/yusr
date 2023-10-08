
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yusr/widgets/tripstatuslist.dart';
import '../controller/notify_controller.dart';
import '../controller/trip_controller.dart';
import '../helper/config/app_text_style.dart';
import '../services/trip_service.dart';

class DropDownBtn extends StatefulWidget {
  const DropDownBtn({Key? key, this.trip, this.onStatusChanged}) : super(key: key);
  final trip;
  final void Function(String?)? onStatusChanged;

  @override
  _DropDownBtnState createState() => _DropDownBtnState();
}

class _DropDownBtnState extends State<DropDownBtn> {
  late String slectedValue=TripStatus[int.
  parse(widget.trip.status)];


  @override
  Widget build(BuildContext context) {
    final tripProvider = Provider.of<TripProvider>(context,listen: false);
    final notify = Provider.of<NotifyController>(context,listen: false);
    AppStyle appStyle = AppStyle(context);
    return DropdownButton<String>(
      underline: SizedBox(),
      iconEnabledColor: Colors.white,
      style: appStyle.whiteFont16,
      dropdownColor: Colors.green.shade200,
      value:slectedValue, // Use the selectedValue here
      onChanged: (String? newValue) async {
        slectedValue=newValue!;
         setState(() {
         });
        await tripProvider.updateTrip(
          widget.trip.id,
          widget.trip.dateTour,
          widget.trip.timeDateTour,
          TripStatus.indexOf(newValue).toString(),
          context,
        );
         notify.sendWebNotification("رحلة جديدة", "تم تحديت حالة الرحلة رقم ${widget.trip.id}", context);

      },
      items: TripStatus.map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
