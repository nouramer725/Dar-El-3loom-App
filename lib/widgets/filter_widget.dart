import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text.dart';
import '../../../utils/responsive.dart';

class FilterWidget extends StatelessWidget {
  final String? selectedItem;
  final String text;
  final Function(String?)? onChanged;
  final List<DropdownMenuItem<String>> items;
  Color color;


  FilterWidget({
    required this.items,
    required this.onChanged,
    required this.selectedItem,
    required this.text,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: w(10)),
      margin: EdgeInsets.symmetric(vertical: h(5)),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.transparentColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color, width: 2),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.25),
            spreadRadius: 0,
            blurRadius: 8,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: AppText.mediumText(
              color: AppColors.blackColor,
              fontSize: 18,
            ),
          ),
          Text(
            selectedItem ?? "",
            style: AppText.mediumText(
              color: AppColors.blackColor,
              fontSize: 18,
            ),
          ),
          DropdownButton<String>(
            value: null,
            underline: SizedBox(),
            icon: Icon(
              Icons.keyboard_arrow_down_sharp,
              color: AppColors.blackColor,
              size: h(30),
            ),
            items: items,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
