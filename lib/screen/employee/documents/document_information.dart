import 'dart:io';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:dreamhrms/controller/common_controller.dart';
import 'package:dreamhrms/controller/employee_details_controller/docu_controller.dart';
import 'package:dreamhrms/services/utils.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../constants/colors.dart';
import '../../../widgets/Custom_text.dart';
import '../../../widgets/common.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/pdf_viewer.dart';
import '../../../widgets/stacket_image_widget.dart';
import 'documents_details.dart';
import 'package:http/http.dart' as http;

class DocumentsInformation extends StatelessWidget {
  const DocumentsInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Container(
            width: Get.width,
            height: Get.height,
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/assets.png",
                  fit: BoxFit.fill,
                  width: Get.width,
                ),
                Positioned(
                  top: Get.height * 0.25,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 500,
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30))),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            CustomText(
                              text: "document_information",
                              color: AppColors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                            SizedBox(height: 20),
                            commonDataDisplay(
                                title1: "doc_name",
                                text1:
                                    "${DocumentsController.to.documentModel?.data?.data![DocumentsController.to.documentIndex].docName}",
                                title2: "created_on",
                                text2: "NA",
                                titleFontSize1: 13,
                                titleFontSize2: 13,
                                textFontSize1: 14,
                                textFontSize2: 14),
                            SizedBox(height: 15),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: Get.width * 0.40,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                          text: "file_owner",
                                          color: AppColors.grey,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400),
                                      SizedBox(height: 8),
                                      Row(
                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          ClipOval(
                                              child: Image.network(
                                            "https://media.istockphoto.com/id/1318482009/photo/young-woman-ready-for-job-business-concept.jpg?s=612x612&w=0&k=20&c=Jc1NcoUMoM78AxPTh9EApaPU2kXh2evb499JgW99b0g=",
                                            fit: BoxFit.cover,
                                            width: 38.0,
                                            height: 38.0,
                                          )),
                                          SizedBox(width: 10),
                                          Align(
                                            alignment: Alignment.center,
                                            child: CustomText(
                                                textAlign: TextAlign.center,
                                                text: "NA",
                                                color: AppColors.grey,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                        text: "who_access",
                                        color: AppColors.grey,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400),
                                    SizedBox(height: 8),
                                    buildExpandedBox(
                                      color: Colors.white,
                                      children: [
                                        buildStackedImages(
                                            direction: TextDirection.rtl,
                                            imgsize: 38,
                                            showCount: true),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            commonDataDisplay(
                                title1: "doc_size",
                                text1: "NA",
                                title2: "view",
                                text2: "NA",
                                titleFontSize1: 13,
                                titleFontSize2: 13,
                                textFontSize1: 14,
                                textFontSize2: 14),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: [
                        SizedBox(
                          width: Get.width * 0.38,
                          child: CommonButton(
                            text: "view",
                            iconText: true,
                            textColor: AppColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            textAlign: TextAlign.center,
                            icons: Icons.remove_red_eye_outlined,
                            iconSize: 20,
                            onPressed: () {
                              // Get.to(()=>PdfViewer());
                              String title =
                                  "${DocumentsController.to.documentModel?.data?.data![DocumentsController.to.documentIndex].docName}";
                              String url =
                                  "${DocumentsController.to.documentModel?.data?.data![DocumentsController.to.documentIndex].documentUrl}";
                              openPdfDialog(title, url);
                            },
                          ),
                        ),
                        SizedBox(width: 15),
                        SizedBox(
                          width: Get.width * 0.38,
                          child: CommonButton(
                            text: "download",
                            iconText: true,
                            textColor: AppColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            textAlign: TextAlign.center,
                            icons: Icons.file_download_outlined,
                            iconSize: 20,
                            buttonLoader: CommonController.to.buttonLoader,
                            onPressed: () async{
                              CommonController.to.buttonLoader = true;
                              await downloadAndSharePDF();
                              CommonController.to.buttonLoader = false;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> downloadAndSharePDF() async {
    Directory? downloadsDirectory;

    if (Platform.isAndroid) {
      downloadsDirectory = await DownloadsPathProvider.downloadsDirectory;
    }

    String url =
        "${DocumentsController.to.documentModel?.data?.data![DocumentsController.to.documentIndex].documentUrl}";
    String fileName =
        "${DocumentsController.to.documentModel?.data?.data![DocumentsController.to.documentIndex].docName}";

    final Directory appDocumentsDirectory =
        await getApplicationDocumentsDirectory();
    final String filePath =
        '${downloadsDirectory?.path ?? appDocumentsDirectory.path}/$fileName';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final File file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        UtilService().showToast("success", message: "${"file_download"}");

        if (Platform.isIOS) {
          await Share.shareFiles([filePath], text: '${"check_out_pdf_file"}');
        }
      } else {
        print('Error: HTTP request returned ${response.statusCode}');
        UtilService().showToast("error", message: "${"file_not_download"}");
      }
    } catch (e) {
      print('Error downloading the file: $e');
      UtilService().showToast("error", message: "${"file_not_download"}");
    }
  }

  void openPdfDialog(String title, pdfUrl) async {
    PDFDocument doc = await PDFDocument.fromURL(pdfUrl);

    return Get.defaultDialog(
      title: title,
      titleStyle: TextStyle(fontSize: 14),
      content: Container(
        width: double.maxFinite,
        height: 500, // Adjust the height as needed
        child: PDFViewer(
          showIndicator: false,
          document: doc,
          // Optionally, you can pass configuration options here
        ),
      ),
    );
  }
}
