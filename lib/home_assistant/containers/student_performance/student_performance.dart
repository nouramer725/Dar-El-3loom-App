import 'package:dar_el_3loom/home_assistant/containers/student_performance/student_performance_table_widget.dart';
import 'package:dar_el_3loom/home_teacher/containers/taqarer_student/taqrer_student_table_widget.dart';
import 'package:dar_el_3loom/utils/app_assets.dart';
import 'package:dar_el_3loom/utils/app_routes.dart';
import 'package:dar_el_3loom/widgets/custom_text_form_field_widget.dart';
import 'package:flutter/material.dart';
import '../../../home/containers_contents/Mozakrat/filter_widget.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text.dart';
import '../../../utils/responsive.dart';
import '../../../widgets/custom_elevated_button_widget.dart';

class StudentPerformance extends StatelessWidget {
  String? code;

  StudentPerformance({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Text(
          "تسجيل اداء الطالب",
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
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              spacing: h(30),
              children: [
                FilterWidget(
                  text: "الكود",
                  type: FilterType.dropdown,
                  color: AppColors.container2Color,
                ),
                CustomElevatedButtonWidget(
                  text: "ارسال",
                  textStyle: AppText.boldText(
                    color: AppColors.blackColor,
                    fontSize: sp(14),
                  ),
                  padding: WidgetStateProperty.all(
                    EdgeInsets.symmetric(horizontal: w(40)),
                  ),
                  colorContainer: AppColors.container2Color,
                  sideColor: AppColors.container2Color,
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.studentPerformanceAssistantDtaScreen,
                    );
                  },
                  // onPressed: uploadProfilePicture,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
