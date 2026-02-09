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
    onTap: onTap,
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
            child: image != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(h(50)),
                    child: Image.file(
                      image,
                      fit: BoxFit.cover,
                      width: h(100),
                      height: h(100),
                    ),
                  )
                : (imageUrl != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(h(50)),
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            width: h(100),
                            height: h(100),
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.broken_image,
                                size: h(50),
                                color: AppColors.greyColor,
                              );
                            },
                          ),
                        )
                      : Icon(
                          Icons.camera_alt,
                          size: h(40),
                          color: AppColors.greyColor,
                        )),
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
          if (isClickable) Icon(Icons.camera_alt, color: AppColors.greyColor),
        ],
      ),
    ),
  );
}
