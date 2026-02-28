import 'package:dar_el_3loom/Model/teacher_login_model.dart';
import 'package:dar_el_3loom/provider/teacher_login_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../BackendSetup Data/Api/api_service.dart';
import '../../provider/app_flow.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_routes.dart';
import '../../utils/app_text.dart';
import '../../utils/responsive.dart';
import '../../widgets/custom_elevated_button_widget.dart';
import 'Controllers/teacher_controller.dart';
import 'Widgets/widget.dart';

class DetailsTeacherScreen extends StatefulWidget {
  const DetailsTeacherScreen({super.key});

  @override
  State<DetailsTeacherScreen> createState() => _DetailsTeacherScreenState();
}

class _DetailsTeacherScreenState extends State<DetailsTeacherScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final loginProvider = Provider.of<TeacherLoginProvider>(
      context,
      listen: false,
    );
    final token = loginProvider.token;
    final teacher = loginProvider.loginModel?.data?.teacher;

    print("Token from provider: $token");
    print("Teacher ID: ${teacher?.code}");
  }

  @override
  Widget build(BuildContext context) {
    final teacherProvider = Provider.of<TeacherLoginProvider>(context);
    final teacher = teacherProvider.loginModel?.data?.teacher;

    if (teacher == null) {
      return Scaffold(
        body: Center(
          child: Text(
            "لا توجد بيانات للمستخدم، يرجى تسجيل الدخول مرة أخرى",
            style: AppText.boldText(
              color: AppColors.blackColor,
              fontSize: sp(18),
            ),
          ),
        ),
      );
    }

    return ChangeNotifierProvider(
      create: (_) => TeacherController(teacher: teacher),
      child: Consumer<TeacherController>(
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
                          controller.id,
                          TextInputType.number,
                          controller.idLocked,
                        ),
                        buildField(
                          "الاسم",
                          controller.name,
                          TextInputType.name,
                          controller.nameLocked,
                        ),
                        buildField(
                          "اسم المادة",
                          controller.nameMada,
                          TextInputType.name,
                          controller.nameMadaLocked,
                        ),
                        buildField(
                          "الرقم القومي",
                          controller.personalId,
                          TextInputType.number,
                          controller.personalIdLocked,
                        ),
                        buildField(
                          "رقم المدرس",
                          controller.phoneParent,
                          TextInputType.number,
                          controller.phoneParentLocked,
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

                            // Validation checks
                            if (!formKey.currentState!.validate())
                              errors.add("الرجاء ملء جميع الحقول بشكل صحيح");
                            if (controller.password.text !=
                                controller.confirmPassword.text)
                              errors.add("كلمة المرور غير مطابقة");
                            if (controller.personalImage == null &&
                                controller.personalImageUrl == null)
                              errors.add("برجاء اختيار صورة شخصية");

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
                              final loginProvider =
                                  Provider.of<TeacherLoginProvider>(
                                    context,
                                    listen: false,
                                  );

                              final token = loginProvider.token;
                              final teacher = loginProvider.loginModel;

                              if (token == null || teacher == null) {
                                throw Exception("User not logged in");
                              }

                              final updatedTeacher = Teacher(
                                code: controller.id.text,
                                nMod: controller.name.text,
                                nMada: controller.nameMada.text,
                                phonenumber: controller.phoneParent.text,
                                personalId: controller.personalId.text,
                                password: controller.password.text,
                                personalImage: controller.personalImage?.path,
                                verified: true,
                              );

                              final api = ApiService(token: token);

                              final response = await api.updateTeacherInfo(
                                updatedTeacher,
                              );

                              final oldLogin = loginProvider.loginModel;

                              final updatedLoginModel =
                                  TeacherLoginModel.fromJson(response);

                              updatedLoginModel.token ??= oldLogin?.token;

                              updatedLoginModel.data?.teacher?.password ??=
                                  oldLogin?.data?.teacher?.password;

                              await loginProvider.setLoginTeacher(
                                updatedLoginModel,
                              );

                              AppFlow.getTeacherToken();

                              print(updatedLoginModel.token);

                              if (updatedLoginModel.token != null) {
                                await AppFlow.saveTeacherToken(
                                  updatedLoginModel.token!,
                                );
                              }

                              // print("-----------Update------------------");
                              // print(updatedLoginModel.status);
                              // print(updatedLoginModel.token);
                              // print(updatedLoginModel.data);
                              // print(updatedLoginModel.data?.teacher);
                              // print(updatedLoginModel.data?.teacher?.code);
                              // print(updatedLoginModel.data?.teacher?.name);
                              // print(updatedLoginModel.data?.teacher?.tel);
                              // print(updatedLoginModel.data?.teacher?.personalId);
                              // print(updatedLoginModel.data?.teacher?.verified);
                              // print(updatedLoginModel.data?.teacher?.password);
                              // print("-----------------------------");

                              Fluttertoast.showToast(
                                msg: "تم تحديث بيانات الطالب بنجاح",
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                              );

                              // Navigate to home and remove all previous screens
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                AppRoutes.homeTeacherScreenName,
                                (route) => false,
                              );
                            } catch (e) {
                              Fluttertoast.showToast(
                                msg: "حدث خطأ أثناء تحديث البيانات",
                                backgroundColor: AppColors.wrongIconColor,
                                textColor: Colors.white,
                              );
                              debugPrint("Update error: $e");
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
