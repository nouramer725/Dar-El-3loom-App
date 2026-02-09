import 'package:flutter/material.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_text.dart';
import '../../../../../utils/responsive.dart';
import '../../../widgets/month_picker_dialog.dart';

enum FilterType { dropdown, calendar }

class FilterWidget extends StatelessWidget {
  final String text;
  final Function(String)? onMonthSelected;
  final FilterType type;
  final List<DropdownMenuItem<String>>? items;
  final String? selectedValue;
  final Function(String?)? onChanged;
  final Function(DateTime)? onDateSelected;
  final Color color;

  const FilterWidget({
    super.key,
    required this.text,
    required this.type,
    required this.color,
    this.items,
    this.selectedValue,
    this.onChanged,
    this.onDateSelected,
    this.onMonthSelected,
  });

  @override
  Widget build(BuildContext context) {
    return type == FilterType.dropdown
        ? _buildDropdown(context)
        : _buildCalendar(context);
  }

  Widget _buildDropdown(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: w(10)),
      margin: EdgeInsets.symmetric(vertical: h(5)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color, width: 2),
      ),
      child: DropdownButtonFormField<String>(
        dropdownColor: Theme.of(context).scaffoldBackgroundColor,
        value: selectedValue,
        hint: Text(
          text,
          style: AppText.boldText(
            fontSize: sp(18),
            color: AppColors.blackColor,
          ),
        ),
        items: items,
        onChanged: onChanged,
        decoration: const InputDecoration(border: InputBorder.none),
      ),
    );
  }

  Widget _buildCalendar(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: w(10), vertical: h(15)),
      margin: EdgeInsets.symmetric(vertical: h(5)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color, width: 2),
      ),
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (_) {
              return MonthPickerDialog(
                boxDecorationColor: color,
                onSelected: (year, month) {
                  final value = '$month / $year';
                  onMonthSelected?.call(value);
                },
              );
            },
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedValue ?? text,
              style: AppText.boldText(
                color: AppColors.blackColor,
                fontSize: sp(18),
              ),
            ),
            const Icon(Icons.calendar_month),
          ],
        ),
      ),
    );
  }
}
