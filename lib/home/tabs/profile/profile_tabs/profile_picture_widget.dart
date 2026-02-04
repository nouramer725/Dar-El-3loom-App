import 'package:flutter/material.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text.dart';
import '../../../../utils/responsive.dart';
import '../../../../widgets/custom_elevated_button_widget.dart';

class ProfilePictureWidget extends StatefulWidget {
  const ProfilePictureWidget({super.key});

  @override
  State<ProfilePictureWidget> createState() => _ProfilePictureWidgetState();
}

class _ProfilePictureWidgetState extends State<ProfilePictureWidget> {
  // File? profileImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.strokeBottomNavBarColor,
        title: Text(
          "تعديل الصورة الشخصية",
          style: AppText.boldText(color: AppColors.blackColor, fontSize: sp(24)),
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
                onTap: () {
                  // updateProfileImage();
                },
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      height: h(200),
                      width: w(200),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage(AppAssets.boy),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // updateProfileImage();
                      },
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
                colorContainer: AppColors.whiteColor,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> updateProfileImage() async {
  //   try {
  //     final picker = ImagePicker();
  //     XFile? image = await picker.pickImage(source: ImageSource.gallery);
  //
  //     if (image != null) {
  //       setState(() {
  //         profileImage = File(image.path);
  //       });
  //     }
  //   } catch (e) {
  //     print("Error picking image: $e");
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text("Failed to pick image. Please try again.")),
  //     );
  //   }
  // }
}
