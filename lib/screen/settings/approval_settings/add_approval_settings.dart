import 'package:dreamhrms/controller/common_controller.dart';
import 'package:dreamhrms/controller/settings/approval/leave-approval_controller.dart';
import 'package:dreamhrms/model/settings/system/leave_approval_settings_model.dart'
    hide State;
import 'package:dreamhrms/model/settings/system/user_master_model.dart'
    hide State;
import 'package:dreamhrms/screen/employee/employee_details/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:skeleton_animation/skeleton_animation.dart';
import '../../../constants/colors.dart';
import '../../../model/asset/approval_employee_list_model.dart';
import '../../../widgets/Custom_rich_text.dart';
import '../../../widgets/Custom_text.dart';
import '../../../widgets/back_to_screen.dart';
import '../../../widgets/common.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/common_searchable_dropdown/MainCommonSearchableDropDown.dart';

class AddLeaveApproval extends StatefulWidget {
  const AddLeaveApproval({super.key});

  @override
  State<AddLeaveApproval> createState() => _AddLeaveApprovalState();
}

class _AddLeaveApprovalState extends State<AddLeaveApproval> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LeaveApprovalController.to.getUserMaster();
    LeaveApprovalController.to.approverLoader = false;
    ApprovalModel? approvalSettingsModel;
    approvalSettingsModel = ApprovalModel(approval: []);
    approvalSettingsModel.approval
        ?.insert(0, Approval(id: "", firstName: "", lastName: ""));
  }

  @override
  Widget build(BuildContext context) {
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
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Obx(
              () => Padding(
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
                LeaveApprovalController.to.showList == true
                    ? Skeleton(
                  height: 30,
                  width: Get.width,
                )
                    : commonLoader(
                  length: MediaQuery.of(context).size.height.toInt(),
                  singleRow: true,
                  loader: LeaveApprovalController.to.approverLoader,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: LeaveApprovalController
                          .to.approvalModel?.approval?.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (LeaveApprovalController.to.approvalModel?.approval == null ||
                            index >= LeaveApprovalController.to.approvalModel!.approval!.length) {
                          return SizedBox();
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomRichText(
                                textAlign: TextAlign.left,
                                text: "Approver ${index + 1}",
                                color: AppColors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                textSpan: ' *',
                                textSpanColor: AppColors.red),
                            Row(
                              children: [
                                SizedBox(
                                  width:
                                  MediaQuery.of(context).size.width *
                                      0.75,
                                  child: MainSearchableDropDown(
                                      isRequired: true,
                                      error: "Required Approver Name",
                                      title: 'first_name',
                                      title1: 'last_name',
                                      hint: "Select Approver",
                                      items: LeaveApprovalController
                                          .to.userMasterModel?.data
                                          ?.map((datum) =>
                                          datum.toJson())
                                          .toList() ??
                                          [],
                                      controller: TextEditingController(
                                        text: LeaveApprovalController
                                            .to.approvalModel?.approval?[index].firstName,
                                      ),
                                      onChanged: (data) {
                                        final approverData =
                                        LeaveApprovalSettingsModel(
                                            approverId:
                                            data['id'].toString(),
                                            approverLevel:
                                            "${LeaveApprovalController.to.approverCount}");
                                        LeaveApprovalController
                                            .to.updateData
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
                                    borderRadius:
                                    BorderRadius.circular(10.0),
                                    color:
                                    AppColors.grey.withOpacity(0.20),
                                  ),
                                  child: Center(
                                    child: index == 0
                                        ? IconButton(
                                      onPressed: () {
                                        LeaveApprovalController
                                            .to.empName.text = "";
                                        LeaveApprovalController.to
                                            .approverLoader = true;
                                        LeaveApprovalController
                                            .to
                                            .approvalModel
                                            ?.approval
                                            ?.insert(
                                            LeaveApprovalController
                                                .to
                                                .approvalModel!
                                                .approval!
                                                .length,
                                            Approval(
                                                id: "",
                                                firstName: "",
                                                lastName: ""));
                                        LeaveApprovalController.to
                                            .approverLoader = false;
                                        LeaveApprovalController
                                            .to.approverCount++;
                                      },
                                      icon: Icon(Icons.add),
                                    )
                                        : GestureDetector(
                                      onTap: () {
                                        var deleteIndex = index;
                                        if (deleteIndex >= 0 && deleteIndex <
                                            LeaveApprovalController
                                                .to
                                                .approvalModel!
                                                .approval!
                                                .length) {

                                          LeaveApprovalController
                                              .to
                                              .approvalModel!
                                              .approval!
                                              .removeAt(
                                              deleteIndex);

                                          if (deleteIndex ==
                                              LeaveApprovalController
                                                  .to
                                                  .approvalModel!
                                                  .approval!
                                                  .length) {
                                            print("true");
                                            LeaveApprovalController
                                                .to
                                                .approverLoader =
                                            true;
                                            if (index < LeaveApprovalController.to.updateData.length) {
                                              LeaveApprovalController.to.updateData.removeAt(index);
                                            }
                                            LeaveApprovalController
                                                .to
                                                .approverLoader =
                                            false;
                                          }
                                        }
                                      },
                                      child: SvgPicture.asset(
                                        'assets/icons/delete_approval.svg',
                                        width: 15,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }),
                ),
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
                      await LeaveApprovalController.to.postLeaveSettingsApproval();
                      CommonController.to.buttonLoader = false;
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
    );
  }
}
