import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dar_el_3loom/home/tabs/home_tab/home_tab.dart';
import 'package:dar_el_3loom/home/tabs/notification_tab/notification_tab.dart';
import 'package:dar_el_3loom/home/tabs/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 1;

  List<Widget> screens = [ProfileScreen(), HomeTab(), NotificationTab()];

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
          backgroundColor: Colors.transparent,
          color: AppColors.strokeBottomNavBarColor,
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
