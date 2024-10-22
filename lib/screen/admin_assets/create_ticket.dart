import 'package:dotted_border/dotted_border.dart';
import 'package:dreamhrms/controller/assets/assign_asset_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

import '../../constants/colors.dart';
import '../../controller/assets/add_asset_controller.dart';
import '../../controller/assets/create_ticket.dart';
import '../../controller/common_controller.dart';
import '../../controller/department/deparrtment_controller.dart';
import '../../widgets/Custom_rich_text.dart';
import '../../widgets/Custom_text.dart';
import '../../widgets/back_to_screen.dart';
import '../../widgets/common.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_searchable_dropdown/MainCommonSearchableDropDown.dart';
import '../../widgets/common_textformfield.dart';

class CreateTicket extends StatelessWidget {
  CreateTicket({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                navBackButton(),
                SizedBox(width: 8),
                CustomText(
                  text: "Create Ticket",
                  color: AppColors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ],
        ),
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 18.0,
            ),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomRichText(
                      textAlign: TextAlign.left,
                      text: "Department",
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      textSpan: ' *',
                      textSpanColor: AppColors.red),
                  SizedBox(
                    height: 8,
                  ),
                  DepartmentController.to.showDepartmentList
                      ? Skeleton(
                          height: 30,
                          width: Get.width,
                        )
                      : MainSearchableDropDown(
                          isRequired: true,
                          error: "Required Department Name",
                          hint: "Select Department",
                          title: "department_name",
                          items: DepartmentController.to.departmentModel?.data
                                  ?.map((datum) => datum.toJson())
                                  .toList() ??
                              [],
                          controller: CreateTicketAssetController.to.depName,
                          onChanged: (data) {}),
                  SizedBox(height: 15),
                  CustomRichText(
                      textAlign: TextAlign.left,
                      text: "Ticket Code",
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      textSpan: ' *',
                      textSpanColor: AppColors.red),
                  SizedBox(
                    height: 8,
                  ),
                  CommonTextFormField(
                    controller: CreateTicketAssetController.to.ticketCode,
                    isBlackColors: true,
                    validator: (String? data) {
                      if (data!.isEmpty) {
                        return "Required Ticket Code";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 15),
                  CustomText(
                    textAlign: TextAlign.left,
                    text: "Subject",
                    color: AppColors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CommonTextFormField(
                    controller: CreateTicketAssetController.to.subject,
                    isBlackColors: true,
                    validator: (String? data) {
                      if (data!.isEmpty) {
                        return "Required Subject";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 15),
                  CustomText(
                    textAlign: TextAlign.left,
                    text: "Priority",
                    color: AppColors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(
                    height: 8,
                  ),

                  ///Proority Dropdown.
                  SizedBox(height: 15),
                  CustomText(
                    textAlign: TextAlign.left,
                    text: "Ticket Message",
                    color: AppColors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CommonTextFormField(
                    controller: CreateTicketAssetController.to.ticketMessage,
                    isBlackColors: true,
                    maxlines: 3,
                    validator: (String? data) {
                      if (data!.isEmpty) {
                        return "Required Ticket Message";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 15),
                  CustomText(
                    textAlign: TextAlign.left,
                    text: "Attachment",
                    color: AppColors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CommonController.to.fileLoader == true
                      ? Skeleton(
                          width: double.infinity,
                        )
                      : DottedBorder(
                          color: Colors.grey.withOpacity(0.5),
                          strokeWidth: 2,
                          dashPattern: [10, 6],
                          child: InkWell(
                            onTap: () {
                              pickFiles(
                                  controller:
                                      CreateTicketAssetController.to.imageName,
                                  binary: CreateTicketAssetController
                                      .to.imageFormat,
                                  key: "");
                            },
                            child: Container(
                              height: 80,
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomRichText(
                                      textAlign: TextAlign.center,
                                      text: "Drop your files here or",
                                      color: AppColors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      textSpan: 'Browser',
                                      textSpanColor: AppColors.blue),
                                  CustomText(
                                    text: "Maximum size: 50MB",
                                    color: AppColors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                  if (CreateTicketAssetController.to.imageName.text == "")
                    SizedBox(height: 8),
                  if (CreateTicketAssetController.to.imageName.text.isNotEmpty)
                    SizedBox(height: 8),
                  CustomText(
                    text: CreateTicketAssetController.to.imageName.text,
                    color: AppColors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity / 1.2,
                    child: CommonButton(
                      text: "Save",
                      textColor: AppColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      onPressed: () {
                        if (formKey.currentState?.validate() == true) {}
                        //CreateTicketAssetController.to.addAssetAttachment();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  BackToScreen(
                      text: "cancel",
                      arrowIcon: false,
                      onPressed: () {
                        Get.back();
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
