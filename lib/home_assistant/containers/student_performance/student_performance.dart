import 'package:dar_el_3loom/home_assistant/containers/student_performance/student_performance_table_widget.dart';
import 'package:dar_el_3loom/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../BackendSetup Data/Api/api_service.dart';
import '../../../home/containers_contents/Mozakrat/filter_widget.dart';
import '../../../provider/assistant_login_provider.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text.dart';
import '../../../utils/responsive.dart';
import '../../../widgets/custom_elevated_button_widget.dart';
import '../../../widgets/custom_text_form_field_widget.dart';

class StudentPerformance extends StatefulWidget {
  StudentPerformance({super.key});

  @override
  State<StudentPerformance> createState() => _StudentPerformanceState();
}

class _StudentPerformanceState extends State<StudentPerformance> {
  final TextEditingController codeController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Text(
          "تسجيل اداء الطالب",
          style: AppText.boldText(
            color: AppColors.blackColor,
            fontSize: sp(25),
          ),
        ),
        backgroundColor: AppColors.container2Color,
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_forward_ios_sharp, size: h(25)),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w(16), vertical: h(16)),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                spacing: h(30),
                children: [
                  CustomTextFormFieldWidget(
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "الرجاء إدخال كود الطالب";
                      }
                      return null;
                    },
                    controller: codeController,
                    keyboardType: TextInputType.number,
                    hintText: "كود الطالب",
                    cursorColor: AppColors.container2Color,
                    borderColor: AppColors.container2Color,
                    borderWidth: 2,
                    hintStyle: AppText.boldText(
                      color: AppColors.greyColor,
                      fontSize: sp(16),
                    ),
                  ),
                  CustomElevatedButtonWidget(
                    text: "ارسال",
                    textStyle: AppText.boldText(
                      color: AppColors.blackColor,
                      fontSize: sp(14),
                    ),
                    padding: WidgetStateProperty.all(
                      EdgeInsets.symmetric(horizontal: w(40)),
                    ),
                    colorContainer: AppColors.container2Color,
                    sideColor: AppColors.container2Color,
                    onPressed: () async {
                      if (!formKey.currentState!.validate()) {
                        return;
                      } else {
                        final enteredCode = codeController.text.trim();

                        if (enteredCode.isEmpty) return;

                        final assistantProvider =
                        Provider.of<AssistantLoginProvider>(
                          context,
                          listen: false,
                        );

                        final api = ApiService(
                          token: assistantProvider.token ?? '',
                        );

                        final data = await api.getStudentInfo(enteredCode);

                        print(data);
                        if (data != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  StudentPerformanceWidget(studentData: data),
                            ),
                          );
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
