import 'package:dar_el_3loom/provider/parent_login_provider.dart';
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
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _initData();
  // }

  // Future<void> _initData() async {
  //   final provider = Provider.of<ParentLoginProvider>(context, listen: false);
  //   await provider.fetchChildren();
  //
  //   if (provider.children.isNotEmpty) {
  //     provider.selectedChild = provider.children.first;
  //   }
  //
  //   setState(() {
  //     loading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // if (loading) {
    //   return Scaffold(
    //     body: Center(
    //       child: CircularProgressIndicator(color: AppColors.blackColor),
    //     ),
    //   );
    // }

    return const HomeTeacherView();
  }
}
