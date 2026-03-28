import 'package:dar_el_3loom/provider/teacher_login_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../../../backend_setup/Api/api_service.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text.dart';
import '../../../../utils/responsive.dart';
import '../../../../widgets/custom_elevated_button_widget.dart';
import '../../../../widgets/custom_text_form_field_widget.dart';

class PasswordTeacherEdit extends StatefulWidget {
  const PasswordTeacherEdit({super.key});

  @override
  State<PasswordTeacherEdit> createState() => _PasswordTeacherEditState();
}

class _PasswordTeacherEditState extends State<PasswordTeacherEdit> {
  String pastPassword = '';
  String newPassword = '';
  String confirmPassword = '';
  var formKey = GlobalKey<FormState>();

  // 🔹 eye icon state
  bool showOldPassword = false;
  bool showNewPassword = false;
  bool showConfirmPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.strokeBottomNavBarColor,
        title: Text(
          "تعديل كلمة السر",
          style: AppText.boldText(
            color: AppColors.blackColor,
            fontSize: sp(24),
          ),
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
          child: SingleChildScrollView(
            child: Column(
              spacing: h(20),
              children: [
                CustomTextFormFieldWidget(
                  shadowColor: AppColors.strokeBottomNavBarColor,
                  filled: false,
                  fillColor: AppColors.transparentColor,
                  borderColor: AppColors.strokeBottomNavBarColor,
                  keyboardType: TextInputType.visiblePassword,
                  borderWidth: 2,
                  hintText: "كلمة السر القديمة",
                  hintStyle: AppText.regularText(
                    color: AppColors.greyColor,
                    fontSize: sp(16),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      showOldPassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppColors.greyColor,
                    ),
                    onPressed: () {
                      setState(() {
                        showOldPassword = !showOldPassword;
                      });
                    },
                  ),
                  onChanged: (value) => pastPassword = value,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "برجاء ادخال كلمة السر القديمة";
                    }
                    return null;
                  },
                  obscureText: !showOldPassword,
                  maxLines: 1,
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
                    fontSize: sp(16),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      showNewPassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppColors.greyColor,
                    ),
                    onPressed: () {
                      setState(() {
                        showNewPassword = !showNewPassword;
                      });
                    },
                  ),
                  onChanged: (value) => newPassword = value,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "برجاء ادخال كلمة السر الجديدة";
                    }
                    return null;
                  },
                  obscureText: !showNewPassword,
                  maxLines: 1,
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
                    fontSize: sp(16),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      showConfirmPassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppColors.greyColor,
                    ),
                    onPressed: () {
                      setState(() {
                        showConfirmPassword = !showConfirmPassword;
                      });
                    },
                  ),
                  onChanged: (value) => confirmPassword = value,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "برجاء تأكيد كلمة السر الجديدة";
                    }
                    return null;
                  },
                  obscureText: !showConfirmPassword,
                  maxLines: 1,
                ),
                CustomElevatedButtonWidget(
                  text: "حفظ",
                  padding: WidgetStateProperty.all(
                    EdgeInsets.symmetric(horizontal: w(40), vertical: h(12)),
                  ),
                  textStyle: AppText.boldText(
                    color: AppColors.blackColor,
                    fontSize: sp(20),
                  ),
                  colorContainer: AppColors.whiteColor,
                  onPressed: () async {
                    if (!formKey.currentState!.validate()) return;

                    if (newPassword != confirmPassword) {
                      Fluttertoast.showToast(
                        msg: "كلمة المرور الجديدة غير متطابقة",
                        backgroundColor: AppColors.wrongIconColor,
                        textColor: Colors.white,
                        gravity: ToastGravity.TOP,
                      );
                      return;
                    }

                    try {
                      final loginProvider = Provider.of<TeacherLoginProvider>(
                        context,
                        listen: false,
                      );
                      final token = loginProvider.token;
                      final teacher = loginProvider.loginModel?.data?.teacher;

                      if (token == null || teacher == null) {
                        Fluttertoast.showToast(msg: "لم يتم تسجيل الدخول");
                        return;
                      }

                      print("teacher token: $token");
                      print("Old password sent: $pastPassword");
                      print("teacher ID: ${teacher.code}");

                      final api = ApiService(token: token);
                      final response = await api.changePasswordTeacher(
                        oldPassword: pastPassword,
                        newPassword: newPassword,
                      );

                      print("Change password response: $response");

                      if (response['status'] == 'success') {
                        // update local password in provider
                        teacher.password = newPassword;
                        await loginProvider.setLoginTeacher(
                          loginProvider.loginModel!,
                        );

                        Fluttertoast.showToast(
                          msg: "تم تغيير كلمة المرور بنجاح",
                          backgroundColor: AppColors.blackColor,
                          textColor: Colors.white,
                        );
                        Navigator.pop(context);
                      } else {
                        Fluttertoast.showToast(
                          msg:
                              response['message'] ??
                              "حدث خطأ غير معروف من السيرفر",
                          backgroundColor: AppColors.wrongIconColor,
                          textColor: Colors.white,
                        );
                      }
                    } catch (e) {
                      print("Change password error: $e");
                      Fluttertoast.showToast(
                        msg: "حدث خطأ أثناء تغيير كلمة المرور",
                        backgroundColor: AppColors.wrongIconColor,
                        textColor: Colors.white,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
