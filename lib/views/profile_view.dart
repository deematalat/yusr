import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:yusr/models/userProfile_model.dart';
import '../controller/auth_controller.dart';
import '../controller/notify_controller.dart';
import '../helper/config/app_text_style.dart';
import '../widgets/customNotifcation.dart';
import '../widgets/shimmer.dart';
import '../widgets/user_card.dart';


class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    AppStyle appStyle = AppStyle(context);
    ForgotPasswordModel authService = ForgotPasswordModel();
    authService.userInfo(context);
    return Center(
      child: FutureBuilder<User?>(
        future: authService.user,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While data is loading, you can display a loading indicator.
            return buildShimmerLoading();
          } else if (snapshot.hasError) {
            // If there's an error, you can display an error message.
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            // If data is available, you can display it using the UserCard widget.
            return    ChangeNotifierProvider(
              create: (context) => NotifyController(),
              child: Consumer<NotifyController>(
                builder: (context, model, child) {
                  return ListView(
              shrinkWrap: true,
              children: [
                UserCard(user: snapshot.data!),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "الاشعارات",
                  style: appStyle.blackFont32,
                  textAlign: TextAlign.end,
                ),
                if (NotifyController.customNotification.isEmpty)
                  Column(
                    children: [
                      Text(
                        "لا يوجد اشعارات متوفرة!",
                        style: appStyle.blackFont26,
                      ),
                      RiveAnimation.asset(
                        'assets/1836-3631-notification.riv',
                        useArtboardSize: true,
                      ),
                    ],
                  )
                else
                 ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Text(
                                NotifyController
                                    .customNotification[index].title,
                                style: appStyle.blueFont26,
                                textAlign: TextAlign.end,
                              ),
                              subtitle: Text(
                                NotifyController
                                    .customNotification[index].message,
                                style: appStyle.blackFont16,
                                textAlign: TextAlign.end,
                              ),
                            ),
                          );
                        },
                        itemCount: NotifyController.customNotification.length,
                      )
              ],
            );}));
          } else {
            // Handle other cases, e.g., when there is no data.
            return Text('No user data available');
          }
        },
      ),
    );
  }
}
