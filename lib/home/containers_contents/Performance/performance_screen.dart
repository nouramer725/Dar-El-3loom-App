import 'package:dar_el_3loom/home/containers_contents/Performance/table_widget.dart';
import 'package:dar_el_3loom/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Model/performance_model.dart';
import '../../../provider/student_login_provider.dart';
import '../../../provider/parent_login_provider.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text.dart';
import '../../../utils/responsive.dart';
import '../Mozakrat/filter_widget.dart';
import '../../../BackendSetup Data/Api/api_service.dart';

class PerformanceScreen extends StatefulWidget {
  const PerformanceScreen({super.key});

  @override
  State<PerformanceScreen> createState() => _PerformanceScreenState();
}

class _PerformanceScreenState extends State<PerformanceScreen> {
  String? selectedSubject;
  String? selectedTeacher;
  String? selectedMonth;
  bool isLoading = true;

  List<Map<String, dynamic>> subjects = [];
  List<String> teachers = [];
  List<Map<String, dynamic>> availableMonths = [];
  Map<String, dynamic>? scheduleDetails;
  List<SessionModel> fetchedSessions = [];

  final monthNames = [
    "يناير",
    "فبراير",
    "مارس",
    "أبريل",
    "مايو",
    "يونيو",
    "يوليو",
    "أغسطس",
    "سبتمبر",
    "أكتوبر",
    "نوفمبر",
    "ديسمبر",
  ];

  late ApiService apiService;
  String? token;
  String? childId;

  @override
  void initState() {
    super.initState();

    // تحديد مصدر الـ token و childId
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final parentProvider = Provider.of<ParentLoginProvider>(
        context,
        listen: false,
      );
      final studentProvider = Provider.of<StudentLoginProvider>(
        context,
        listen: false,
      );

      token = parentProvider.selectedChild != null
          ? parentProvider.token
          : studentProvider.token;

      childId =
          parentProvider.selectedChild?.codTalb ??
          studentProvider.student?.codTalb;

      apiService = ApiService(token: token);
      fetchSubjects();
    });
  }

  /// Fetch subjects from API
  void fetchSubjects() async {
    setState(() => isLoading = true);

    subjects = await apiService.fetchSubjects(childId: childId);

    setState(() => isLoading = false);
  }

  /// Update teachers based on selected subject
  void updateTeachers() {
    if (selectedSubject != null) {
      final subjectData = subjects.firstWhere(
        (s) => s['subject_name'] == selectedSubject,
      );

      teachers = List<String>.from(
        subjectData['teachers'].map((t) => t['teacher_name']),
      ).toSet().toList();

      if (selectedTeacher != null && !teachers.contains(selectedTeacher)) {
        selectedTeacher = null;
      }
    } else {
      teachers = [];
      selectedTeacher = null;
    }
  }

  /// Update months based on selected subject & teacher
  void updateAvailableMonths() {
    if (selectedSubject != null && selectedTeacher != null) {
      final subjectData = subjects.firstWhere(
        (s) => s['subject_name'] == selectedSubject,
      );

      final teacherData = subjectData['teachers'].firstWhere(
        (t) => t['teacher_name'] == selectedTeacher,
      );

      availableMonths = List<Map<String, dynamic>>.from(
        teacherData['available_months'],
      );
    } else {
      availableMonths = [];
    }
  }

  /// Fetch schedule based on selections
  void fetchSchedule() async {
    if (selectedSubject != null &&
        selectedTeacher != null &&
        selectedMonth != null) {
      final parts = selectedMonth!.split('/').map((e) => e.trim()).toList();
      final month = int.parse(parts[0]);
      final year = int.parse(parts[1]);

      setState(() => isLoading = true);

      final response = await apiService.fetchScheduleDetails(
        subject: selectedSubject!,
        teacher: selectedTeacher!,
        month: month,
        year: year,
        childId: childId,
      );

      final sessionsJson = response!['sessions'] as List<dynamic>;
      final sessionsList = sessionsJson
          .map((s) => SessionModel.fromJson(s as Map<String, dynamic>))
          .toList();

      setState(() {
        isLoading = false;
        scheduleDetails = response;
        fetchedSessions = sessionsList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Text(
          "المستوي الدراسي",
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
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: AppColors.container1Color,
              ),
            )
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: w(10), vertical: h(10)),
              child: SingleChildScrollView(
                child: Column(
                  spacing: h(10),
                  children: [
                    FilterWidget(
                      type: FilterType.dropdown,
                      color: AppColors.container1Color,
                      items: subjects
                          .map<DropdownMenuItem<String>>(
                            (s) => DropdownMenuItem<String>(
                              value: s['subject_name'] as String,
                              child: Text(s['subject_name'] as String),
                            ),
                          )
                          .toList(),
                      text: "المادة",
                      onChanged: (value) {
                        setState(() {
                          selectedSubject = value;
                          selectedTeacher = null;
                          selectedMonth = null;
                          scheduleDetails = null;
                          updateTeachers();
                          availableMonths = [];
                        });
                      },
                    ),
                    FilterWidget(
                      type: FilterType.dropdown,
                      color: AppColors.container1Color,
                      selectedValue: selectedTeacher,
                      items: teachers
                          .map<DropdownMenuItem<String>>(
                            (t) => DropdownMenuItem<String>(
                              value: t,
                              child: Text(t),
                            ),
                          )
                          .toList(),
                      text: "المدرس",
                      onChanged: (value) {
                        setState(() {
                          selectedTeacher = value;
                          selectedMonth = null;
                          scheduleDetails = null;
                          updateAvailableMonths();
                        });
                      },
                    ),
                    if (availableMonths.isNotEmpty)
                      FilterWidget(
                        text: 'الشهر',
                        type: FilterType.dropdown,
                        color: AppColors.container1Color,
                        selectedValue: selectedMonth,
                        items: availableMonths.map<DropdownMenuItem<String>>((
                          m,
                        ) {
                          final month = m['month'] is int
                              ? m['month'] as int
                              : int.parse(m['month'].toString());
                          final year = m['year'] is int
                              ? m['year'] as int
                              : int.parse(m['year'].toString());
                          final monthName = monthNames[month - 1];

                          return DropdownMenuItem<String>(
                            value: '$month/$year',
                            child: Text('$monthName / $year'),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedMonth = value;
                            fetchSchedule();
                          });
                        },
                      ),
                    scheduleDetails != null && fetchedSessions.isNotEmpty
                        ? PerformanceTableWidget(
                            tableTitleColor: AppColors.container1Color,
                            sessions: fetchedSessions,
                          )
                        : Image.asset(AppAssets.container1Image),
                  ],
                ),
              ),
            ),
    );
  }
}
