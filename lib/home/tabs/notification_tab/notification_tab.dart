import 'package:flutter/material.dart';
import '../../../home/tabs/profile/divider_widget.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text.dart';
import '../../../utils/responsive.dart';

class NotificationTab extends StatefulWidget {
  const NotificationTab({super.key});

  @override
  State<NotificationTab> createState() => _NotificationTabState();
}

class _NotificationTabState extends State<NotificationTab> {
  bool isLoading = true;

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
                                  "الاشعارات ستظهر بمجرد ان ترسل",
                                  style: AppText.semiBoldText(
                                    color: AppColors.blackColor,
                                    fontSize: sp(18),
                                  ),
                                ),
                                Text(
                                  "الاشعارات ستظهر بمجرد ان ترسل لك",
                                  style: AppText.semiBoldText(
                                    color: AppColors.greyColor,
                                    fontSize: sp(15),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "25-10-2025",
                            style: AppText.semiBoldText(
                              color: AppColors.greyColor,
                              fontSize: sp(14),
                            ),
                          ),
                        ],
                      ),
                      DividerWidget(),
                    ],
                  ),
                );
              },
              itemCount: 5,
            ),
    );
  }
}
