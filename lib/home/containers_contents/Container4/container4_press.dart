import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_text.dart';
import '../../../utils/responsive.dart';

class Container4Press extends StatelessWidget {
  const Container4Press({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Text(
          "المدفوعات",
          style: AppText.boldText(color: AppColors.blackColor, fontSize: sp(25)),
        ),
        backgroundColor: AppColors.container4Color,
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_forward_ios_sharp, size: h(25)),
          ),
        ],
      ),
    );
  }
}
