import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: AppColors.strokeBottomNavBarColor,
      thickness: 1,
      height: 30,
    );
  }
}
