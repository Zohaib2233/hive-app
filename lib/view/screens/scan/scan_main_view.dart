import 'package:beekeep/view/screens/scan/bar_code_scanner_view.dart';
import 'package:beekeep/view/screens/scan/qr_code_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_styling.dart';
import '../../../core/bindings/bindings.dart';
import '../../../core/constants/firebase_constants.dart';
import '../../../core/utils/snackbar.dart';
import '../../../core/utils/utils.dart';
import '../../../models/apiary_model.dart';
import '../../../models/hiveModels/hive_model.dart';
import '../../../services/firebaseServices/firebase_crud_services.dart';
import '../../widget/Custom_button_widget.dart';
import '../../widget/Custom_text_widget.dart';
import '../../widget/common_image_view_widget.dart';
import '../hive/check_hive_data_view.dart';

class ScanMainView extends StatefulWidget {
  const ScanMainView({super.key});

  @override
  State<ScanMainView> createState() => _ScanMainViewState();
}

class _ScanMainViewState extends State<ScanMainView> {
  int selectedOption = 0;

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(

          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      if (barcodeScanRes.isNotEmpty) {
        Utils.showProgressDialog(context: context);
        // scannerController.dispose();
        DocumentSnapshot? snapshot = await FirebaseCRUDServices.instance
            .readSingleDoc(
            collectionReference:
            FirebaseConstants.hivesCollectionReference,
            docId: barcodeScanRes ?? '');


        if (snapshot!=null && snapshot.exists) {
          HiveModel hiveModel = HiveModel.fromDocument(snapshot);
          DocumentSnapshot? doc = await FirebaseCRUDServices.instance
              .readSingleDoc(
              collectionReference:
              FirebaseConstants.apiaryCollectionReference,
              docId: hiveModel.apiaryId);
          ApiaryModel apiaryModel =
          ApiaryModel.fromMap(doc!.data() as Map<String, dynamic>);
          Utils.hideProgressDialog(context: context);
          Get.to(
                  () => CheckHiveDataView(
                hiveModel: hiveModel, apiaryModel: apiaryModel,isResultScreen: true,),
              binding: HiveDataBinding(),
              arguments: hiveModel);
        } else {
          Utils.hideProgressDialog(context: context);
          Get.back();
          CustomSnackBars.instance.showFailureSnackbar(
              title: "failed", message: "Wrong Code");
        }
      }
      print("barcodeScanRes = $barcodeScanRes");
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    // setState(() {
    //   _scanBarcode = barcodeScanRes;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreybackgroundColor,
      appBar: AppBar(
        backgroundColor: kGreybackgroundColor,
        leading: Container(),
        centerTitle: true,
        title: CustomText(
          text: 'Scan',
          size: 16,
          weight: FontWeight.w600,
          color: kFullBlackBgColor,
        ),
        leadingWidth: w(context, 50),
      ),
      body: Padding(
        padding: symmetric(context, vertical: 20, horizontal: 20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedOption = 0;
                      });
                    },
                    child: Container(
                      height: h(context, 150),
                      decoration: BoxDecoration(
                          color: selectedOption == 0
                              ? const Color(0xffffd700).withOpacity(0.3)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(h(context, 10))),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CommonImageView(
                              imagePath: Assets.imagesBarCode,
                              width: w(context, 62),
                              height: h(context, 62),
                            ),
                            SizedBox(
                              height: h(context, 12),
                            ),
                            CustomText(
                              text: 'Bar Code Scanner',
                              size: 17,
                              weight: FontWeight.w600,
                              color: kFullBlackBgColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: w(context, 12),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedOption = 1;
                      });
                    },
                    child: Container(
                      height: h(context, 150),
                      decoration: BoxDecoration(
                          color: selectedOption == 1
                              ? const Color(0xffffd700).withOpacity(0.3)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(h(context, 10))),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CommonImageView(
                              imagePath: Assets.imagesQrCode,
                              width: w(context, 62),
                              height: h(context, 62),
                            ),
                            SizedBox(
                              height: h(context, 12),
                            ),
                            CustomText(
                              text: 'QR Code Scanner',
                              size: 17,
                              weight: FontWeight.w600,
                              color: kFullBlackBgColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: h(context, 15),
            ),

            const Spacer(),
            CustomButton3(
              borderRadius: 8,
              buttonText: "Continue",
              onTap: () {
                if(selectedOption==0){
                  scanBarcodeNormal();
                  // Get.to(()=>BarCodeScanView());
                  // Get.to(()=>QrCodeView());
                }
                else{
                  Get.to(()=>QrCodeView());
                }



                // Get.to(() => const BarCodeScanView());
              },
            )
          ],
        ),
      ),
    );
  }
}
