import 'package:dar_el_3loom/Model/parent_login_model.dart';
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

class HomeParentTab extends StatelessWidget {
  const HomeParentTab({super.key});

  @override
  Widget build(BuildContext context) {
    final parentProvider = Provider.of<ParentLoginProvider>(context);
    final Parent? parent = parentProvider.student;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: h(160),
        title: Column(
          spacing: h(10),
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (context) {
                      return Container(
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: w(25),
                            vertical: h(25),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: w(16),
                            vertical: h(16),
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                            border: Border.all(
                              color: AppColors.strokeBottomNavBarColor,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                leading: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: w(7),
                                    vertical: h(5),
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.whiteColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                    border: Border.all(
                                      color: AppColors.strokeBottomNavBarColor,
                                      width: 2,
                                    ),
                                  ),
                                  child: Icon(Icons.person),
                                ),
                                title: Text(
                                  "نور احمد",
                                  style: AppText.regularText(
                                    color: AppColors.blackColor,
                                    fontSize: sp(15),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                  print("Switch to account 2");
                                },
                              ),
                              DividerWidget(),
                              ListTile(
                                leading: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: w(7),
                                    vertical: h(5),
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.whiteColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                    border: Border.all(
                                      color: AppColors.strokeBottomNavBarColor,
                                      width: 3,
                                    ),
                                  ),
                                  child: Icon(Icons.add),
                                ),
                                title: Text(
                                  "اضف حساب جديد",
                                  style: AppText.regularText(
                                    color: AppColors.blackColor,
                                    fontSize: sp(15),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                  print("Add new account");
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Row(
                  spacing: w(10),
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      parent?.name ?? "اسم ولي الامر",
                      style: AppText.boldText(
                        color: AppColors.blackColor,
                        fontSize: sp(30),
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_down, size: w(35)),
                  ],
                ),
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
                  child: parent?.profileImage != null
                      ? Image.network(
                          parent!.profileImage!,
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
                        parent?.name ?? "اسم ولي الامر",
                        style: AppText.boldText(
                          color: AppColors.blackColor,
                          fontSize: sp(24),
                        ),
                      ),
                      Text(
                        parent?.id ?? "كود ولي الامر",
                        style: AppText.regularText(
                          color: AppColors.greyColor,
                          fontSize: sp(14),
                        ),
                      ),
                    ],
                  ),
                ),

                // Spacer(),

                // InkWell(
                //   onTap: () {
                //     showDialog(
                //       context: context,
                //       barrierDismissible: true,
                //       builder: (context) {
                //         return Dialog(
                //           backgroundColor: AppColors.whiteColor,
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(16),
                //           ),
                //           child: Padding(
                //             padding: EdgeInsets.all(w(20)),
                //             child: Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               spacing: h(10),
                //               mainAxisSize: MainAxisSize.min,
                //               children: [
                //                 Text(
                //                   "الاسم: ${student?.nTalb ?? "-"}",
                //                   style: AppText.boldText(
                //                     color: AppColors.blackColor,
                //                     fontSize: sp(24),
                //                   ),
                //                 ),
                //                 Text(
                //                   "المرحلة التعليمية: ${student?.nSaf ?? "-"}",
                //                   style: AppText.boldText(
                //                     color: AppColors.blackColor,
                //                     fontSize: sp(24),
                //                   ),
                //                 ),
                //                 SizedBox(height: h(10)),
                //                 Container(
                //                   width: double.infinity,
                //                   padding: EdgeInsets.all(w(20)),
                //                   decoration: BoxDecoration(
                //                     borderRadius: BorderRadius.circular(16),
                //                     border: Border.all(
                //                       color: AppColors.container1Color,
                //                       width: 3,
                //                     ),
                //                   ),
                //                   child: Column(
                //                     children: [
                //                       Image.asset(
                //                         AppAssets.barcodeImage,
                //                         fit: BoxFit.contain,
                //                       ),
                //                       SizedBox(height: h(8)),
                //                       Text(
                //                         student?.codTalb ?? "-",
                //                         style: AppText.boldText(
                //                           color: AppColors.blackColor,
                //                           fontSize: sp(18),
                //                         ),
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         );
                //       },
                //     );
                //   },
                //   child: Image.asset(AppAssets.barcodeImage, fit: BoxFit.fill),
                // ),
              ],
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
