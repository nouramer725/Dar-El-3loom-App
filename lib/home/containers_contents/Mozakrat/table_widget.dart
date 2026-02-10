import 'package:dar_el_3loom/Model/mozakrat_model.dart';
import 'package:dar_el_3loom/home/containers_contents/Mozakrat/table_cell.dart';
import 'package:dar_el_3loom/home/containers_contents/Mozakrat/table_cell_title.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/responsive.dart';

class TableWidget extends StatelessWidget {
  final Color tableTitleColor;
  final List<String> headers;
  final List<Mozakrat> lessons;

  const TableWidget({
    required this.tableTitleColor,
    required this.headers,
    required this.lessons,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Table(
          columnWidths: const {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(1),
            3: FlexColumnWidth(1),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: tableTitleColor,
              ),
              children: headers
                  .map((header) => TableCellTitle(text: header))
                  .toList(),
            ),
          ],
        ),
        SizedBox(height: h(15)),
        // Use Expanded/ListView outside
        SizedBox(
          height: h(650),
          child: ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: h(15)),
            itemCount: lessons.length,
            itemBuilder: (context, index) {
              final lesson = lessons[index];
              final rowData = [
                lesson.nMod,
                lesson.nSanf,
                lesson.nMada,
                lesson.pSales.toString(),
              ];

              return Table(
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(2),
                  2: FlexColumnWidth(1),
                  3: FlexColumnWidth(1),
                },
                children: [
                  TableRow(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: tableTitleColor, width: 2),
                    ),
                    children: rowData
                        .map(
                          (text) => CustomTableCell(text: text, isIcon: false),
                        )
                        .toList(),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
