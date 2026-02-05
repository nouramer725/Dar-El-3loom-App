import 'package:dar_el_3loom/BackendSetup%20Data/Api/api_service.dart';
import 'package:dar_el_3loom/provider/app_flow.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Model/student_model.dart';
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
                    shadowColor: AppColors.container2Color,
                    keyboardType: TextInputType.phone,
                    filled: false,
                    fillColor: AppColors.transparentColor,
                    borderColor: AppColors.container2Color,
                    borderWidth: 2,
                    hintText: "رقم تليفون ولي الامر",
                    hintStyle: AppText.boldText(
                      color: AppColors.textColorLogin,
                      fontSize: sp(16),
                    ),
                    onChanged: (value) {
                      phoneNumber = value;
                    },
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "برجاء ادخال رقم تليفون ولي الامر";
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
                    colorContainer: AppColors.container2Color,
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        try {
                          final response = await ApiService().verifyStudent(
                            code: code,
                            parentNumber: phoneNumber,
                          );

                          if (response['status'] == 'success') {
                            final studentJson = response['data']['student'];
                            final student = StudentModel.fromJson(studentJson);

                            await AppFlow.goToDetails();
                            Navigator.pushNamed(
                              context,
                              AppRoutes.detailsScreen,
                              arguments: student,
                            );
                          } else {
                            Fluttertoast.showToast(
                              msg: "الطالب غير موجود",
                              backgroundColor: AppColors.wrongIconColor,
                              textColor: Colors.white,
                            );
                          }
                        } catch (e) {
                          Fluttertoast.showToast(
                            msg: "الطالب غير موجود",
                            backgroundColor: AppColors.wrongIconColor,
                            textColor: Colors.white,
                          );
                          print(e);
                        }
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
