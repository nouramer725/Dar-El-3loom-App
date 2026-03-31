import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../backend_setup/Api/api_service.dart';
import '../../../../models/lessons_date_model.dart';
import '../../../../provider/student_login_provider.dart';
import '../../../../provider/parent_login_provider.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/responsive.dart';
import '../../Mozakrat/filter_widget.dart';
import 'lesson_table_widget.dart';

class LessonsDateWidget extends StatefulWidget {
  const LessonsDateWidget({super.key});

  @override
  State<LessonsDateWidget> createState() => _LessonsDateWidgetState();
}

class _LessonsDateWidgetState extends State<LessonsDateWidget> {
  late ApiService apiService;

  List<Map<String, dynamic>> subjects = [];
  List<String> teachers = [];
  List<Map<String, dynamic>> months = [];

  List<LessonScheduleModel> lessons = [];

  String? selectedSubject;
  String? selectedTeacher;
  String? selectedMonth;

  bool isLoading = true;

  String? childId;

  @override
  void initState() {
    super.initState();

    final parentProvider = Provider.of<ParentLoginProvider>(
      context,
      listen: false,
    );
    final studentProvider = Provider.of<StudentLoginProvider>(
      context,
      listen: false,
    );

    String? token;
    if (parentProvider.selectedChild != null) {
      token = parentProvider.token;
      childId = parentProvider.selectedChild!.codTalb;
    } else {
      token = studentProvider.token;
      childId = studentProvider.student?.codTalb;
    }

    apiService = ApiService(token: token);
    fetchFilters();
  }

  Future<void> fetchFilters() async {
    final data = await apiService.fetchLessonsFilters(childId: childId);

    subjects = data.where((s) {
      final name = s['subject_name']?.toString().trim().toLowerCase();
      return name != null && name.isNotEmpty && name != "null";
    }).toList();

    setState(() => isLoading = false);
  }

  void updateTeachers() {
    final subjectData = subjects.firstWhere(
      (e) => e['subject_name'] == selectedSubject,
    );

    teachers = List<String>.from(
      subjectData['teachers'].map((t) => t['teacher_name']),
    );

    selectedTeacher = null;
    months = [];
  }

  void updateMonths() {
    final subjectData = subjects.firstWhere(
      (e) => e['subject_name'] == selectedSubject,
    );

    final teacherData = subjectData['teachers'].firstWhere(
      (t) => t['teacher_name'] == selectedTeacher,
    );

    months = List<Map<String, dynamic>>.from(teacherData['available_months']);
  }

  Future<void> fetchLessons() async {
    if (selectedSubject == null ||
        selectedTeacher == null ||
        selectedMonth == null) {
      return;
    }

    final parts = selectedMonth!.split('/');
    final month = int.parse(parts[0]);
    final year = int.parse(parts[1]);

    setState(() => isLoading = true);

    lessons = await apiService.fetchLessonsDetails(
      subject: selectedSubject!,
      teacher: selectedTeacher!,
      month: month,
      year: year,
      childId: childId,
    );

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(color: AppColors.container2Color),
          )
        : Column(
            spacing: h(10),
            children: [
              /// SUBJECT
              FilterWidget(
                textColor: AppColors.blackColor,
                type: FilterType.dropdown,
                color: AppColors.container2Color,
                selectedValue: selectedSubject,
                text: "المادة",
                items: subjects
                    .where((s) {
                      final name = s['subject_name']
                          ?.toString()
                          .trim()
                          .toLowerCase();
                      return name != null && name.isNotEmpty && name != "null";
                    })
                    .map<DropdownMenuItem<String>>((s) {
                      final name = s['subject_name'].toString();
                      return DropdownMenuItem<String>(
                        value: name,
                        child: Text(name),
                      );
                    })
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedSubject = value;
                    updateTeachers();
                  });
                },
              ),

              /// TEACHER
              FilterWidget(
                textColor: AppColors.blackColor,
                type: FilterType.dropdown,
                color: AppColors.container2Color,
                selectedValue: selectedTeacher,
                text: "المدرس",
                items: teachers.map<DropdownMenuItem<String>>((t) {
                  return DropdownMenuItem<String>(value: t, child: Text(t));
                }).toList(),

                onChanged: (value) {
                  setState(() {
                    selectedTeacher = value;
                    updateMonths();
                  });
                },
              ),

              /// MONTH
              FilterWidget(
                textColor: AppColors.blackColor,
                type: FilterType.dropdown,
                color: AppColors.container2Color,
                selectedValue: selectedMonth,
                text: "الشهر",
                items: months.map<DropdownMenuItem<String>>((m) {
                  return DropdownMenuItem<String>(
                    value: "${m['month']}/${m['year']}",
                    child: Text("${m['month']} / ${m['year']}"),
                  );
                }).toList(),

                onChanged: (value) {
                  setState(() {
                    selectedMonth = value;
                    fetchLessons();
                  });
                },
              ),

              SizedBox(height: h(20)),

              /// TABLE OR EMPTY
              if (lessons.isNotEmpty)
                LessonsTableWidget(
                  tableTitleColor: AppColors.container2Color,
                  lessons: lessons,
                )
              else
                Image.asset(AppAssets.container2Image),
            ],
          );
  }
}
