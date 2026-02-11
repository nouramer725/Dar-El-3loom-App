import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../Model/lessons_date_model.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text.dart';
import '../../../../utils/responsive.dart';

class LessonsTableWidget extends StatelessWidget {
  final Color tableTitleColor;
  final List<LessonScheduleModel> lessons;

  const LessonsTableWidget({
    super.key,
    required this.tableTitleColor,
    required this.lessons,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: h(20),
      children: [
        Table(
          columnWidths: const {
            0: FlexColumnWidth(),
            1: FlexColumnWidth(),
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
                Cell(text: "المجموعة", isHeader: true),
                Cell(text: "المدرس", isHeader: true),
                Cell(text: "المادة", isHeader: true),
                Cell(text: "التاريخ", isHeader: true),
                Cell(text: "الساعة", isHeader: true),
              ],
            ),
          ],
        ),

        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: lessons.length,
          separatorBuilder: (_, _) => SizedBox(height: h(5)),
          itemBuilder: (_, i) {
            final l = lessons[i];

            return Table(
              columnWidths: const {
                0: FlexColumnWidth(),
                1: FlexColumnWidth(),
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
                    Cell(text: l.group),
                    Cell(text: l.teacher),
                    Cell(text: l.subject),
                    Cell(text: l.date),
                    Cell(text: formatTime(l.time)),
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

class Cell extends StatelessWidget {
  final String text;
  final bool isHeader;

  const Cell({required this.text, this.isHeader = false});

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
