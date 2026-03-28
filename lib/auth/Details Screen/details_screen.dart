import 'package:dar_el_3loom/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../../../backend_setup/Api/api_service.dart';
import '../../models/student_login_model.dart';
import '../../provider/app_flow.dart';
import '../../provider/student_login_provider.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_routes.dart';
import '../../utils/app_text.dart';
import '../../utils/responsive.dart';
import '../../widgets/custom_elevated_button_widget.dart';
import 'Controllers/student_controller.dart';
import 'Widgets/widget.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final formKey = GlobalKey<FormState>();
  bool showPassword = false;
  bool showConfirmPassword = false;

  @override
  void initState() {
    super.initState();
    final loginProvider = Provider.of<StudentLoginProvider>(
      context,
      listen: false,
    );
    final token = loginProvider.token;
    final student = loginProvider.student;

    print("Token from provider: $token");
    print("Student: ${student?.nTalb}");
  }

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentLoginProvider>(context);
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
                          validator: (v) =>
                              AppValidators.requiredField(v, "الكود"),
                        ),
                        buildField(
                          "الاسم",
                          controller.name,
                          TextInputType.name,
                          controller.nameLocked,
                          validator: (v) =>
                              AppValidators.requiredField(v, "الاسم"),
                        ),
                        buildField(
                          "الصف",
                          controller.level,
                          TextInputType.name,
                          controller.levelLocked,
                          validator: (v) =>
                              AppValidators.requiredField(v, "الصف"),
                        ),
                        buildField(
                          "رقم الطالب",
                          controller.phoneStudent,
                          TextInputType.number,
                          controller.phoneStudentLocked,
                          validator: (v) =>
                              AppValidators.phone(v, "رقم الطالب"),
                        ),
                        buildField(
                          "كود الدخول الخاص ب ولي الامر",
                          controller.parentId,
                          TextInputType.number,
                          controller.parentIdLocked,
                          validator: (v) =>
                              AppValidators.requiredField(v, "كود ولي الامر"),
                        ),
                        buildField(
                          "رقم ولي الامر",
                          controller.phoneParent,
                          TextInputType.number,
                          controller.phoneParentLocked,
                          validator: (v) =>
                              AppValidators.phone(v, "رقم ولي الامر"),
                        ),
                        buildField(
                          "الرقم القومي",
                          controller.nationalId,
                          TextInputType.number,
                          controller.nationalIdLocked,
                          validator: AppValidators.nationalId,
                        ),
                        buildField(
                          "الباسورد",
                          controller.password,
                          TextInputType.visiblePassword,
                          controller.passwordLocked,
                          isPassword: true,
                          isPasswordVisible: showPassword,
                          validator: AppValidators.password,
                          onTogglePassword: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                        ),
                        buildField(
                          "تاكيد الباسورد",
                          controller.confirmPassword,
                          TextInputType.visiblePassword,
                          controller.confirmPasswordLocked,
                          isPassword: true,
                          isPasswordVisible: showConfirmPassword,
                          validator: (v) => AppValidators.confirmPassword(
                            v,
                            controller.password.text,
                          ),
                          onTogglePassword: () {
                            setState(() {
                              showConfirmPassword = !showConfirmPassword;
                            });
                          },
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

                            // Validation checks
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
                              final loginProvider =
                                  Provider.of<StudentLoginProvider>(
                                    context,
                                    listen: false,
                                  );

                              final token = loginProvider.token;
                              final student = loginProvider.student;

                              if (token == null || student == null) {
                                throw Exception("User not logged in");
                              }

                              final updatedStudent = Student(
                                codTalb: controller.code.text,
                                nTalb: controller.name.text,
                                nSaf: controller.level.text,
                                tel: controller.phoneStudent.text,
                                tel1: controller.phoneParent.text,
                                personalId: controller.nationalId.text,
                                birthCertificate: controller.birthImage?.path,
                                profilePicture: controller.personalImage?.path,
                                verified: true,
                                password: controller.password.text,
                                parentId: controller.parentId.text,
                              );

                              final api = ApiService(token: token);

                              final response = await api.updateStudentInfo(
                                updatedStudent,
                              );

                              final oldLogin = loginProvider.loginModel;

                              final updatedLoginModel =
                                  StudentLoginModel.fromJson(response);

                              updatedLoginModel.token ??= oldLogin?.token;

                              updatedLoginModel.data?.student?.password ??=
                                  oldLogin?.data?.student?.password;

                              await loginProvider.setLogin(updatedLoginModel);

                              AppFlow.getStudentToken();

                              print(updatedLoginModel.token);

                              if (updatedLoginModel.token != null) {
                                await AppFlow.saveStudentToken(
                                  updatedLoginModel.token!,
                                );
                              }

                              print("-----------Update------------------");
                              print(updatedLoginModel.status);
                              print(updatedLoginModel.token);
                              print("-----------------------------");

                              Fluttertoast.showToast(
                                msg: "تم تحديث بيانات الطالب بنجاح",
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: sp(16),
                                gravity: ToastGravity.TOP,
                              );

                              // Navigate to home and remove all previous screens
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
