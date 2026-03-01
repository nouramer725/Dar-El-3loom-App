import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../../BackendSetup Data/Api/api_service.dart';
import '../../../provider/teacher_login_provider.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text.dart';
import '../../../utils/responsive.dart';
import '../../../widgets/custom_elevated_button_widget.dart';
import '../../../widgets/custom_text_form_field_widget.dart';

class AddNewAssistantScreen extends StatefulWidget {
  const AddNewAssistantScreen({super.key});

  @override
  State<AddNewAssistantScreen> createState() => _AddNewAssistantScreenState();
}

class _AddNewAssistantScreenState extends State<AddNewAssistantScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Text(
          "اضافة مساعد",
          style: AppText.boldText(
            color: AppColors.blackColor,
            fontSize: sp(25),
          ),
        ),
        backgroundColor: AppColors.container3Color,
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_forward_ios_sharp, size: h(25)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w(16), vertical: h(72)),
          child: Form(
            key: formKey,
            child: Column(
              spacing: h(30),
              children: [
                CustomTextFormFieldWidget(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "برجاء ادخال الاسم";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  controller: nameController,
                  cursorColor: AppColors.container3Color,
                  borderColor: AppColors.container3Color,
                  borderWidth: 2,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: AppColors.container3Color,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: AppColors.container3Color,
                      width: 2,
                    ),
                  ),
                  hintStyle: AppText.boldText(
                    color: AppColors.greyColor,
                    fontSize: sp(16),
                  ),
                  hintText: "الاسم",
                ),
                CustomTextFormFieldWidget(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "برجاء ادخال رقم الموبايل";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.phone,
                  controller: phoneController,
                  cursorColor: AppColors.container3Color,
                  borderColor: AppColors.container3Color,
                  borderWidth: 2,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: AppColors.container3Color,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: AppColors.container3Color,
                      width: 2,
                    ),
                  ),
                  hintStyle: AppText.boldText(
                    color: AppColors.greyColor,
                    fontSize: sp(16),
                  ),
                  hintText: "رقم الموبايل",
                ),
                SizedBox(height: h(60)),
                CustomElevatedButtonWidget(
                  sideColor: AppColors.transparentColor,
                  textStyle: AppText.boldText(
                    color: AppColors.blackColor,
                    fontSize: sp(16),
                  ),
                  text: "تسجيل",
                  colorContainer: AppColors.container3Color,
                  onPressed: () async {
                    if (!formKey.currentState!.validate()) return;

                    try {
                      final teacherProvider = Provider.of<TeacherLoginProvider>(
                        context,
                        listen: false,
                      );

                      final token = teacherProvider.token;

                      if (token == null) {
                        Fluttertoast.showToast(
                          msg: "برجاء تسجيل الدخول مرة أخرى",
                          backgroundColor: AppColors.wrongIconColor,
                        );
                        return;
                      }

                      final api = ApiService(token: token);

                      final response = await api.addAssistant(
                        name: nameController.text,
                        phone: phoneController.text,
                      );

                      if (response['status'] == 'success') {
                        Fluttertoast.showToast(
                          msg: "تم إضافة المساعد بنجاح",
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                        );

                        Navigator.pop(context);
                        return;
                      }

                      if (response['message']?.toString().contains("exists") ==
                          true) {
                        Fluttertoast.showToast(
                          msg: "رقم الموبايل مستخدم بالفعل",
                          backgroundColor: AppColors.wrongIconColor,
                        );
                        return;
                      }

                      Fluttertoast.showToast(
                        msg: response['message'] ?? "حدث خطأ",
                        backgroundColor: AppColors.wrongIconColor,
                      );
                    } catch (e) {
                      Fluttertoast.showToast(
                        msg: "حدث خطأ أثناء إضافة المساعد",
                        backgroundColor: AppColors.wrongIconColor,
                      );
                      debugPrint("Add assistant error: $e");
                    }
                  },
                  padding: WidgetStateProperty.all(
                    EdgeInsets.symmetric(horizontal: w(40), vertical: h(12)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
