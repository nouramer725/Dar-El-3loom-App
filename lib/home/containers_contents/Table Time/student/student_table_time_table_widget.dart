import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../Model/student_time_model.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text.dart';
import '../../../../utils/responsive.dart';

class StudentDatesTableWidget extends StatelessWidget {
  final Color tableTitleColor;
  final List<StudentDateModel> sessions;

  const StudentDatesTableWidget({
    super.key,
    required this.tableTitleColor,
    required this.sessions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: h(20),
      children: [
        /// Header
        Table(
          columnWidths: const {
            0: FlexColumnWidth(1.3),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(),
            3: FlexColumnWidth(2),
            4: FlexColumnWidth(),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: tableTitleColor,
                borderRadius: BorderRadius.circular(10),
              ),
              children: const [
                _Cell(text: "المجموعة", isHeader: true),
                _Cell(text: "المدرس", isHeader: true),
                _Cell(text: "المادة", isHeader: true),
                _Cell(text: "التاريخ", isHeader: true),
                _Cell(text: "الساعة", isHeader: true),
              ],
            ),
          ],
        ),

        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: sessions.length,
          separatorBuilder: (_, __) => SizedBox(height: h(5)),
          itemBuilder: (_, i) {
            final s = sessions[i];

            return Table(
              columnWidths: const {
                0: FlexColumnWidth(),
                1: FlexColumnWidth(2),
                2: FlexColumnWidth(),
                3: FlexColumnWidth(2),
                4: FlexColumnWidth(),
              },
              children: [
                TableRow(
                  decoration: BoxDecoration(
                    border: Border.all(color: tableTitleColor, width: 2),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  children: [
                    _Cell(text: s.groupNumber),
                    _Cell(text: s.teacher),
                    _Cell(text: s.subject),
                    _Cell(text: s.date),
                    _Cell(text: formatTime(s.time)),
                  ],
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  String formatTime(String timeString) {
    try {
      DateTime parsedTime;

      if (timeString.contains("ص") || timeString.contains("م")) {
        final normalized = timeString
            .replaceAll("م", "PM")
            .replaceAll("ص", "AM");
        parsedTime = DateFormat("hh:mm:ss a").parse(normalized);
      } else {
        parsedTime = DateFormat("HH:mm:ss").parse(timeString);
      }

      final formatted = DateFormat.jm().format(parsedTime);
      return formatted.replaceAll("AM", "ص").replaceAll("PM", "م");
    } catch (e) {
      return timeString;
    }
  }
}

class _Cell extends StatelessWidget {
  final String text;
  final bool isHeader;

  const _Cell({required this.text, this.isHeader = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: h(14)),
      child: Text(
        textAlign: TextAlign.center,
        text,
        style: isHeader
            ? AppText.boldText(fontSize: sp(18), color: AppColors.blackColor)
            : AppText.mediumText(fontSize: sp(17), color: AppColors.blackColor),
      ),
    );
  }
}
