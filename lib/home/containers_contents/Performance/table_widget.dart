import 'package:flutter/material.dart';
import '../../../../../utils/responsive.dart';
import '../../../Model/performance_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text.dart';

/// Custom cell for table
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
              text ?? '',
              textAlign: TextAlign.center,
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

/// Table widget for displaying sessions
class PerformanceTableWidget extends StatelessWidget {
  final Color tableTitleColor;
  final List<SessionModel> sessions;

  const PerformanceTableWidget({
    required this.tableTitleColor,
    required this.sessions,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Table header
        Table(
          columnWidths: const {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(1),
            3: FlexColumnWidth(1),
            4: FlexColumnWidth(1),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: tableTitleColor,
              ),
              children: const [
                CustomTableCell(text: 'الحصة', isHeader: true),
                CustomTableCell(text: 'التاريخ', isHeader: true),
                CustomTableCell(text: 'الحضور', isHeader: true),
                CustomTableCell(text: 'الميعاد', isHeader: true),
                CustomTableCell(text: 'الواجب', isHeader: true),
              ],
            ),
          ],
        ),
        SizedBox(height: h(10)),

        /// Table rows
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: sessions.length,
          separatorBuilder: (context, index) => SizedBox(height: h(5)),
          itemBuilder: (context, index) {
            final s = sessions[index];
            return Table(
              columnWidths: const {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(2),
                2: FlexColumnWidth(1),
                3: FlexColumnWidth(1),
                4: FlexColumnWidth(1),
              },
              children: [
                TableRow(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: tableTitleColor, width: 2),
                  ),
                  children: [
                    CustomTableCell(text: s.sessionNumber.toString()),
                    CustomTableCell(text: s.date),
                    CustomTableCell(
                      text: (s.attendanceStatus.isEmpty)
                          ? "——"
                          : s.attendanceStatus,
                    ),
                    CustomTableCell(text: s.evaluation),
                    CustomTableCell(
                      icon: Icon(
                        s.homework == 0 ? Icons.close : Icons.check,
                        color: s.homework == 0
                            ? AppColors.wrongIconColor
                            : AppColors.checkIconColor,
                        size: h(20),
                      ),
                    ),
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
