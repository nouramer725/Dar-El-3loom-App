import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_text.dart';

class CustomElevatedButtonWidget extends StatelessWidget {
  String text;
  TextStyle textStyle = AppText.boldText(color: AppColors.buttonColor, fontSize: 22);
  Color colorContainer;
  Color sideColor;
  double sideWidth;
  Function()? onPressed;

  CustomElevatedButtonWidget({
    required this.text,
    this.textStyle = const TextStyle(),
    this.sideColor = AppColors.strokeBottomNavBarColor,
    this.sideWidth = 2,
    required this.colorContainer,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(colorContainer),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: sideColor,
              width: sideWidth,
            )
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }
}
