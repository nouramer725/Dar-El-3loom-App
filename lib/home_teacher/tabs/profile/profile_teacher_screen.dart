import 'package:dar_el_3loom/home/tabs/profile/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Model/student_login_model.dart';
import '../../../home/tabs/profile/divider_widget.dart';
import '../../../provider/app_flow.dart';
import '../../../provider/student_login_provider.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_routes.dart';
import '../../../utils/app_text.dart';
import '../../../utils/responsive.dart';

class ProfileTeacherScreen extends StatelessWidget {
  ProfileTeacherScreen({super.key});

  bool isSwitched = false;

  String? language;

  @override
  Widget build(BuildContext context) {
    // final studentProvider = Provider.of<StudentLoginProvider>(context);
    // final Student? student = studentProvider.student;
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileWidget(
              text: "تعديل كلمة السر",
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.passwordTeacherEdit);
              },
              icon: Image.asset(AppAssets.arrowIcon),
            ),
            DividerWidget(),
            ProfileWidget(
              text: "تعديل الصورة الشخصية",
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.profilePictureTeacherEdit);
              },
              icon: Image.asset(AppAssets.arrowIcon),
            ),
            DividerWidget(),
            ProfileWidget(
              text: "تسجيل خروج",
              onTap: () async {
                await AppFlow.logout(context);
              },
              icon: Image.asset(AppAssets.logoutIcon),
            ),
          ],
        ),
      ),
    );
  }
}
