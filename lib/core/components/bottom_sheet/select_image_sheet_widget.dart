

import 'dart:io';


import 'package:fare/core/components/text/text.dart';
import 'package:fare/core/res/media_res.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';



class SelectImageSheetWidget extends StatelessWidget {
  final BuildContext bottomSheetContext;


  const SelectImageSheetWidget(
      {super.key, required this.bottomSheetContext});


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 200,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15), topLeft: Radius.circular(15))

        ),
        child: Column(
          children: [

            SizedBox(height: 10,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(text: 'بارگذاری'),
                  InkWell(
                    onTap: () {
                      context.pop();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle
                      ),
                      child: Center(
                        child: Icon(Icons.clear, color: Colors.white,),
                      ),
                    ),
                  )

                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10),
              child: Divider(thickness: .5, color: Colors.grey,),
            ),

            InkWell(
              onTap: () async {

                  final ImagePicker picker = ImagePicker();

                  final XFile? image = await picker.pickImage(
                      source: ImageSource.gallery, imageQuality: 70);
                  //context.pop(image);
                  // Navigator.of(context).pop(image);
                  debugPrint('select_image');
                  Navigator.pop(bottomSheetContext, image);


              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 10),
                child: Row(

                  children: [
                    SvgPicture.asset(MediaRes.gallery),
                    SizedBox(width: 10,),
                    MyText(text: 'انتخاب از گالری'),


                  ],
                ),
              ),
            ),

            InkWell(
              onTap: () async {




                final ImagePicker picker = ImagePicker();

                final XFile? image = await picker.pickImage(
                    preferredCameraDevice : CameraDevice.rear,
                    // maxHeight: 1300,
                    // maxWidth: 1080,
                  imageQuality: 90,
                    requestFullMetadata : false,

                    source: ImageSource.camera,);
                debugPrint('take_image');
                //  context.pop(image);
                Navigator.pop(bottomSheetContext, image);



                // File? _scannedImage;
                //
                // final ImagePicker _picker = ImagePicker();
                // final DocumentScanner _scanner = DocumentScanner(options: DocumentScannerOptions());


                // final XFile? image = await _picker.pickImage(source: ImageSource.camera);
                // if (image == null) return;
                //
                // final File imageFile = File(image.path);



                // اسکن سند با ML Kit
                //  DocumentScanningResult document = await _scanner.scanDocument();

                //
                //
                // if (document.images.isNotEmpty) {
                //
                //   final File imageFile = File(document.images.first);
                //
                //
                //   // گرفتن اولین سند تشخیص داده شده
                //
                //  // final File croppedImage = await doc.crop(imageFile);
                //
                //   Navigator.pop(
                //       bottomSheetContext, imageFile);
                //
                //
                //
                // } else {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     const SnackBar(content: Text('سندی پیدا نشد')),
                //   );
                // }



                // final ImagePicker picker = ImagePicker();
                //
                // final XFile? image = await picker.pickImage(
                //     preferredCameraDevice : CameraDevice.rear,
                //     maxHeight: 1100,
                //     maxWidth: 900,
                //     requestFullMetadata : false,
                //
                //     source: ImageSource.camera,imageQuality: 45);
                // debugPrint('take_image');
                //  context.pop(image);

                // این متد اسکن را انجام می‌دهد و تصاویر اسکن‌شده (کروپ‌شده) را برمی‌گرداند

    //             try {
    // // این متد اسکن می‌کنه و خروجی مسیر فایل‌ها رو برمی‌گردونه
    // final pictures = await CunningDocumentScanner.getPictures();
    // print("هیچ تصویری برنگشت1111111");
    // if (pictures != null && pictures.isNotEmpty) {
    // print("هیچ تصویری برنگشت3333");
    // } else {
    // print("هیچ تصویری برنگشت");
    // }
    // } catch (e) {
    // print("خطا در اسکن: $e");
    // }

                print("هیچ تصویری برنگشت555555");



                // final imagesPath = await CunningDocumentScanner.getPictures(
                //   noOfPages: 1, // Limit the number of pages to 1
                //    // Allow the user to also pick an image from his gallery
                // );
                //
                // Navigator.pop(
                //     bottomSheetContext, File(imagesPath.toString()));


                // List<String>? scannedImagePaths;
                // try {
                //   dynamic result = await FlutterDocScanner()
                //       .getScannedDocumentAsImages(page: 1);
                //   // اگر null نیامد
                //   if (result != null && result is List) {
                //     // فرض می‌کنیم لیستی از مسیرهای فایل است
                //
                //     scannedImagePaths = List<String>.from(result);
                //   }
                // } on PlatformException catch (e) {
                //   print("خطا در اسکن: $e");
                // }


                // final  scannedDocuments = await FlutterDocScanner().getScannedDocumentAsImages() ??
                // Navigator.pop(
                //     bottomSheetContext, File(scannedImagePaths![0].toString()));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 10),
                child: Row(

                  children: [
                    SvgPicture.asset(MediaRes.camera),
                    SizedBox(width: 10,),
                    MyText(text: 'انتخاب از دوربین'),


                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
//   Future<void> scanDocumentAsImages() async {
//     dynamic scannedDocuments;
//     try {
//       scannedDocuments =
//           await FlutterDocScanner().getScannedDocumentAsImages() ??
//               'Unknown platform documents';
//     } on PlatformException {
//       scannedDocuments = 'Failed to get scanned documents.';
//     }
//     print(scannedDocuments.toString());
//     if (!mounted) return;
//     setState(() {
//       _scannedDocuments = scannedDocuments;
//     });
//   }
// }


}
