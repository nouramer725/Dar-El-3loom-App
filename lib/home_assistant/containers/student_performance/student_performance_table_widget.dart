import 'package:flutter/material.dart';
import '../../../../../utils/responsive.dart';
import '../../../home/containers_contents/Mozakrat/filter_widget.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text.dart';
import '../../../widgets/custom_text_form_field_widget.dart';

class StudentPerformanceWidget extends StatelessWidget {
  final Map<String, dynamic> studentData;

  const StudentPerformanceWidget({super.key, required this.studentData});

  @override
  Widget build(BuildContext context) {
    final student = studentData['data']['student'];
    final codeController = TextEditingController(text: student['cod_talb']);

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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w(16), vertical: h(30)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: h(10),
            children: [
              CustomTextFormFieldWidget(
                controller: codeController,
                readOnly: true,
                keyboardType: TextInputType.number,
                cursorColor: AppColors.container2Color,
                borderColor: AppColors.container2Color,
                borderWidth: 2,
                hintStyle: AppText.boldText(
                  color: AppColors.greyColor,
                  fontSize: sp(16),
                ),
              ),
              SizedBox(height: h(60)),
              Text(
                "الاسم : ${studentData['data']['student']['n_talb'] ?? ''}",
                style: AppText.boldText(
                  color: AppColors.greyColor,
                  fontSize: sp(19),
                ),
              ),
              Text(
                "الصف : ${studentData['data']['student']['n_saf'] ?? ''}",
                style: AppText.boldText(
                  color: AppColors.greyColor,
                  fontSize: sp(19),
                ),
              ),
              SizedBox(height: h(30)),
              FilterWidget(
                text: "الواجب",
                type: FilterType.dropdown,
                color: AppColors.container2Color,
              ),
              CustomTextFormFieldWidget(
                validator: (value) {},
                keyboardType: TextInputType.number,
                controller: SearchController(),
                cursorColor: AppColors.container2Color,
                borderColor: AppColors.container2Color,
                borderWidth: 2,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: AppColors.container2Color,
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: AppColors.container2Color,
                    width: 2,
                  ),
                ),
                hintStyle: AppText.boldText(
                  color: AppColors.greyColor,
                  fontSize: sp(18),
                ),
                hintText: "درجة الامتحان",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
