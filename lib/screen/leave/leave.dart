import 'package:dreamhrms/constants/colors.dart';
import 'package:dreamhrms/controller/leave_controller.dart';
import 'package:dreamhrms/screen/employee/employee_details/profile.dart';
import 'package:dreamhrms/screen/leave/add_leave.dart';
import 'package:dreamhrms/screen/leave/leave_history_list.dart';
import 'package:dreamhrms/screen/leave/leave_rejected.dart';
import 'package:dreamhrms/screen/leave/leave_request_list.dart';
import 'package:dreamhrms/widgets/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import '../../controller/leave_add_permission_controller.dart';
import '../../services/provision_check.dart';
import '../../widgets/Custom_text.dart';
import '../schedule/calender_view.dart';

class Leave extends StatelessWidget {
  const Leave({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((value) async {
      await LeaveController.to.getLeaveHistory();
    });
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
                    text: "Leaves",
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
                    LeaveAddPermissionController.to.onClose();
                    Get.to(() => AddLeave(backBtnOnPressed: () {
                          Get.to(() => Leave());
                        }));
                  },
                  child: Container(
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(
                        color: AppColors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Icon(Icons.add, color: AppColors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Obx(
          () => Container(
            height: Get.height,
            child: ViewProvisionedWidget(
              provision: "Leave",
              type: "view",
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Calender(isSingleDate: true)),
                  Visibility(
                    visible: LeaveController
                            .to.leaveHistory?.data?.leaveTypes?.length !=
                        0,
                    child: commonLoader(
                      length: 6,
                      singleRow: true,
                      loader: LeaveController.to.showList,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.30,
                          child: GridView.builder(
                            physics: ScrollPhysics(),
                            itemCount: LeaveController
                                .to.leaveHistory?.data?.leaveTypes?.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 2 / 0.8),
                            itemBuilder: (BuildContext context, int index) {
                              var data = LeaveController
                                  .to.leaveHistory?.data?.leaveTypes?[index];
                              return Row(
                                children: [
                                  Container(
                                    height: 43,
                                    width: 46,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFEAEEF6),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        'assets/icons/leave_annual.svg',
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: Get.width * 0.28,
                                        child: CustomText(
                                            text: data?.leaveType.toString() ??
                                                "",
                                            color: AppColors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      CustomText(
                                          text: '${data?.empCount} Emp Applied',
                                          color: AppColors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ],
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  TabBar(
                      labelColor: AppColors.blue,
                      unselectedLabelColor: AppColors.grey,
                      indicatorColor: AppColors.blue,
                      tabs: [
                        Tab(text: "Request List"),
                        Tab(text: "History List")
                      ]),
                  Expanded(
                    child: TabBarView(
                      children: [LeavePendingList(), LeaveHistoryList()],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
