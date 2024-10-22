import 'dart:io';

import 'package:cupertino_stepper/cupertino_stepper.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dreamhrms/controller/theme_controller.dart';
import 'package:dreamhrms/screen/announcement/announcement.dart';
import 'package:dreamhrms/screen/announcement/create_attendance_tabs/department_tab_screen.dart';
import 'package:dreamhrms/screen/announcement/create_attendance_tabs/employees_tab_screen.dart';
import 'package:dreamhrms/screen/announcement/create_attendance_tabs/position_tab_screen.dart';
import 'package:dreamhrms/screen/employee/asset_details/attachment.dart';
import 'package:dreamhrms/services/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localization/localization.dart';
import 'package:skeleton_animation/skeleton_animation.dart';
import '../../constants/colors.dart';
import '../../controller/announcement_controller.dart';
import '../../controller/common_controller.dart';
import '../../services/provision_check.dart';
import '../../services/provision_check.dart';
import '../../widgets/Custom_rich_text.dart';
import '../../widgets/Custom_text.dart';
import '../../widgets/back_to_screen.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_textformfield.dart';

class CreateAnnouncement extends StatelessWidget {
  const CreateAnnouncement({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (AnnouncementController.to.isEdit == "") {
          validate();
        }
        return false;
      },
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Row(
              children: [
                InkWell(
                  onTap: () {
                    validate();
                  },
                  child: Icon(Icons.arrow_back_ios_new_outlined,
                      color: ThemeController.to.checkThemeCondition() == true ? AppColors.white : AppColors.black),
                ),
                SizedBox(width: 8),
                CustomText(
                  text: AnnouncementController.to.isEdit == ""
                      ? "Create Announcement"
                      : "Edit Announcement",
                  color: AppColors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
          body: Obx(() => CupertinoStepper(
                  type: StepperType.horizontal,
                  physics: ScrollPhysics(),
                  currentStep: AnnouncementController.to.currentStep,
                  onStepContinue: continueStep,
                  onStepCancel: cancelStep,
                  // onStepTapped: (index) {
                  //   AnnouncementController.to.currentStep = index;
                  // },
                  controlsBuilder: AnnouncementController.to.currentStep == 0
                      ? controlsBuilder
                      : (context, details) {
                          return SizedBox();
                        },
                  steps: [
                    Step(
                      isActive: AnnouncementController.to.currentStep >= 0,
                      title: CustomText(
                          text: 'information',
                          color: AppColors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomRichText(
                              textAlign: TextAlign.left,
                              text: 'subject',
                              color: AppColors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              textSpan: '*',
                              textSpanColor: AppColors.red),
                          SizedBox(height: 10),
                          CommonTextFormField(
                            controller: AnnouncementController.to.subject,
                            isBlackColors: true,
                            hintText: "enter_subject",
                            keyboardType: TextInputType.name,
                            validator: (String? data) {
                              if (data == "" || data == null) {
                                return "required_subject";
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: 20),
                          CustomRichText(
                              textAlign: TextAlign.left,
                              text: 'message',
                              color: AppColors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              textSpan: '*',
                              textSpanColor: AppColors.red),
                          SizedBox(height: 10),
                          CommonTextFormField(
                            controller: AnnouncementController.to.message,
                            isBlackColors: true,
                            hintText: "enter_message",
                            maxlines: 5,
                            keyboardType: TextInputType.name,
                            validator: (String? data) {
                              if (data == "" || data == null) {
                                return "required_message";
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: 20),
                          CustomRichText(
                              textAlign: TextAlign.left,
                              text: 'attachment',
                              color: AppColors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              textSpan: '',
                              textSpanColor: AppColors.red),
                          const SizedBox(
                            height: 12,
                          ),
                          CommonController.to.imageLoader == true
                              ? Skeleton()
                              : AnnouncementController.to.attachment.text != ""
                                  ? InkWell(
                                      onTap: () async {
                                        _onImageSelectedFromGallery(
                                            AnnouncementController
                                                .to.attachment);
                                      },
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        child: AnnouncementController
                                                        .to.imageFormat ==
                                                    "Network" ||
                                                AnnouncementController.to
                                                    .isNetworkImage(
                                                        AnnouncementController
                                                            .to.attachment.text)
                                            ? Image.network(
                                                AnnouncementController
                                                    .to.attachment.text)
                                            : Image.file(File(
                                                AnnouncementController
                                                    .to.attachment.text
                                                    .toString())),
                                      ),
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        DottedBorder(
                                          color: Colors.grey.withOpacity(0.5),
                                          strokeWidth: 2,
                                          dashPattern: [10, 6],
                                          child: InkWell(
                                            onTap: () {
                                              AnnouncementController
                                                  .to.imageFormat = "";
                                              _onImageSelectedFromGallery(
                                                  AnnouncementController
                                                      .to.attachment);
                                            },
                                            child: Container(
                                              height: 80,
                                              width: double.infinity,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  CustomRichText(
                                                      textAlign:
                                                          TextAlign.center,
                                                      text:
                                                          "drop_your_image_here_or"
                                                              ,
                                                      color: AppColors.black,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      textSpan: 'browser',
                                                      textSpanColor:
                                                          AppColors.blue),
                                                  SizedBox(height: 10),
                                                  CustomText(
                                                    text: "maximum_size: 50MB",
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
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                    Step(
                        isActive: AnnouncementController.to.currentStep >= 1,
                        title: CustomText(
                            text: 'members',
                            color: AppColors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                        content: ProvisionsWithIgnorePointer(
                          provision: "Announcement",
                          type:"create",
                          child: Column(
                            children: [
                              TabBar(
                                  indicatorColor: AppColors.blue,
                                  unselectedLabelColor: AppColors.grey,
                                  labelColor: AppColors.blue,
                                  tabs: [
                                    Tab(
                                      text: "employees",
                                      icon: Icon(Icons.person),
                                    ),
                                    Tab(
                                      text: "department",
                                      icon: Icon(Icons.apartment),
                                    ),
                                    Tab(
                                      text: "position",
                                      icon: Icon(Icons.flag),
                                    )
                                  ]),
                              Container(
                                height: Get.height * 0.70,
                                child: TabBarView(children: [
                                  EmployeesTabScreen(),
                                  DepartmentTabScreen(),
                                  PositionTabScreen()
                                ]),
                              )
                            ],
                          ),
                        ))
                  ])),
        ),
      ),
    );
  }

  Widget controlsBuilder(context, details) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: CommonButton(
              iconText: true,
              text: 'next',
              icons: Icons.check,
              iconSize: 18,
              textColor: AppColors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              onPressed: details.onStepContinue),
        ),
        SizedBox(
          width: 20,
        ),
        SizedBox(
          width: 100,
          child: BackToScreen(
              text: "cancel",
              filled: true,
              icon: "assets/icons/cancel.svg",
              iconColor: AppColors.grey,
              arrowIcon: true,
              onPressed: details.onStepCancel),
        ),
      ],
    );
  }

  continueStep() async {
    if (AnnouncementController.to.isEdit == "") {
      await AnnouncementController.to.postAnnouncement(false, false);
      if (AnnouncementController.to.announcementId != null &&
          AnnouncementController.to.attachment.text.isNotEmpty) {
        await AnnouncementController.to.announcementImage(
            announcementId: AnnouncementController.to.announcementId);
        if (AnnouncementController.to.currentStep != 1) {
          AnnouncementController.to.currentStep += 1;
        }
      } else {
        if (AnnouncementController.to.announcementId != null &&
            AnnouncementController.to.attachment.text.isEmpty) {
          if (AnnouncementController.to.currentStep != 1) {
            AnnouncementController.to.currentStep += 1;
          }
        }
      }
    } else {
      await AnnouncementController.to.postAnnouncement(true, false,
          announcementId:AnnouncementController.to.announcementId);

        if (AnnouncementController.to.currentStep != 1) {
          AnnouncementController.to.currentStep += 1;
        }
       else {
        if (AnnouncementController.to.announcementId != null &&
            AnnouncementController.to.attachment.text.isEmpty) {
          if (AnnouncementController.to.currentStep != 1) {
            AnnouncementController.to.currentStep += 1;
          }
        }
      }
    }
  }

  cancelStep() {
    if (AnnouncementController.to.currentStep != 0) {
      AnnouncementController.to.currentStep -= 1;
    }
  }

  void _onImageSelectedFromGallery(controller) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      CommonController.to.imageLoader = true;
      controller.text = pickedFile.path;
      AnnouncementController.to.imageFormat;
      final file = File(controller.text);
      final length = await file.length();
      final imageSizeMB = length ~/ (1024 * 1024);
      CommonController.to.officeImageSize = imageSizeMB;
      print('image length $imageSizeMB');
      CommonController.to.imageLoader = false;
    }
  }

  validate() async {
    if (AnnouncementController.to.isEdit == "Edit") {
      Get.back();
    }
    else if (AnnouncementController.to.currentStep == 0 ||
        AnnouncementController.to.currentStep == 1) {
      if (AnnouncementController.to.subject.text != "" &&
          AnnouncementController.to.message.text != "") {
        AnnouncementController.to.isAdded == true ? null :
        await AnnouncementController.to.postAnnouncement(false, true);
        UtilService()
            .showToast("Success", message: "announcement_saved_as_draft");
        if (AnnouncementController.to.announcementId != null &&
            AnnouncementController.to.attachment.text.isNotEmpty) {
          await AnnouncementController.to.announcementImage(
              announcementId: AnnouncementController.to.announcementId);
        }
        AnnouncementController.to.getAnnouncementDraftList();
         Get.to(()=>AnnouncementScreen());
      } else {
        Get.back();
      }
    }
    else {
      Get.back();
    }
  }
}
