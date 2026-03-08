import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_text.dart';
import '../../../utils/responsive.dart';

class CheckBoxWidget extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CheckBoxWidget({
    required this.value,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.2,
      child: Checkbox(
        value: value,
        checkColor: Colors.white,
        fillColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.container3Color;
          }
          return Colors.transparent;
        }),
        side: WidgetStateBorderSide.resolveWith(
          (states) => BorderSide(color: AppColors.container3Color, width: 2),
        ),
        onChanged: (val) => onChanged(val!),
      ),
    );
  }
}

class CustomTableCell extends StatelessWidget {
  final String? text;
  final bool isHeader;
  final Widget? icon;

  const CustomTableCell({
    this.text,
    this.icon,
    this.isHeader = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: h(14)),
      child: Center(
        child:
            icon ??
            Text(
              textAlign: TextAlign.center,
              text ?? '',
              style: isHeader
                  ? AppText.boldText(
                      color: AppColors.blackColor,
                      fontSize: sp(18),
                    )
                  : AppText.mediumText(
                      color: AppColors.blackColor,
                      fontSize: sp(17),
                    ),
            ),
      ),
    );
  }
}
