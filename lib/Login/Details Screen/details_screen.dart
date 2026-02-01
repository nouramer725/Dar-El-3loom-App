import 'dart:io';
import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_routes.dart';
import '../../utils/app_text.dart';
import '../../utils/responsive.dart';
import '../../widgets/custom_elevated_button_widget.dart';
import '../../widgets/custom_text_form_field_widget.dart';
import 'package:provider/provider.dart';
import 'Api/student_api.dart';
import 'Controllers/student_controller.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          StudentController(StudentRepositoryImpl())..loadStudentData(),
      child: Consumer<StudentController>(
        builder: (context, controller, _) {
          if (controller.loading) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: AppColors.container2Color,
                  strokeWidth: h(7),
                ),
              ),
            );
          }
          return Scaffold(
            body: Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: w(16),
                  vertical: h(25),
                ),
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      spacing: h(25),
                      children: [
                        buildField(
                          "الاسم",
                          controller.name,
                          TextInputType.name,
                          controller.nameLocked,
                        ),
                        buildLevelDropdown(controller, context),
                        buildField(
                          "رقم الطالب",
                          controller.phoneStudent,
                          TextInputType.number,
                          controller.phoneStudentLocked,
                        ),
                        buildField(
                          "رقم ولي الامر",
                          controller.phoneParent,
                          TextInputType.number,
                          controller.phoneParentLocked,
                        ),
                        buildField(
                          "الرقم القومي",
                          controller.nationalId,
                          TextInputType.number,
                          controller.nationalIdLocked,
                        ),
                        buildField(
                          "الباسورد",
                          controller.password,
                          TextInputType.visiblePassword,
                          controller.passwordLocked,
                        ),
                        buildField(
                          "تاكيد الباسورد",
                          controller.confirmPassword,
                          TextInputType.visiblePassword,
                          controller.confirmPasswordLocked,
                        ),
                        buildImagePicker(
                          context,
                          "شهادة الميلاد",
                          controller.birthImage,
                          () => controller.pickImage(true),
                        ),
                        buildImagePicker(
                          context,
                          "صورة شخصية",
                          controller.personalImage,
                          () => controller.pickImage(false),
                        ),

                        CustomElevatedButtonWidget(
                          sideColor: AppColors.transparentColor,
                          textStyle: AppText.boldText(
                            color: AppColors.blackColor,
                            fontSize: sp(16),
                          ),
                          text: "انضم",
                          colorContainer: AppColors.container2Color,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              if (controller.password.text !=
                                  controller.confirmPassword.text) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(
                                      "كلمة المرور غير متطابقة",
                                      style: AppText.boldText(
                                        color: Colors.white,
                                        fontSize: sp(16),
                                      ),
                                    ),
                                  ),
                                );
                                return;
                              }
                              if (controller.personalImage == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(
                                      style: AppText.boldText(
                                        color: Colors.white,
                                        fontSize: sp(16),
                                      ),
                                      "برجاء اختيار صورة شخصية",
                                    ),
                                  ),
                                );
                                return;
                              } else if (controller.birthImage == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(
                                      style: AppText.boldText(
                                        color: Colors.white,
                                        fontSize: sp(16),
                                      ),
                                      "برجاء اختيار صورة شهادة الميلاد",
                                    ),
                                  ),
                                );
                                return;
                              }

                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                AppRoutes.homeScreenName,
                                (route) => false,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildField(
    String hint,
    TextEditingController controller,
    TextInputType keyboardType,
    bool locked,
  ) {
    return CustomTextFormFieldWidget(
      enabled: !locked,
      shadowColor: AppColors.container2Color,
      filled: false,
      cursorColor: AppColors.textColorLogin,
      keyboardType: keyboardType,
      fillColor: AppColors.transparentColor,
      borderColor: AppColors.container2Color,
      borderWidth: 2,
      labelText: hint,
      labelStyle: AppText.boldText(
        color: AppColors.textColorLogin,
        fontSize: sp(16),
      ),
      controller: controller,
      validator: (v) => v == null || v.isEmpty ? "ادخل $hint" : null,
    );
  }

  Widget buildImagePicker(
    BuildContext context,
    String title,
    File? image,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: h(120),
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: w(12), vertical: h(6)),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.container2Color, width: 2),
          borderRadius: BorderRadius.circular(14),
        ),
        child: image == null
            ? Row(
                children: [
                  Text(
                    title,
                    style: AppText.boldText(
                      fontSize: sp(16),
                      color: AppColors.textColorLogin,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.camera_alt, color: AppColors.greyColor),
                ],
              )
            : Row(
                spacing: w(20),
                children: [
                  CircleAvatar(radius: h(50), backgroundImage: FileImage(image)),
                  Text(
                    title,
                    style: AppText.boldText(
                      fontSize: sp(16),
                      color: AppColors.textColorLogin,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.edit, color: AppColors.greyColor),
                ],
              ),
      ),
    );
  }

  Widget buildLevelDropdown(
    StudentController controller,
    BuildContext context,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: w(12)),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.container2Color, width: 2),
        borderRadius: BorderRadius.circular(14),
      ),
      child: DropdownButtonFormField<String>(
        dropdownColor: Theme.of(context).scaffoldBackgroundColor,
        initialValue: controller.selectedLevel,
        hint: Text(
          "اختر الصف",
          style: AppText.boldText(
            fontSize: sp(16),
            color: AppColors.textColorLogin,
          ),
        ),
        items: controller.levels
            .map(
              (level) => DropdownMenuItem(
                value: level,
                child: Text(
                  level,
                  style: AppText.boldText(
                    fontSize: sp(17),
                    color: AppColors.darkGreyColor,
                  ),
                ),
              ),
            )
            .toList(),
        onChanged: controller.levelLocked
            ? null
            : (value) {
                controller.setLevel(value!);
              },
        validator: (value) => value == null ? "اختر الصف" : null,
        decoration: InputDecoration(border: InputBorder.none),
      ),
    );
  }
}
