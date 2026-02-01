import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_text.dart';
import '../../../utils/responsive.dart';

class TableCellTitle extends StatelessWidget {
  final String text;

  const TableCellTitle({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: h(14)),
      child: Center(
        child: Text(
          text,
          style: AppText.regularText(color: AppColors.blackColor, fontSize: sp(15)),
        ),
      ),
    );
  }
}
