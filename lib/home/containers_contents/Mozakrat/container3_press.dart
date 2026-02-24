import 'package:dar_el_3loom/Model/mozakrat_model.dart';
import 'package:dar_el_3loom/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../BackendSetup Data/Api/api_service.dart';
import '../../../provider/student_login_provider.dart';
import '../../../provider/parent_login_provider.dart';
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
  String filter = 'subjects';

  late ApiService api;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() => isLoading = true);

    String? token;
    String? childId;

    final parentProvider = Provider.of<ParentLoginProvider>(
      context,
      listen: false,
    );
    final studentProvider = Provider.of<StudentLoginProvider>(
      context,
      listen: false,
    );

    if (parentProvider.selectedChild != null) {
      token = parentProvider.token;
      childId = parentProvider.selectedChild!.codTalb;
    } else {
      token = studentProvider.token;
      childId = null;
    }

    if (token == null) {
      setState(() => isLoading = false);
      throw Exception("لم يتم تسجيل الدخول");
    }

    api = ApiService(token: token);

    try {
      print(
        "Fetching Mozakrat -> Token: $token, ChildId: $childId, Filter: $filter",
      );

      mozakrat = await api.fetchMozakrat(filter: filter, childId: childId);

      setState(() => isLoading = false);
    } catch (e) {
      print("Error fetching mozakrat: $e");

      setState(() {
        mozakrat = [];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ParentLoginProvider>(
      builder: (context, parentProvider, _) {
        final studentProvider = Provider.of<StudentLoginProvider>(
          context,
          listen: false,
        );

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
                  /// 🔹 Filter Dropdown
                  FilterWidget(
                    type: FilterType.dropdown,
                    color: AppColors.container3Color,
                    items: [
                      DropdownMenuItem(
                        value: 'subjects',
                        child: Text("المواد المسجلة"),
                      ),
                      DropdownMenuItem(
                        value: 'all',
                        child: Text("جميع المواد"),
                      ),
                    ],
                    text: "المواد المسجلة",
                    onChanged: (value) {
                      filter = value!;
                      fetchData();
                    },
                  ),

                  /// 🔹 Loading or Table
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
                      : mozakrat.isEmpty
                      ? Center(child: Image.asset(AppAssets.container3Image))
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
      },
    );
  }
}
