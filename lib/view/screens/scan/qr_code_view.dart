import 'package:beekeep/core/constants/firebase_constants.dart';
import 'package:beekeep/core/utils/snackbar.dart';
import 'package:beekeep/models/apiary_model.dart';
import 'package:beekeep/models/hiveModels/hive_model.dart';
import 'package:beekeep/services/firebaseServices/firebase_crud_services.dart';
import 'package:beekeep/view/screens/hive/check_hive_data_view.dart';
import 'package:beekeep/view/screens/scan/result_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../core/bindings/bindings.dart';
import '../../../core/utils/utils.dart';

class QrCodeView extends StatefulWidget {
  const QrCodeView({super.key});

  @override
  State<QrCodeView> createState() => _QrCodeViewState();
}

class _QrCodeViewState extends State<QrCodeView> {
  Barcode? _barcode;
  MobileScannerController scannerController = MobileScannerController(
    autoStart: true
  );

  Widget _buildBarcode(Barcode? value) {
    if (value == null) {
      return Text(
        'Scan something! ${value}',
        overflow: TextOverflow.fade,
        style: TextStyle(color: Colors.white),
      );
    }

    return Text(
      value.displayValue ?? 'No display value.',
      overflow: TextOverflow.fade,
      style: const TextStyle(color: Colors.white),
    );
  }

  void _handleBarcode(BarcodeCapture barcodes) {
    if (mounted) {
      setState(() {
        _barcode = barcodes.barcodes.firstOrNull;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simple scanner')),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(
            controller: scannerController,
            onDetect: (barcodes) async {
              _barcode = barcodes.barcodes.firstOrNull;
              if (_barcode != null) {
                Utils.showProgressDialog(context: context);
                scannerController.dispose();
                DocumentSnapshot? snapshot = await FirebaseCRUDServices.instance
                    .readSingleDoc(
                        collectionReference:
                            FirebaseConstants.hivesCollectionReference,
                        docId: _barcode!.displayValue ?? '');


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
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.bottomCenter,
              height: 100,
              color: Colors.black.withOpacity(0.4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child: Center(child: _buildBarcode(_barcode))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
