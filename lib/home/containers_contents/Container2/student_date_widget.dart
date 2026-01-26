import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/responsive.dart';
import '../../../widgets/filter_widget.dart';
import '../../../widgets/table_widget.dart';

class StudentDateWidget extends StatefulWidget {
  const StudentDateWidget({super.key});

  @override
  State<StudentDateWidget> createState() => _StudentDateWidgetState();
}

class _StudentDateWidgetState extends State<StudentDateWidget> {
  String? selectedSubject;
  String? selectedMonth;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FilterWidget(
          color: AppColors.container2Color,
          items: [
            DropdownMenuItem(value: "عربي", child: Text("عربي")),
            DropdownMenuItem(value: "رياضة", child: Text("رياضة")),
            DropdownMenuItem(value: "انجليزي", child: Text("انجليزي")),
            DropdownMenuItem(value: "الماني", child: Text("الماني")),
          ],
          selectedItem: selectedSubject,
          text: "التاريخ",
          onChanged: (value) {
            setState(() {
              selectedSubject = value;
            });
          },
        ),
        FilterWidget(
          color: AppColors.container2Color,
          items: [
            DropdownMenuItem(value: "عربي", child: Text("عربي")),
            DropdownMenuItem(value: "رياضة", child: Text("رياضة")),
            DropdownMenuItem(value: "انجليزي", child: Text("انجليزي")),
            DropdownMenuItem(value: "الماني", child: Text("الماني")),
          ],
          selectedItem: selectedSubject,
          text: "المادة",
          onChanged: (value) {
            setState(() {
              selectedSubject = value;
            });
          },
        ),
        SizedBox(height: h(20)),
        TableWidget(
          tableTitleColor: AppColors.container2Color,
          headers: ["المجموعة", "المدرس", "المادة", "التاريخ", "الساعة"],
        ),
        // Image.asset(
        //   AppAssets.container2Image,
        //   fit: BoxFit.fill,
        //   height: h(350),
        //   width: w(350),
        // ),
      ],
    );
  }
}
