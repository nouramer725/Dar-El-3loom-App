import 'package:dar_el_3loom/models/assistant_login_model.dart';
import 'package:dar_el_3loom/home/tabs/home_tab/widget_container.dart';
import 'package:dar_el_3loom/provider/assistant_login_provider.dart';
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
    final assistantProvider = Provider.of<AssistantLoginProvider>(context);
    final Assistant? assistant = assistantProvider.assistants;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: h(120),
        title: Column(
          children: [
            Text(
              assistant?.name ?? "اسم المساعد",
              style: AppText.boldText(
                color: AppColors.blackColor,
                fontSize: sp(35),
              ),
            ),
            Row(
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
                  child: assistant?.personalImage != null
                      ? Image.network(
                          assistant!.personalImage!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Image.asset(AppAssets.boy, fit: BoxFit.fill),
                        )
                      : Image.asset(AppAssets.boy, fit: BoxFit.fill),
                ),

                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        assistant?.code ?? "كود المساعد",
                        style: AppText.regularText(
                          color: AppColors.greyColor,
                          fontSize: sp(20),
                        ),
                      ),
                      Text(
                        assistant?.nMod ?? "اسم المدرس",
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
                    Navigator.of(context).pushNamed(AppRoutes.taqarerAssistant);
                  },
                  verticalPadding: h(36),
                  text: "تقرير الطالب",
                  containerColor: AppColors.container1Color,
                ),
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
                WidgetContainer(
                  onTap: () {
                    Navigator.of(
                      context,
                    ).pushNamed(AppRoutes.groupPerformance);
                  },
                  verticalPadding: h(36),
                  text: "تسجيل حضور المجموعة",
                  containerColor: AppColors.container3Color,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
