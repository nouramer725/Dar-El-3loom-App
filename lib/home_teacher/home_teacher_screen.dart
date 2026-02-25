import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dar_el_3loom/home_teacher/tabs/home_tab/home_teacher_tab.dart';
import 'package:dar_el_3loom/home_teacher/tabs/profile/profile_teacher_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';

class HomeTeacherScreen extends StatefulWidget {
  const HomeTeacherScreen({super.key});

  @override
  State<HomeTeacherScreen> createState() => _HomeTeacherScreenState();
}

class _HomeTeacherScreenState extends State<HomeTeacherScreen> {
  int selectedIndex = 1;

  List<Widget> screens = [ProfileTeacherScreen(), HomeTeacherTab()];

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
          ],
        ),
      ),
      body: screens[selectedIndex],
    );
  }
}
