import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_text.dart';
import '../../../utils/responsive.dart';

class CustomTableCell extends StatelessWidget {
  Color color = AppColors.blackColor;
  bool isIcon;
  String? text;
  IconData? icon;
  CustomTableCell({
    required this.isIcon,
    this.text,
    this.icon,
    super.key,
    this.color = AppColors.blackColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: h(12)),
      child: Center(
        child:
            isIcon
                ? Icon(icon, color: color)
                : Text(
                  text ?? '',
                  style: AppText.regularText(
                    color: AppColors.blackColor,
                    fontSize: h(15),
                  ),
                ),
      ),
    );
  }
}
