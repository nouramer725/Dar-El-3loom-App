import 'package:dar_el_3loom/utils/app_colors.dart';
import 'package:dar_el_3loom/utils/app_text.dart';
import 'package:dar_el_3loom/utils/responsive.dart';
import 'package:flutter/material.dart';

class MonthPickerDialog extends StatefulWidget {
  final Function(int year, int month) onSelected;
  Color boxDecorationColor;

  MonthPickerDialog({
    required this.boxDecorationColor,
    super.key,
    required this.onSelected,
  });

  @override
  State<MonthPickerDialog> createState() => _MonthPickerDialogState();
}

class _MonthPickerDialogState extends State<MonthPickerDialog> {
  int currentYear = DateTime.now().year;
  int? selectedMonth;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.whiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: w(10), vertical: h(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: AppColors.textColorLogin,
                  ),
                  onPressed: () {
                    setState(() => currentYear--);
                  },
                ),
                Text(
                  '$currentYear',
                  style: AppText.boldText(
                    color: AppColors.blackColor,
                    fontSize: sp(25),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_forward,
                    color: AppColors.textColorLogin,
                  ),
                  onPressed: () {
                    setState(() => currentYear++);
                  },
                ),
              ],
            ),

            /// Months grid
            GridView.builder(
              shrinkWrap: true,
              itemCount: 12,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
                childAspectRatio: 1.5,
              ),
              itemBuilder: (context, index) {
                final month = index + 1;
                final isSelected = selectedMonth == month;

                return InkWell(
                  onTap: () {
                    setState(() => selectedMonth = month);

                    widget.onSelected(currentYear, month);
                    Duration(milliseconds: 1000);
                    Navigator.pop(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(
                      horizontal: w(20),
                      vertical: h(5),
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? widget.boxDecorationColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      month.toString(),
                      style: AppText.mediumText(
                        fontSize: 20,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
