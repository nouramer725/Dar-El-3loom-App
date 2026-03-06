import 'package:dar_el_3loom/home/tabs/profile/divider_widget.dart';
import 'package:dar_el_3loom/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../../BackendSetup Data/Api/api_service.dart';
import '../../../provider/parent_login_provider.dart';
import '../../../socket/socket_service.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text.dart';
import '../../../utils/responsive.dart';

class NotificationParentTab extends StatefulWidget {
  const NotificationParentTab({super.key});

  @override
  State<NotificationParentTab> createState() => _NotificationParentTabState();
}

class _NotificationParentTabState extends State<NotificationParentTab> {
  bool isLoading = true;

  List notifications = [];

  @override
  void initState() {
    super.initState();

    loadNotifications();

    final socketService = SocketService();
    socketService.connect();

    socketService.socket.on("new_notification", (data) {
      print("Realtime notification received: $data");

      setState(() {
        notifications.insert(0, data);
      });

      Fluttertoast.showToast(
        msg: "وصل اشعار جديد",
        backgroundColor: AppColors.container2Color,
        textColor: AppColors.whiteColor,
        fontSize: 16,
      );
    });
  }

  @override
  void dispose() {
    SocketService().socket.dispose();
    super.dispose();
  }

  void loadNotifications() async {
    final loginProvider = Provider.of<ParentLoginProvider>(
      context,
      listen: false,
    );
    final token = loginProvider.token;

    if (token == null) {
      Fluttertoast.showToast(msg: "لم يتم تسجيل الدخول");
      return;
    }

    final api = ApiService(token: token);
    final result = await api.getNotifications();

    notifications = result["data"];

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.strokeBottomNavBarColor,
        title: Text(
          "الاشعارات",
          style: AppText.boldText(
            color: AppColors.blackColor,
            fontSize: sp(24),
          ),
        ),
      ),
      body: isLoading
          ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(AppAssets.notificationImage),
                  Text(
                    "لا توجد اشعارات حتي الان",
                    textAlign: TextAlign.center,
                    style: AppText.boldText(
                      color: AppColors.blackColor,
                      fontSize: sp(35),
                    ),
                  ),
                  Text(
                    "الاشعارات ستظهر بمجرد ان ترسل لك",
                    textAlign: TextAlign.center,
                    style: AppText.semiBoldText(
                      color: AppColors.greyColor,
                      fontSize: sp(20),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: w(16),
                    vertical: h(10),
                  ),
                  child: Column(
                    children: [
                      Row(
                        spacing: h(10),
                        children: [
                          CircleAvatar(
                            radius: h(35),
                            backgroundColor: AppColors.whiteColor,
                            child: Image.asset(AppAssets.darEl3loomLogo),
                          ),
                          Expanded(
                            child: Column(
                              spacing: h(5),
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "حضور الطالب ${notifications[index]["student_name"]}",
                                  style: AppText.boldText(
                                    color: AppColors.blackColor,
                                    fontSize: sp(17),
                                  ),
                                ),
                                Text(
                                  "مادة ${notifications[index]["subject"]} مع ${notifications[index]["teacher_name"]}",
                                  style: AppText.semiBoldText(
                                    color: AppColors.greyColor,
                                    fontSize: sp(15),
                                  ),
                                ),
                                Text(
                                  "الساعة ${notifications[index]["created_time"] ?? notifications[index]["attendance_time"] ?? ''}",
                                  style: AppText.semiBoldText(
                                    color: AppColors.greyColor,
                                    fontSize: sp(14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            spacing: h(5),
                            children: [
                              Text(
                                notifications[index]["created_date"] ??
                                    notifications[index]["attendance_date"] ??
                                    '',
                                style: AppText.semiBoldText(
                                  color: AppColors.greyColor,
                                  fontSize: sp(14),
                                ),
                              ),
                              Text(
                                notifications[index]["created_time"] ??
                                    notifications[index]["attendance_time"] ??
                                    '',
                                style: AppText.semiBoldText(
                                  color: AppColors.greyColor,
                                  fontSize: sp(14),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      DividerWidget(),
                    ],
                  ),
                );
              },
              itemCount: notifications.length,
            ),
    );
  }
}
