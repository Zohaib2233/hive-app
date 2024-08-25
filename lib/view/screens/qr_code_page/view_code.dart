import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:barcode_widget/barcode_widget.dart';
import 'package:beekeep/core/utils/snackbar.dart';
import 'package:beekeep/core/utils/utils.dart';
import 'package:beekeep/models/hiveModels/hive_model.dart';
import 'package:beekeep/view/widget/Custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:printing/printing.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ViewCode extends StatefulWidget {
  final HiveModel hiveModel;
  final bool isBarcode;

  const ViewCode({super.key, required this.hiveModel, this.isBarcode = false});

  @override
  State<ViewCode> createState() => _ViewCodeState();
}

class _ViewCodeState extends State<ViewCode> {
  final GlobalKey _globalKey = GlobalKey();

  Future<void> _saveQRCode() async {
    try {
      Utils.showProgressDialog(context: context);
      RenderRepaintBoundary boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      final pdf = pw.Document();

      final imageProvider = pw.MemoryImage(pngBytes);

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Image(imageProvider,

              dpi: 1000,
              width: 400,
              height: 200
              ),
            );
          },
        ),
      );



      if (await Permission.photos.request().isGranted ||
          await Permission.storage.request().isGranted ||
          await Permission.accessMediaLocation.request().isGranted||
      await Permission.manageExternalStorage.request().isGranted) {

        /// for saving in to gallery
        final result =
            await ImageGallerySaver.saveImage(Uint8List.fromList(pngBytes));
        final output = await getApplicationDocumentsDirectory();
        final file = File("${output.path}/${widget.hiveModel.hiveName}.pdf");
        await file.writeAsBytes(await pdf.save());
        // Use the printing package to print the PDF
        await Printing.layoutPdf(
          dynamicLayout: false,
            format: PdfPageFormat.a3,
            onLayout: (PdfPageFormat format) async => pdf.save());
        Utils.hideProgressDialog(context: context);

        CustomSnackBars.instance.showSuccessSnackbar(
            title: "Success", message: "Qr Code Saved to Gallery");

      } else {
        Utils.hideProgressDialog(context: context);
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Permission denied')));
        // openAppSettings();
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Error saving QR Code')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Export"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (widget.isBarcode == false)
                RepaintBoundary(
                    key: _globalKey,
                    child: QrImageView(
                      data: widget.hiveModel.hiveId,
                      backgroundColor: Colors.white,
                      version: QrVersions.auto,
                    )),
              if (widget.isBarcode == true)
                RepaintBoundary(
                  key: _globalKey,
                  child: BarcodeWidget(
                    backgroundColor: Colors.white,
                    data: widget.hiveModel.hiveId,
                    barcode: Barcode.gs128(
                      addSpaceAfterParenthesis: true,
                      escapes: true,
                      keepParenthesis: true,
                      useCode128C: false,
                      useCode128A: false,
                      useCode128B: true
                    ),
                    width: Get.width,
                    height: 200,
                  ),
                ),
              const Spacer(),
              CustomButton(
                  buttonText: "Download",
                  onTap: () {
                    _saveQRCode();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
