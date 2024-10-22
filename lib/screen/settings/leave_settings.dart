import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

import '../../constants/colors.dart';
import '../../controller/common_controller.dart';
import '../../controller/department/add_department_controller.dart';
import '../../controller/department/deparrtment_controller.dart';
import '../../controller/employee/employee_controller.dart';
import '../../controller/settings/leave/annual_leave_controller.dart';
import '../../controller/settings/leave_settings_list_model.dart' hide State;
import '../../controller/theme_controller.dart';
import '../../services/utils.dart';
import '../../widgets/Custom_rich_text.dart';
import '../../widgets/Custom_text.dart';
import '../../widgets/back_to_screen.dart';
import '../../widgets/common.dart';
import '../../widgets/common_alert_dialog.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_searchable_dropdown/MainCommonSearchableDropDown.dart';
import '../../widgets/common_textformfield.dart';
import '../../widgets/no_record.dart';
import '../employee/employee_details/profile.dart';
import '../schedule/multi_select_dropdown.dart';

class LeaveSettings extends StatefulWidget {
  const LeaveSettings({Key? key}) : super(key: key);

  @override
  State<LeaveSettings> createState() => _LeaveSettingsState();
}

class _LeaveSettingsState extends State<LeaveSettings> {
  final formKey = GlobalKey<FormState>();
  final form = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero).then((value) async {
      LeaveSettingsController.to.leaveSettingsLoader = true;
      await LeaveSettingsController.to.onClear();
      await DepartmentController.to.getDepartmentList();
      await EmployeeController.to.getEmployeeList();
      await LeaveSettingsController.to.getLeaveSettings();
    });
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
              text: "leave_setting",
              color: AppColors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                onTap: () {
                  showNewLeaveBottomSheet();
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
      //Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //
      //               ],
      //             )
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: SingleChildScrollView(
          child: Obx(
            () => commonLoader(
              loader: LeaveSettingsController.to.leaveSettingsLoader,
              length: MediaQuery.of(context).size.height.toInt(),
              singleRow: true,
              child: LeaveSettingsController
                          .to.leaveSettingsListModel?.data?.data?.length ==
                      0
                  ? NoRecord()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: LeaveSettingsController
                              .to.leaveSettingsListModel?.data?.data?.length ??
                          0,
                      itemBuilder: (context, index) {
                        var LeaveSettings = LeaveSettingsController
                            .to.leaveSettingsListModel?.data?.data?[index];
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                              // color: AppColors.white,
                              border: Border.all(
                                color: AppColors.grey.withOpacity(0.3),
                                // width: 1.0,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: '${LeaveSettings?.name ?? "-"}',
                                      color: AppColors.secondaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    Spacer(),
                                    PopupMenuButton(
                                      icon: Icon(Icons.more_vert,
                                          color: AppColors.grey),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      itemBuilder: (BuildContext context) =>
                                          <PopupMenuEntry<String>>[
                                        PopupMenuItem(
                                          height: 30,
                                          child: InkWell(
                                            onTap: () async {
                                              LeaveSettingsController
                                                      .to.daysController.text =
                                                  '${LeaveSettings?.noOfDays ?? "0"}';
                                              LeaveSettingsController
                                                      .to
                                                      .leaveNameController
                                                      .text =
                                                  '${LeaveSettings?.name ?? ""}';
                                              LeaveSettingsController.to.carryForwarDaysController.text='${LeaveSettings?.carryForwardDays??"0"}';
                                              showEditBottomSheet(
                                                  index, context,
                                                  type: "editLeaveType");
                                            },
                                            child: Row(
                                              children: [
                                                SvgPicture.asset(
                                                  "assets/icons/edit_out.svg",
                                                  color: ThemeController.to
                                                              .checkThemeCondition() ==
                                                          true
                                                      ? AppColors.white
                                                      : AppColors.black,
                                                  width: 14,
                                                  height: 14,
                                                ),
                                                SizedBox(
                                                  width: 12,
                                                ),
                                                CustomText(
                                                    text: "edit",
                                                    color: AppColors.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500)
                                              ],
                                            ),
                                          ),
                                        ),
                                        PopupMenuItem(
                                            height: 30,
                                            child: InkWell(
                                              onTap: () {
                                                final form =
                                                    GlobalKey<FormState>();
                                                Get.back();
                                                LeaveSettingsController
                                                    .to
                                                    .policyNameController
                                                    .text = "";
                                                LeaveSettingsController.to
                                                    .daysController.text = "";
                                                // LeaveSettingsController
                                                //     .to
                                                //     .employeeController
                                                //     .text ="";//'${LeaveSettings.customPolicy}';
                                                // LeaveSettingsController
                                                //     .to
                                                //     .employeeIdController
                                                //     .text = "";
                                                LeaveSettingsController
                                                    .to
                                                    .departmentController
                                                    .text = "";
                                                LeaveSettingsController
                                                    .to
                                                    .departmentController
                                                    .text = "";
                                                LeaveSettingsController
                                                    .to
                                                    .positionController
                                                    .text = "";
                                                if (LeaveSettings
                                                            ?.customPolicy ==
                                                        [] ||
                                                    LeaveSettings
                                                            ?.customPolicy ==
                                                        null) {
                                                  showAddCutomLeaveBottomSheet(
                                                      form: form,
                                                      leaveSettingsList:
                                                          LeaveSettings,
                                                      type: "add");
                                                } else {
                                                  LeaveSettingsController.to
                                                          .daysController.text =
                                                      '${LeaveSettings?.customPolicy?.noOfDays ?? ""}';
                                                  LeaveSettingsController
                                                          .to
                                                          .policyNameController
                                                          .text =
                                                      '${LeaveSettings?.customPolicy?.policyName ?? ""}';
                                                  LeaveSettingsController.to.employeeController=LeaveSettings!.customPolicy!.userId!.map((e) => '${e.firstName!} ${e.lastName}').toList();
                                                 LeaveSettingsController
                                                      .to.departmentController.text='${LeaveSettings.customPolicy?.departmentId?[0].departmentName}';
                                                  LeaveSettingsController
                                                      .to.departmentIdController.text='${LeaveSettings.customPolicy?.departmentId?[0].id}';
                                                  LeaveSettingsController
                                                      .to.positionController.text='${LeaveSettings.customPolicy?.positionId?[0].positionName}';
                                                  LeaveSettingsController
                                                      .to.positionIdController.text='${LeaveSettings.customPolicy?.positionId?[0].id}';
                                                  showAddCutomLeaveBottomSheet(
                                                      form: form,
                                                      leaveSettingsList:
                                                      LeaveSettings,type:"edit",id:LeaveSettings.customPolicy?.id);
                                                }
                                              },
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    "assets/icons/menu/attendance.svg",
                                                    color: ThemeController.to
                                                                .checkThemeCondition() ==
                                                            true
                                                        ? AppColors.white
                                                        : AppColors.black,
                                                    width: 14,
                                                    height: 14,
                                                  ),
                                                  SizedBox(
                                                    width: 12,
                                                  ),
                                                  CustomText(
                                                      text: LeaveSettings
                                                                      ?.customPolicy ==
                                                                  [] ||
                                                              LeaveSettings
                                                                      ?.customPolicy ==
                                                                  null
                                                          ? "add_policy"
                                                          : "edit_policy"
                                                              ,
                                                      color: AppColors.black,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500)
                                                ],
                                              ),
                                            ))
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: Get.width * 0.45,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                            text: 'days',
                                            color: AppColors.secondaryColor,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          CustomText(
                                              text:
                                                  '${LeaveSettings?.noOfDays ?? "-"}',
                                              color: AppColors.black,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500)
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                            text: 'count_weekend',
                                            color: AppColors.grey,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w400),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        LeaveSettingsController
                                                .to.leaveSettingsLoader
                                            ? Skeleton()
                                            : FlutterSwitch(
                                                height: 22,
                                                width: 50,
                                                padding: 2,
                                                valueFontSize: 11,
                                                activeColor: AppColors.blue,
                                                activeTextColor: AppColors.grey,
                                                // inactiveColor:
                                                // AppColors.lightGrey,
                                                inactiveTextColor:
                                                    AppColors.grey,
                                                value: LeaveSettings
                                                            ?.countWeekendStatus ==
                                                        1
                                                    ? true
                                                    : false,
                                                onToggle: (val) {
                                                  commonAlertDialog(
                                                    icon: Icons
                                                        .remove_circle_outline,
                                                    title: LeaveSettings
                                                                ?.countWeekendStatus ==
                                                            1
                                                        ? "deny_weekend ?"
                                                        : "allow_weekend ?",
                                                    description: LeaveSettings
                                                                ?.countWeekendStatus ==
                                                            1
                                                        ? 'this_weekend_will_be_denied'
                                                        : 'this_weekend_will_be_allowed',
                                                    actionButtonText: LeaveSettings
                                                                ?.countWeekendStatus ==
                                                            1
                                                        ? "deny"
                                                        : "allow",
                                                    context: context,
                                                    provision: 'settings',
                                                    provisionType: 'create',
                                                    onPressed: () async {
                                                      CommonController.to
                                                          .buttonLoader = true;
                                                      LeaveSettings
                                                              ?.countWeekendStatus =
                                                          val == true ? 1 : 0;
                                                      LeaveSettingsController
                                                              .to
                                                              .leaveNameController
                                                              .text =
                                                          '${LeaveSettings?.name ?? ''}';
                                                      LeaveSettingsController
                                                              .to
                                                              .daysController
                                                              .text =
                                                          '${LeaveSettings?.noOfDays ?? ''}';
                                                      await LeaveSettingsController
                                                          .to
                                                          .editLeaveSettings(
                                                              index);
                                                      CommonController.to
                                                          .buttonLoader = false;
                                                    },
                                                  );
                                                  // LeaveSettingsController.to
                                                  //         .leaveSettingsLoader =
                                                  //     true;
                                                  // LeaveSettings
                                                  //         ?.carryForwardStatus =
                                                  //     val == true ? 1 : 0;
                                                  // LeaveSettingsController.to
                                                  //         .leaveSettingsLoader =
                                                  //     false;
                                                },
                                              ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: Get.width * 0.45,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                            text: 'max_days',
                                            color: AppColors.secondaryColor,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          CustomText(
                                              text:
                                                  '${LeaveSettings?.carryForwardDays ?? "-"}',
                                              color: AppColors.black,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500)
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                            text: 'carry_forward',
                                            color: AppColors.grey,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w400),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        LeaveSettingsController
                                                .to.leaveSettingsLoader
                                            ? Skeleton()
                                            : FlutterSwitch(
                                                height: 22,
                                                width: 50,
                                                padding: 2,
                                                valueFontSize: 11,
                                                activeColor: AppColors.blue,
                                                activeTextColor: AppColors.grey,
                                                // inactiveColor:
                                                // AppColors.lightGrey,
                                                inactiveTextColor:
                                                    AppColors.grey,
                                                value: LeaveSettings
                                                            ?.carryForwardStatus ==
                                                        1
                                                    ? true
                                                    : false,
                                                onToggle: (val) {
                                                  commonAlertDialog(
                                                    icon: Icons
                                                        .remove_circle_outline,
                                                    provision: 'settings',
                                                    provisionType: 'create',
                                                    title: LeaveSettings
                                                                ?.carryForwardStatus ==
                                                            1
                                                        ? "Deny Carry Forward ?"
                                                        : "Allow Carry Forward ?",
                                                    description: LeaveSettings
                                                                ?.carryForwardStatus ==
                                                            1
                                                        ? 'this_carry_forward_will_be_denied'
                                                        : 'this_carry_forward_will_be_allowed',
                                                    actionButtonText: LeaveSettings
                                                                ?.carryForwardStatus ==
                                                            1
                                                        ? "deny"
                                                        : "allow",
                                                    context: context,
                                                    onPressed: () async {
                                                      CommonController.to
                                                          .buttonLoader = true;
                                                      LeaveSettings
                                                              ?.carryForwardStatus =
                                                          val == true ? 1 : 0;
                                                      LeaveSettingsController
                                                              .to
                                                              .leaveNameController
                                                              .text =
                                                          '${LeaveSettings?.name ?? ''}';
                                                      LeaveSettingsController
                                                              .to
                                                              .daysController
                                                              .text =
                                                          '${LeaveSettings?.noOfDays ?? ''}';
                                                      await LeaveSettingsController
                                                          .to
                                                          .editLeaveSettings(
                                                              index);
                                                      CommonController.to
                                                          .buttonLoader = false;
                                                    },
                                                  );
                                                  // LeaveSettingsController.to
                                                  //         .leaveSettingsLoader =
                                                  //     true;
                                                  // LeaveSettings
                                                  //         ?.carryForwardStatus =
                                                  //     val == true ? 1 : 0;
                                                  // LeaveSettingsController.to
                                                  //         .leaveSettingsLoader =
                                                  //     false;
                                                },
                                              ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
            ),
          ),
        ),
      ),
    );
  }

  showNewLeaveBottomSheet() {
    return Get.bottomSheet(
        isDismissible: false,
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: ThemeController.to.checkThemeCondition() == true
                    ? AppColors.black
                    : AppColors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return Form(
                key: formKey,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25.0),
                    ),
                    color: ThemeController.to.checkThemeCondition() == true
                        ? AppColors.black
                        : AppColors.white,
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8),
                          Center(
                            child: Container(
                              height: 4,
                              width: 75,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: AppColors.grey,
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          CustomText(
                            text: 'new_leave_type',
                            color: AppColors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(height: 16),
                          CustomRichText(
                              textAlign: TextAlign.left,
                              text: "policy_name",
                              color: AppColors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              textSpan: ' *',
                              textSpanColor: AppColors.red),
                          SizedBox(height: 8),
                          CommonTextFormField(
                            controller:
                                LeaveSettingsController.to.policyNameController,
                            isBlackColors: true,
                            keyboardType: TextInputType.name,
                            validator: (String? data) {
                              if (data!.isEmpty) {
                                return "required_policy_name";
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: 16),
                          CustomRichText(
                              textAlign: TextAlign.left,
                              text: "days",
                              color: AppColors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              textSpan: ' *',
                              textSpanColor: AppColors.red),
                          SizedBox(height: 8),
                          CommonTextFormField(
                            controller:
                                LeaveSettingsController.to.newLeaveTypeDays,
                            isBlackColors: true,
                            keyboardType: TextInputType.number,
                            validator: (String? data) {
                              if (data!.isEmpty) {
                                return "required_leave_days";
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: 16),
                          Obx(
                            () => SizedBox(
                              width: double.infinity / 1.2,
                              child: CommonButton(
                                text: "Save",
                                textColor: AppColors.white,
                                fontSize: 16,
                                buttonLoader: CommonController.to.buttonLoader,
                                fontWeight: FontWeight.w500,
                                onPressed: () async {
                                  if (formKey.currentState?.validate() ==
                                      true) {
                                    CommonController.to.buttonLoader = true;
                                    await LeaveSettingsController.to
                                        .addLeaveType();
                                    LeaveSettingsController
                                        .to.newLeaveTypeDays.text = "";
                                    LeaveSettingsController
                                        .to.policyNameController.text = "";
                                    Get.back();
                                    CommonController.to.buttonLoader = false;
                                  }
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          BackToScreen(
                            text: "cancel",
                            arrowIcon: false,
                            onPressed: () {
                              LeaveSettingsController.to.newLeaveTypeDays.text =
                                  "";
                              LeaveSettingsController
                                  .to.policyNameController.text = "";
                              Get.back();
                            },
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ));
  }

  showEditBottomSheet(int index, context, {required String type}) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: ThemeController.to.checkThemeCondition() == true
                ? AppColors.black
                : AppColors.white,
            content: SingleChildScrollView(
              child: Container(
                height: 440,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: ThemeController.to.checkThemeCondition() == true
                        ? AppColors.black
                        : AppColors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Obx(
                  () => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Form(
                      key: form,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: 'edit_leave_details',
                                color: AppColors.secondaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: Icon(Icons.cancel_outlined),
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                          CustomRichText(
                              textAlign: TextAlign.left,
                              text: "leave_name",
                              color: AppColors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              textSpan: ' *',
                              textSpanColor: AppColors.red),
                          SizedBox(height: 10),
                          CommonTextFormField(
                            controller:
                                LeaveSettingsController.to.leaveNameController,
                            isBlackColors: true,
                            readOnly: LeaveSettingsController.to.edit,
                            keyboardType: TextInputType.text,
                            validator: (String? data) {
                              if (data == "" || data == null) {
                                return "leave_name_validation";
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: 5),
                          CustomRichText(
                              textAlign: TextAlign.left,
                              text: "days",
                              color: AppColors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              textSpan: ' *',
                              textSpanColor: AppColors.red),
                          SizedBox(height: 5),
                          CommonTextFormField(
                            controller:
                                LeaveSettingsController.to.daysController,
                            isBlackColors: true,
                            readOnly: LeaveSettingsController.to.edit,
                            keyboardType: TextInputType.number,
                            validator: (String? data) {
                              if (data == "" || data == null) {
                                return "leave_days_validation";
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: 5),
                          CustomRichText(
                              textAlign: TextAlign.left,
                              text: "carry_forward_days",
                              color: AppColors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              textSpan: ' *',
                              textSpanColor: AppColors.red),
                          SizedBox(height: 5),
                          CommonTextFormField(
                            controller: LeaveSettingsController
                                .to.carryForwarDaysController,
                            isBlackColors: true,
                            readOnly: LeaveSettingsController.to.edit,
                            keyboardType: TextInputType.number,
                            validator: (String? data) {
                              if (data == "" || data == null) {
                                return "carry_forward_days_validation";
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Obx(
                                  () => CommonButton(
                                      text: "save",
                                      buttonLoader:
                                          CommonController.to.buttonLoader,
                                      textColor: AppColors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      onPressed: () async {
                                        if (form.currentState!.validate()) {
                                          CommonController.to.buttonLoader =
                                              true;
                                          await type == "editPolicy"
                                              ? await LeaveSettingsController.to
                                                  .editLeaveSettingsPolicy(
                                                      index)
                                              : await LeaveSettingsController.to
                                                  .editLeaveSettings(index);
                                          Get.back();
                                          CommonController.to.buttonLoader =
                                              false;
                                        }
                                      }),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          BackToScreen(
                            text: "cancel",
                            arrowIcon: false,
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  showAddCutomLeaveBottomSheet(
      {required GlobalKey<FormState> form, Data? leaveSettingsList, required String type, int? id}) {
    return Get.bottomSheet(
        isDismissible: false,
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: ThemeController.to.checkThemeCondition() == true
                    ? AppColors.black
                    : AppColors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return Obx(
                () => Form(
                  key: form,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(25.0),
                      ),
                      color: ThemeController.to.checkThemeCondition() == true
                          ? AppColors.black
                          : AppColors.white,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8),
                          Center(
                            child: Container(
                              height: 4,
                              width: 75,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: AppColors.grey,
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          CustomText(
                            text: 'add_custom_policy',
                            color: AppColors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(height: 16),
                          CustomRichText(
                              textAlign: TextAlign.left,
                              text: "policy_name",
                              color: AppColors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              textSpan: ' *',
                              textSpanColor: AppColors.red),
                          SizedBox(height: 8),
                          CommonTextFormField(
                            controller:
                                LeaveSettingsController.to.policyNameController,
                            isBlackColors: true,
                            keyboardType: TextInputType.name,
                            validator: (String? data) {
                              if (data!.isEmpty) {
                                return "policy_name_validation";
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: 16),
                          CustomRichText(
                              textAlign: TextAlign.left,
                              text: "days",
                              color: AppColors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              textSpan: ' *',
                              textSpanColor: AppColors.red),
                          SizedBox(height: 8),
                          CommonTextFormField(
                            controller:
                                LeaveSettingsController.to.daysController,
                            isBlackColors: true,
                            keyboardType: TextInputType.number,
                            validator: (String? data) {
                              if (data!.isEmpty) {
                                return "days_validator";
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: 16),
                          CustomRichText(
                              textAlign: TextAlign.left,
                              text: "employee",
                              color: AppColors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              textSpan: ' *',
                              textSpanColor: AppColors.red),
                          SizedBox(height: 8),
                          EmployeeController.to.isLoading
                              ? Skeleton(
                                  height: 30,
                                  width: Get.width,
                                )
                              : MultiSelectDropDown(
                                  title: "select_emp",
                                  items: EmployeeController.to.employeeListModel
                                          ?.data?.data?.data
                                          ?.map((datum) =>
                                              "${datum.firstName} ${datum.lastName}" ??
                                              "")
                                          .toList() ??
                                      [],
                                  onChanged: (value) {
                                    print("Selected Departments: $value");
                                    LeaveSettingsController
                                        .to.employeeController = value;
                                  },
                                  selectedItems: LeaveSettingsController
                                      .to.employeeController),
                          SizedBox(height: 16),
                          CustomRichText(
                              textAlign: TextAlign.left,
                              text: "department",
                              color: AppColors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              textSpan: ' *',
                              textSpanColor: AppColors.red),
                          SizedBox(height: 8),
                          DepartmentController.to.showDepartmentList
                              ? Skeleton(
                                  height: 30,
                                  width: Get.width,
                                )
                              : MainSearchableDropDown(
                                  isRequired: true,
                                  error: "dept_name_validator",
                                  // hint: "select_dept",
                                  title: "department_name",
                                  items: DepartmentController
                                          .to.departmentModel?.data
                                          ?.map((datum) => datum.toJson())
                                          .toList() ??
                                      [],
                                  controller: LeaveSettingsController
                                      .to.departmentController,
                                  onChanged: (data) async {
                                    print("department choosen data$data");
                                    LeaveSettingsController
                                        .to
                                        .departmentController
                                        .text = data['department_name'];
                                    LeaveSettingsController
                                        .to
                                        .departmentIdController
                                        .text = data['department_id'];
                                    await DepartmentController.to
                                        .storePositionModel(
                                            LeaveSettingsController.to
                                                .departmentIdController.text);
                                  }),
                          SizedBox(height: 16),
                          CustomRichText(
                              textAlign: TextAlign.left,
                              text: "position",
                              color: AppColors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              textSpan: ' *',
                              textSpanColor: AppColors.red),
                          SizedBox(height: 8),
                          EmployeeController.to.personalLoader ||
                                  AddDepartmentController.to.positionLoader
                              ? Skeleton(width: Get.width, height: 30)
                              : MainSearchableDropDown(
                                  title: 'position_name',
                                  // hint: "select_position",
                                  // filled: true,
                                  // fillColor: AppColors.white,
                                  isRequired: true,
                                  error: "required_position_type",
                                  items: DepartmentController
                                          .to.positionModel?.data?[0].positions
                                          ?.map((datum) => datum.toJson())
                                          .toList() ??
                                      [],
                                  controller: LeaveSettingsController
                                      .to.positionController,
                                  onChanged: (data) {
                                    LeaveSettingsController.to
                                        .positionIdController.text = data['id'];
                                  }),
                          SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity / 1.2,
                            child: CommonButton(
                              text: "submit",
                              textColor: AppColors.white,
                              fontSize: 16,
                              buttonLoader: CommonController.to.buttonLoader,
                              fontWeight: FontWeight.w500,
                              onPressed: () async {
                                if (form.currentState?.validate() == true) {
                                  CommonController.to.buttonLoader = true;
                                  final empID = EmployeeController
                                      .to.employeeListModel?.data?.data?.data
                                      ?.where((element) => LeaveSettingsController
                                          .to.employeeController
                                          .contains(
                                              "${element.firstName} ${element.lastName}"))
                                      .toList();
                                  await LeaveSettingsController.to
                                      .addLeaveSettingsPolicy(
                                          settings_id: leaveSettingsList?.id,
                                          employee_Id:
                                              empID!.map((e) => e.id).toList(),
                                  type:type,id:id);
                                  Get.back();
                                  CommonController.to.buttonLoader = false;
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          BackToScreen(
                              text: "cancel",
                              arrowIcon: false,
                              onPressed: () {
                                Get.back();
                              }),
                          SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ));
  }
}
