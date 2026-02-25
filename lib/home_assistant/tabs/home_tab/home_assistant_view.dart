import 'package:dar_el_3loom/home/tabs/home_tab/widget_container.dart';
import 'package:dar_el_3loom/home/tabs/profile/divider_widget.dart';
import 'package:dar_el_3loom/provider/parent_login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_routes.dart';
import '../../../utils/app_text.dart';
import '../../../utils/responsive.dart';

class HomeAssistantView extends StatelessWidget {
  const HomeAssistantView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: h(120),
        title: Row(
          spacing: w(10),
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              width: w(65),
              height: h(65),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(AppAssets.boy, fit: BoxFit.fill),
            ),

            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "كود المساعد",
                    style: AppText.regularText(
                      color: AppColors.greyColor,
                      fontSize: sp(14),
                    ),
                  ),
                  Text(
                    "اسم المساعد",
                    style: AppText.boldText(
                      color: AppColors.greyColor,
                      fontSize: sp(24),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w(16)),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              spacing: h(55),
              children: [
                WidgetContainer(
                  onTap: () {
                    Navigator.of(
                      context,
                    ).pushNamed(AppRoutes.studentPerformanceAssistant);
                  },
                  verticalPadding: h(36),
                  text: "تسجيل اداء الطالب",
                  containerColor: AppColors.container2Color,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
