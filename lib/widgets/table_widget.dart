import 'package:dar_el_3loom/widgets/table_cell.dart';
import 'package:dar_el_3loom/widgets/table_cell_title.dart';
import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/responsive.dart';
import 'lessons_model.dart';

class TableWidget extends StatelessWidget {
  final Color tableTitleColor;
  final List<String> headers;

  const TableWidget({
    required this.tableTitleColor,
    required this.headers,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Table(
          children: [
            TableRow(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: tableTitleColor,
              ),
              children:
                  headers
                      .map((header) => TableCellTitle(text: header))
                      .toList(),
            ),
          ],
        ),
        SizedBox(height: h(15)),
        ListView.separated(
          separatorBuilder: (context, index) => SizedBox(height: h(15)),
          shrinkWrap: true,
          itemCount: lessons.length,
          itemBuilder: (context, index) {
            final lessonData = [
              lessons[index].name,
              lessons[index].date,
              lessons[index].time,
              lessons[index].score,
            ];

            return Table(
              children: [
                TableRow(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: tableTitleColor, width: 2),
                  ),
                  children: [
                    ...lessonData.map(
                      (text) => CustomTableCell(text: text, isIcon: false),
                    ),

                    CustomTableCell(
                      isIcon: true,
                      icon: lessons[index].passed ? Icons.check : Icons.close,
                      color:
                          lessons[index].passed
                              ? AppColors.checkIconColor
                              : AppColors.wrongIconColor,
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
