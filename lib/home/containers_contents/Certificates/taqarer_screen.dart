import 'package:dar_el_3loom/home/containers_contents/Certificates/taqarer_table_widget.dart';
import 'package:dar_el_3loom/utils/app_assets.dart';
import 'package:dar_el_3loom/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../BackendSetup Data/Api/api_service.dart';
import '../../../Model/takim_model.dart';
import '../../../provider/student_login_provider.dart';
import '../../../utils/app_text.dart';
import '../../../utils/responsive.dart';

class TaqreerScreen extends StatefulWidget {
  const TaqreerScreen({super.key});

  @override
  State<TaqreerScreen> createState() => _TaqreerScreenState();
}

class _TaqreerScreenState extends State<TaqreerScreen> {
  late ApiService apiService;

  List<TakiimModel> takiimList = [];
  int totalGrades = 0;
  int totalMax = 0;
  int totalPercentage = 0;

  bool isLoading = false;
  int? selectedMonth;

  @override
  void initState() {
    super.initState();

    final loginProvider = Provider.of<StudentLoginProvider>(
      context,
      listen: false,
    );

    apiService = ApiService(token: loginProvider.token);
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() => isLoading = true);

    final response = await apiService.fetchTakiim(month: selectedMonth ?? 0);

    if (response != null) {
      setState(() {
        takiimList = response["takiim"] ?? [];

        final totals = response["totals"] ?? {};

        totalGrades = totals["totalgrades"] ?? 0;
        totalMax = totals["totalmax"] ?? 0;
        totalPercentage = totals["totalperstange"] ?? 0;

        isLoading = false;
      });
    } else {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    var loginProvider = Provider.of<StudentLoginProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Text(
          "التقرير",
          style: AppText.boldText(
            color: AppColors.blackColor,
            fontSize: sp(25),
          ),
        ),
        backgroundColor: AppColors.container5Color,
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_forward_ios_sharp, size: h(25)),
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: AppColors.container5Color,
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(w(10)),
                child: Column(
                  spacing: h(25),
                  children: [
                    /// 🔹 Month Dropdown
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: w(10)),
                      margin: EdgeInsets.symmetric(vertical: h(5)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.container5Color,
                          width: 2,
                        ),
                      ),
                      child: DropdownButtonFormField<int>(
                        dropdownColor: Theme.of(
                          context,
                        ).scaffoldBackgroundColor,
                        icon: Icon(Icons.arrow_drop_down),
                        value: selectedMonth,
                        hint: Text(
                          "اختر الشهر",
                          style: AppText.boldText(
                            fontSize: sp(18),
                            color: AppColors.blackColor,
                          ),
                        ),
                        items: List.generate(
                          12,
                          (index) => DropdownMenuItem(
                            value: index + 1,
                            child: Text("شهر ${index + 1}"),
                          ),
                        ),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => selectedMonth = value);
                            fetchData();
                          }
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),

                    isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: AppColors.container5Color,
                            ),
                          )
                        : takiimList.isEmpty
                        ? Center(child: Image.asset(AppAssets.container5Image))
                        : SingleChildScrollView(
                            child: TaqarerTableWidget(
                              selectedMonth: selectedMonth.toString(),
                              studentName: loginProvider.student?.nTalb ?? "",
                              tableTitleColor: AppColors.container5Color,
                              records: takiimList,
                              totals: {
                                "totalgrades": totalGrades,
                                "totalmax": totalMax,
                                "totalperstange": totalPercentage,
                              },
                            ),
                          ),
                  ],
                ),
              ),
            ),
    );
  }
}
