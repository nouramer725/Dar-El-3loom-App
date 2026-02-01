import 'package:flutter/material.dart';

import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text.dart';
import '../../../utils/responsive.dart';
import '../../../widgets/filter_widget.dart';
import '../../../widgets/table_widget.dart';

class Container3Press extends StatefulWidget {
  const Container3Press({super.key});

  @override
  State<Container3Press> createState() => _Container3PressState();
}

class _Container3PressState extends State<Container3Press> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Text(
          "المذكرات",
          style: AppText.boldText(
            color: AppColors.blackColor,
            fontSize: sp(25),
          ),
        ),
        backgroundColor: AppColors.container3Color,
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_forward_ios_sharp, size: h(25)),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w(10), vertical: h(10)),
        child: Column(
          children: [
            FilterWidget(
              type: FilterType.dropdown,
              color: AppColors.container3Color,
              items: [
                DropdownMenuItem(
                  value: "المواد المسجلة",
                  child: Text("المواد المسجلة"),
                ),
                DropdownMenuItem(
                  value: "جميع المواد",
                  child: Text("جميع المواد"),
                ),
              ],
              text: "المذكرات",
              onChanged: (value) {
                setState(() {});
              },
            ),
            // TableWidget(
            //   tableTitleColor: AppColors.container3Color,
            //   headers: ["المذكرة", "المدرس", "المادة", "السعر"],
            // ),
            Image.asset(
              AppAssets.container3Image,
              fit: BoxFit.fill,
              height: h(350),
              width: w(350),
            ),
          ],
        ),
      ),
    );
  }
}
