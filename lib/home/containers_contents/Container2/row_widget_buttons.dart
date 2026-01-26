import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text.dart';
import '../../../utils/responsive.dart';

class RowWidgetButtons extends StatelessWidget {
  bool isSelected;
  final Function(bool) onChange;
  RowWidgetButtons({
    required this.isSelected,
    required this.onChange,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: w(10),
      children: [
        Expanded(
          child: ElevatedButton(
            style: ButtonStyle(
              padding: WidgetStateProperty.all(
                EdgeInsets.symmetric(vertical: h(5)),
              ),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              backgroundColor: WidgetStateProperty.all(
                isSelected
                    ? AppColors.container2Color
                    : AppColors.lightGreyColor,
              ),
            ),
            onPressed: () => onChange(true),
            child: Text(
              "مواعيد الطالب",
              style: AppText.mediumText(
                color: AppColors.blackColor,
                fontSize: 16,
              ),
            ),
          ),
        ),
        Expanded(
          child: ElevatedButton(
            style: ButtonStyle(
              padding: WidgetStateProperty.all(
                EdgeInsets.symmetric(vertical: h(5)),
              ),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              backgroundColor: WidgetStateProperty.all(
                isSelected
                    ? AppColors.lightGreyColor
                    : AppColors.container2Color,
              ),
            ),
            onPressed: () => onChange(false),
            child: Text(
              "مواعيد الحصص",
              style: AppText.mediumText(
                color: AppColors.blackColor,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
