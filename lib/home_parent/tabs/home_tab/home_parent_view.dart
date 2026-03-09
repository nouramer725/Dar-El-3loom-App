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

class HomeParentView extends StatelessWidget {
  const HomeParentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: h(160),
        title: Column(
          spacing: h(10),
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Consumer<ParentLoginProvider>(
                builder: (context, provider, _) {
                  final child = provider.selectedChild;
                  String displayName = child?.nTalb ?? "اسم ولي الامر";

                  return GestureDetector(
                    onTap: () async {
                      if (provider.children.isEmpty) {
                        await provider.fetchChildren();
                      }

                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (context) {
                          return Container(
                            decoration: const BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            child: provider.loading
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.container2Color,
                                    ),
                                  )
                                : Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: w(25),
                                      vertical: h(25),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: w(16),
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.whiteColor,
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      ),
                                      border: Border.all(
                                        color:
                                            AppColors.strokeBottomNavBarColor,
                                        width: 2,
                                      ),
                                    ),
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      itemCount: provider.children.length,
                                      separatorBuilder: (context, index) =>
                                          DividerWidget(),
                                      itemBuilder: (context, index) {
                                        final c = provider.children[index];
                                        return ListTile(
                                          leading: c.profilePicture != null
                                              ? CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                    c.profilePicture!,
                                                  ),
                                                )
                                              : Container(
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                    color: AppColors.whiteColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          30,
                                                        ),
                                                    border: Border.all(
                                                      color:
                                                          AppColors.greyColor,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  child: const Icon(
                                                    Icons.person_3_outlined,
                                                  ),
                                                ),
                                          title: Text(
                                            c.nTalb ?? '',
                                            style: AppText.regularText(
                                              color: AppColors.blackColor,
                                              fontSize: sp(15),
                                            ),
                                          ),
                                          onTap: () {
                                            provider.changeSelectedChild(c);
                                            Navigator.pop(context);
                                          },
                                        );
                                      },
                                    ),
                                  ),
                          );
                        },
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: w(10),
                      children: [
                        Text(
                          displayName,
                          style: AppText.boldText(
                            color: AppColors.blackColor,
                            fontSize: sp(30),
                          ),
                        ),
                        const Icon(Icons.keyboard_arrow_down),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              spacing: w(10),
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  width: w(65),
                  height: h(65),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Consumer<ParentLoginProvider>(
                    builder: (context, provider, _) {
                      final child = provider.selectedChild;
                      if (child?.profilePicture != null) {
                        return Image.network(
                          child!.profilePicture!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Image.asset(AppAssets.person, fit: BoxFit.fill),
                        );
                      } else {
                        return Image.asset(AppAssets.boy, fit: BoxFit.fill);
                      }
                    },
                  ),
                ),
                Consumer<ParentLoginProvider>(
                  builder: (context, provider, _) {
                    final child = provider.selectedChild;
                    return Column(
                      spacing: h(10),
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          child?.codTalb ?? "كود الطالب",
                          style: AppText.regularText(
                            color: AppColors.greyColor,
                            fontSize: sp(18),
                          ),
                        ),
                        Text(
                          child?.nSaf ?? "الصف",
                          style: AppText.regularText(
                            color: AppColors.greyColor,
                            fontSize: sp(18),
                          ),
                        ),
                      ],
                    );
                  },
                ),
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
