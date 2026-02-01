import 'package:dar_el_3loom/home/tabs/home_tab/widget_container.dart';
import 'package:flutter/material.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_routes.dart';
import '../../../utils/app_text.dart';
import '../../../utils/responsive.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: h(130),
        title: Row(
          spacing: w(10),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              width: w(65),
              height: h(65),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(AppAssets.person, fit: BoxFit.fill),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "احمد محمد",
                  style: AppText.boldText(
                    color: AppColors.blackColor,
                    fontSize: sp(24),
                  ),
                ),
                Text(
                  "اولي ثانوي",
                  style: AppText.regularText(
                    color: AppColors.greyColor,
                    fontSize: sp(16),
                  ),
                ),
                Text(
                  "1001",
                  style: AppText.regularText(
                    color: AppColors.greyColor,
                    fontSize: sp(14),
                  ),
                ),
              ],
            ),
            Spacer(),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) {
                    return Dialog(
                      backgroundColor: AppColors.whiteColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(w(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: h(10),
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "الاسم :  احمد محمد",
                              style: AppText.boldText(
                                color: AppColors.blackColor,
                                fontSize: sp(24),
                              ),
                            ),
                            Text(
                              "المرحلة التعليمية :  الثانوية",
                              style: AppText.boldText(
                                color: AppColors.blackColor,
                                fontSize: sp(24),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(w(20)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: AppColors.container1Color,
                                  width: 3,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Image.asset(
                                    AppAssets.barcodeImage,
                                    fit: BoxFit.contain,
                                  ),
                                  Text(
                                    "1001",
                                    style: AppText.boldText(
                                      color: AppColors.blackColor,
                                      fontSize: sp(18),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Image.asset(AppAssets.barcodeImage, fit: BoxFit.fill),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w(12), vertical: h(12)),
        child: SingleChildScrollView(
          child: Column(
            spacing: h(30),
            children: [
              WidgetContainer(
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.container1Press);
                },
                verticalPadding: h(36),
                text: "المستوي الدراسي",
                containerColor: AppColors.container1Color,
              ),
              WidgetContainer(
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.container2Press);
                },
                verticalPadding: h(36),
                text: "مواعيد الجداول",
                containerColor: AppColors.container2Color,
              ),
              WidgetContainer(
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.container3Press);
                },
                verticalPadding: h(36),
                text: "المذكرات",
                containerColor: AppColors.container3Color,
              ),
              WidgetContainer(
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.container4Press);
                },
                verticalPadding: h(36),
                text: "المدفوعات",
                containerColor: AppColors.container4Color,
              ),
              WidgetContainer(
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.container5Press);
                },
                verticalPadding: h(36),
                text: "التقرير",
                containerColor: AppColors.container5Color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
