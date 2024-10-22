import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:dreamhrms/screen/branch/add_branch_screen.dart';
import 'package:dreamhrms/widgets/Custom_text.dart';
import 'package:dreamhrms/widgets/picked_image_error_size_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localization/localization.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

import '../../../constants/colors.dart';
import '../../../controller/branch_controller.dart';
import '../../../controller/common_controller.dart';
import '../../../widgets/Custom_rich_text.dart';
import '../../../widgets/back_to_screen.dart';
import '../../../widgets/common.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/common_textformfield.dart';
import '../../../widgets/custom_dotted_border.dart';

class OfficeDetailsScreen extends StatelessWidget {
  OfficeDetailsScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                      text: "office_details",
                      color: AppColors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                  SizedBox(height: 20),
                  CustomRichText(
                      textAlign: TextAlign.left,
                      text: 'office_name',
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      textSpan: '*',
                      textSpanColor: AppColors.red),
                  SizedBox(height: 10),
                  CommonTextFormField(
                    controller: BranchController.to.officeName,
                    isBlackColors: true,
                    keyboardType: TextInputType.name,
                    validator: (String? data) {
                      if (data == "" || data == null) {
                        print("Empty data");
                        return "required_office_name";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  CustomRichText(
                      textAlign: TextAlign.left,
                      text: 'office_full_address',
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      textSpan: '*',
                      textSpanColor: AppColors.red),
                  SizedBox(height: 10),
                  CommonTextFormField(
                    controller: BranchController.to.officeFullAddress,
                    isBlackColors: true,
                    keyboardType: TextInputType.name,
                    validator: (String? data) {
                      if (data == "" || data == null) {
                        print("Empty data");
                        return "required_office_full_address";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  CustomRichText(
                      textAlign: TextAlign.left,
                      text: 'office_image',
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      textSpan: '*',
                      textSpanColor: AppColors.red),
                  const SizedBox(
                    height: 12,
                  ),
                  CommonController.to.imageLoader == true
                      ? Skeleton()
                      : BranchController.to.officeImage.text != ""
                          ? InkWell(
                              onTap: () async {
                                _onImageSelectedFromGallery(
                                    BranchController.to.officeImage);
                              },
                              child: Container(
                                height: 100,
                                width: 100,
                                child: BranchController.to.imageFormat ==
                                            "Network" ||
                                        BranchController.to.isNetworkImage(
                                            BranchController
                                                .to.officeImage.text)
                                    ? Image.network(
                                        BranchController.to.officeImage.text)
                                    : Image.file(File(BranchController
                                        .to.officeImage.text
                                        .toString())),
                              ),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DottedBorder(
                                  color: Colors.grey.withOpacity(0.5),
                                  strokeWidth: 2,
                                  dashPattern: [10, 6],
                                  child: InkWell(
                                    onTap: () {
                                      BranchController.to.imageFormat = "";
                                      _onImageSelectedFromGallery(
                                          BranchController.to.officeImage);
                                    },
                                    child: Container(
                                      height: 80,
                                      width: double.infinity,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CustomRichText(
                                              textAlign: TextAlign.center,
                                              text: "drop_your_files_here_or",
                                              color: AppColors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              textSpan: 'Browser',
                                              textSpanColor: AppColors.blue),
                                          SizedBox(height: 10),
                                          CustomText(
                                            text: "maximum_size",
                                            color: AppColors.grey,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                if (BranchController.to.officeImage.text == "")
                                  CustomText(
                                      text: "required_office_image",
                                      color: Colors.red.shade800,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                              ],
                            ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CommonButton(
                            text: "Next",
                            textColor: AppColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                Get.back();
                                Get.to(() => AddBranchScreen(
                                      index: 1,
                                    ));
                              }
                              // BranchController.to.addBranchAttachment(
                              //  "30");
                            }),
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
                      BranchController.to.isEdit = "";
                      Get.back();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  void _onImageSelectedFromGallery(controller) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      CommonController.to.imageLoader = true;
      controller.text = pickedFile.path;
      BranchController.to.imageFormat;
      final file = File(controller.text);
      final length = await file.length();
      final imageSizeMB = length ~/ (1024 * 1024);
      CommonController.to.officeImageSize = imageSizeMB;
      print('image length $imageSizeMB');
      CommonController.to.imageLoader = false;
    }
  }
}
