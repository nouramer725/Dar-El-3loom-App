import 'package:dar_el_3loom/home_teacher/containers/taqarer_student/taqrer_student_table_widget.dart';
import 'package:dar_el_3loom/utils/app_assets.dart';
import 'package:dar_el_3loom/widgets/custom_text_form_field_widget.dart';
import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text.dart';
import '../../../utils/responsive.dart';

class TaqarerTeacherScreen extends StatelessWidget {
  String? code;

  TaqarerTeacherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Text(
          "تقرير الطالب",
          style: AppText.boldText(
            color: AppColors.blackColor,
            fontSize: sp(25),
          ),
        ),
        backgroundColor: AppColors.container1Color,
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
              // FilterWidget(
              //   text: "كود الطالب",
              //   type: FilterType.dropdown,
              //   color: AppColors.container1Color,
              // ),
              CustomTextFormFieldWidget(
                validator: (value) {},
                keyboardType: TextInputType.number,
                suffixIcon: Icon(Icons.search),
                controller: SearchController(),
                cursorColor: AppColors.container1Color,
                borderColor: AppColors.container1Color,
                borderWidth: 2,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: AppColors.container1Color,
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: AppColors.container1Color,
                    width: 2,
                  ),
                ),
                hintStyle: AppText.boldText(
                  color: AppColors.blackColor,
                  fontSize: sp(16),
                ),
                hintText: "كود الطالب",
              ),
              // TaqrerStudentTableWidget(
              //   tableTitleColor: AppColors.container1Color,
              // ),
              Image.asset(AppAssets.container1Image),
            ],
          ),
        ),
      ),
    );
  }
}
