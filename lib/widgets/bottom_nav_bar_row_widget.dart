import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_text.dart';
import '../../../utils/responsive.dart';

class BottomNavBarRowWidget extends StatelessWidget {
  Color tableTitleColor;

  BottomNavBarRowWidget({required this.tableTitleColor, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w(20), vertical: h(30)),
      child: Row(
        children: [
          IconButton(
            alignment: Alignment.center,
            style: ButtonStyle(
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              backgroundColor: WidgetStateProperty.all(
                AppColors.lightGreyColor,
              ),
            ),
            onPressed: () {},
            icon: Icon(Icons.arrow_back_ios_sharp, size: h(20)),
          ),
          IconButton(
            alignment: Alignment.center,
            style: ButtonStyle(
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              backgroundColor: WidgetStateProperty.all(
                tableTitleColor,
              ),
            ),
            onPressed: () {},
            icon: Icon(Icons.arrow_forward_ios_rounded, size: h(20)),
          ),
          SizedBox(width: w(7)),
          Text(
            "1 من 4",
            style: AppText.regularText(
              color: AppColors.blackColor,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
