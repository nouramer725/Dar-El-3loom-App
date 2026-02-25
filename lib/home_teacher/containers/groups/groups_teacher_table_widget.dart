import 'package:flutter/material.dart';
import '../../../../../utils/responsive.dart';
import '../../../Model/balance_model.dart';
import '../../../home/containers_contents/Certificates/taqarer_table_widget.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text.dart';

class GroupsTeacherTableWidget extends StatelessWidget {
  final Color tableTitleColor;
  // final List<BalanceModel> balances;

  const GroupsTeacherTableWidget({
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
          "الصف : الثاني الثانوي",
          style: AppText.boldText(color: AppColors.greyColor, fontSize: sp(19)),
        ),
        Text(
          "اليوم : الاربع",
          style: AppText.boldText(color: AppColors.greyColor, fontSize: sp(19)),
        ),
        Text(
          "المعاد : 6:00",
          style: AppText.boldText(color: AppColors.greyColor, fontSize: sp(19)),
        ),
        Text(
          "عدد الطلاب : 115",
          style: AppText.boldText(color: AppColors.greyColor, fontSize: sp(19)),
        ),
        Table(
          columnWidths: const {0: FlexColumnWidth(2), 1: FlexColumnWidth(10)},
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
          itemCount: 5,
          separatorBuilder: (_, __) => SizedBox(height: h(15)),
          itemBuilder: (context, index) {
            // final b = balances[index];

            return Table(
              columnWidths: const {
                0: FlexColumnWidth(2),
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
                    CustomTableCell(text: "1001"),
                    CustomTableCell(text: "نور محمد محمود حسن عامر"),
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
