import 'package:flutter/material.dart';
import '../main.dart';
import '../utils/app_colors.dart';
import '../utils/app_text.dart';
import '../utils/responsive.dart';

void showGlobalNotificationDialog(dynamic data) {
  final context = navigatorKey.currentContext!;
  final studentName = data["student_name"] ?? "طفلك";
  final subject = data["subject"] ?? "";
  final teacherName = data["teacher_name"] ?? "";
  final time = data["created_time"] ?? data["attendance_time"] ?? "";
  final date = data["created_date"] ?? data["attendance_date"] ?? "";

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => AlertDialog(
      backgroundColor: AppColors.whiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        "🎉 إشعار جديد 🎉",
        style: AppText.boldText(
          fontSize: sp(22),
          color: AppColors.backCertificate,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "👦 حضور الطالب: $studentName",
            style: AppText.boldText(
              fontSize: sp(20),
              color: AppColors.blackColor,
            ),
          ),
          if (subject.isNotEmpty)
            Text(
              "📚 مادة: $subject",
              style: AppText.semiBoldText(
                fontSize: sp(18),
                color: AppColors.greyColor,
              ),
            ),
          if (teacherName.isNotEmpty)
            Text(
              "👩‍🏫 مع: $teacherName",
              style: AppText.semiBoldText(
                fontSize: sp(18),
                color: AppColors.greyColor,
              ),
            ),
          if (date.isNotEmpty || time.isNotEmpty)
            Text(
              "📅 بتاريخ: $date\n⏰ الساعة: $time",
              style: AppText.semiBoldText(
                fontSize: sp(18),
                color: AppColors.greyColor,
              ),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(),
          child: Text(
            "حسنا 👍",
            style: AppText.boldText(
              color: AppColors.container1Color,
              fontSize: sp(18),
            ),
          ),
        ),
      ],
    ),
  );
}
