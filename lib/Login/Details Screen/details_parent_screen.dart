import 'package:dar_el_3loom/Login/Details%20Screen/Controllers/parent_controller.dart';
import 'package:dar_el_3loom/Model/parent_login_model.dart';
import 'package:dar_el_3loom/provider/parent_login_provider.dart';
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
import 'Widgets/widget.dart';

class DetailsParentScreen extends StatefulWidget {
  const DetailsParentScreen({super.key});

  @override
  State<DetailsParentScreen> createState() => _DetailsParentScreenState();
}

class _DetailsParentScreenState extends State<DetailsParentScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final loginProvider = Provider.of<ParentLoginProvider>(
      context,
      listen: false,
    );
    final token = loginProvider.token;
    final parent = loginProvider.loginModel?.data?.parent;

    print("Token from provider: $token");
    print("Parent ID: ${parent?.id}");
  }

  @override
  Widget build(BuildContext context) {
    final parentProvider = Provider.of<ParentLoginProvider>(context);
    final parent = parentProvider.loginModel?.data?.parent;

    if (parent == null) {
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
      create: (_) => ParentController(parent: parent),
      child: Consumer<ParentController>(
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
                          "الرقم القومي",
                          controller.personalId,
                          TextInputType.number,
                          controller.personalIdLocked,
                        ),
                        buildField(
                          "رقم ولي الامر",
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
                                  Provider.of<ParentLoginProvider>(
                                    context,
                                    listen: false,
                                  );

                              final token = loginProvider.token;
                              final parent = loginProvider.loginModel;

                              if (token == null || parent == null) {
                                throw Exception("User not logged in");
                              }

                              final updatedStudent = Parent(
                                id: controller.id.text,
                                name: controller.name.text,
                                tel: controller.phoneParent.text,
                                personalId: controller.personalId.text,
                                password: controller.password.text,
                                profileImage: controller.personalImage?.path,
                                verified: true,
                              );

                              final api = ApiService(token: token);

                              final response = await api.updateParentInfo(
                                updatedStudent,
                              );

                              final oldLogin = loginProvider.loginModel;

                              final updatedLoginModel =
                                  ParentLoginModel.fromJson(response);

                              updatedLoginModel.token ??= oldLogin?.token;

                              updatedLoginModel.data?.parent?.password ??=
                                  oldLogin?.data?.parent?.password;

                              await loginProvider.setLoginParent(
                                updatedLoginModel,
                              );

                              AppFlow.getParentToken();

                              print(updatedLoginModel.token);

                              if (updatedLoginModel.token != null) {
                                await AppFlow.saveParentToken(
                                  updatedLoginModel.token!,
                                );
                              }

                              print("-----------Update------------------");
                              print(updatedLoginModel.status);
                              print(updatedLoginModel.token);
                              print(updatedLoginModel.data);
                              print(updatedLoginModel.data?.parent);
                              print(updatedLoginModel.data?.parent?.id);
                              print(updatedLoginModel.data?.parent?.name);
                              print(updatedLoginModel.data?.parent?.tel);
                              print(updatedLoginModel.data?.parent?.personalId);
                              print(updatedLoginModel.data?.parent?.verified);
                              print(updatedLoginModel.data?.parent?.password);
                              print("-----------------------------");

                              Fluttertoast.showToast(
                                msg: "تم تحديث بيانات الطالب بنجاح",
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                              );

                              // Navigate to home and remove all previous screens
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                AppRoutes.homeParentScreenName,
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
