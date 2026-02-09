import 'package:flutter/material.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/responsive.dart';
import '../Mozakrat/filter_widget.dart';

class LessonsDateWidget extends StatefulWidget {
  const LessonsDateWidget({super.key});

  @override
  State<LessonsDateWidget> createState() => _LessonsDateWidgetState();
}

class _LessonsDateWidgetState extends State<LessonsDateWidget> {
  String? selectedSubject;
  String? selectedMonth;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FilterWidget(
          type: FilterType.dropdown,
          color: AppColors.container2Color,
          items: [
            DropdownMenuItem(value: "عربي", child: Text("عربي")),
            DropdownMenuItem(value: "رياضة", child: Text("رياضة")),
            DropdownMenuItem(value: "انجليزي", child: Text("انجليزي")),
            DropdownMenuItem(value: "الماني", child: Text("الماني")),
          ],
          text: "المادة",
          onChanged: (value) {
            setState(() {
              selectedSubject = value;
            });
          },
        ),
        FilterWidget(
          type: FilterType.dropdown,
          color: AppColors.container2Color,
          items: [
            DropdownMenuItem(value: "حسن", child: Text("حسن")),
            DropdownMenuItem(value: "احمد", child: Text("احمد")),
            DropdownMenuItem(value: "محمد", child: Text("محمد")),
            DropdownMenuItem(value: "زينب", child: Text("زينب")),
          ],
          text: "المدرس",
          onChanged: (value) {
            setState(() {
              selectedSubject = value;
            });
          },
        ),
        FilterWidget(
          text: 'التاريخ',
          type: FilterType.calendar,
          color: AppColors.container2Color,
          selectedValue: selectedMonth,
          onMonthSelected: (value) {
            setState(() {
              selectedMonth = value;
            });
          },
        ),
        SizedBox(height: h(20)),
        // TableWidget(
        //   tableTitleColor: AppColors.container2Color,
        //   headers: ["المجموعة", "المدرس", "المادة", "التاريخ", "الساعة"],
        // ),
        Image.asset(
          AppAssets.container2Image,
          fit: BoxFit.fill,
          height: h(350),
          width: w(350),
        ),
      ],
    );
  }
}
