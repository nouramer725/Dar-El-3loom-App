import 'package:dar_el_3loom/utils/responsive.dart';
import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text.dart';

class ProfileWidget extends StatelessWidget {
  final String text;
  final Widget icon;
  final Function()? onTap;

  ProfileWidget({
    this.onTap,
    required this.text,
    required this.icon,
    super.key,
  });

  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: AppText.regularText(
                  color: AppColors.blackColor,
                  fontSize: sp(20),
                ),
              ),
              InkWell(onTap: onTap, child: icon),
            ],
          ),
        ],
      ),
    );
  }
}
