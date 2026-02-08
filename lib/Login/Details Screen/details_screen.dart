import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../BackendSetup Data/Api/api_service.dart';
import '../../Model/student_model.dart';
import '../../provider/app_flow.dart';
import '../../provider/student_provider.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_routes.dart';
import '../../utils/app_text.dart';
import '../../utils/responsive.dart';
import '../../widgets/custom_elevated_button_widget.dart';
import 'Controllers/student_controller.dart';
import 'Widgets/widget.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(context);
    final student = studentProvider.student;

    if (student == null) {
      return Scaffold(
        body: Center(
          child: Text(
            "لا توجد بيانات للطالب، يرجى تسجيل الدخول مرة أخرى",
            style: AppText.boldText(
              color: AppColors.blackColor,
              fontSize: sp(18),
            ),
          ),
        ),
      );
    }

    return ChangeNotifierProvider(
      create: (_) => StudentController(student: student),
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
                          "الكود",
                          controller.code,
                          TextInputType.name,
                          controller.codeLocked,
                        ),
                        buildField(
                          "الاسم",
                          controller.name,
                          TextInputType.name,
                          controller.nameLocked,
                        ),
                        buildField(
                          "الصف",
                          controller.level,
                          TextInputType.name,
                          controller.levelLocked,
                        ),
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
                          controller.birthImageUrl,
                        ),
                        buildImagePicker(
                          context,
                          "صورة شخصية",
                          controller.personalImage,
                          () => controller.pickImage(false),
                          controller.personalImageUrl,
                        ),

                        CustomElevatedButtonWidget(
                          sideColor: AppColors.transparentColor,
                          textStyle: AppText.boldText(
                            color: AppColors.blackColor,
                            fontSize: sp(16),
                          ),
                          text: "انضم",
                          colorContainer: AppColors.container2Color,
                          onPressed: () async {
                            List<String> errors = [];

                            if (!formKey.currentState!.validate())
                              errors.add("الرجاء ملء جميع الحقول بشكل صحيح");
                            if (controller.level.text.trim().isEmpty)
                              errors.add("برجاء اختيار الصف الدراسي");
                            if (controller.password.text !=
                                controller.confirmPassword.text)
                              errors.add("كلمة المرور غير مطابقة");
                            if (controller.personalImage == null &&
                                controller.personalImageUrl == null)
                              errors.add("برجاء اختيار صورة شخصية");
                            if (controller.birthImage == null &&
                                controller.birthImageUrl == null)
                              errors.add("برجاء اختيار شهادة الميلاد");

                            if (errors.isNotEmpty) {
                              Fluttertoast.showToast(
                                msg: errors.map((e) => "• $e").join("\n"),
                                backgroundColor: AppColors.wrongIconColor,
                                textColor: Colors.white,
                                fontSize: sp(16),
                                gravity: ToastGravity.TOP,
                              );
                              return;
                            }

                            try {
                              StudentModel updatedStudent = StudentModel(
                                code: student.code,
                                name: controller.name.text,
                                level: controller.level.text,
                                phoneStudent: controller.phoneStudent.text,
                                phoneParent: controller.phoneParent.text,
                                nationalId: controller.nationalId.text,
                                password: controller.password.text,
                                birthImage: controller.birthImage?.path,
                                studentImage: controller.personalImage?.path,
                              );

                              final api = ApiService();
                              final response = await api.updateStudentInfo(
                                updatedStudent,
                              );

                              print("Response from API: $response");

                              studentProvider.setStudent(
                                StudentModel.fromJson(
                                  response['data']['student'],
                                ),
                              );

                              Fluttertoast.showToast(
                                msg: "تم تحديث بيانات الطالب بنجاح",
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                              );

                              await AppFlow.goToCompleted();

                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                AppRoutes.homeScreenName,
                                (route) => false,
                              );
                            } catch (e) {
                              Fluttertoast.showToast(
                                msg: "حدث خطأ أثناء تحديث البيانات",
                                backgroundColor: AppColors.wrongIconColor,
                                textColor: Colors.white,
                              );
                              print("Error updating student: $e");
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
}
