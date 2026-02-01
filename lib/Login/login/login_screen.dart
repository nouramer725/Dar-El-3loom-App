import 'package:flutter/material.dart';
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
  int code = 0;
  int phoneNumber = 0;
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
                      code = value as int;
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
                      phoneNumber = value as int;
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
                    onPressed: () {
                      if (formKey.currentState!.validate() == true) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoutes.detailsScreen,
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
  }
}
