import 'package:dreamhrms/screen/employee/employee_details/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:path/path.dart' as path;

import '../../../constants/colors.dart';
import '../../../controller/employee/document_controller.dart';
import '../../../controller/employee_details_controller/docu_controller.dart';
import '../../../widgets/Custom_text.dart';
import '../../../widgets/back_to_screen.dart';
import '../../../widgets/common.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/common_widget_icon_button.dart';
import '../../../widgets/custom_dotted_border.dart';
import '../../../widgets/no_record.dart';
import '../documents/documents_details.dart';

class Documents extends StatelessWidget {
  const Documents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      await DocumentsController.to.getDocuList();
    });
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "documents",
                        color: AppColors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      CommonIconButton(
                        icon: Icon(Icons.add, color: AppColors.white),
                        width: 36,
                        height: 36,
                        onPressed: () {
                          documentsBottomSheet();
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "My Folders",
                        color: AppColors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      CustomText(
                        text: "View All",
                        color: AppColors.blue,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  getFolderList(),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "Recent Files",
                        color: AppColors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      CustomText(
                        text: "View All",
                        color: AppColors.blue,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  getDocumentList(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  getFolderList() {
    return Container(
      height: Get.height * 0.13,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10),
                  width: Get.width * 0.43,
                  decoration: BoxDecoration(
                      color: AppColors.grey.withOpacity(0.1),
                      borderRadius: const BorderRadius.all(Radius.circular(8))),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              "assets/images/file.png",
                              fit: BoxFit.contain,
                              width: 30,
                              height: 30,
                            ),
                            Icon(Icons.more_horiz, color: AppColors.grey)
                          ],
                        ),
                        // SizedBox(height: 8),
                        Spacer(),
                        CustomText(
                          textAlign: TextAlign.left,
                          text: "Personal",
                          color: AppColors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        // SizedBox(height: 8),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              textAlign: TextAlign.left,
                              text: "100 Files",
                              color: AppColors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                            CustomText(
                              textAlign: TextAlign.left,
                              text: "2 GB",
                              color: AppColors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }

  getDocumentList(BuildContext context) {
    return commonLoader(
      loader: DocumentsController.to.showDocuList,
      length: MediaQuery.of(context).size.height.toInt(),
      singleRow: true,
      child: DocumentsController.to.documentModel?.data?.data?.length == 0
          ? NoRecord()
          : ListView.builder(
              shrinkWrap: true,
              itemCount:
                  DocumentsController.to.documentModel?.data?.data?.length ?? 0,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: InkWell(
                    onTap: () {
                      DocumentsController.to.documentIndex = index;
                      Get.to(() => DocumentDetails(
                          url:
                              '${DocumentsController.to.documentModel?.data?.data?[index].documentUrl}'));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          border: Border.all(
                            color: AppColors.grey.withOpacity(0.3),
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 38,
                              width: 38,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: findDocImage(DocumentsController
                                          .to
                                          .documentModel
                                          ?.data
                                          ?.data![index]
                                          .documentUrl)),
                                  color: AppColors.grey.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: Get.width * 0.55,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                      text:
                                          '${DocumentsController.to.documentModel?.data?.data?[index].docName}',
                                      color: AppColors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                  SizedBox(height: 10),
                                  CustomText(
                                      text: 'March 2023',
                                      color: AppColors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ],
                              ),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () {},
                              child: Icon(
                                Icons.more_vert,
                                size: 20,
                                color: AppColors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
    );
  }

  getPathExtension(documentUrl) {
    String extension = path.extension(documentUrl);
    return extension;
  }

  findDocImage(documentUrl) {
    String extension = documentUrl != null ? getPathExtension(documentUrl) : "";
    return extension == "pdf"
        ? AssetImage("assets/images/pdf.png")
        : extension == "doc"
            ? AssetImage("assets/images/doc.png")
            : extension == "ppt"
                ? AssetImage("assets/images/ppt.png")
                : AssetImage("assets/images/xls.png");
  }

  documentsBottomSheet() {
    return Get.bottomSheet(SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40))),
        child: Column(
          children: [buildDocumentInformation()],
        ),
      ),
    ));
  }

  buildDocumentInformation() {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 75,
              height: 4,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.grey),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          CustomText(
              text: 'upload_doc',
              color: AppColors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600),
          const SizedBox(
            height: 25,
          ),
          CustomDottedBorder(
            onPressed: () async {
              await pickFiles(
                loader: DocumentController.to.loader,
                controller: DocumentController.to.documentName,
                binary: DocumentController.to.document,
                key: "Document",
              );
              setState(() {});
            },
          ),
          SizedBox(height: 5),
          if (DocumentController.to.documentName.text == null)
            CustomText(
                text: "doc_validation",
                color: AppColors.red,
                fontSize: 12,
                fontWeight: FontWeight.w500),
          if (DocumentController.to.documentName.text != null)
            CustomText(
                text: DocumentController.to.documentName.text ?? "",
                color: AppColors.green,
                fontSize: 13,
                fontWeight: FontWeight.w600),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: CommonButton(
                  text: "save",
                  textColor: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  // textAlign: TextAlign.center,
                  onPressed: () {
                    DocumentController.to.postDocumentData();
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          BackToScreen(
            text: "cancel",
            arrowIcon: false,
            onPressed: () {
              Get.back();
            },
          ),
        ],
      );
    });
  }
}
