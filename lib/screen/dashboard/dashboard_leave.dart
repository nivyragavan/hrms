import 'package:dreamhrms/constants/colors.dart';
import 'package:dreamhrms/controller/leave_controller.dart';
import 'package:dreamhrms/controller/theme_controller.dart';
import 'package:dreamhrms/screen/employee/employee_details/profile.dart';
import 'package:dreamhrms/widgets/Custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';

import '../../controller/dashboard_controller.dart';
import '../../controller/permission_controller.dart';

class DashboardLeave extends StatelessWidget {
  const DashboardLeave({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((value) async {
      await LeaveController.to.getLeaveHistory();
      await PermissionController.to.getPermissionHistory();
    });
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            labelColor: AppColors.blue,
            unselectedLabelColor: AppColors.grey,
            indicatorColor: AppColors.blue,
            tabs: [
              Tab(text: "Leave"),
              Tab(text: "Permission"),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.40,
            width: MediaQuery.of(context).size.width * 0.99,
            child: TabBarView(
              children: [
                buildLeaveList(context),
                buildPermissionList(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildLeaveList(BuildContext context) {
    double itemWidth = MediaQuery.of(context).size.width * 0.65;
    var ownerImg =
        "https://media.istockphoto.com/id/1318482009/photo/young-woman-ready-for-job-business-concept.jpg?s=612x612&w=0&k=20&c=Jc1NcoUMoM78AxPTh9EApaPU2kXh2evb499JgW99b0g=";
    return Obx(()=>
       commonLoader(
         length: 1,
         loader: LeaveController.to.showList,
         width: Get.width,
         singleRow: true,
         child: ListView.builder(
          itemCount: LeaveController.to.leaveHistory?.data?.historyList?.data?.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            var data = LeaveController.to.leaveHistory?.data?.historyList?.data?.elementAt(index);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: itemWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: AppColors.grey.withOpacity(0.40)),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12.0,),
                  child: Column(
                    children: [
                      ListTile(
                        leading: ClipOval(
                            child: Image.network(
                          ownerImg,
                          fit: BoxFit.cover,
                          width: 50.0,
                          height: 50.0,
                        )),
                        title: CustomText(
                          text: "${data?.users?.firstName ?? ""} ${data?.users?.lastName ?? ""}",
                          color: AppColors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        subtitle: CustomText(
                          text: "${data?.users?.department?.departmentName ?? ""}",
                          color: AppColors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Row(
                        children: [
                          CustomText(
                            text: "Leave Type",
                            color: AppColors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                          Spacer(),
                          CustomText(
                            text: "${data?.leaveType}",
                            color: AppColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          CustomText(
                            text: "Date",
                            color: AppColors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                          Spacer(),
                          CustomText(
                            text: "${data?.leaveFrom==null || data!.leaveFrom==""?"-":"${DateFormat("MMM d").format(DateTime.parse(data!.leaveFrom!))} - ${DateFormat("MMM d, yyyy").format(DateTime.parse(data.leaveTo!))}"}",
                            color: AppColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      _buildStatusContainer(
                          data?.status ?? "", context, itemWidth),
                      SizedBox(height: 12),
                      Container(
                        height: 40,
                        width: itemWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color:ThemeController.to.checkThemeCondition() == true ? AppColors.grey.withOpacity(0.3) : AppColors.lightBlue,
                        ),
                        child: Center(
                          child: CustomText(
                              text: "Approved By: ${data?.approvedBy.toString()}",
                              color: AppColors.blue,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
      ),
       ),
    );
  }

  buildPermissionList(BuildContext context) {
    double itemWidth = MediaQuery.of(context).size.width * 0.65;
    var ownerImg =
        "https://media.istockphoto.com/id/1318482009/photo/young-woman-ready-for-job-business-concept.jpg?s=612x612&w=0&k=20&c=Jc1NcoUMoM78AxPTh9EApaPU2kXh2evb499JgW99b0g=";
    return ListView.builder(
      itemCount: 6,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: itemWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: AppColors.grey.withOpacity(0.40)),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0,),
              child: Column(
                children: [
                  ListTile(
                    leading: ClipOval(
                        child: Image.network(
                      ownerImg,
                      fit: BoxFit.cover,
                      width: 50.0,
                      height: 50.0,
                    )),
                    title: CustomText(
                      text: "John Walker",
                      color: AppColors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    subtitle: CustomText(
                      text: "UI/UX Designer",
                      color: AppColors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Row(
                    children: [
                      CustomText(
                        text: "Leave Type",
                        color: AppColors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      Spacer(),
                      CustomText(
                        text: "Sick",
                        color: AppColors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      CustomText(
                        text: "UI/UX Designer",
                        color: AppColors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      Spacer(),
                      CustomText(
                        text: "05 Mar 2023",
                        color: AppColors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  _buildStatusContainer(
                      index.isOdd ? "Pending" : "Rejected", context, itemWidth),
                  SizedBox(height: 12),
                  Container(
                    height: 40,
                    width: itemWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: ThemeController.to.checkThemeCondition() == true ? AppColors.grey.withOpacity(0.3) : AppColors.lightBlue,
                    ),
                    child: Center(
                      child: CustomText(
                          text: "Approved By: John",
                          color: AppColors.blue,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _buildStatusContainer(String status, BuildContext context, double itemWidth) {
    return Container(
      height: 40,
      width: itemWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(
            width: 1.2,
            color: status == "Pending"
                ? AppColors.lightOrange
                : status == "Rejected"
                    ? AppColors.red
                    : status == "Approved"
                        ? AppColors.lightGreen
                        : AppColors.black,
          ),
          // color: AppColors.white
      ),
      child: Center(
        child: CustomText(
            text: status,
            color: status == "Pending"
                ? AppColors.lightOrange
                : status == "Rejected"
                    ? AppColors.red
                    : status == "Approved"
                        ? AppColors.darkClrGreen
                        : AppColors.black,
            fontSize: 12,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
