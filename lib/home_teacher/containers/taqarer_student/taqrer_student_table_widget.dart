import 'package:flutter/material.dart';
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
          Text(
            "المجموعة: ${takiimList[0]['no_group'] ?? ''}",
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
          itemCount: takiimList.length,
          separatorBuilder: (_, __) => SizedBox(height: h(10)),
          itemBuilder: (context, index) {
            final t = takiimList[index];
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
          columnWidths: const {0: FlexColumnWidth(5), 1: FlexColumnWidth(4)},
          children: [
            TableRow(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: tableTitleColor, width: 2),
              ),
              children: [
                const Cell(text: "إجمالي الدرجة:", isHeader: true),
                Cell(
                  text:
                      "${totals['totalgrades'] ?? 0}/${totals['totalmax'] ?? 0}",
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
        text,
        style: isHeader
            ? AppText.boldText(color: AppColors.blackColor, fontSize: sp(16))
            : AppText.mediumText(color: AppColors.blackColor, fontSize: sp(15)),
      ),
    );
  }
}
