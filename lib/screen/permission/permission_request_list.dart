import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';
import '../../constants/colors.dart';
import '../../controller/leave_add_permission_controller.dart';
import '../../controller/permission_controller.dart';
import '../../model/leave/leave_request_model.dart';
import '../../services/utils.dart';
import '../../widgets/Custom_text.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_text_button.dart';
import '../../widgets/common_textformfield.dart';
import '../../widgets/no_record.dart';
import '../employee/employee_details/profile.dart';

class PermissionRequestList extends StatelessWidget {
  const PermissionRequestList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((value) async {
      await PermissionController.to.getPermissionHistory();
    });
    return Scaffold(
      body: buildLeaveList(),
    );
  }

  buildLeaveList() {
    return Obx(
      () => Padding(
        padding: EdgeInsets.all(12),
        child: commonLoader(
          length: 6,
          singleRow: true,
          loader: PermissionController.to.showList,
          child: PermissionController
                      .to.leaveRequest?.data?.requestList?.length ==
                  0
              ? NoRecord()
              : ListView.builder(
                  itemCount: PermissionController
                          .to.leaveRequest?.data?.requestList?.length ??
                      0,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    var requestData = PermissionController
                        .to.leaveRequest?.data?.requestList
                        ?.elementAt(index);
                    return Container(
                      height: 100,
                      margin: EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          12.0,
                        ),
                        border: Border.all(
                          color: AppColors.grey.withOpacity(0.3),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        child: Row(
                          // direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 226,
                                  child: ListTile(
                                    dense: true,
                                    leading: CircleAvatar(
                                      radius: 25,
                                      backgroundColor: Colors.transparent,
                                      backgroundImage: NetworkImage(
                                          requestData?.users?.profileImage ??
                                              ""),
                                    ),
                                    title: CustomText(
                                        text:
                                            "${requestData?.users?.firstName}",
                                        color: AppColors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                    subtitle: CustomText(
                                        text:
                                            "${requestData?.users?.department?.departmentName}",
                                        color: AppColors.grey,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Row(
                                  children: [
                                    CustomText(
                                        text:
                                            "${DateFormat('dd-MM-yyyy').format(DateTime.parse(requestData!.permissionDate!))}",
                                        color: AppColors.blue,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                    SizedBox(
                                      width: 6,
                                    ),
                                    CircleAvatar(
                                      radius: 4,
                                      backgroundColor: AppColors.lightGrey,
                                    ),
                                    SizedBox(
                                      width: 6,
                                    ),
                                    CustomText(
                                        text:
                                            "${DateFormat('hh:mm a').format(DateFormat("hh:mm:ss").parse(requestData.fromTime!))} - ${DateFormat('hh:mm a').format(DateFormat("hh:mm:ss").parse(requestData.toTime!))}",
                                        color: AppColors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildStatusContainer(requestData.status ?? ""),
                                SizedBox(
                                  height: 12,
                                ),
                                requestData.status == "Pending"
                                    ? Flexible(
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Get.defaultDialog(
                                                    title: "approve",
                                                    titleStyle: TextStyle(
                                                        color: AppColors
                                                            .darkClrGreen,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    titlePadding:
                                                        EdgeInsets.only(
                                                            top: 15,
                                                            bottom: 15),
                                                    middleText:
                                                        "do_you_want_to_approve_this_permission_request ?",
                                                    middleTextStyle:
                                                        TextStyle(
                                                            color: AppColors
                                                                .grey,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                    actions: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          CommonTextButton(
                                                              text: "no",
                                                              textColor:
                                                                  AppColors
                                                                      .red,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              onPressed: () {
                                                                Get.back();
                                                              }),
                                                          CommonTextButton(
                                                              text: "yes",
                                                              textColor: AppColors
                                                                  .darkClrGreen,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              onPressed: () {
                                                                Get.back();
                                                                LeaveAddPermissionController.to.leaveAction(
                                                                    requestData
                                                                        .id
                                                                        .toString(),
                                                                    "Approve",
                                                                    "Permission");
                                                              }),
                                                        ],
                                                      )
                                                    ]);
                                              },
                                              child: CircleAvatar(
                                                radius: 15,
                                                backgroundColor:
                                                    AppColors.lightGreen,
                                                child: Icon(
                                                  Icons.check,
                                                  color:
                                                      AppColors.darkClrGreen,
                                                  size: 18,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Get.defaultDialog(
                                                    title: "reject",
                                                    titleStyle: TextStyle(
                                                        color: AppColors.red,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    titlePadding:
                                                        EdgeInsets.only(
                                                            top: 15,
                                                            bottom: 15),
                                                    middleText:
                                                        "do_you_want_to_reject_this_permission_request ?",
                                                    middleTextStyle:
                                                        TextStyle(
                                                            color: AppColors
                                                                .grey,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                    actions: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          CommonTextButton(
                                                              text: "no",
                                                              textColor:
                                                                  AppColors
                                                                      .red,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              onPressed: () {
                                                                Get.back();
                                                              }),
                                                          CommonTextButton(
                                                              text: "yes",
                                                              textColor: AppColors
                                                                  .darkClrGreen,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              onPressed: () {
                                                                Get.back();
                                                                _showRejectedReasonAlert(
                                                                    context,
                                                                    requestData);
                                                              }),
                                                        ],
                                                      )
                                                    ]);
                                              },
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    AppColors.lightRed,
                                                radius: 15,
                                                child: Icon(
                                                  Icons.close,
                                                  color: AppColors.red,
                                                  size: 18,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : SizedBox(
                                        height: 0,
                                      ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }

  _buildStatusContainer(String status) {
    return Container(
      height: 24,
      width: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: status == "Pending"
            ? Color(0xFFFFC107).withOpacity(0.2)
            : status == "Rejected"
                ? AppColors.lightRed
                : status == "Approved"
                    ? AppColors.lightGreen
                    : AppColors.black,
      ),
      child: Center(
        child: CustomText(
            text: status,
            color: status == "Pending"
                ? Color(0xFFFFC107)
                : status == "Rejected"
                    ? AppColors.red
                    : status == "Approved"
                        ? AppColors.darkClrGreen
                        : AppColors.black,
            fontSize: 11,
            fontWeight: FontWeight.w500),
      ),
    );
  }

  _showRejectedReasonAlert(BuildContext context, RequestList requestData) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actionsPadding: EdgeInsets.all(16.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              CustomText(
                  text: "reason_for_rejecting_permission",
                  color: AppColors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CommonTextFormField(
                  hintText: 'reason',
                  keyboardType: TextInputType.text,
                  action: TextInputAction.done,
                  controller: LeaveAddPermissionController.to.rejectingReason,
                ),
              ),
            ],
          ),
          actions: [
            CommonButton(
                text: "cancel",
                isCancel: true,
                textColor: AppColors.black,
                fontSize: 13,
                fontWeight: FontWeight.w400,
                onPressed: () {
                  Get.back();
                }),
            CommonButton(
                text: "save",
                textColor: AppColors.white,
                fontSize: 13,
                fontWeight: FontWeight.w400,
                onPressed: () {
                  if (LeaveAddPermissionController
                      .to.rejectingReason.text.isNotEmpty) {
                    LeaveAddPermissionController.to.leaveAction(
                        requestData.id.toString(),
                        "Reject",
                        "Permission",
                        LeaveAddPermissionController.to.rejectingReason.text);
                    Get.back();
                  } else {
                    UtilService().showToast("error",
                        message: "please_type_reason_before_rejecting");
                  }
                }),
          ],
        );
      },
    );
  }
}
