import 'package:flutter/material.dart';
import '../../../../../utils/responsive.dart';
import '../../../home/containers_contents/Mozakrat/filter_widget.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text.dart';
import '../../../widgets/custom_text_form_field_widget.dart';

class StudentPerformanceWidget extends StatelessWidget {
  const StudentPerformanceWidget({super.key});

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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w(16), vertical: h(100)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: h(10),
            children: [
              Text(
                "الاسم : احمد محمد",
                style: AppText.boldText(
                  color: AppColors.greyColor,
                  fontSize: sp(19),
                ),
              ),
              Text(
                "الصف : الاول الثانوي",
                style: AppText.boldText(
                  color: AppColors.greyColor,
                  fontSize: sp(19),
                ),
              ),
              Text(
                "الكود : 1001",
                style: AppText.boldText(
                  color: AppColors.greyColor,
                  fontSize: sp(19),
                ),
              ),
              SizedBox(height: h(100)),
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
                  color: AppColors.blackColor,
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
