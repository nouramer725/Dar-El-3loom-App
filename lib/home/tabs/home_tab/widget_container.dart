import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text.dart';
import '../../../utils/responsive.dart';

class WidgetContainer extends StatelessWidget {
  final String text;
  final double verticalPadding;
  final VoidCallback onTap;
  final Color containerColor;

  const WidgetContainer({
    required this.text,
    required this.verticalPadding,
    required this.onTap,
    required this.containerColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: verticalPadding),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: containerColor,
        ),
        child: Text(
          text,
          style: AppText.boldText(color: AppColors.blackColor, fontSize: sp(24)),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
