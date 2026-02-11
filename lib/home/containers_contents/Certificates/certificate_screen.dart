import 'dart:typed_data';
import 'dart:ui';
import 'package:dar_el_3loom/utils/app_colors.dart';
import 'package:dar_el_3loom/utils/responsive.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_text.dart';
import '../../../widgets/custom_elevated_button_widget.dart';

class CertificateScreen extends StatefulWidget {
  final String studentName;
  final int percent;
  final String month;
  final String date;

  const CertificateScreen({
    super.key,
    required this.studentName,
    required this.percent,
    required this.month,
    required this.date,
  });

  @override
  State<CertificateScreen> createState() => _CertificateScreenState();
}

class _CertificateScreenState extends State<CertificateScreen> {
  final GlobalKey certificateKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: h(10),
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RepaintBoundary(
          key: certificateKey,
          child: Container(
            width: double.infinity,
            clipBehavior: Clip.antiAlias,
            // height: h(320),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(AppAssets.certificate),
                fit: BoxFit.fill,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: h(60)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: h(5),
                children: [
                  Text(
                    "شهادة تقدير",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.gulzar(
                      color: AppColors.titleCertificate,
                      fontSize: sp(30),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "مقدمة من دار العلوم الي الطالب",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.catamaran(
                      color: AppColors.contentCertificate,
                      fontSize: sp(15),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    widget.studentName,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.catamaran(
                      color: AppColors.contentCertificate,
                      fontSize: sp(22),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DottedLine(
                    dashColor: AppColors.contentCertificate,
                    dashLength: 6,
                    dashGapLength: 1,
                    lineThickness: 1,
                    dashRadius: 1,
                    lineLength: w(300),
                  ),
                  Text(
                    "تُمنح هذه الشهادة تقديراً واعتزازاً بجهوده، \n "
                    "لحصوله على نسبة ${widget.percent}% خلال شهر ${widget.month}،",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.catamaran(
                      color: AppColors.contentCertificate,
                      fontSize: sp(12),
                    ),
                  ),
                  Text(
                    "نتمنى دوام التوفيق و النجاح",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.catamaran(
                      color: AppColors.titleCertificate,
                      fontSize: sp(15),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: h(10)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        widget.date,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.catamaran(
                          color: AppColors.contentCertificate,
                          fontSize: sp(12),
                        ),
                      ),
                      Text(
                        "محمود عبدالله محمود رضوان",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.gulzar(
                          color: AppColors.contentCertificate,
                          fontSize: sp(12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        CustomElevatedButtonWidget(
          sideColor: AppColors.container5Color,
          textStyle: AppText.boldText(
            color: AppColors.blackColor,
            fontSize: sp(20),
          ),
          text: "حفظ",
          padding: WidgetStateProperty.all(
            EdgeInsets.symmetric(horizontal: w(40), vertical: h(12)),
          ),
          colorContainer: AppColors.whiteColor,
          onPressed: saveCertificateAsImage,
        ),
      ],
    );
  }

  Future<void> saveCertificateAsImage() async {
    try {
      RenderRepaintBoundary boundary =
          certificateKey.currentContext!.findRenderObject()
              as RenderRepaintBoundary;

      var image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      // 3️⃣ Save to gallery
      final result = await ImageGallerySaverPlus.saveImage(
        pngBytes,
        name: "certificate_${widget.studentName}",
        quality: 100,
      );

      if (result['isSuccess']) {
        Fluttertoast.showToast(
          msg: "تم حفظ الشهادة في المعرض بنجاح!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.container5Color,
          textColor: AppColors.blackColor,
        );
      }
    } catch (e) {
      print(e);
    }
  }
}
