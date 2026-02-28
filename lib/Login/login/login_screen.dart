import 'package:dar_el_3loom/Model/student_login_model.dart';
import 'package:dar_el_3loom/Model/teacher_login_model.dart';
import 'package:dar_el_3loom/provider/student_login_provider.dart';
import 'package:dar_el_3loom/provider/teacher_login_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../BackendSetup Data/Api/api_service.dart';
import '../../Model/parent_login_model.dart';
import '../../provider/app_flow.dart';
import '../../provider/parent_login_provider.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_routes.dart';
import '../../utils/app_text.dart';
import '../../utils/responsive.dart';
import '../../widgets/custom_elevated_button_widget.dart';
import '../../widgets/custom_text_form_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String code = '';
  String password = '';
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: w(16), vertical: h(60)),
            child: SingleChildScrollView(
              child: Column(
                spacing: h(35),
                children: [
                  Image.asset(AppAssets.boy, fit: BoxFit.fill),
                  CustomTextFormFieldWidget(
                    shadowColor: AppColors.container1Color,
                    filled: false,
                    cursorColor: AppColors.textColorLogin,
                    keyboardType: TextInputType.number,
                    fillColor: AppColors.transparentColor,
                    borderColor: AppColors.container1Color,
                    borderWidth: 2,
                    hintText: "الكود",
                    hintStyle: AppText.boldText(
                      color: AppColors.textColorLogin,
                      fontSize: sp(16),
                    ),
                    onChanged: (value) {
                      code = value;
                    },
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "برجاء ادخال الكود";
                      } else {
                        return null;
                      }
                    },
                  ),
                  CustomTextFormFieldWidget(
                    cursorColor: AppColors.textColorLogin,
                    shadowColor: AppColors.container1Color,
                    keyboardType: TextInputType.visiblePassword,
                    filled: false,
                    fillColor: AppColors.transparentColor,
                    borderColor: AppColors.container1Color,
                    borderWidth: 2,
                    hintText: "الباسورد",
                    hintStyle: AppText.boldText(
                      color: AppColors.textColorLogin,
                      fontSize: sp(16),
                    ),
                    onChanged: (value) {
                      password = value;
                    },
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "برجاء ادخال الباسورد";
                      } else {
                        return null;
                      }
                    },
                  ),
                  CustomElevatedButtonWidget(
                    sideColor: AppColors.transparentColor,
                    textStyle: AppText.boldText(
                      color: AppColors.blackColor,
                      fontSize: sp(16),
                    ),
                    text: "انضم",
                    colorContainer: AppColors.container1Color,
                    onPressed: () async {
                      if (!formKey.currentState!.validate()) return;

                      try {
                        final api = ApiService();

                        /// 1️⃣ تسجيل دخول الطالب
                        final studentResponse = await api.login(
                          code: code,
                          password: password,
                        );
                        final studentModel = StudentLoginModel.fromJson(
                          studentResponse,
                        );

                        if (studentModel.status == 'success' &&
                            studentModel.data?.student != null) {
                          Provider.of<StudentLoginProvider>(
                            context,
                            listen: false,
                          ).setLogin(studentModel);

                          if (studentModel.token != null) {
                            await AppFlow.saveStudentToken(studentModel.token!);
                          }

                          Fluttertoast.showToast(
                            msg: "تم تسجيل الدخول كطالب بنجاح",
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                          );

                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            AppRoutes.homeScreenName,
                            (route) => false,
                          );
                          return;
                        }

                        /// 2️⃣ تسجيل دخول ولي الأمر
                        final parentResponse = await api.loginParent(
                          id: code,
                          password: password,
                        );
                        final parentModel = ParentLoginModel.fromJson(
                          parentResponse,
                        );

                        if (parentModel.status == 'success' &&
                            parentModel.data?.parent != null) {
                          Provider.of<ParentLoginProvider>(
                            context,
                            listen: false,
                          ).setLoginParent(parentModel);

                          if (parentModel.token != null) {
                            await AppFlow.saveParentToken(parentModel.token!);
                          }

                          Fluttertoast.showToast(
                            msg: "تم تسجيل الدخول كولي أمر بنجاح",
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                          );

                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            AppRoutes.homeParentScreenName,
                            (route) => false,
                          );
                          return;
                        }

                        ///  تسجيل دخول teacher
                        final teacherResponse = await api.loginTeacher(
                          code: code,
                          password: password,
                        );
                        final teacherModel = TeacherLoginModel.fromJson(
                          teacherResponse,
                        );

                        if (teacherModel.status == 'success' &&
                            teacherModel.data?.teacher != null) {
                          Provider.of<TeacherLoginProvider>(
                            context,
                            listen: false,
                          ).setLoginTeacher(teacherModel);

                          if (teacherModel.token != null) {
                            await AppFlow.saveTeacherToken(teacherModel.token!);
                          }

                          Fluttertoast.showToast(
                            msg: "تم تسجيل الدخول المدرس بنجاح",
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                          );

                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            AppRoutes.homeTeacherScreenName,
                            (route) => false,
                          );
                          return;
                        }

                        Fluttertoast.showToast(
                          msg: "كود أو كلمة المرور غير صحيحة",
                          backgroundColor: AppColors.wrongIconColor,
                          textColor: Colors.white,
                        );
                      } catch (e) {
                        Fluttertoast.showToast(
                          msg: "حدث خطأ أثناء تسجيل الدخول",
                          backgroundColor: AppColors.wrongIconColor,
                          textColor: Colors.white,
                        );
                        debugPrint("Login error: $e");
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
  }
}
