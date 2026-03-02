import 'package:dar_el_3loom/BackendSetup%20Data/Api/api_service.dart';
import 'package:dar_el_3loom/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../../provider/teacher_login_provider.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text.dart';
import '../../../utils/responsive.dart';
import '../../../widgets/custom_text_form_field_widget.dart';
import 'taqrer_student_table_widget.dart';

class TaqarerTeacherScreen extends StatefulWidget {
  const TaqarerTeacherScreen({super.key});

  @override
  State<TaqarerTeacherScreen> createState() => _TaqarerTeacherScreenState();
}

class _TaqarerTeacherScreenState extends State<TaqarerTeacherScreen> {
  final TextEditingController _codeController = TextEditingController();
  bool isLoading = false;
  Map<String, dynamic>? studentData;

  late ApiService apiService;

  @override
  void initState() {
    super.initState();
    final teacherProvider = Provider.of<TeacherLoginProvider>(
      context,
      listen: false,
    );
    final token = teacherProvider.token ?? '';
    apiService = ApiService(token: token);
  }

  void _onSearch() async {
    final code = _codeController.text.trim();
    if (code.isEmpty) {
      Fluttertoast.showToast(
        msg: "برجاء ادخال الكود",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.wrongIconColor,
        textColor: Colors.white,
      );
      return;
    }

    setState(() {
      isLoading = true;
      studentData = null;
    });

    final data = await apiService.fetchTeacherTakiim(code);

    setState(() {
      studentData = data;
      isLoading = false;
    });

    if (data == null) {
      Fluttertoast.showToast(
        msg: "لا يوجد بيانات لهذا الكود",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.wrongIconColor,
        textColor: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Text(
          "تقرير الطالب",
          style: AppText.boldText(
            color: AppColors.blackColor,
            fontSize: sp(25),
          ),
        ),
        backgroundColor: AppColors.container1Color,
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_forward_ios_sharp, size: h(25)),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w(16), vertical: h(16)),
        child: SingleChildScrollView(
          child: Column(
            spacing: h(15),
            children: [
              CustomTextFormFieldWidget(
                controller: _codeController,
                keyboardType: TextInputType.number,
                hintText: "كود الطالب",
                cursorColor: AppColors.container1Color,
                borderColor: AppColors.container1Color,
                borderWidth: 2,
                onFieldSubmitted: (_) => _onSearch(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _onSearch,
                ),
                hintStyle: AppText.boldText(
                  color: AppColors.blackColor,
                  fontSize: sp(16),
                ),
              ),
              Image.asset(AppAssets.container1Image),
              if (isLoading)
                const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.container1Color,
                  ),
                ),
              if (!isLoading && studentData != null)
                TaqrerStudentTableWidget(
                  tableTitleColor: AppColors.container1Color,
                  studentData: studentData!,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
