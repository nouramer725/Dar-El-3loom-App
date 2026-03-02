import 'package:dar_el_3loom/Model/teacher_login_model.dart';
import 'package:dar_el_3loom/provider/teacher_login_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../BackendSetup Data/Api/api_service.dart';
import '../../Model/assistant_login_model.dart';
import '../../Model/parent_login_model.dart';
import '../../Model/student_login_model.dart';
import '../../provider/assistant_login_provider.dart';
import '../../provider/parent_login_provider.dart';
import '../../provider/student_login_provider.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_routes.dart';
import '../../utils/app_text.dart';
import '../../utils/responsive.dart';
import '../../widgets/custom_elevated_button_widget.dart';
import '../../widgets/custom_text_form_field_widget.dart';

class FirstTimeLoginScreen extends StatefulWidget {
  const FirstTimeLoginScreen({super.key});

  @override
  State<FirstTimeLoginScreen> createState() => _FirstTimeLoginScreenState();
}

class _FirstTimeLoginScreenState extends State<FirstTimeLoginScreen> {
  String code = '';
  String phoneNumber = '';
  final formKey = GlobalKey<FormState>();

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
                    shadowColor: AppColors.container2Color,
                    filled: false,
                    cursorColor: AppColors.textColorLogin,
                    keyboardType: TextInputType.number,
                    fillColor: AppColors.transparentColor,
                    borderColor: AppColors.container2Color,
                    borderWidth: 2,
                    hintText: "الكود",
                    hintStyle: AppText.boldText(
                      color: AppColors.textColorLogin,
                      fontSize: sp(16),
                    ),
                    onChanged: (value) => code = value,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "برجاء ادخال الكود";
                      }
                      return null;
                    },
                  ),
                  CustomTextFormFieldWidget(
                    cursorColor: AppColors.textColorLogin,
                    shadowColor: AppColors.container2Color,
                    keyboardType: TextInputType.phone,
                    filled: false,
                    fillColor: AppColors.transparentColor,
                    borderColor: AppColors.container2Color,
                    borderWidth: 2,
                    hintText: "رقم الهاتف",
                    hintStyle: AppText.boldText(
                      color: AppColors.textColorLogin,
                      fontSize: sp(16),
                    ),
                    onChanged: (value) => phoneNumber = value,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "برجاء ادخال رقم الهاتف";
                      }
                      return null;
                    },
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
                      if (!formKey.currentState!.validate()) return;

                      try {
                        final api = ApiService();

                        final studentResponse = await api.verifyStudent(
                          code: code,
                          parentNumber: phoneNumber,
                        );

                        final studentModel = StudentLoginModel.fromJson(
                          studentResponse,
                        );

                        if (studentModel.status == 'success' &&
                            studentModel.data?.student != null) {
                          final studentProvider =
                              Provider.of<StudentLoginProvider>(
                                context,
                                listen: false,
                              );

                          await studentProvider.setLogin(studentModel);

                          Navigator.pushNamed(context, AppRoutes.detailsScreen);
                          return;
                        }

                        final parentResponse = await api.verifyParent(
                          id: int.tryParse(code) ?? 0,
                          parentNumber: phoneNumber,
                        );

                        final parentModel = ParentLoginModel.fromJson(
                          parentResponse,
                        );

                        if (parentModel.status == 'success' &&
                            parentModel.data?.parent != null) {
                          final parentProvider =
                              Provider.of<ParentLoginProvider>(
                                context,
                                listen: false,
                              );

                          await parentProvider.setLoginParent(parentModel);

                          Navigator.pushNamed(
                            context,
                            AppRoutes.detailsParentScreen,
                          );
                          return;
                        }

                        final teacherResponse = await api.verifyTeacher(
                          id: code,
                          parentNumber: phoneNumber,
                        );

                        final teacherModel = TeacherLoginModel.fromJson(
                          teacherResponse,
                        );

                        if (teacherModel.status == 'success' &&
                            teacherModel.data?.teacher != null) {
                          final teacherProvider =
                              Provider.of<TeacherLoginProvider>(
                                context,
                                listen: false,
                              );

                          await teacherProvider.setLoginTeacher(teacherModel);

                          Navigator.pushNamed(
                            context,
                            AppRoutes.detailsTeacherScreen,
                          );
                          return;
                        }

                        final assistantResponse = await api.verifyAssistant(
                          id: code,
                          parentNumber: phoneNumber,
                        );

                        final assistantModel = AssistantLoginModel.fromJson(
                          assistantResponse,
                        );

                        if (assistantModel.status == 'success' &&
                            assistantModel.data?.assistant != null) {
                          final assistantProvider =
                          Provider.of<AssistantLoginProvider>(
                            context,
                            listen: false,
                          );

                          await assistantProvider.setLoginAssistant(assistantModel);

                          Navigator.pushNamed(
                            context,
                            AppRoutes.detailsAssistantScreen,
                          );
                          return;
                        }

                        /// 3️⃣ لو الاتنين فشلوا
                        Fluttertoast.showToast(
                          msg: "الكود أو رقم التليفون غير صحيح",
                          backgroundColor: AppColors.wrongIconColor,
                          textColor: Colors.white,
                        );
                      } catch (e) {
                        Fluttertoast.showToast(
                          msg: "حدث خطأ، حاول مرة اخرى",
                          backgroundColor: AppColors.wrongIconColor,
                          textColor: Colors.white,
                        );
                        debugPrint("Verify error: $e");
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
