import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dar_el_3loom/home_parent/tabs/home_tab/home_parent_tab.dart';
import 'package:dar_el_3loom/home_parent/tabs/notification_tab/notification_parent_tab.dart';
import 'package:dar_el_3loom/home_parent/tabs/profile/profile_parent_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';

class HomeParentScreen extends StatefulWidget {
  const HomeParentScreen({super.key});

  @override
  State<HomeParentScreen> createState() => _HomeParentScreenState();
}

class _HomeParentScreenState extends State<HomeParentScreen> {
  int selectedIndex = 1;

  List<Widget> screens = [
    ProfileParentScreen(),
    HomeParentTab(),
    NotificationParentTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: InnerShadow(
        shadows: [
          BoxShadow(
            color: AppColors.transparentColor,
            offset: Offset(0, -4),
            blurRadius: 4,
          ),
        ],
        child: CurvedNavigationBar(
          backgroundColor: AppColors.whiteColor,
          color: AppColors.strokeBottomNavBarColor2,
          buttonBackgroundColor: AppColors.transparentColor,
          height: h(75),
          index: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: [
            Icon(Icons.menu, size: h(35), color: AppColors.bottomNavBarIcon),
            Icon(
              Icons.home_filled,
              size: h(35),
              color: AppColors.bottomNavBarIcon,
            ),
            Icon(
              Icons.notifications,
              size: h(35),
              color: AppColors.bottomNavBarIcon,
            ),
          ],
        ),
      ),
      body: screens[selectedIndex],
    );
  }
}
