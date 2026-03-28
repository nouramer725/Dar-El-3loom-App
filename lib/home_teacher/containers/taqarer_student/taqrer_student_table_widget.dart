import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/teacher_login_model.dart';
import '../../../provider/teacher_login_provider.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text.dart';
import '../../../utils/responsive.dart';

class TaqrerStudentTableWidget extends StatelessWidget {
  final Color tableTitleColor;
  final Map<String, dynamic> studentData;

  const TaqrerStudentTableWidget({
    required this.tableTitleColor,
    required this.studentData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final takiimList = studentData['takiim'] as List<dynamic>? ?? [];
    final totals = studentData['totals'] ?? {};
    final teacherProvider = Provider.of<TeacherLoginProvider>(context);
    final Teacher? teacher = teacherProvider.teachers;
    String rawDate = '';
    String? matchedGroup;

    for (var t in takiimList) {
      if ((t['n_mada'] ?? '') == (teacher?.nMada ?? '')) {
        matchedGroup = t['no_group']?.toString();
        break;
      }
    }
    if (takiimList.isNotEmpty) {
      rawDate = takiimList[0]['dates']?.toString() ?? '';
    }

    final teacherSubject = teacher?.nMada ?? '';
    final filteredTakiimList = takiimList
        .where((t) => (t['n_mada'] ?? '') == teacherSubject)
        .toList();

    final totalGrades = filteredTakiimList.fold<double>(
      0,
      (sum, t) => sum + ((t['gadestudent'] ?? 0).toDouble()),
    );

    final totalMax = filteredTakiimList.fold<double>(0, (sum, t) {
      final maxGrade = t['totalmax'];
      return sum + (maxGrade != null ? maxGrade.toDouble() : 0);
    });
    final displayMax = totalMax == 0 ? 100 : totalMax;

    String month = '';

    try {
      if (rawDate.isNotEmpty) {
        DateTime parsedDate = DateTime.parse(rawDate);
        month = parsedDate.month.toString();
      }
    } catch (e) {
      month = '';
    }
    //0003458473
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: h(15),
      children: [
        if (takiimList.isNotEmpty) ...[
          Text(
            "الاسم: ${takiimList[0]['n_talb'] ?? ''}",
            style: AppText.boldText(
              color: AppColors.greyColor,
              fontSize: sp(19),
            ),
          ),
          Text(
            "الصف: ${takiimList[0]['n_saf'] ?? ''}",
            style: AppText.boldText(
              color: AppColors.greyColor,
              fontSize: sp(19),
            ),
          ),
          Text(
            "الكود: ${takiimList[0]['cod_talb'] ?? ''}",
            style: AppText.boldText(
              color: AppColors.greyColor,
              fontSize: sp(19),
            ),
          ),
          if (matchedGroup != null)
            Text(
              "المجموعة: $matchedGroup",
              style: AppText.boldText(
                color: AppColors.greyColor,
                fontSize: sp(19),
              ),
            ),
        ],

        Table(
          columnWidths: const {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(1.5),
            2: FlexColumnWidth(1),
            3: FlexColumnWidth(1),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: tableTitleColor,
                borderRadius: BorderRadius.circular(10),
              ),
              children: const [
                CustomTableCell(text: "المادة", isHeader: true),
                CustomTableCell(text: "التاريخ", isHeader: true),
                CustomTableCell(text: "الدرجة", isHeader: true),
                CustomTableCell(text: "النسبة", isHeader: true),
              ],
            ),
          ],
        ),

        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: filteredTakiimList.length,
          separatorBuilder: (_, __) => SizedBox(height: h(10)),
          itemBuilder: (context, index) {
            final t = filteredTakiimList[index];
            return Table(
              columnWidths: const {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(1.5),
                2: FlexColumnWidth(1),
                3: FlexColumnWidth(1),
              },
              children: [
                TableRow(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: tableTitleColor, width: 2),
                  ),
                  children: [
                    CustomTableCell(text: t['n_mada'] ?? ''),
                    CustomTableCell(text: t['dates'] ?? ''),
                    CustomTableCell(text: t['gadestudent'].toString()),
                    CustomTableCell(text: t['perstangestudent'].toString()),
                  ],
                ),
              ],
            );
          },
        ),

        Table(
          columnWidths: const {0: FlexColumnWidth(11), 1: FlexColumnWidth(5)},
          children: [
            TableRow(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: tableTitleColor, width: 2),
              ),
              children: [
                Cell(text: "درجة الامتحان الشامل لشهر $month", isHeader: true),
                Cell(
                  // text: "$totalGrades/${totals["totalmax"] ?? displayMax}",
                  text: "$totalGrades/$displayMax",
                  isHeader: true,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

///0003962835
class CustomTableCell extends StatelessWidget {
  final String? text;
  final bool isHeader;
  const CustomTableCell({this.text, this.isHeader = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: h(14)),
      child: Center(
        child: Text(
          textAlign: TextAlign.center,
          text ?? '',
          style: isHeader
              ? AppText.boldText(color: AppColors.blackColor, fontSize: sp(18))
              : AppText.mediumText(
                  color: AppColors.blackColor,
                  fontSize: sp(17),
                ),
        ),
      ),
    );
  }
}

class Cell extends StatelessWidget {
  final String text;
  final bool isHeader;
  const Cell({required this.text, this.isHeader = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(h(10)),
      child: Text(
        textAlign: TextAlign.center,
        text,
        style: isHeader
            ? AppText.boldText(color: AppColors.blackColor, fontSize: sp(16))
            : AppText.mediumText(color: AppColors.blackColor, fontSize: sp(15)),
      ),
    );
  }
}
