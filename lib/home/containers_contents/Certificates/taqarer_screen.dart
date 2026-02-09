import 'package:flutter/material.dart';

import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text.dart';
import '../../../utils/responsive.dart';
import '../Mozakrat/filter_widget.dart';

class TaqarerScreen extends StatefulWidget {
  const TaqarerScreen({super.key});

  @override
  State<TaqarerScreen> createState() => _TaqarerScreenState();
}

class _TaqarerScreenState extends State<TaqarerScreen> {
  String? selectedMonth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Text(
          "التقرير",
          style: AppText.boldText(
            color: AppColors.blackColor,
            fontSize: sp(25),
          ),
        ),
        backgroundColor: AppColors.container5Color,
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
                text: 'الشهر',
                type: FilterType.calendar,
                color: AppColors.container5Color,
                selectedValue: selectedMonth,
                onMonthSelected: (value) {
                  setState(() {
                    selectedMonth = value;
                  });
                },
              ),
              // TableWidget(
              //   tableTitleColor: AppColors.container5Color,
              //   headers: [
              //     "التاريخ",
              //     "المجموعة",
              //     "المدرس",
              //     "المادة",
              //     "الدرجة",
              //     "القصوي",
              //     "النسبة",
              //   ],
              // ),
              Image.asset(
                AppAssets.container5Image,
                fit: BoxFit.fill,
                height: h(350),
                width: w(350),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
