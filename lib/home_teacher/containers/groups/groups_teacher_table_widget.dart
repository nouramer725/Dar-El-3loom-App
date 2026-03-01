import 'package:flutter/material.dart';
import '../../../../../utils/responsive.dart';
import '../../../Model/group_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text.dart';

class GroupsTeacherTableWidget extends StatelessWidget {
  final Color tableTitleColor;
  final GroupModel group;

  const GroupsTeacherTableWidget({
    required this.tableTitleColor,
    required this.group,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: h(15),
      children: [
        Text(
          "الصف : ${group.className}",
          style: AppText.boldText(color: AppColors.greyColor, fontSize: sp(19)),
        ),
        Text(
          "اليوم : ${group.day}",
          style: AppText.boldText(color: AppColors.greyColor, fontSize: sp(19)),
        ),
        Text(
          "المعاد : ${group.time}",
          style: AppText.boldText(color: AppColors.greyColor, fontSize: sp(19)),
        ),
        Text(
          "عدد الطلاب : ${group.totalStudents}",
          style: AppText.boldText(color: AppColors.greyColor, fontSize: sp(19)),
        ),
        Table(
          columnWidths: const {0: FlexColumnWidth(5), 1: FlexColumnWidth(10)},
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: tableTitleColor,
                borderRadius: BorderRadius.circular(10),
              ),
              children: const [
                CustomTableCell(text: "الكود", isHeader: true),
                CustomTableCell(text: "الطالب", isHeader: true),
              ],
            ),
          ],
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: group.students.length,
          separatorBuilder: (_, __) => SizedBox(height: h(15)),
          itemBuilder: (context, index) {
            final student = group.students[index];
            return Table(
              columnWidths: const {
                0: FlexColumnWidth(5),
                1: FlexColumnWidth(10),
              },
              children: [
                TableRow(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: tableTitleColor, width: 2),
                  ),
                  children: [
                    CustomTableCell(text: student.code),
                    CustomTableCell(text: student.name),
                  ],
                ),
              ],
            );
          },
        ),
      ],
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
