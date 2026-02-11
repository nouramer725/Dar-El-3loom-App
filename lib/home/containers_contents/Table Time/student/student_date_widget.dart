import 'package:dar_el_3loom/home/containers_contents/Table%20Time/student/student_table_time_table_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../BackendSetup Data/Api/api_service.dart';
import '../../../../Model/student_time_model.dart';
import '../../../../provider/student_login_provider.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/responsive.dart';
import '../../Mozakrat/filter_widget.dart';

class StudentDateWidget extends StatefulWidget {
  const StudentDateWidget({super.key});

  @override
  State<StudentDateWidget> createState() => _StudentDateWidgetState();
}

class _StudentDateWidgetState extends State<StudentDateWidget> {
  List<String> subjects = [];
  List<StudentDateModel> sessions = [];

  String? selectedType;
  String? selectedSubject;

  bool isLoading = true;

  late ApiService apiService;

  @override
  void initState() {
    super.initState();

    final login = Provider.of<StudentLoginProvider>(context, listen: false);
    apiService = ApiService(token: login.token);

    fetchSubjects();
  }

  Future<void> fetchSubjects() async {
    subjects = await apiService.fetchScheduleSubjects();
    setState(() => isLoading = false);
  }

  Future<void> fetchDetails() async {
    if (selectedSubject == null || selectedType == null) return;

    setState(() => isLoading = true);

    sessions = await apiService.fetchScheduleDatesDetails(
      subject: selectedSubject!,
      type: selectedType!,
    );

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: h(10),
        children: [
          /// المادة
          FilterWidget(
            type: FilterType.dropdown,
            color: AppColors.container2Color,
            selectedValue: selectedSubject,
            text: "المادة",
            items: subjects
                .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                .toList(),
            onChanged: (v) {
              setState(() {
                selectedSubject = v;
              });
              fetchDetails();
            },
          ),

          /// التاريخ
          FilterWidget(
            type: FilterType.dropdown,
            color: AppColors.container2Color,
            selectedValue: selectedType,
            text: "التاريخ",
            items: const [
              DropdownMenuItem(value: "today", child: Text("اليوم")),
              DropdownMenuItem(value: "future", child: Text("القادم")),
            ],
            onChanged: (v) {
              setState(() {
                selectedType = v;
              });
              fetchDetails();
            },
          ),

          if (sessions.isNotEmpty)
            StudentDatesTableWidget(
              tableTitleColor: AppColors.container2Color,
              sessions: sessions,
            )
          else
            Image.asset(AppAssets.container2Image),
        ],
      ),
    );
  }
}
