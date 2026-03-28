import 'package:dar_el_3loom/home/tabs/profile/divider_widget.dart';
import 'package:dar_el_3loom/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import '../../../../backend_setup/Api/api_service.dart';
import '../../../provider/parent_login_provider.dart';
import '../../../socket/socket_service.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text.dart';
import '../../../utils/global_dialogs.dart';
import '../../../utils/responsive.dart';

class NotificationParentTab extends StatefulWidget {
  const NotificationParentTab({super.key});

  @override
  State<NotificationParentTab> createState() => _NotificationParentTabState();
}

class _NotificationParentTabState extends State<NotificationParentTab> {
  bool isLoading = true;
  List notifications = [];
  late SocketService socketService;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadNotifications();

      socketService = SocketService();
      socketService.connect();

      socketService.socket.onConnect((_) {
        print("SOCKET CONNECTED");
      });

      final parentProvider = Provider.of<ParentLoginProvider>(
        context,
        listen: false,
      );

      final parentId = parentProvider.student?.id;

      print("PARENT ID: $parentId");

      socketService.socket.emit('join_parent_room', {'parent_id': parentId});

      print("JOINED PARENT ROOM");

      socketService.socket.on('parent_notification', (data) {
        print("PARENT EVENT RECEIVED: $data");

        if (!mounted) return;

        setState(() {
          notifications.insert(0, data);
        });

        showGlobalNotificationDialog(data);
      });
    });
  }

  @override
  void dispose() {
    socketService.disconnect();
    super.dispose();
  }

  void loadNotifications() async {
    final loginProvider = Provider.of<ParentLoginProvider>(
      context,
      listen: false,
    );
    final token = loginProvider.token;

    if (token == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("لم يتم تسجيل الدخول")));
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
          ? Center(
              child: CircularProgressIndicator(
                color: AppColors.blackColor,
                strokeWidth: h(7),
              ),
            )
          : notifications.isEmpty
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: w(16), vertical: h(10)),
              child: SingleChildScrollView(
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
