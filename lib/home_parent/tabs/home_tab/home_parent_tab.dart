import 'package:dar_el_3loom/provider/parent_login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/app_colors.dart';
import 'home_parent_view.dart';

class HomeParentTab extends StatefulWidget {
  const HomeParentTab({super.key});

  @override
  State<HomeParentTab> createState() => _HomeParentTabState();
}

class _HomeParentTabState extends State<HomeParentTab> {
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    final provider = Provider.of<ParentLoginProvider>(context, listen: false);
    await provider.fetchChildren();

    if (provider.children.isNotEmpty) {
      provider.selectedChild = provider.children.first;
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

    return const HomeParentView();
  }
}
