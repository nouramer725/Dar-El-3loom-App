import 'package:dar_el_3loom/home/containers_contents/Container2/row_widget_buttons.dart';
import 'package:dar_el_3loom/home/containers_contents/Container2/student_date_widget.dart';
import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text.dart';
import '../../../utils/responsive.dart';
import '../../../widgets/bottom_nav_bar_row_widget.dart';
import 'lessons_date_widget.dart';

class Container2Press extends StatefulWidget {
  const Container2Press({super.key});

  @override
  State<Container2Press> createState() => _Container2PressState();
}

class _Container2PressState extends State<Container2Press> {

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
          style: AppText.boldText(color: AppColors.blackColor, fontSize: sp(25)),
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
              SizedBox(height: h(20)),
              isSelected ? StudentDateWidget() : LessonsDateWidget(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBarRowWidget(
        tableTitleColor: AppColors.container2Color,
      ),
    );
  }
}
