import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../constants/colors.dart';
import '../../controller/leave_controller.dart';
import '../../widgets/Custom_text.dart';
import '../../widgets/no_record.dart';
import '../employee/employee_details/profile.dart';

class LeaveHistoryList extends StatelessWidget {
  const LeaveHistoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((value) async {
    //  await LeaveController.to.getLeaveHistory();
    });
    return Scaffold(
      body: buildLeaveList(),
    );
  }

  buildLeaveList() {
    return Obx(
      () => Container(
        height: Get.height,
        child: Padding(
          padding: EdgeInsets.all(12),
          child: commonLoader(
            length: 6,
            singleRow: true,
            loader: LeaveController.to.showList,
            child: LeaveController
                        .to.leaveHistory?.data?.historyList?.data?.length ==
                    0
                ? NoRecord()
                : ListView.builder(
                    itemCount: LeaveController
                            .to.leaveHistory?.data?.historyList?.data?.length ??
                        0,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    primary: true,
                    physics: ScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      var historyData = LeaveController
                          .to.leaveHistory?.data?.historyList?.data
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
                                    width: 220,
                                    child: ListTile(
                                      dense: true,
                                      leading: CircleAvatar(
                                        radius: 25,
                                        backgroundColor: Colors.transparent,
                                        backgroundImage: NetworkImage(
                                            historyData?.users?.profileImage ??
                                                ""),
                                      ),
                                      title: CustomText(
                                          text:
                                              "${historyData?.users?.firstName}",
                                          color: AppColors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                      subtitle: CustomText(
                                          text:
                                              "${historyData?.users?.department?.departmentName}",
                                          color: AppColors.grey,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      CustomText(
                                          text:
                                            //  "${historyData?.leaveTypes?.leaveType}",
                                          "${historyData?.leaveType}",
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
                                          historyData!.leaveFrom==null || historyData!.leaveFrom==""?"-":"${DateFormat("MMM d").format(DateTime.parse(historyData!.leaveFrom!))} - ${DateFormat("MMM d, yyyy").format(DateTime.parse(historyData.leaveTo!))}",
                                          color: AppColors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ],
                                  ),
                                ],
                              ),
                              _buildStatusContainer(historyData.status ?? ""),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }

  _buildStatusContainer(String status) {
    return Container(
      height: 24,
      width: 75,
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
}
