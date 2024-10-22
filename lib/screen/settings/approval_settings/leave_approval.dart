import 'package:dreamhrms/controller/common_controller.dart';
import 'package:dreamhrms/controller/settings/approval/leave-approval_controller.dart';
import 'package:dreamhrms/model/settings/system/approval_settings_list_model.dart';
import 'package:dreamhrms/screen/employee/employee_details/profile.dart';
import 'package:dreamhrms/screen/settings/approval_settings/add_approval_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:skeleton_animation/skeleton_animation.dart';
import '../../../constants/colors.dart';
import '../../../controller/theme_controller.dart';
import '../../../model/settings/system/leave_approval_settings_model.dart';
import '../../../widgets/Custom_rich_text.dart';
import '../../../widgets/Custom_text.dart';
import '../../../widgets/back_to_screen.dart';
import '../../../widgets/common.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/common_searchable_dropdown/MainCommonSearchableDropDown.dart';
import '../../../widgets/no_record.dart';

class LeaveApproval extends StatelessWidget {
  const LeaveApproval({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((value) async {
      LeaveApprovalController.to.showApproverList = true;
      await LeaveApprovalController.to.getApprovalSettingsList();
      await LeaveApprovalController.to.getUserMaster();
      LeaveApprovalController.to.setApprovalListInformation();
      LeaveApprovalController.to.approvalType.value = LeaveApprovalController
          .to.approvalSettingListModel[0].defaultLeaveApproval == "1"?
      LeaveApprovalType.SequenceApproval: LeaveApprovalType.SimultaneousApproval;
      LeaveApprovalController.to. showApproverList = false;
    });
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        // leading: Icon(Icons.arrow_back_ios_new_outlined,color: AppColors.black),
        title: Row(
          children: [
            navBackButton(),
            SizedBox(width: 8),
            CustomText(
              text: "approval_settings",
              color: AppColors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                onTap: () {
                  LeaveApprovalController.to.clear();
                  Get.to(() => AddLeaveApproval());
                },
                child: Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    color: AppColors.blue,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: Icon(Icons.add, color: AppColors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () =>  commonLoader(
            length: MediaQuery.of(context).size.height.toInt(),
            loader: LeaveApprovalController.to.showApproverList,
            singleRow: true,
            height:MediaQuery.of(context).size.height.toDouble(),
            child: LeaveApprovalController.to.approvalSettingsModel?.data?.approvalListData?.length == 0 ?
            NoRecord():
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomRichText(
                      textAlign: TextAlign.left,
                      text: "Default Leave Approval",
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      textSpan: ' *',
                      textSpanColor: AppColors.red),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    height: 43,
                    width: Get.width * 0.99,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: AppColors.grey.withAlpha(40),
                      ),
                    ),
                    child: Row(
                      children: [
                        Radio<LeaveApprovalType>(
                          value: LeaveApprovalType.SequenceApproval,
                          groupValue:
                              LeaveApprovalController.to.approvalType.value,
                          onChanged: (LeaveApprovalType? value) {
                            LeaveApprovalController.to.approvalType.value =
                                value!;
                          },
                        ),
                        CustomText(
                            text: "Sequence Approval (Chain)",
                            color: LeaveApprovalController
                                        .to.approvalType.value.name ==
                                    'SequenceApproval'
                                ? AppColors.darkBlue
                                : AppColors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 43,
                    width: Get.width * 0.99,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: AppColors.grey.withAlpha(40),
                      ),
                    ),
                    child: Row(
                      children: [
                        Radio<LeaveApprovalType>(
                          value: LeaveApprovalType.SimultaneousApproval,
                          groupValue:
                              LeaveApprovalController.to.approvalType.value,
                          onChanged: (LeaveApprovalType? value) {
                            LeaveApprovalController.to.approvalType.value =
                                value!;
                          },
                        ),
                        CustomText(
                            text: "Simultaneous Approval",
                            color: LeaveApprovalController
                                        .to.approvalType.value.name ==
                                    'SimultaneousApproval'
                                ? AppColors.darkBlue
                                : AppColors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                      text: "Leave Approves",
                      color: AppColors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                  SizedBox(
                    height: 8,
                  ),
                   ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: LeaveApprovalController
                              .to.approvalSettingListModel.length,
                          itemBuilder: (BuildContext context, int index) {
                            var data = LeaveApprovalController
                                .to.approvalSettingListModel[index];
                            if (index >=
                                LeaveApprovalController
                                    .to.approvalSettingListModel.length) {
                              return SizedBox();
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomRichText(
                                    textAlign: TextAlign.left,
                                    text: "Approver ${data.approverLevel}",
                                    color: AppColors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    textSpan: ' *',
                                    textSpanColor: AppColors.red),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.75,
                                      child: MainSearchableDropDown(
                                          isRequired: true,
                                          error: "Required Approver Name",
                                          title: 'first_name',
                                          title1: 'last_name',
                                          hint: "Select Approver",
                                          items: LeaveApprovalController
                                                  .to.userMasterModel?.data
                                                  ?.map((datum) => datum.toJson())
                                                  .toList() ??
                                              [],
                                          controller: TextEditingController(
                                            text: LeaveApprovalController
                                                .to
                                                .approvalSettingListModel[index]
                                                .firstName,
                                          ),
                                          onChanged: (data) {
                                            final approverData =
                                                LeaveApprovalSettingsModel(
                                                    approverId:
                                                        data['id'].toString(),
                                                    approverLevel:
                                                        "${LeaveApprovalController.to.approverCount}");
                                            LeaveApprovalController.to.updateData
                                                .add(approverData);
                                          }),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        color: AppColors.grey.withOpacity(0.20),
                                      ),
                                      child: Center(
                                        child: index ==
                                                LeaveApprovalController
                                                        .to
                                                        .approvalSettingListModel
                                                        .length -
                                                    1
                                            ? IconButton(
                                                onPressed: () {
                                                  LeaveApprovalController
                                                      .to.empName.text = "";
                                                  LeaveApprovalController.to
                                                      .approverItemLoader = true;
                                                  LeaveApprovalController
                                                      .to.approvalSettingListModel
                                                      .insert(index,
                                                          ApprovalDataList(
                                                            approverLevel: LeaveApprovalController
                                                                .to
                                                                .approvalSettingListModel.length + 1,
                                                          ));

                                                  LeaveApprovalController.to
                                                      .approverItemLoader = false;
                                                },
                                                icon: Icon(Icons.add),
                                              )
                                            : GestureDetector(
                                                onTap: () {
                                                  LeaveApprovalController.to
                                                    .approverItemLoader = true;
                                                  LeaveApprovalController
                                                      .to.approvalSettingListModel
                                                      .removeAt(index);
                                                  if (index <
                                                      LeaveApprovalController
                                                          .to.updateData.length) {
                                                    LeaveApprovalController
                                                        .to
                                                        .approvalSettingListModel[
                                                            index]
                                                        .approverLevel = LeaveApprovalController
                                                        .to
                                                        .approvalSettingListModel.length  == 1?
                                                    LeaveApprovalController
                                                        .to
                                                        .approvalSettingListModel.length:
                                                    LeaveApprovalController
                                                        .to
                                                        .approvalSettingListModel.length - 1 ;
                                                  }
                                                  LeaveApprovalController.to
                                                      .approverItemLoader = false;
                                                },
                                                child: SvgPicture.asset(
                                                  'assets/icons/delete_approval.svg',
                                                  width: 15,
                                                  color: ThemeController.to
                                                              .checkThemeCondition() ==
                                                          true
                                                      ? AppColors.white
                                                      : AppColors.black,
                                                ),
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }),
                  SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity / 1.2,
                    child: CommonButton(
                      text: "Save",
                      textColor: AppColors.white,
                      fontSize: 16,
                      buttonLoader: CommonController.to.buttonLoader,
                      fontWeight: FontWeight.w500,
                      onPressed: () async {
                        CommonController.to.buttonLoader = true;
                        await LeaveApprovalController.to
                            .postLeaveSettingsApproval();
                        CommonController.to.buttonLoader = false;
                        Get.back();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  BackToScreen(
                      text: "cancel", arrowIcon: false, onPressed: () {
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
