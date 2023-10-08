import 'package:flutter/material.dart';

import '../helper/config/app_colors.dart';
import '../helper/config/app_text_style.dart';
import '../models/userProfile_model.dart';


class UserCard extends StatelessWidget {
  final User user; // User data to display

  UserCard({required this.user});

  @override
  Widget build(BuildContext context) {
    AppStyle appStyle = AppStyle(context);
    return Card(
      color:AppColors.kprimary,
      elevation: 3, // Adjust the card elevation as needed// Adjust the card margins as needed
      child: Padding(
        padding: EdgeInsets.all(16), // Adjust the padding inside the card
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.end,
              children: [
              Column(
                children: [
                  Text('اسم السائق: ${user.name}',style:appStyle.whiteFont16 ,),
                  SizedBox(height:10,),
                  Text('رقم الهاتف${user.phone}',style:appStyle.whiteFont16 ),

                ],),
                SizedBox(width: 20,),
              CircleAvatar(radius: 35,
              child: Image.asset("assets/images/user.png"),
              ),
            ],),

          ],
        ),
      ),
    );
  }
}
