import 'package:flutter/material.dart';
import '../../../../../utils/responsive.dart';
import '../../../models/performance_model.dart';
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
class PerformanceTableWidget extends StatefulWidget {
  final Color tableTitleColor;
  final List<SessionModel> sessions;
  final String monthName;

  const PerformanceTableWidget({
    required this.tableTitleColor,
    required this.sessions,
    required this.monthName,
    super.key,
  });

  @override
  State<PerformanceTableWidget> createState() => _PerformanceTableWidgetState();
}

class _PerformanceTableWidgetState extends State<PerformanceTableWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    /// تقسيم الليست
    final firstSessions = widget.sessions.take(4).toList();
    final remainingSessions = widget.sessions.length > 4
        ? widget.sessions.sublist(4)
        : [];

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
                color: widget.tableTitleColor,
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

        /// أول 4 حصص
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: firstSessions.length,
          separatorBuilder: (context, index) => SizedBox(height: h(5)),
          itemBuilder: (context, index) {
            final s = firstSessions[index];
            return buildRow(s);
          },
        ),

        SizedBox(height: h(10)),

        /// الكونتينر (عرض المزيد)
        if (remainingSessions.isNotEmpty)
          Container(
            padding: EdgeInsets.only(right: w(15)),
            decoration: BoxDecoration(
              color: AppColors.container1Color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "الحصص الاضافية لشهر ${widget.monthName}",

                  style: AppText.boldText(
                    color: Colors.black,
                    fontSize: sp(20),
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  icon: Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_right,
                  ),
                ),
              ],
            ),
          ),

        SizedBox(height: h(10)),

        /// باقي الحصص (تحت الكونتينر)
        if (isExpanded)
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: remainingSessions.length,
            separatorBuilder: (context, index) => SizedBox(height: h(5)),
            itemBuilder: (context, index) {
              final s = remainingSessions[index];
              return buildRow(s);
            },
          ),
      ],
    );
  }

  /// Row builder (عشان الكود يبقى نضيف)
  Widget buildRow(SessionModel s) {
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
            border: Border.all(color: widget.tableTitleColor, width: 2),
          ),
          children: [
            CustomTableCell(text: s.sessionNumber.toString()),
            CustomTableCell(text: s.date),
            CustomTableCell(
              text: (s.attendanceStatus.isEmpty) ? "——" : s.attendanceStatus,
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
  }
}
