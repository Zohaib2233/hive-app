import 'package:beekeep/view/screens/qr_code_page/view_code.dart';
import 'package:beekeep/view/widget/Custom_button_widget.dart';
import 'package:beekeep/view/widget/my_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_styling.dart';
import '../../../models/hiveModels/hive_model.dart';
import '../../widget/Custom_text_widget.dart';
import '../../widget/common_image_view_widget.dart';

class QRCodePage extends StatefulWidget {
  final HiveModel hiveModel;
  const QRCodePage({super.key, required this.hiveModel});

  @override
  State<QRCodePage> createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {

//   void buildBarcode(
//       Barcode bc,
//       String data, {
//         String? filename,
//         double? width,
//         double? height,
//         double? fontHeight,
//       }) {
//
//     // Create an image
//
//     final image = Image(width: 300, height: 120);
//
// // Fill it with a solid color (white)
//     fill(image, color: ColorRgb8(255, 255, 255));
//
// // Draw the barcode
//     drawBarcode(image, Barcode.qrCode(), 'Test', font: arial24);
//
// // Save the image
//     File('test.png').writeAsBytesSync(encodePng(image));
//     /// Create the Barcode
//     final svg = bc.toSvg(
//       data,
//       width: width ?? 200,
//       height: height ?? 80,
//       fontHeight: fontHeight,
//     );
//
//
//
//     // Save the image
//     filename ??= bc.name.replaceAll(RegExp(r'\s'), '-').toLowerCase();
//     File('$filename.svg').writeAsStringSync(svg);
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kGreybackgroundColor,
        leading: Padding(
          padding: only(context, left: 20),
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: SizedBox(
              width: h(context, 29),
              height: w(context, 29),
              child: CommonImageView(
                imagePath: Assets.imagesBack,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        centerTitle: true,
        title: CustomText(
          text: 'Generate Code',
          size: 16,
          weight: FontWeight.w600,
          color: kFullBlackBgColor,
        ),
        leadingWidth: w(context, 50),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
        child: Column(
          children: [
            Card(
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(text: "QR Code",size: 13,weight: FontWeight.w600,),
                    SizedBox(height: 10,),
                    MyText(
                        text:
                        "To view detailed management information for Hive, including health, status, production and management schedules",
                    weight: FontWeight.w400,
                      size: 10,
                    ),
                    SizedBox(height: 24,),
                    CustomButton(buttonText: "Generate QR Code", onTap: () {
                      Get.to(()=>ViewCode(hiveModel: widget.hiveModel,));

                      // buildBarcode(Barcode.qrCode(), "34234234234",filename: "hivecode");


                    },
                    textColor: Colors.white,)
                  ],
                ),
              ),
            ),
            SizedBox(height: 30,),
            Card(
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(text: "Bar Code",size: 13,weight: FontWeight.w600,),
                    SizedBox(height: 10,),
                    MyText(
                      text:
                      "To view detailed management information for Hive, including health status, production data, and maintenance schedules.",
                      weight: FontWeight.w400,
                      size: 10,
                    ),
                    SizedBox(height: 24,),
                    CustomButton(buttonText: "Generate Bar Code", onTap: () {
                      Get.to(()=>ViewCode(hiveModel: widget.hiveModel,isBarcode: true,));
                    },
                      textColor: Colors.white,)
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
