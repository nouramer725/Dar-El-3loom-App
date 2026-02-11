import 'package:flutter/material.dart';
import '../../../../../utils/responsive.dart';
import '../../../Model/balance_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text.dart';

class BalanceTableWidget extends StatelessWidget {
  final Color tableTitleColor;
  final List<BalanceModel> balances;

  const BalanceTableWidget({
    required this.tableTitleColor,
    required this.balances,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Table(
          columnWidths: const {
            0: FlexColumnWidth(1.3),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(2),
            3: FlexColumnWidth(1),
            4: FlexColumnWidth(1),
            5: FlexColumnWidth(1),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: tableTitleColor,
                borderRadius: BorderRadius.circular(10),
              ),
              children: const [
                CustomTableCell(text: "المادة", isHeader: true),
                CustomTableCell(text: "المدرس", isHeader: true),
                CustomTableCell(text: "تاريخ الدفع", isHeader: true),
                CustomTableCell(text: "السعر", isHeader: true),
                CustomTableCell(text: "المسدد", isHeader: true),
                CustomTableCell(text: "الباقي", isHeader: true),
              ],
            ),
          ],
        ),

        SizedBox(height: h(10)),

        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: balances.length,
          separatorBuilder: (_, __) => SizedBox(height: h(5)),
          itemBuilder: (context, index) {
            final b = balances[index];

            return Table(
              columnWidths: const {
                0: FlexColumnWidth(1.3),
                1: FlexColumnWidth(2),
                2: FlexColumnWidth(2),
                3: FlexColumnWidth(1),
                4: FlexColumnWidth(1),
                5: FlexColumnWidth(1),
              },
              children: [
                TableRow(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: tableTitleColor, width: 2),
                  ),
                  children: [
                    CustomTableCell(text: b.subject),
                    CustomTableCell(text: b.teacher),
                    CustomTableCell(text: b.date.split("T").first),
                    CustomTableCell(text: b.price.toString()),
                    CustomTableCell(text: b.paid.toString()),
                    CustomTableCell(text: b.remaining.toString()),
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
