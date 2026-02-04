import 'package:flutter/material.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text.dart';
import '../../../utils/responsive.dart';
import '../../../widgets/filter_widget.dart';

class Container1Press extends StatefulWidget {
  const Container1Press({super.key});

  @override
  State<Container1Press> createState() => _Container1PressState();
}

class _Container1PressState extends State<Container1Press> {
  String? selectedSubject;
  String? selectedTeacher;
  String? selectedMonth;
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Text(
          "المستوي الدراسي",
          style: AppText.boldText(
            color: AppColors.blackColor,
            fontSize: sp(25),
          ),
        ),
        backgroundColor: AppColors.container1Color,
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_forward_ios_sharp, size: h(25)),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w(10), vertical: h(10)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              FilterWidget(
                type: FilterType.dropdown,
                color: AppColors.container1Color,
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
                color: AppColors.container1Color,
                items: [
                  DropdownMenuItem(
                    value: "محمد احمد",
                    child: Text("محمد احمد"),
                  ),
                  DropdownMenuItem(
                    value: "احمد بدري",
                    child: Text("احمد بدري"),
                  ),
                  DropdownMenuItem(
                    value: "سالم محمد",
                    child: Text("سالم محمد"),
                  ),
                  DropdownMenuItem(
                    value: "اسامة سعدالله",
                    child: Text("اسامة سعدالله"),
                  ),
                ],
                text: "المدرس",
                onChanged: (value) {
                  setState(() {
                    selectedTeacher = value;
                  });
                },
              ),
              FilterWidget(
                text: 'التاريخ',
                type: FilterType.calendar,
                color: AppColors.container1Color,
                selectedValue: selectedMonth,
                onMonthSelected: (value) {
                  setState(() {
                    selectedMonth = value;
                  });
                },
              ),
              SizedBox(height: h(20)),
              // TableWidget(
              //   tableTitleColor: AppColors.container1Color,
              //   headers: ["الحصة", "التاريخ", "الحضور", "الامتحان", "الواجب"],
              // ),
              Image.asset(
                AppAssets.container1Image,
                fit: BoxFit.fill,
                height: h(350),
                width: w(350),
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavBarRowWidget(
      //   tableTitleColor: AppColors.container1Color,
      // ),
    );
  }
}
