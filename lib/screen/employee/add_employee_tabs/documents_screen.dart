import 'package:dreamhrms/controller/employee/employee_controller.dart';
import 'package:dreamhrms/screen/employee/employee_details/profile.dart';
import 'package:dreamhrms/screen/main_screen.dart';
import 'package:dreamhrms/widgets/Custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

import '../../../constants/colors.dart';
import '../../../controller/common_controller.dart';
import '../../../controller/employee/document_controller.dart';
import '../../../controller/employee_details_controller/docu_controller.dart';
import '../../../services/utils.dart';
import '../../../widgets/Custom_rich_text.dart';
import '../../../widgets/back_to_screen.dart';
import '../../../widgets/common.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/custom_dotted_border.dart';

class DocumentsScreen extends StatelessWidget {
  const DocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((value) async {
      DocumentController.to.loader = true;
      CommonController.to.fileLoader = true;
      CommonController.to.clearValues();
      await DocumentController.to.disposeValues();
      if (EmployeeController.to.isEmployee == "Edit") {
        await DocumentsController.to.getDocuList(type: "Edit");
        await DocumentController.to
            .editSetValues(DocumentsController.to.documentModel?.data);
      }
      DocumentController.to.loader = false;
      CommonController.to.fileLoader = false;
    });
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Obx(
            () => commonLoader(
              length: MediaQuery.of(context).size.height.toInt(),
              singleRow: true,
              loader: DocumentController.to.loader,
              child: CommonController.to.fileLoader == true
                  ? Skeleton()
                  : Column(
                      children: [
                        buildDocumentInformation(context),
                        const SizedBox(
                          height: 30,
                        ),
                        buildWorkExperience(context),
                        const SizedBox(
                          height: 30,
                        ),
                        buildEducational(context),
                        SizedBox(height: 30),
                        Row(
                          children: [
                            Expanded(
                              child: CommonButton(
                                text: "save_next",
                                textColor: AppColors.white,
                                buttonLoader: CommonController.to.buttonLoader,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                // textAlign: TextAlign.center,
                                onPressed: () async {
                                  if (DocumentController.to.idProofName.text.isNotEmpty &&
                                      DocumentController
                                          .to.addressName.text.isNotEmpty &&
                                      DocumentController
                                          .to.indentName.text.isNotEmpty &&
                                      DocumentController
                                          .to.experienceName.text.isNotEmpty &&
                                      DocumentController
                                          .to.certificateName.text.isNotEmpty &&
                                      DocumentController
                                          .to.courseName.text.isNotEmpty) {
                                    CommonController.to.buttonLoader = true;
                                    EmployeeController.to.isEmployee == "Edit"
                                        ? await DocumentController.to
                                            .editDocuments()
                                        : await DocumentController.to
                                            .postDocumentData();
                                    CommonController.to.buttonLoader = false;
                                  } else {
                                    UtilService().showToast("error",
                                        message:
                                            "required_fields".toString());
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        BackToScreen(
                          text: "cancel",
                          arrowIcon: false,
                          onPressed: () {
                            Get.offAll(() => MainScreen());
                          },
                        ),
                        SizedBox(height: 20),
                        BackToScreen(
                          text: "Skip",
                          filled: true,
                          arrowIcon: false,
                          onPressed: () {
                            Get.offAll(() => MainScreen());
                          },
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  buildDocumentInformation(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
            text: 'document_information',
            color: AppColors.blue,
            fontSize: 13,
            fontWeight: FontWeight.w400),
        const SizedBox(
          height: 25,
        ),
        CustomRichText(
          textAlign: TextAlign.left,
          text: "id_proof",
          color: AppColors.black,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          textSpan: "*",
          textSpanColor: AppColors.red,
        ),
        SizedBox(height: 10),
        CustomDottedBorder(onPressed: () {
          pickFiles(
              loader: DocumentController.to.loader,
              controller: DocumentController.to.idProofName,
              binary: DocumentController.to.idProof,
              key: "ID");
        }),
        SizedBox(height: 5),
        if (DocumentController.to.idProofName.text == "")
          CustomText(
              text: "id_proof_validation",
              color: AppColors.red,
              fontSize: 12,
              fontWeight: FontWeight.w500),
        if (DocumentController.to.idProofName.text != null &&
            (CommonController.to.officeImageSize <= 50))
          CustomText(
              text: DocumentController.to.idProofName.text,
              color: AppColors.green,
              fontSize: 13,
              fontWeight: FontWeight.w600),
        if (DocumentController.to.idProofName.text != null &&
            (CommonController.to.officeImageSize > 50))
          CustomText(
              text: "image_size_exceed_50mb",
              color: AppColors.red,
              fontSize: 12,
              fontWeight: FontWeight.w500),
        const SizedBox(
          height: 20,
        ),
        CustomRichText(
          textAlign: TextAlign.left,
          text: "address_proof",
          color: AppColors.black,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          textSpan: "*",
          textSpanColor: AppColors.red,
        ),
        SizedBox(height: 10),
        CustomDottedBorder(onPressed: () {
          pickFiles(
              loader: DocumentController.to.loader,
              controller: DocumentController.to.addressName,
              binary: DocumentController.to.addressBytes,
              key: "Address");
        }),
        SizedBox(height: 5),
        if (DocumentController.to.addressName.text == "")
          CustomText(
              text: "address_proof_validation",
              color: AppColors.red,
              fontSize: 12,
              fontWeight: FontWeight.w500),
        if (DocumentController.to.addressName.text != null &&
            (CommonController.to.officeImageSize <= 50))
          CustomText(
              text: DocumentController.to.addressName.text,
              color: AppColors.green,
              fontSize: 13,
              fontWeight: FontWeight.w600),
        if (DocumentController.to.addressName.text != null &&
            (CommonController.to.officeImageSize > 50))
          CustomText(
              text: "image_size_exceed_50mb",
              color: AppColors.red,
              fontSize: 12,
              fontWeight: FontWeight.w500),
      ],
    );
  }

  buildWorkExperience(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
            text: 'work_exp_cert',
            color: AppColors.blue,
            fontSize: 13,
            fontWeight: FontWeight.w400),
        const SizedBox(
          height: 25,
        ),
        CustomRichText(
          textAlign: TextAlign.left,
          text: "letter_of_indent",
          color: AppColors.black,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          textSpan: " *",
          textSpanColor: AppColors.red,
        ),
        SizedBox(height: 10),
        CustomDottedBorder(onPressed: () {
          pickFiles(
              loader: DocumentController.to.loader,
              controller: DocumentController.to.indentName,
              binary: DocumentController.to.indentBytes,
              key: "Indent");
        }),
        SizedBox(height: 5),
        if (DocumentController.to.indentName.text == "")
          CustomText(
              text: "letter_of_indent_validation",
              color: AppColors.red,
              fontSize: 12,
              fontWeight: FontWeight.w500),
        if (DocumentController.to.indentName.text != null &&
            (CommonController.to.officeImageSize <= 50))
          CustomText(
              text: DocumentController.to.indentName.text,
              color: AppColors.green,
              fontSize: 13,
              fontWeight: FontWeight.w600),
        if (DocumentController.to.indentName.text != null &&
            (CommonController.to.officeImageSize > 50))
          CustomText(
              text: "image_size_exceed_50mb",
              color: AppColors.red,
              fontSize: 12,
              fontWeight: FontWeight.w500),
        const SizedBox(
          height: 20,
        ),
        CustomRichText(
          textAlign: TextAlign.left,
          text: "work_exp",
          color: AppColors.black,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          textSpan: " *",
          textSpanColor: AppColors.red,
        ),
        SizedBox(height: 10),
        CustomDottedBorder(onPressed: () {
          pickFiles(
              loader: DocumentController.to.loader,
              controller: DocumentController.to.experienceName,
              binary: DocumentController.to.expCertificate,
              key: "ExpCertificate");
        }),
        SizedBox(height: 5),
        if (DocumentController.to.experienceName.text == "")
          CustomText(
              text: "work_exp_validation",
              color: AppColors.red,
              fontSize: 12,
              fontWeight: FontWeight.w500),
        if (DocumentController.to.experienceName.text != null &&
            (CommonController.to.officeImageSize <= 50))
          CustomText(
              text: DocumentController.to.experienceName.text,
              color: AppColors.green,
              fontSize: 13,
              fontWeight: FontWeight.w600),
        if (DocumentController.to.experienceName.text != null &&
            (CommonController.to.officeImageSize > 50))
          CustomText(
              text: "image_size_exceed_50mb",
              color: AppColors.red,
              fontSize: 12,
              fontWeight: FontWeight.w500),
      ],
    );
  }

  buildEducational(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
            text: 'educational_cert',
            color: AppColors.blue,
            fontSize: 13,
            fontWeight: FontWeight.w400),
        const SizedBox(
          height: 25,
        ),
        CustomRichText(
          textAlign: TextAlign.left,
          text: "letter_cert",
          color: AppColors.black,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          textSpan: " *",
          textSpanColor: AppColors.red,
        ),
        SizedBox(height: 10),
        CustomDottedBorder(onPressed: () {
          pickFiles(
              loader: DocumentController.to.loader,
              controller: DocumentController.to.certificateName,
              binary: DocumentController.to.certificateBytes,
              key: "DegreeCertificate");
        }),
        SizedBox(height: 5),
        if (DocumentController.to.certificateName.text == "")
          CustomText(
              text: "letter_cert_validation",
              color: AppColors.red,
              fontSize: 12,
              fontWeight: FontWeight.w500),
        if (DocumentController.to.certificateName.text != null &&
            (CommonController.to.officeImageSize <= 50))
          CustomText(
              text: DocumentController.to.certificateName.text,
              color: AppColors.green,
              fontSize: 13,
              fontWeight: FontWeight.w600),
        if (DocumentController.to.certificateName.text != null &&
            (CommonController.to.officeImageSize > 50))
          CustomText(
              text: "image_size_exceed_50mb",
              color: AppColors.red,
              fontSize: 12,
              fontWeight: FontWeight.w500),
        const SizedBox(
          height: 20,
        ),
        CustomRichText(
          textAlign: TextAlign.left,
          text: "exp_course_completion",
          color: AppColors.black,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          textSpan: " *",
          textSpanColor: AppColors.red,
        ),
        SizedBox(height: 10),
        CustomDottedBorder(onPressed: () {
          pickFiles(
              controller: DocumentController.to.courseName,
              binary: DocumentController.to.courseBytes,
              key: "CourseCertificate",
              loader: DocumentController.to.loader);
        }),
        SizedBox(height: 5),
        if (DocumentController.to.courseName.text == "")
          CustomText(
              text: "req_exp_course_completion",
              color: AppColors.red,
              fontSize: 12,
              fontWeight: FontWeight.w500),
        if (DocumentController.to.courseName.text != null &&
            (CommonController.to.officeImageSize <= 50))
          CustomText(
              text: DocumentController.to.courseName.text,
              color: AppColors.green,
              fontSize: 13,
              fontWeight: FontWeight.w600),
        if (DocumentController.to.courseName.text != null &&
            (CommonController.to.officeImageSize > 50))
          CustomText(
              text: "image_size_exceed_50mb",
              color: AppColors.red,
              fontSize: 12,
              fontWeight: FontWeight.w500),
      ],
    );
  }
}
