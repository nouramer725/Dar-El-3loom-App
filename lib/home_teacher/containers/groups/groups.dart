import 'package:dar_el_3loom/provider/teacher_login_provider.dart';
import 'package:dar_el_3loom/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Model/group_model.dart';
import '../../../home/containers_contents/Mozakrat/filter_widget.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text.dart';
import '../../../utils/responsive.dart';
import 'groups_teacher_table_widget.dart';
import '../../../BackendSetup Data/Api/api_service.dart';

class GroupsScreen extends StatefulWidget {
  const GroupsScreen({super.key});

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  late ApiService api;
  List<String> groups = [];
  String? selectedGroup;
  GroupModel? selectedGroupModel;
  bool loadingGroups = true;
  bool loadingStudents = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final teacherProvider = Provider.of<TeacherLoginProvider>(
        context,
        listen: false,
      );
      final token = teacherProvider.token ?? '';
      api = ApiService(token: token);

      fetchGroups();
    });
  }

  Future<void> fetchGroups() async {
    setState(() => loadingGroups = true);
    groups = ['رقم المجموعة', ...await api.fetchTeacherGroups()];
    selectedGroup = groups[0];

    if (groups.isNotEmpty && selectedGroup != 'رقم المجموعة') {
      await fetchStudents(selectedGroup!);
    }

    setState(() => loadingGroups = false);
  }

  Future<void> fetchStudents(String groupNo) async {
    setState(() => loadingStudents = true);
    selectedGroupModel = await api.fetchGroupDetailsAsGroup(groupNo: groupNo);
    setState(() => loadingStudents = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Text(
          "المجاميع",
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w(16), vertical: h(16)),
        child: SingleChildScrollView(
          child: Column(
            spacing: h(30),
            children: [
              FilterWidget(
                text: "رقم المجموعة",
                type: FilterType.dropdown,
                color: AppColors.container2Color,
                selectedValue: selectedGroup,
                items: groups
                    .map(
                      (g) => DropdownMenuItem(
                        value: g,
                        child: Text(
                          g,
                          style: AppText.mediumText(
                            color: AppColors.blackColor,
                            fontSize: sp(20),
                          ),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null && value != 'رقم المجموعة') {
                    setState(() {
                      selectedGroup = value;
                      selectedGroupModel = null;
                    });
                    fetchStudents(value);
                  } else {
                    setState(() => selectedGroupModel = null);
                  }
                },
              ),
              if (loadingGroups || loadingStudents)
                Center(child: CircularProgressIndicator(
                  color: AppColors.container2Color,
                ))
              else if (selectedGroupModel == null ||
                  selectedGroupModel!.students.isEmpty)
                Image.asset(AppAssets.container2Image)
              else
                GroupsTeacherTableWidget(
                  tableTitleColor: AppColors.container2Color,
                  group: selectedGroupModel!,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
