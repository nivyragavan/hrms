import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:dreamhrms/screen/settings/company_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localization/localization.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

import '../../../constants/colors.dart';
import '../../../controller/common_controller.dart';
import '../../../controller/department/add_department_controller.dart';
import '../../../controller/settings/company/company_settings.dart';
import '../../../widgets/Custom_rich_text.dart';
import '../../../widgets/Custom_text.dart';
import '../../../widgets/back_to_screen.dart';
import '../../../widgets/common.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/common_textformfield.dart';

class CompanyProfile extends StatelessWidget {
   CompanyProfile({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();

   @override
  Widget build(BuildContext context) {
     Future.delayed(Duration.zero).then((value) async {
       await CompanySettingsController.to.setWorkingDays();
     });
    return GestureDetector(
      onTap: commonTapHandler,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Form(
          key:formKey, child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Obx(()=>
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomRichText(
                        textAlign: TextAlign.left,
                        text: "company_name",
                        color: AppColors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        textSpan: ' *',
                        textSpanColor: AppColors.red),
                    SizedBox(height: 10),
                    CompanySettingsController.to.companyLoader?Skeleton(height: 30,
                      width: Get.width):CommonTextFormField(
                      controller: CompanySettingsController.to.companyName,
                      isBlackColors: true,
                      keyboardType: TextInputType.name,
                      validator: (String? data) {
                        if (data == "" || data == null) {
                          return "company_name_validator";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 10),
                    CustomRichText(
                        textAlign: TextAlign.left,
                        text: "legal_name",
                        color: AppColors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        textSpan: ' *',
                        textSpanColor: AppColors.red),
                    SizedBox(height: 10),
                    CompanySettingsController.to.companyLoader?Skeleton(height: 30,
                        width: Get.width):CommonTextFormField(
                      controller: CompanySettingsController.to.legalName,
                      isBlackColors: true,
                      keyboardType: TextInputType.name,
                      validator: (String? data) {
                        if (data == "" || data == null) {
                          return "legal_name_validator";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 10),
                  CustomRichText(
                        textAlign: TextAlign.left,
                        text: "company_website",
                        color: AppColors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        textSpan: ' *',
                        textSpanColor: AppColors.red),
                    SizedBox(height: 10),
                    CompanySettingsController.to.companyLoader?Skeleton(height: 30,
                        width: Get.width):CommonTextFormField(
                      controller: CompanySettingsController.to.companyWebsite,
                      isBlackColors: true,
                      keyboardType: TextInputType.name,
                      validator: (String? data) {
                        if (data == "" || data == null) {
                          return "company_website_validator";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 10),
                    CustomRichText(
                        textAlign: TextAlign.left,
                        text: "company_reg",
                        color: AppColors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        textSpan: ' *',
                        textSpanColor: AppColors.red),
                    SizedBox(height: 10),
                    CompanySettingsController.to.companyLoader?Skeleton(height: 30,
                        width: Get.width):CommonTextFormField(
                      controller: CompanySettingsController.to.companyLogo,
                      isBlackColors: true,
                      keyboardType: TextInputType.name,
                      validator: (String? data) {
                        if (data == "" || data == null) {
                          return "company_register_validator";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 10),
                    CustomRichText(
                        textAlign: TextAlign.left,
                        text: "company_logo",
                        color: AppColors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        textSpan: ' ',
                        textSpanColor: AppColors.red),
                    SizedBox(height: 10),
                    CompanySettingsController.to.companyLoader?Skeleton(height: 30,
                        width: Get.width):CommonController.to.imageLoader == true
                          ? Skeleton()
                          : CompanySettingsController.to.companyLogo.text != ""
                          ? InkWell(
                        onTap: () async {
                          _onImageSelectedFromGallery(
                              CompanySettingsController.to.companyLogo);
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.grey.withAlpha(40),
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child:
                              AddDepartmentController.to.isNetworkImage(
                                  CompanySettingsController.to.companyLogo.text)
                              ? Image.network(CompanySettingsController.to.companyLogo.text)
                              : Image.file(File(CompanySettingsController.to.companyLogo.text
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
                                _onImageSelectedFromGallery(
                                    CompanySettingsController.to.companyLogo);
                              },
                              child: Container(
                                height: 80,
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomRichText(
                                        textAlign: TextAlign.center,
                                        text: "drop_your_files_here_or",
                                        color: AppColors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        textSpan: 'browser',
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
                        ],
                      ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          child: CommonButton(
                            text: "next",
                            textColor: AppColors.white,
                            fontSize: 16,
                            buttonLoader:CommonController.to.buttonLoader,
                            fontWeight: FontWeight.w500,
                            // textAlign: TextAlign.center,
                            onPressed: () async {
                              // Get.back();
                              // Get.to(() => CompanySettings(selectedIndex: 1));
                              if (formKey.currentState!.validate()) {
                                 CommonController.to.buttonLoader=true;
                                 Get.back();
                                 Get.to(() => CompanySettings(selectedIndex: 1));
                                CommonController.to.buttonLoader=false;
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
                        Get.back();
                      },
                    )
                  ],
              ),
            ),
          ),
        ),
        ),
      ),
    );
  }

   void _onImageSelectedFromGallery(controller) async {
     final pickedFile =
     await ImagePicker().pickImage(source: ImageSource.gallery);
     if (pickedFile != null) {
       CommonController.to.imageLoader = true;
       controller.text = pickedFile.path ?? "";
       AddDepartmentController.to.imageFormat = "";
       CommonController.to.imageLoader = false;
     }
   }
}
