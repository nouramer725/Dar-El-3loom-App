import 'package:flutter/material.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text.dart';
import '../../../../utils/responsive.dart';
import '../../../../widgets/custom_elevated_button_widget.dart';
import '../../../../widgets/custom_text_form_field_widget.dart';

class PasswordEdit extends StatefulWidget {
  const PasswordEdit({super.key});

  @override
  State<PasswordEdit> createState() => _PasswordEditState();
}

class _PasswordEditState extends State<PasswordEdit> {
  String pastPassword = '';
  String newPassword = '';
  String confirmPassword = '';
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.strokeBottomNavBarColor,
        title: Text(
          "تعديل كلمة السر",
          style: AppText.boldText(color: AppColors.blackColor, fontSize: 24),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_forward_ios_sharp, size: h(25)),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w(16), vertical: h(16)),
          child: Column(
            spacing: h(20),
            children: [
              CustomTextFormFieldWidget(
                shadowColor: AppColors.strokeBottomNavBarColor,
                filled: false,
                fillColor: AppColors.transparentColor,
                borderColor: AppColors.strokeBottomNavBarColor,
                borderWidth: 2,
                hintText: "كلمة السر القديمة",
                hintStyle: AppText.regularText(
                  color: AppColors.greyColor,
                  fontSize: 16,
                ),
                suffixIcon: Icon(
                  Icons.visibility_off_outlined,
                  color: AppColors.greyColor,
                ),
                suffixIconColor: AppColors.greyColor,
                onChanged: (value) {
                  pastPassword = value;
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "برجاء ادخال كلمة السر القديمة";
                  } else {
                    return null;
                  }
                },
              ),
              CustomTextFormFieldWidget(
                shadowColor: AppColors.strokeBottomNavBarColor,
                filled: false,
                fillColor: AppColors.transparentColor,
                borderColor: AppColors.strokeBottomNavBarColor,
                borderWidth: 2,
                hintText: "كلمة السر الجديدة",
                hintStyle: AppText.regularText(
                  color: AppColors.greyColor,
                  fontSize: 16,
                ),
                suffixIcon: Icon(
                  Icons.visibility_off_outlined,
                  color: AppColors.greyColor,
                ),
                suffixIconColor: AppColors.greyColor,
                onChanged: (value) {
                  newPassword = value;
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "برجاء ادخال كلمة السر الجديدة";
                  } else {
                    return null;
                  }
                },
              ),
              CustomTextFormFieldWidget(
                shadowColor: AppColors.strokeBottomNavBarColor,
                filled: false,
                fillColor: AppColors.transparentColor,
                borderColor: AppColors.strokeBottomNavBarColor,
                borderWidth: 2,
                hintText: "تأكيد كلمة السر الجديدة",
                hintStyle: AppText.regularText(
                  color: AppColors.greyColor,
                  fontSize: 16,
                ),
                suffixIcon: Icon(
                  Icons.visibility_off_outlined,
                  color: AppColors.greyColor,
                ),
                suffixIconColor: AppColors.greyColor,
                onChanged: (value) {
                  confirmPassword = value;
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "برجاء تأكيد كلمة السر الجديدة";
                  } else {
                    return null;
                  }
                },
              ),
              CustomElevatedButtonWidget(
                text: "حفظ",
                colorContainer: AppColors.whiteColor,
                onPressed: () {
                  if (formKey.currentState!.validate() == true) {}
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
