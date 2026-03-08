import 'package:dar_el_3loom/home/containers_contents/Mozakrat/filter_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../BackendSetup Data/Api/api_service.dart';
import '../../../Model/group_model.dart';
import '../../../provider/assistant_login_provider.dart';
import '../../../socket/socket_service.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text.dart';
import '../../../utils/responsive.dart';
import 'groups_assistant_performance_widget.dart';

class GroupPerformanceScreen extends StatefulWidget {
  const GroupPerformanceScreen({super.key});

  @override
  State<GroupPerformanceScreen> createState() => _GroupPerformanceScreenState();
}

class _GroupPerformanceScreenState extends State<GroupPerformanceScreen> {
  List<String> groups = [];
  String? selectedGroup;

  List<StudentModel> students = [];
  List<bool> attendance = [];
  List<bool> homework = [];

  bool loadingGroups = true;
  bool loadingStudents = false;
  bool hasChanges = false;
  SocketService? socketService;

  @override
  void initState() {
    super.initState();
    loadGroups();

    socketService = SocketService();
    socketService?.connect();
  }

  void printSelectedStudents() {
    for (int i = 0; i < students.length; i++) {
      if (attendance[i] || homework[i]) {
        print(
          "طالب: ${students[i].name}, الكود: ${students[i].code}, حضور: ${attendance[i]}, واجب: ${homework[i]}",
        );
      }
    }
  }

  Future<void> loadGroups() async {
    final assistantProvider = Provider.of<AssistantLoginProvider>(
      context,
      listen: false,
    );

    final api = ApiService(token: assistantProvider.token ?? '');

    final result = await api.fetchAssistantGroups();

    if (!mounted) return;

    setState(() {
      groups = result;
      loadingGroups = false;
    });
  }

  Future<void> loadStudents(String groupNo) async {
    setState(() {
      loadingStudents = true;
      students = [];
      attendance = [];
      homework = [];
    });

    final assistantProvider = Provider.of<AssistantLoginProvider>(
      context,
      listen: false,
    );

    final api = ApiService(token: assistantProvider.token ?? '');

    final group = await api.fetchAssistantGroupDetails(groupNo: groupNo);

    if (!mounted) return;

    setState(() {
      students = group?.students ?? [];
      attendance = List.generate(students.length, (_) => false);
      homework = List.generate(students.length, (_) => false);
      loadingStudents = false;
      hasChanges = false;
    });
  }

  List<Map<String, dynamic>> prepareStudentsData() {
    final validStudents = List.generate(students.length, (i) {
      final code = students[i].code.trim();
      if (code.isEmpty) return null;
      return {
        "cod_talb": code,
        "attended": attendance[i] ? 1 : 0,
        "hw_done": homework[i] ? 1 : 0,
      };
    }).whereType<Map<String, dynamic>>().toList();

    return validStudents;
  }

  bool isSaving = false;

  // Update saveGroupPerformance
  Future<void> saveGroupPerformance() async {
    if (students.isEmpty) return;

    setState(() {
      isSaving = true; // start loading
    });

    final assistantProvider = Provider.of<AssistantLoginProvider>(
      context,
      listen: false,
    );
    final api = ApiService(token: assistantProvider.token ?? '');

    final dataToSend = prepareStudentsData();
    print("DATA TO SEND: $dataToSend");

    try {
      final result = await api.submitGroupPerformance(students: dataToSend);
      print("RESULT: $result");

      if (result['status'] == 'success') {
        setState(() {
          hasChanges = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result['message'] ?? "تم الحفظ")),
        );

        socketService?.socket.emit('group_performance_saved', dataToSend);

        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(result['message'] ?? "حدث خطأ")));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("حدث خطأ: $e")));
    } finally {
      if (!mounted) return;

      setState(() {
        isSaving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Text(
          "حضور المجموعة",
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
        padding: EdgeInsets.symmetric(horizontal: w(16), vertical: h(16)),
        child: loadingGroups
            ? const Center(
                child: CircularProgressIndicator(
                  color: AppColors.container3Color,
                ),
              )
            : Column(
                spacing: h(15),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FilterWidget(
                    text: "المجموعة",
                    type: FilterType.dropdown,
                    color: AppColors.container3Color,
                    selectedValue: selectedGroup,
                    textColor: AppColors.blackColor,
                    items: groups
                        .map(
                          (group) => DropdownMenuItem(
                            value: group,
                            child: Text(group),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectedGroup = value;
                        });
                        loadStudents(value);
                      }
                    },
                  ),

                  if (loadingStudents)
                    const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.container3Color,
                      ),
                    )
                  else if (students.isEmpty)
                    Center(
                      child: Text(
                        "لا يوجد طلاب في هذه المجموعة",
                        style: AppText.mediumText(
                          color: AppColors.blackColor,
                          fontSize: sp(18),
                        ),
                      ),
                    )
                  else
                    Expanded(
                      child: Column(
                        spacing: h(15),
                        children: [
                          Table(
                            columnWidths: const {
                              0: FlexColumnWidth(2),
                              1: FlexColumnWidth(2),
                              2: FlexColumnWidth(1.2),
                              3: FlexColumnWidth(1.4),
                            },
                            children: [
                              TableRow(
                                decoration: BoxDecoration(
                                  color: AppColors.container3Color,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                children: const [
                                  CustomTableCell(
                                    text: "الاسم",
                                    isHeader: true,
                                  ),
                                  CustomTableCell(
                                    text: "الكود",
                                    isHeader: true,
                                  ),
                                  CustomTableCell(
                                    text: "الحضور",
                                    isHeader: true,
                                  ),
                                  CustomTableCell(
                                    text: "الواجب",
                                    isHeader: true,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Expanded(
                            child: ListView.separated(
                              itemCount: students.length,
                              separatorBuilder: (_, __) =>
                                  SizedBox(height: h(20)),
                              itemBuilder: (context, index) {
                                return Table(
                                  columnWidths: const {
                                    0: FlexColumnWidth(2),
                                    1: FlexColumnWidth(2),
                                    2: FlexColumnWidth(1.2),
                                    3: FlexColumnWidth(1.4),
                                  },
                                  children: [
                                    TableRow(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          color: AppColors.container3Color,
                                          width: 2,
                                        ),
                                      ),
                                      children: [
                                        CustomTableCell(
                                          text: students[index].name,
                                        ),
                                        CustomTableCell(
                                          text: students[index].code,
                                        ),

                                        CheckBoxWidget(
                                          value: attendance[index],
                                          onChanged: (val) {
                                            setState(() {
                                              attendance[index] = val;
                                              hasChanges = true;
                                            });
                                          },
                                        ),

                                        CheckBoxWidget(
                                          value: homework[index],
                                          onChanged: (value) {
                                            setState(() {
                                              homework[index] = value;
                                              hasChanges = true;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: hasChanges
          ? SizedBox(
              width: w(200),
              height: h(55),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.container3Color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: isSaving
                    ? null
                    : () {
                        saveGroupPerformance();
                        printSelectedStudents();
                      },
                child: isSaving
                    ? SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: AppColors.container3Color,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        "حفظ",
                        style: AppText.boldText(
                          color: AppColors.blackColor,
                          fontSize: sp(20),
                        ),
                      ),
              ),
            )
          : null,
    );
  }
}
