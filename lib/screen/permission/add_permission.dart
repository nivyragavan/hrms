import 'package:dreamhrms/constants/colors.dart';
import 'package:dreamhrms/controller/leave_add_permission_controller.dart';
import 'package:dreamhrms/controller/leave_controller.dart';
import 'package:dreamhrms/services/utils.dart';
import 'package:dreamhrms/widgets/common.dart';
import 'package:dreamhrms/widgets/common_textformfield.dart';
import 'package:dreamhrms/widgets/common_timePicker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:localization/localization.dart';
import '../../controller/common_controller.dart';
import '../../widgets/Custom_rich_text.dart';
import '../../widgets/Custom_text.dart';
import '../../widgets/back_to_screen.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_datePicker.dart';

class AddPermission extends StatelessWidget {
  const AddPermission({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    Future.delayed(Duration.zero).then((value) async {
      await LeaveController.to.getLeaveTypes();
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
                navBackButton(),
                SizedBox(width: 8),
                CustomText(
                  text: "add_permission",
                  color: AppColors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ],
        ),
      ),
      // body: ProvisionsWithIgnorePointer(
      //   provision: "Permission",
      //   type: "create",
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
            child: Obx(() {
              return Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomRichText(
                        textAlign: TextAlign.left,
                        text: "date",
                        color: AppColors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        textSpan: ' *',
                        textSpanColor: AppColors.red),
                    SizedBox(
                      height: 8,
                    ),
                    DatePicker(
                      controller: LeaveAddPermissionController.to.permissionDate,
                      hintText: 'select_date',
                      dateFormat: "yyyy-MM-dd",
                      validator: (String? data) {
                        if (data!.isEmpty) {
                          return "Required  Choose Date";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomRichText(
                        textAlign: TextAlign.left,
                        text: "start_time",
                        color: AppColors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        textSpan: ' *',
                        textSpanColor: AppColors.red),
                    SizedBox(height: 8),
                    CommonTimePicker(
                      controller:
                          LeaveAddPermissionController.to.permissionStartTime,
                       timeFormat: GetStorage().read("global_time").toString(),
                      validator: (String? data) {
                        if (data!.isEmpty) {
                          return "required_start_time";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (String? newValue) {
                        LeaveAddPermissionController.to.isStartTimeEnabled = true;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomRichText(
                        textAlign: TextAlign.left,
                        text: "end_time",
                        color: AppColors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        textSpan: ' *',
                        textSpanColor: AppColors.red),
                    SizedBox(height: 8),
                    LeaveAddPermissionController.to.isStartTimeEnabled == true
                        ? CommonTimePicker(
                            controller:
                                LeaveAddPermissionController.to.permissionEndTime,
                            timeFormat: GetStorage().read("global_time").toString(),
                            validator: (String? data) {
                              if (data!.isEmpty) {
                                return "required_end_time";
                              } else {
                                return null;
                              }
                            },
                            onSaved: (String? newValue) {
                              if (newValue != null && newValue.isNotEmpty) {
                                LeaveAddPermissionController.to
                                    .calculateTimeDifference(
                                  LeaveAddPermissionController
                                      .to.permissionStartTime.text,
                                  newValue,
                                );
                              }
                            },
                          )
                        : _buildDisabledPermission(),
                    SizedBox(height: 15),
                    CustomText(
                      text: "hours",
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 8),
                    CommonTextFormField(
                      controller: LeaveAddPermissionController.to.permissionHours,
                      isBlackColors: true,
                      readOnly: true,
                      hintText: "NaN:NaN",
                      //  keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 15),
                    CustomText(
                      text: "permission_reason",
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 8),
                    CommonTextFormField(
                      controller:
                          LeaveAddPermissionController.to.permissionReason,
                      isBlackColors: true,
                      maxlines: 3,
                      action: TextInputAction.done,
                      hintText: "enter_reason",
                      validator: (String? data) {
                        if (data!.isEmpty) {
                          return "required_reason";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity / 1.2,
                      child: CommonButton(
                        text: "Submit",
                        textColor: AppColors.white,
                        fontSize: 16,
                        buttonLoader: CommonController.to.buttonLoader,
                        fontWeight: FontWeight.w500,
                        onPressed: () async {
                          if (formKey.currentState?.validate() == true) {
                            CommonController.to.buttonLoader = true;
                            await LeaveAddPermissionController.to.addPermission();
                            CommonController.to.buttonLoader = false;
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 15),
                  BackToScreen(
                      text: "cancel",
                      arrowIcon: false,
                      onPressed: () {
                        Get.back();
                      })
                  ],
                ),
              );
            }),
          ),
        ),
    //  ),
    );
  }

  _buildDisabledPermission() {
    return TextFormField(
      // controller: widget.controller,
      validator: (String? data) {
        if (data!.isEmpty) {
          return "required_end_time";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(15),
        isDense: false,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.lightGrey, width: 1.7),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.lightGrey, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.lightGrey, width: 1),
        ),
        hintText: GetStorage().read("global_time").toString(),
        // widget.hintText.isEmpty ? 'Select Shift Time' : widget.hintText,
        hintStyle: TextStyle(fontSize: 14, color: AppColors.grey),
        suffixIcon: const Icon(
          Icons.access_time_outlined,
          size: 18,
          // color: Colors.black,
        ),
      ),
      readOnly: true,
      onTap: () {
        UtilService().showToast("error", message: "Required Start Time");
      },
    );
  }
}
