import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

import '../../constants/colors.dart';
import '../../controller/common_controller.dart';
import '../../controller/off_boarding/off_boarding_checklist_controller.dart';
import '../../controller/off_boarding/off_boarding_controller.dart';
import '../../controller/theme_controller.dart';
import '../../services/provision_check.dart';
import '../../widgets/Custom_rich_text.dart';
import '../../widgets/Custom_text.dart';
import '../../widgets/back_to_screen.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_searchable_dropdown/MainCommonSearchableDropDown.dart';
import '../../widgets/no_record.dart';
import '../../widgets/offboarding_expansion_tile_widget.dart';
import '../employee/employee_details/profile.dart';
import '../main_screen.dart';
import 'off_boarding_template/off_boarding_template.dart';

class OffBoardingScreen extends StatelessWidget {
  OffBoardingScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      OffBoardingChecklistController.to.showCheckList = true;
      OffBoardingController.to.clearValues();
      await OffBoardingChecklistController.to.getChecklist();
      await OffBoardingController.to.getTemplateList();
      await OffBoardingController.to.getTaskRole();
      await OffBoardingChecklistController.to.getChecklistAssignList();
      OffBoardingChecklistController.to.showCheckList = false;
    });
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
                InkWell(
                  onTap: () {
                    Get.offAll(MainScreen());
                  },
                  child: Icon(Icons.arrow_back_ios_new_outlined,
                      color: ThemeController.to.checkThemeCondition() == true
                          ? AppColors.white
                          : AppColors.black),
                ),
                SizedBox(width: 8),
                CustomText(
                  text: "offboarding",
                  color: AppColors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                onTap: () {
                  Get.to(() => OffBoardingTemplateScreen());
                },
                child: Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryColor1,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: Icon(Icons.settings, color: AppColors.white),
                ),
              ),
            )
          ],
        ),
      ),
      body: Obx(() {
        return Padding(
          padding: EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                    text: "checklist_assignment",
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
                SizedBox(
                  height: 15,
                ),
                buildCheckList(),
                SizedBox(
                  height: 20,
                ),
                CustomText(
                    text: "checklist",
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
                SizedBox(
                  height: 15,
                ),
                buildIndividualCheckList()
              ],
            ),
          ),
        );
      }),
    );
  }

  buildCheckList() {
    return ViewProvisionedWidget(
      provision: "Offboarding",
      type:"view",
      child: SizedBox(
        height: Get.height * 0.18,
        child: commonLoader(
          length: 3,
          singleRow: true,
          loader: OffBoardingChecklistController.to.showList,
          child: OffBoardingChecklistController
                      .to.checklistModel?.data?.data?.length ==
                  0
              ? NoRecord()
              : ListView.separated(
                  itemCount: OffBoardingChecklistController
                          .to.checklistModel?.data?.data?.length ??
                      0,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    var checklist = OffBoardingChecklistController
                        .to.checklistModel?.data?.data?[index];
                    return ProvisionsWithIgnorePointer(
                      provision: "Offboarding",
                      type:"view",
                      child: InkWell(
                        onTap: () {
                          assignChecklistBottomSheet(index);
                        },
                        child: Container(
                          width: Get.width * 0.85,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColors.grey.withOpacity(0.5)),
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            children: [
                              ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: checklist!.profileImage == null
                                      ? Image.asset('assets/images/user.jpeg').image
                                      : Image.network(checklist.profileImage!)
                                          .image,
                                ),
                                title: CustomText(
                                    text:
                                        '${checklist.firstName ?? "-"} ${checklist.lastName ?? "-"}',
                                    color: AppColors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                                subtitle: CustomText(
                                    text: checklist.emailId ?? "-",
                                    color: AppColors.grey,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: Get.width * 0.25,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                              text: "join_date",
                                              color: AppColors.grey,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w400),
                                          SizedBox(height: 8),
                                          CustomText(
                                              text: checklist.personalInfo == null
                                                  ? "-"
                                                  : DateFormat('dd-MM-yyyy').format(
                                                      checklist.personalInfo!
                                                          .effectiveDate!),
                                              color: AppColors.black,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500)
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.35,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                              text: "job_position",
                                              color: AppColors.grey,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w400),
                                          SizedBox(height: 8),
                                          CustomText(
                                              text: checklist.jobPosition == null
                                                  ? "-"
                                                  : checklist.jobPosition!.position!
                                                          .positionName ??
                                                      "-",
                                              color: AppColors.black,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500)
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.blue.withOpacity(0.2)),
                                      child: Icon(
                                        Icons.check,
                                        color: AppColors.blue,
                                        size: 16,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 10);
                  },
                ),
        ),
      ),
    );
  }

  buildIndividualCheckList() {
    return commonLoader(
      length: 5,
      singleRow: true,
      loader: OffBoardingChecklistController.to.showCheckList,
      child: ViewProvisionedWidget(
        provision: "Offboarding",
        type:"view",
        child: OffBoardingChecklistController
                    .to.checklistAssignListModel?.data?.data?.length ==
                0
            ? NoRecord()
            : ListView.separated(
                itemCount: OffBoardingChecklistController
                        .to.checklistAssignListModel?.data?.data?.length ??
                    0,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (context, index) {
                  var checklistAssignList = OffBoardingChecklistController
                      .to.checklistAssignListModel?.data?.data?[index];
                  return SingleChildScrollView(
                    child: OffBoardingExpansionTileWidget(
                        title: CustomText(
                            text:
                                '${checklistAssignList!.user?.firstName ?? "-"} ${checklistAssignList.user?.lastName ?? "-"}',
                            color: AppColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                        subTitle: CustomText(
                            text: checklistAssignList.user?.emailId ?? "-",
                            color: AppColors.grey,
                            fontSize: 11,
                            fontWeight: FontWeight.w400),
                        image: CircleAvatar(
                          backgroundImage:
                              checklistAssignList.user?.profileImage == null
                                  ? Image.asset('assets/images/user.jpeg').image
                                  : Image.network(
                                          checklistAssignList.user!.profileImage!)
                                      .image,
                        ),
                        mainIndex: index,
                        effectiveDate : checklistAssignList.user?.personalInfo?.effectiveDate,
                        offBoardingFor:
                            '${checklistAssignList.user?.firstName ?? "-"} ${checklistAssignList.user?.lastName ?? "-"}',
                        offBoardingImage:
                            checklistAssignList.user?.profileImage == null
                                ? Image.asset('assets/images/user.jpeg').image
                                : Image.network(
                                        checklistAssignList.user!.profileImage!)
                                    .image,
                        templateName: checklistAssignList.template!.templateName!,
                        taskLength: checklistAssignList.template?.task?.length),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 10,
                  );
                },
              ),
      ),
    );
  }

  assignChecklistBottomSheet(int index) {
    return Get.bottomSheet(
      isDismissible: false,
      Container(
        // height: Get.height * 0.65,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: ThemeController.to.checkThemeCondition() == true
                ? AppColors.black
                : AppColors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40))),
        child: ListView(
          shrinkWrap: true,
          children: [buildAssignCheckListInformation(index)],
        ),
      ),
    );
  }

  buildAssignCheckListInformation(int index) {
    var checklist =
        OffBoardingChecklistController.to.checklistModel?.data?.data?[index];
    return Obx(() {
      return Form(
        key: formKey,
        child: Column(
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
                text: 'assign_checklist',
                color: AppColors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600),
            const SizedBox(
              height: 25,
            ),
            Row(
              children: [
                SizedBox(
                  width: Get.width * 0.40,
                  child: CustomText(
                      text: "offboarding_for",
                      color: AppColors.grey,
                      fontSize: 11,
                      fontWeight: FontWeight.w400),
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundImage: checklist!.profileImage == null
                          ? Image.asset('assets/images/user.jpeg').image
                          : Image.network(checklist.profileImage!).image,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      width: Get.width * 0.40,
                      child: CustomText(
                          text:
                              "${checklist.firstName ?? "-"} ${checklist.lastName ?? "-"}",
                          color: AppColors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                SizedBox(
                  width: Get.width * 0.40,
                  child: CustomText(
                      text: "join_date",
                      color: AppColors.grey,
                      fontSize: 11,
                      fontWeight: FontWeight.w400),
                ),
                CustomText(
                    text: checklist.personalInfo == null
                        ? "-"
                        : DateFormat('dd-MM-yyyy')
                            .format(checklist.personalInfo!.effectiveDate!),
                    color: AppColors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400)
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            CustomRichText(
                textAlign: TextAlign.left,
                text: 'template',
                color: AppColors.black,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                textSpan: '*',
                textSpanColor: AppColors.red),
            OffBoardingController.to.showList ? Skeleton(width: Get.width,height: 30) : MainSearchableDropDown(
                title: 'template_name',
                hint: "select_template",
                dropdownHeight: 200,
                isRequired: true,
                error: "template",
                items: OffBoardingController.to.templateListModel?.data?.data
                    ?.map((template) {
                  return {
                    "template_name": template.templateName,
                    "template_id": template.id
                  };
                }).toList(),
                controller: OffBoardingChecklistController.to.template,
                onChanged: (data) {
                  OffBoardingChecklistController.to.templateId.text =
                      data["template_id"].toString();
                  ;
                  print(
                      'template id ${OffBoardingChecklistController.to.templateId.text}');
                }),
            CustomRichText(
                textAlign: TextAlign.left,
                text: 'hr_in_charge',
                color: AppColors.black,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                textSpan: '*',
                textSpanColor: AppColors.red),
            OffBoardingController.to.showType ? Skeleton(width: Get.width,height: 30,) : MainSearchableDropDown(
                title: 'hr_in_charge',
                hint: "select_hr_in_charge",
                dropdownHeight: 100,
                isRequired: true,
                error: 'hr_in_charge',
                items: OffBoardingController.to.taskRoleModel?.data?.data
                    ?.map((type) {
                  return {
                    "hr_in_charge": type.type,
                    "hr_in_charge_id": type.id
                  };
                }).toList(),
                controller: OffBoardingChecklistController.to.hrInCharge,
                onChanged: (data) {
                  OffBoardingChecklistController.to.hrInChargeId.text =
                      data["hr_in_charge_id"].toString();
                  ;
                  print(
                      'hr_in_charge_id ${OffBoardingChecklistController.to.hrInChargeId.text}');
                }),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: CommonButton(
                    text: "assign_checklist",
                    textColor: AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    buttonLoader: CommonController.to.buttonLoader,
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        CommonController.to.buttonLoader = true;
                        await OffBoardingChecklistController.to
                            .checklistAssign(index);
                        CommonController.to.buttonLoader = false;
                      }
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
                OffBoardingChecklistController.to.clearValues();
                Get.back();
              },
            ),
          ],
        ),
      );
    });
  }
}
