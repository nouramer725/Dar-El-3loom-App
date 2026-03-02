import 'dart:io';
import 'package:dar_el_3loom/Model/assistant_login_model.dart';
import 'package:dar_el_3loom/provider/assistant_login_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../../BackendSetup Data/Api/api_service.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text.dart';
import '../../../../utils/responsive.dart';
import '../../../../widgets/custom_elevated_button_widget.dart';

class ProfilePictureAssistantWidget extends StatefulWidget {
  const ProfilePictureAssistantWidget({super.key});

  @override
  State<ProfilePictureAssistantWidget> createState() =>
      _ProfilePictureAssistantWidgetState();
}

class _ProfilePictureAssistantWidgetState
    extends State<ProfilePictureAssistantWidget> {
  File? selectedImage;
  final ImagePicker picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  Future<void> uploadProfilePicture() async {
    if (selectedImage == null) return;

    try {
      final assistantProvider = Provider.of<AssistantLoginProvider>(
        context,
        listen: false,
      );
      final token = assistantProvider.token;

      if (token == null) throw Exception("لم يتم تسجيل الدخول");

      final api = ApiService(token: token);

      final response = await api.uploadProfilePictureAssistant(selectedImage!);

      if (response['status'] == 'success') {
        final assistantData = response['data']['assistant'];
        assistantProvider.assistants?.personalImage =
            assistantData['profile_image'];

        Fluttertoast.showToast(
          msg: "تم تحديث الصورة الشخصية بنجاح",
          backgroundColor: AppColors.blackColor,
          textColor: Colors.white,
          gravity: ToastGravity.TOP,
        );
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(
          msg: response['message'] ?? "حدث خطأ",
          backgroundColor: AppColors.wrongIconColor,
          textColor: Colors.white,
          gravity: ToastGravity.TOP,
        );
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(
        msg: "حدث خطأ",
        backgroundColor: AppColors.wrongIconColor,
        textColor: Colors.white,
        gravity: ToastGravity.TOP,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final assistantProvider = Provider.of<AssistantLoginProvider>(context);
    final Assistant? assistant = assistantProvider.assistants;

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
                onTap: pickImage,
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
                      child: selectedImage != null
                          ? Image.file(selectedImage!, fit: BoxFit.cover)
                          : assistant?.personalImage != null
                          ? Image.network(
                              assistant!.personalImage!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset(AppAssets.boy, fit: BoxFit.fill),
                            )
                          : Image.asset(AppAssets.boy, fit: BoxFit.fill),
                    ),
                    CircleAvatar(
                      radius: sp(25),
                      backgroundColor: AppColors.strokeBottomNavBarColor,
                      child: Icon(
                        Icons.camera_alt_outlined,
                        size: sp(25),
                        color: Color(0xFFA1A5AC),
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
                onPressed: uploadProfilePicture,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
