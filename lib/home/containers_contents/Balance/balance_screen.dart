import 'package:dar_el_3loom/Model/balance_model.dart';
import 'package:dar_el_3loom/home/containers_contents/Balance/table_widget_balance.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../BackendSetup Data/Api/api_service.dart';
import '../../../provider/student_login_provider.dart';
import '../../../provider/parent_login_provider.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text.dart';
import '../../../utils/responsive.dart';
import '../Mozakrat/filter_widget.dart';

class BalanceScreen extends StatefulWidget {
  const BalanceScreen({super.key});

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  List<Map<String, dynamic>> filtersData = [];
  List<String> teachers = [];
  List<BalanceModel> balances = [];

  String? selectedSubject;
  String? selectedTeacher;
  String? selectedStatus;

  bool isLoading = true;

  late ApiService apiService;

  @override
  void initState() {
    super.initState();
    fetchFilters();
  }

  Future<void> fetchFilters() async {
    setState(() => isLoading = true);

    try {
      final parentProvider = Provider.of<ParentLoginProvider>(
        context,
        listen: false,
      );
      final studentProvider = Provider.of<StudentLoginProvider>(
        context,
        listen: false,
      );

      String? token = parentProvider.selectedChild != null
          ? parentProvider.token
          : studentProvider.token;

      if (token == null) {
        print("Token is null");
        filtersData = [];
      } else {
        apiService = ApiService(token: token);
        String? childId;
        if (parentProvider.selectedChild != null) {
          childId = parentProvider.selectedChild!.codTalb;
        }

        filtersData = await apiService.fetchBalanceFilters(childId: childId);
      }
    } catch (e) {
      print("Error fetching filters: $e");
      filtersData = [];
    }

    setState(() => isLoading = false);
  }

  void updateTeachers() {
    teachers = filtersData
        .where((e) => e['n_mada'] == selectedSubject)
        .map((e) => e['n_mod'].toString())
        .toSet()
        .toList();
  }

  Future<void> fetchBalances() async {
    setState(() => isLoading = true);

    final parentProvider = Provider.of<ParentLoginProvider>(
      context,
      listen: false,
    );

    String? childId;
    if (parentProvider.selectedChild != null) {
      childId = parentProvider.selectedChild!.codTalb;
    }

    balances = await apiService.fetchBalanceDetails(
      subject: selectedSubject,
      teacher: selectedTeacher,
      status: selectedStatus,
      childId: childId,
    );

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ParentLoginProvider, StudentLoginProvider>(
      builder: (context, parentProvider, studentProvider, _) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            automaticallyImplyLeading: false,
            title: Text(
              "المدفوعات",
              style: AppText.boldText(
                color: AppColors.blackColor,
                fontSize: sp(25),
              ),
            ),
            backgroundColor: AppColors.container4Color,
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
                    color: AppColors.container4Color,
                  ),
                )
              : Padding(
                  padding: EdgeInsets.all(w(10)),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        /// Subject
                        FilterWidget(
                          type: FilterType.dropdown,
                          color: AppColors.container4Color,
                          selectedValue: selectedSubject,
                          text: "المادة",
                          items: filtersData
                              .map<DropdownMenuItem<String>>(
                                (e) => DropdownMenuItem<String>(
                                  value: e['n_mada'] as String,
                                  child: Text(e['n_mada'] as String),
                                ),
                              )
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              selectedSubject = val;
                              selectedTeacher = null;
                              updateTeachers();
                            });
                          },
                        ),

                        /// Teacher
                        FilterWidget(
                          type: FilterType.dropdown,
                          color: AppColors.container4Color,
                          selectedValue: selectedTeacher,
                          text: "المدرس",
                          items: teachers
                              .map<DropdownMenuItem<String>>(
                                (t) => DropdownMenuItem<String>(
                                  value: t,
                                  child: Text(t),
                                ),
                              )
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              selectedTeacher = val;
                            });
                          },
                        ),

                        /// Status
                        FilterWidget(
                          type: FilterType.dropdown,
                          color: AppColors.container4Color,
                          selectedValue: selectedStatus,
                          text: "حالة الدفع",
                          items: const [
                            DropdownMenuItem(
                              value: "done",
                              child: Text("المدفوع"),
                            ),
                            DropdownMenuItem(
                              value: "not_completed",
                              child: Text("غير المدفوع"),
                            ),
                          ],
                          onChanged: (val) {
                            setState(() {
                              selectedStatus = val;
                              fetchBalances();
                            });
                          },
                        ),

                        SizedBox(height: h(20)),

                        if (balances.isNotEmpty)
                          BalanceTableWidget(
                            tableTitleColor: AppColors.container4Color,
                            balances: balances,
                          )
                        else
                          Image.asset(AppAssets.container4Image),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
