import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../../../../utils/responsive.dart';
import '../../../BackendSetup Data/Api/api_service.dart';
import '../../../provider/assistant_login_provider.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text.dart';
import '../../../widgets/custom_elevated_button_widget.dart';
import '../../../widgets/custom_text_form_field_widget.dart';

class StudentPerformanceWidget extends StatefulWidget {
  final Map<String, dynamic> studentData;

  StudentPerformanceWidget({super.key, required this.studentData});

  @override
  State<StudentPerformanceWidget> createState() =>
      _StudentPerformanceWidgetState();
}

class _StudentPerformanceWidgetState extends State<StudentPerformanceWidget> {
  bool isHomeWorkChecked = true;
  final TextEditingController examController = TextEditingController();
  final TextEditingController maxGradeController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  late Map<String, dynamic> student;
  late TextEditingController codeController;

  @override
  void initState() {
    super.initState();
    student = widget.studentData['data']['student'];
    codeController = TextEditingController(text: student['cod_talb']);
  }

  @override
  Widget build(BuildContext context) {
    student = widget.studentData['data']['student'];

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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w(16), vertical: h(30)),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: h(10),
              children: [
                CustomTextFormFieldWidget(
                  controller: codeController,
                  readOnly: true,
                  keyboardType: TextInputType.number,
                  cursorColor: AppColors.container2Color,
                  borderColor: AppColors.container2Color,
                  borderWidth: 2,
                  hintStyle: AppText.boldText(
                    color: AppColors.greyColor,
                    fontSize: sp(16),
                  ),
                ),
                SizedBox(height: h(60)),
                Text(
                  "الاسم : ${widget.studentData['data']['student']['n_talb'] ?? ''}",
                  style: AppText.boldText(
                    color: AppColors.greyColor,
                    fontSize: sp(19),
                  ),
                ),
                Text(
                  "الصف : ${widget.studentData['data']['student']['n_saf'] ?? ''}",
                  style: AppText.boldText(
                    color: AppColors.greyColor,
                    fontSize: sp(19),
                  ),
                ),
                SizedBox(height: h(30)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "الواجب",
                      style: AppText.boldText(
                        color: AppColors.greyColor,
                        fontSize: sp(25),
                      ),
                    ),
                    Checkbox(
                      value: isHomeWorkChecked,
                      fillColor: WidgetStateProperty.all(
                        AppColors.container2Color,
                      ),
                      activeColor: AppColors.container2Color,
                      checkColor: AppColors.whiteColor,
                      focusColor: AppColors.container2Color,
                      hoverColor: AppColors.container2Color,
                      side: BorderSide(
                        color: AppColors.container2Color,
                        width: 2,
                      ),
                      onChanged: (value) {
                        isHomeWorkChecked = value!;
                        setState(() {});
                      },
                    ),
                  ],
                ),
                CustomTextFormFieldWidget(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "الرجاء إدخال درجة الامتحان";
                    }
                    final numValue = num.tryParse(value);
                    if (numValue == null) {
                      return "الرجاء إدخال رقم صالح";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  controller: examController,
                  cursorColor: AppColors.container2Color,
                  borderColor: AppColors.container2Color,
                  borderWidth: 2,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: AppColors.container2Color,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: AppColors.container2Color,
                      width: 2,
                    ),
                  ),
                  hintStyle: AppText.boldText(
                    color: AppColors.greyColor,
                    fontSize: sp(18),
                  ),
                  hintText: "درجة الامتحان",
                ),
                CustomTextFormFieldWidget(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "الرجاء إدخال الدرجة القصوى";
                    }
                    final numValue = int.tryParse(value);
                    if (numValue == null) {
                      return "الرجاء إدخال رقم صحيح";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  controller: maxGradeController,
                  cursorColor: AppColors.container2Color,
                  borderColor: AppColors.container2Color,
                  borderWidth: 2,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: AppColors.container2Color,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: AppColors.container2Color,
                      width: 2,
                    ),
                  ),
                  hintStyle: AppText.boldText(
                    color: AppColors.greyColor,
                    fontSize: sp(18),
                  ),
                  hintText: "الدرجة القصوي",
                ),
                Center(
                  child: CustomElevatedButtonWidget(
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
                        Fluttertoast.showToast(
                          msg: "قم ب ادخال الدرجات",
                          backgroundColor: AppColors.blackColor,
                          textColor: AppColors.whiteColor,
                          fontSize: sp(16),
                          gravity: ToastGravity.TOP,
                        );
                        return;
                      }

                      String hwScore = isHomeWorkChecked ? "1" : "0";

                      final assistantProvider =
                          Provider.of<AssistantLoginProvider>(
                            context,
                            listen: false,
                          );
                      final token = assistantProvider.token;

                      if (token == null) throw Exception("لم يتم تسجيل الدخول");

                      final api = ApiService(token: token);

                      final result = await api.addStudentPerformance(
                        studentCode: student['cod_talb'],
                        hwScore: hwScore,
                        examScore: examController.text,
                        maxGrade: int.parse(maxGradeController.text),
                      );
                      Fluttertoast.showToast(
                        msg: "تم تسجيل حضور الطالب بنجاح",
                        backgroundColor: Colors.green,
                        textColor: AppColors.whiteColor,
                        fontSize: sp(16),
                        gravity: ToastGravity.TOP,
                      );
                      Navigator.pop(context);
                      Navigator.pop(context);

                      print(result);
                    },
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
