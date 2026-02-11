import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../Model/takim_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text.dart';
import '../../../utils/responsive.dart';
import '../../../widgets/custom_elevated_button_widget.dart';
import 'certificate_screen.dart';

class TaqarerTableWidget extends StatefulWidget {
  final Color tableTitleColor;
  final List<TakiimModel> records;
  final Map<String, dynamic> totals;
  final String studentName;
  final String selectedMonth;

  const TaqarerTableWidget({
    super.key,
    required this.tableTitleColor,
    required this.records,
    required this.totals,
    required this.studentName,
    required this.selectedMonth,
  });

  @override
  State<TaqarerTableWidget> createState() => _TaqarerTableWidgetState();
}

class _TaqarerTableWidgetState extends State<TaqarerTableWidget> {
  bool showMessage = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: h(15),
      children: [
        /// Header
        Table(
          columnWidths: const {
            0: FlexColumnWidth(3),
            1: FlexColumnWidth(3),
            2: FlexColumnWidth(3),
            3: FlexColumnWidth(2),
            4: FlexColumnWidth(2),
            5: FlexColumnWidth(2),
            6: FlexColumnWidth(2),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: widget.tableTitleColor,
              ),
              children: const [
                Cell(text: "التاريخ", isHeader: true),
                Cell(text: "المجموعة", isHeader: true),
                Cell(text: "المدرس", isHeader: true),
                Cell(text: "المادة", isHeader: true),
                Cell(text: "الدرجة", isHeader: true),
                Cell(text: "القصوى", isHeader: true),
                Cell(text: "%", isHeader: true),
              ],
            ),
          ],
        ),

        /// Rows
        ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (context, index) => SizedBox(height: h(15)),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.records.length,
          itemBuilder: (context, index) {
            final r = widget.records[index];

            return Table(
              columnWidths: const {
                0: FlexColumnWidth(3),
                1: FlexColumnWidth(2),
                2: FlexColumnWidth(3),
                3: FlexColumnWidth(2),
                4: FlexColumnWidth(2),
                5: FlexColumnWidth(2),
                6: FlexColumnWidth(2),
              },
              children: [
                TableRow(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: widget.tableTitleColor, width: 2),
                  ),
                  children: [
                    Cell(text: r.date),
                    Cell(text: r.groupNumber),
                    Cell(text: r.teacher),
                    Cell(text: r.subject),
                    Cell(text: r.studentGrade.toString()),
                    Cell(text: r.maxGrade.toString()),
                    Cell(text: "${r.percentage}%"),
                  ],
                ),
              ],
            );
          },
        ),

        Table(
          columnWidths: const {
            0: FlexColumnWidth(6),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(2),
            3: FlexColumnWidth(2),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: widget.tableTitleColor,
              ),
              children: [
                const Cell(text: "المجموع", isHeader: true),
                Cell(
                  text: "${widget.totals['totalgrades'] ?? 0}",
                  isHeader: true,
                ),
                Cell(text: "${widget.totals['totalmax'] ?? 0}", isHeader: true),
                Cell(
                  text: "${widget.totals['totalperstange'] ?? 0} %",
                  isHeader: true,
                ),
              ],
            ),
          ],
        ),

        SizedBox(height: h(50)),

        CustomElevatedButtonWidget(
          sideColor: AppColors.container5Color,
          textStyle: AppText.boldText(
            color: AppColors.blackColor,
            fontSize: sp(16),
          ),
          text: "الشهادة",
          padding: WidgetStateProperty.all(
            EdgeInsets.symmetric(horizontal: w(40), vertical: h(12)),
          ),
          colorContainer: AppColors.whiteColor,
          onPressed: () {
            double percent = (widget.totals['totalperstange'] ?? 0).toDouble();

            if (percent >= 85) {
              showDialog(
                context: context,
                barrierDismissible: true,
                barrierColor: AppColors.blackColor.withOpacity(0.7),
                builder: (context) {
                  return Dialog(
                    insetPadding: EdgeInsets.all(h(5)),
                    backgroundColor: Colors.transparent,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CertificateScreen(
                            studentName: widget.studentName,
                            percent: percent.toInt(),
                            month: widget.selectedMonth,
                            date: DateFormat("dd/MM/yyyy").format(DateTime.now()),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              setState(() {
                showMessage = true;
              });
            }
          },
        ),
        if (showMessage)
          Padding(
            padding: EdgeInsets.all(h(15)),
            child: Text(
              "لم يتم الحصول على الشهادة هذه المرة لأن النسبة أقل من 85%.\n"
              "نثق أنك ستتمكن من تحقيقها قريباً.",
              textAlign: TextAlign.center,
              style: AppText.boldText(
                color: AppColors.darkGreyColor,
                fontSize: sp(20),
              ),
            ),
          ),
      ],
    );
  }
}

class Cell extends StatelessWidget {
  final String text;
  final bool isHeader;

  const Cell({required this.text, this.isHeader = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: h(10)),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: isHeader
            ? AppText.boldText(fontSize: sp(16), color: AppColors.blackColor)
            : AppText.mediumText(
                fontSize: sp(15),
                color: AppColors.blackColor,
              ),
      ),
    );
  }
}
