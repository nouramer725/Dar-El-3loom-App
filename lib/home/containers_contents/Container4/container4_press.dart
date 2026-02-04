import 'package:flutter/material.dart';

import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text.dart';
import '../../../utils/responsive.dart';
import '../../../widgets/filter_widget.dart';

class Container4Press extends StatefulWidget {
  const Container4Press({super.key});

  @override
  State<Container4Press> createState() => _Container4PressState();
}

class _Container4PressState extends State<Container4Press> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Text(
          "المدفوعات",
          style: AppText.boldText(
            color: AppColors.blackColor,
            fontSize: sp(25),
          ),
        ),
        backgroundColor: AppColors.container4Color,
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
                color: AppColors.container4Color,
                items: [
                  DropdownMenuItem(value: "عربي", child: Text("عربي")),
                  DropdownMenuItem(value: "رياضة", child: Text("رياضة")),
                  DropdownMenuItem(value: "انجليزي", child: Text("انجليزي")),
                  DropdownMenuItem(value: "الماني", child: Text("الماني")),
                ],
                text: "المادة",
                onChanged: (value) {
                  setState(() {});
                },
              ),
              FilterWidget(
                type: FilterType.dropdown,
                color: AppColors.container4Color,
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
                  setState(() {});
                },
              ),
              FilterWidget(
                type: FilterType.dropdown,
                color: AppColors.container4Color,
                items: [
                  DropdownMenuItem(value: "المدفوع", child: Text("المدفوع")),
                  DropdownMenuItem(
                    value: "غير المدفوع",
                    child: Text("غير المدفوع"),
                  ),
                ],
                text: "حالة الدفع",
                onChanged: (value) {
                  setState(() {});
                },
              ),
              // TableWidget(
              //   tableTitleColor: AppColors.container4Color,
              //   headers: [
              //     "الماده",
              //     "المدرس",
              //     "المدفوعات",
              //     "تاريخ الدفع",
              //     "السعر",
              //     "المسدد",
              //     "الباقي",
              //   ],
              // ),
              Image.asset(
                AppAssets.container4Image,
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
