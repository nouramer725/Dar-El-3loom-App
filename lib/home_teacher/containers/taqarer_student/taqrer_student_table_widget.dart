import 'package:flutter/material.dart';
import '../../../../../utils/responsive.dart';
import '../../../Model/balance_model.dart';
import '../../../home/containers_contents/Certificates/taqarer_table_widget.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text.dart';

class TaqrerStudentTableWidget extends StatelessWidget {
  final Color tableTitleColor;
  // final List<BalanceModel> balances;

  const TaqrerStudentTableWidget({
    required this.tableTitleColor,
    // required this.balances,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: h(15),
      children: [
        Text(
          "الاسم : احمد محمد",
          style: AppText.boldText(color: AppColors.greyColor, fontSize: sp(19)),
        ),
        Text(
          "الصف : الاول الثانوي",
          style: AppText.boldText(color: AppColors.greyColor, fontSize: sp(19)),
        ),
        Text(
          "الكود : 1001",
          style: AppText.boldText(color: AppColors.greyColor, fontSize: sp(19)),
        ),
        Text(
          "المجموعة: 44",
          style: AppText.boldText(color: AppColors.greyColor, fontSize: sp(19)),
        ),
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
                CustomTableCell(text: "الحصة", isHeader: true),
                CustomTableCell(text: "التاريخ", isHeader: true),
                CustomTableCell(text: "الساعه", isHeader: true),
                CustomTableCell(text: "الواجب", isHeader: true),
              ],
            ),
          ],
        ),

        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
          separatorBuilder: (_, __) => SizedBox(height: h(15)),
          itemBuilder: (context, index) {
            // final b = balances[index];

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
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: tableTitleColor, width: 2),
                  ),
                  children: [
                    CustomTableCell(text: "الحصة"),
                    CustomTableCell(text: "التاريخ"),
                    CustomTableCell(text: "الساعه"),
                    CustomTableCell(text: "الواجب"),
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
                const Cell(
                  text: "درجة الامتحان الشامل لشهر 9:",
                  isHeader: true,
                ),
                Cell(text: "65/100", isHeader: true),
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
