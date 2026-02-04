import 'dart:io';
import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text.dart';
import '../../../utils/responsive.dart';
import '../../../widgets/custom_text_form_field_widget.dart';

Widget buildField(
  String hint,
  TextEditingController controller,
  TextInputType keyboardType,
  bool locked,
) {
  return CustomTextFormFieldWidget(
    enabled: !locked,
    shadowColor: AppColors.container2Color,
    filled: false,
    cursorColor: AppColors.textColorLogin,
    keyboardType: keyboardType,
    fillColor: AppColors.transparentColor,
    borderColor: AppColors.container2Color,
    borderWidth: 2,
    labelText: hint,
    labelStyle: AppText.boldText(
      color: AppColors.textColorLogin,
      fontSize: sp(16),
    ),
    controller: controller,
    validator: (v) => v == null || v.isEmpty ? "ادخل $hint" : null,
  );
}

Widget buildImagePicker(
  BuildContext context,
  String title,
  File? image,
  VoidCallback onTap,
  String? imageUrl,
) {
  final bool isClickable = image == null && imageUrl == null;

  return InkWell(
    onTap: isClickable ? onTap : null,
    child: Container(
      height: h(120),
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: w(12), vertical: h(6)),
      decoration: BoxDecoration(
        border: Border.all(
          color: isClickable
              ? AppColors.container2Color
              : AppColors.strokeBottomNavBarColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: h(50),
            backgroundColor: AppColors.greyColor.withOpacity(0.2),
            backgroundImage: image != null
                ? FileImage(image)
                : (imageUrl != null ? NetworkImage(imageUrl) : null),
            child: image == null && imageUrl == null
                ? Icon(
                    Icons.camera_alt,
                    size: h(40),
                    color: AppColors.greyColor,
                  )
                : null,
          ),
          SizedBox(width: w(16)),
          Expanded(
            child: Text(
              title,
              style: AppText.boldText(
                fontSize: sp(16),
                color: AppColors.textColorLogin,
              ),
            ),
          ),

          isClickable
              ? Icon(Icons.camera_alt, color: AppColors.greyColor)
              : Container(),
        ],
      ),
    ),
  );
}
