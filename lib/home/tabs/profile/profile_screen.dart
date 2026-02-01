import 'package:dar_el_3loom/home/tabs/profile/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/app_flow.dart';
import '../../../provider/app_theme_provider.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_routes.dart';
import '../../../utils/app_text.dart';
import '../../../utils/responsive.dart';
import 'divider_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isSwitched = false;
  String? language;

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);

    final brightness = MediaQuery.of(context).platformBrightness;
    final bool systemIsDark = brightness == Brightness.dark;

    bool switchValue =
        themeProvider.appTheme == ThemeMode.dark ||
        (themeProvider.appTheme == ThemeMode.system && systemIsDark);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: AppColors.strokeBottomNavBarColor,
        title: Text(
          "الاعدادات",
          style: AppText.boldText(
            color: AppColors.blackColor,
            fontSize: sp(24),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w(16), vertical: h(16)),
        child: Column(
          children: [
            ProfileWidget(
              text: "تعديل كلمة السر",
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.passwordEdit);
              },
              icon: Image.asset(AppAssets.arrowIcon),
            ),
            DividerWidget(),
            ProfileWidget(
              text: "تعديل الصورة الشخصية",
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.profilePictureEdit);
              },
              icon: Image.asset(AppAssets.arrowIcon),
            ),
            DividerWidget(),
            ProfileWidget(
              text: "تغير الاضاءة (فاتح/داكن)",
              icon: Switch(
                value: switchValue,
                onChanged: (value) {
                  themeProvider.changeTheme(
                    value ? ThemeMode.dark : ThemeMode.light,
                  );
                },
                activeThumbColor: AppColors.blackColor,
                inactiveThumbColor: AppColors.blackColor,
              ),
            ),
            DividerWidget(),
            ProfileWidget(
              text: "تسجيل خروج",
              onTap: () async {
                await AppFlow.logout();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.loginScreen,
                  (route) => false,
                );
              },
              icon: Image.asset(AppAssets.logoutIcon),
            ),
          ],
        ),
      ),
    );
  }
}
