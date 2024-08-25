import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

import '../../../core/bindings/bindings.dart';
import '../../../core/constants/firebase_constants.dart';
import '../../../core/utils/snackbar.dart';
import '../../../core/utils/utils.dart';
import '../../../models/apiary_model.dart';
import '../../../models/hiveModels/hive_model.dart';
import '../../../services/firebaseServices/firebase_crud_services.dart';
import '../hive/check_hive_data_view.dart';

class BarCodeScanView extends StatefulWidget {
  const BarCodeScanView({super.key});

  @override
  State<BarCodeScanView> createState() => _BarCodeScanViewState();
}

class _BarCodeScanViewState extends State<BarCodeScanView> {
  String _scanBarcode = 'Unknown';
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
          Get.close(1);
          Get.to(
                  () => CheckHiveDataView(
                hiveModel: hiveModel, apiaryModel: apiaryModel,isResultScreen: true,),
              binding: HiveDataBinding(),
              arguments: hiveModel);
        } else {
          Utils.hideProgressDialog(context: context);
          Get.close(1);
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

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () => scanBarcodeNormal(),
                  child: Text('Start barcode scan')),
            ],
          ),
        ),
      ),
    );
  }
}
