import 'package:dar_el_3loom/provider/teacher_login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/app_colors.dart';
import 'home_teacher_view.dart';

class HomeTeacherTab extends StatefulWidget {
  const HomeTeacherTab({super.key});

  @override
  State<HomeTeacherTab> createState() => _HomeTeacherTabState();
}

class _HomeTeacherTabState extends State<HomeTeacherTab> {
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    final provider = Provider.of<TeacherLoginProvider>(context, listen: false);
    await provider.teacher;

    if (provider.teacher.isNotEmpty) {
      provider.selectedTeacher = provider.teacher.first;
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: AppColors.blackColor),
        ),
      );
    }

    return const HomeTeacherView();
  }
}
