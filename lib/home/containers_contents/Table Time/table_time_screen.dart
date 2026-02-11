import 'package:dar_el_3loom/home/containers_contents/Table%20Time/row_widget_buttons.dart';
import 'package:dar_el_3loom/home/containers_contents/Table%20Time/student/student_date_widget.dart';
import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text.dart';
import '../../../utils/responsive.dart';
import 'lessons/lessons_date_widget.dart';

class TableTimeScreen extends StatefulWidget {
  const TableTimeScreen({super.key});

  @override
  State<TableTimeScreen> createState() => _TableTimeScreenState();
}

class _TableTimeScreenState extends State<TableTimeScreen> {
  bool isSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Text(
          "مواعيد الجداول",
          style: AppText.boldText(
            color: AppColors.blackColor,
            fontSize: sp(25),
          ),
        ),
        backgroundColor: AppColors.container2Color,
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
              RowWidgetButtons(
                isSelected: isSelected,
                onChange: (value) {
                  setState(() {
                    isSelected = value;
                  });
                },
              ),
              SizedBox(height: h(10)),
              isSelected ? StudentDateWidget() : LessonsDateWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
