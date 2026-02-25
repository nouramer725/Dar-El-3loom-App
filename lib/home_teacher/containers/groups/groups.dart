import 'package:dar_el_3loom/utils/app_assets.dart';
import 'package:flutter/material.dart';
import '../../../home/containers_contents/Mozakrat/filter_widget.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text.dart';
import '../../../utils/responsive.dart';
import 'groups_teacher_table_widget.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Text(
          "المجاميع",
          style: AppText.boldText(
            color: AppColors.blackColor,
            fontSize: sp(25),
          ),
        ),
        backgroundColor: AppColors.container2Color,
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_forward_ios_sharp, size: h(25)),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w(16), vertical: h(16)),
        child: SingleChildScrollView(
          child: Column(
            spacing: h(30),
            children: [
              FilterWidget(
                text: "رقم المجموعة",
                type: FilterType.dropdown,
                color: AppColors.container2Color,
              ),
              // GroupsTeacherTableWidget(
              //   tableTitleColor: AppColors.container2Color,
              // ),
              Image.asset(AppAssets.container2Image),
            ],
          ),
        ),
      ),
    );
  }
}
