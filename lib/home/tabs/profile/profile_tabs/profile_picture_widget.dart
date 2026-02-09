import 'package:dar_el_3loom/Model/student_login_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../provider/student_login_provider.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text.dart';
import '../../../../utils/responsive.dart';
import '../../../../widgets/custom_elevated_button_widget.dart';

class ProfilePictureWidget extends StatelessWidget {
  const ProfilePictureWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentLoginProvider>(context);
    final Student? student = studentProvider.student;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.strokeBottomNavBarColor,
        title: Text(
          "تعديل الصورة الشخصية",
          style: AppText.boldText(
            color: AppColors.blackColor,
            fontSize: sp(24),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_forward_ios_sharp, size: h(25)),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: h(50)),
        child: Center(
          child: Column(
            spacing: h(80),
            children: [
              InkWell(
                onTap: () {},
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      clipBehavior: Clip.antiAlias,
                      width: w(300),
                      height: h(300),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: student?.profilePicture != null
                          ? Image.network(
                              student!.profilePicture!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset(AppAssets.boy, fit: BoxFit.fill),
                            )
                          : Image.asset(AppAssets.boy, fit: BoxFit.fill),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: CircleAvatar(
                        radius: sp(25),
                        backgroundColor: AppColors.strokeBottomNavBarColor,
                        child: Icon(
                          Icons.camera_alt_outlined,
                          size: sp(25),
                          color: Color(0xFFA1A5AC),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              CustomElevatedButtonWidget(
                text: "حفظ",
                textStyle: AppText.boldText(
                  color: AppColors.blackColor,
                  fontSize: sp(25),
                ),
                padding: WidgetStateProperty.all(
                  EdgeInsets.symmetric(horizontal: w(40), vertical: h(10)),
                ),
                colorContainer: AppColors.whiteColor,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
