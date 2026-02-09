import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../../../BackendSetup Data/Api/api_service.dart';
import '../../../../provider/student_login_provider.dart';
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
                      final loginProvider = Provider.of<StudentLoginProvider>(
                        context,
                        listen: false,
                      );
                      final token = loginProvider.token;

                      if (token == null) {
                        throw Exception("لم يتم تسجيل الدخول");
                      }

                      final api = ApiService(token: token);

                      final response = await api.changePassword(
                        oldPassword: pastPassword,
                        newPassword: newPassword,
                      );

                      if (response['status'] == 'success') {
                        final student = loginProvider.student;
                        if (student != null) {
                          student.password = newPassword;
                          await loginProvider.setLogin(
                            loginProvider.loginModel!,
                          );
                        }

                        Fluttertoast.showToast(
                          msg: "تم تغيير كلمة المرور بنجاح",
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          gravity: ToastGravity.TOP,
                        );
                        Navigator.pop(context);
                      } else {
                        Fluttertoast.showToast(
                          msg: response['message'] ?? "حدث خطأ",
                          backgroundColor: AppColors.wrongIconColor,
                          textColor: Colors.white,
                          gravity: ToastGravity.TOP,
                        );
                      }
                    } catch (e) {
                      print(e);
                      Fluttertoast.showToast(
                        msg: "كلمة المرور القديمة غير صحيحة",
                        backgroundColor: AppColors.wrongIconColor,
                        textColor: Colors.white,
                        gravity: ToastGravity.TOP,
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
