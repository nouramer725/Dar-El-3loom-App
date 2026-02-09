import 'package:dar_el_3loom/Model/mozakrat_model.dart';
import 'package:dar_el_3loom/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../BackendSetup Data/Api/api_service.dart';
import '../../../provider/student_login_provider.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text.dart';
import '../../../utils/responsive.dart';
import 'filter_widget.dart';
import 'table_widget.dart';

class MozakratScreen extends StatefulWidget {
  const MozakratScreen({super.key});

  @override
  State<MozakratScreen> createState() => _MozakratScreenState();
}

class _MozakratScreenState extends State<MozakratScreen> {
  List<Mozakrat> mozakrat = [];
  bool isLoading = true;
  String filter = 'teachers';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final loginProvider = Provider.of<StudentLoginProvider>(
      context,
      listen: false,
    );
    final token = loginProvider.token;

    if (token == null) {
      throw Exception("لم يتم تسجيل الدخول");
    }

    final api = ApiService(token: token);

    setState(() => isLoading = true);
    mozakrat = await api.fetchMozakrat(filter: filter);
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Text(
          "المذكرات",
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w(10), vertical: h(10)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              FilterWidget(
                type: FilterType.dropdown,
                color: AppColors.container3Color,
                items: [
                  DropdownMenuItem(
                    value: 'teachers',
                    child: Text("المواد المسجلة"),
                  ),
                  DropdownMenuItem(value: 'all', child: Text("جميع المواد")),
                ],
                text: "المواد المسجلة",
                onChanged: (value) {
                  filter = value!;
                  fetchData();
                },
              ),
              isLoading
                  ? Column(
                    children: [
                      Image.asset(AppAssets.container3Image),
                      Center(
                        child: CircularProgressIndicator(
                          color: AppColors.container3Color,
                        ),
                      ),
                    ],
                  )
                  : Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: w(10),
                      vertical: h(10),
                    ),
                    child: TableWidget(
                        tableTitleColor: AppColors.container3Color,
                        headers: ["المذكرة", "المدرس", "المادة", "السعر"],
                        lessons: mozakrat,
                      ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
