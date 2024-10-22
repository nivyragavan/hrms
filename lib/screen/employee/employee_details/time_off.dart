import 'package:dreamhrms/controller/employee_details_controller/time_off_controller.dart';
import 'package:dreamhrms/screen/employee/employee_details/profile.dart';
import 'package:dreamhrms/screen/employee/employee_details/time_off_tabs/leave_tab_screen.dart';
import 'package:dreamhrms/screen/employee/employee_details/time_off_tabs/permission_tab_screen.dart';
import 'package:dreamhrms/screen/main_screen.dart';
import 'package:dreamhrms/widgets/no_record.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get_storage/get_storage.dart';
import 'package:localization/localization.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

import '../../../constants/colors.dart';
import '../../../controller/leave_add_permission_controller.dart';
import '../../../controller/theme_controller.dart';
import '../../../services/provision_check.dart';
import '../../../widgets/Custom_text.dart';
import '../../../widgets/common.dart';
import '../../leave/add_leave.dart';
import '../../leave/leavePermissionTab.dart';

class TimeOff extends StatefulWidget {
  final String type;
  const TimeOff({Key? key, required this.type}) : super(key: key);

  @override
  State<TimeOff> createState() => _TimeOffState();
}

class _TimeOffState extends State<TimeOff> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero).then((value) async {
      TimeOffController.to.taken_leave=0;
      TimeOffController.to.total_leave=0;
      TimeOffController.to.remaining_leave=0;
      await TimeOffController.to.getTimeOffList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: widget.type=="employee"?
        AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: false,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // navBackButton(),
                  // SizedBox(width: 8),
                  CustomText(
                    text: "leave",
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
                    Get.to(() => AddLeave(
                        backBtnOnPressed:(){
                        Get.to(()=>MainScreen());
                      }
                    ));
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
        ):null,
        body: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Obx(
            () => SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                // child: commonLoader(
                //   length: MediaQuery.of(context).size.height.toInt(),
                //   loader: TimeOffController.to.showTimeOffList,
                //   singleRow: true,
                  child: Container(
                    height: Get.height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if( widget.type=="admin")Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: "time_off",
                              color: AppColors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                            // SizedBox(
                            //   child: CommonIconButton(
                            //     icon: Icon(Icons.add, color: AppColors.white),
                            //     width: 36,
                            //     height: 36,
                            //     onPressed: () {
                            //       // Get.to(()=>MainScreen());
                            //     },
                            //   ),
                            // ),
                          ],
                        ),
                         Center(
                          child: TimeOffController.to.showTimeOffList?
                          ClipOval(
                              child: Skeleton(
                                width: 100.0,
                                height: 100.0,
                              )):Container(
                            child: CircularPercentIndicator(
                              radius: 90,
                              animation: true,
                              animationDuration: 1000,
                              lineWidth: 8,
                              percent: 0.60,
                              center: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TimeOffController.to.countLoader
                                      ? Skeleton(width: 20, height: 20)
                                      : CustomText(
                                          text:
                                              "${TimeOffController.to.remaining_leave}",
                                          color: AppColors.black,
                                          fontSize: 35,
                                          fontWeight: FontWeight.w700),
                                  CustomText(
                                      text: "bal_leave",
                                      color: AppColors.grey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500)
                                ],
                              ),
                              circularStrokeCap: CircularStrokeCap.butt,
                              backgroundColor: Color(0xffE5ECF6),
                              progressColor: AppColors.blue, //
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        TimeOffController.to.showTimeOffList?Skeleton(width: Get.width,height: 35):
                        TimeOffController.to.employeeTimeOffModel
                            ?.data?.data?.commonLeaveDetails?.length==0?NoRecord():GridView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: TimeOffController.to.employeeTimeOffModel
                                  ?.data?.data?.commonLeaveDetails?.length ??
                              0,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: 2 / 0.7),
                          itemBuilder: (BuildContext context, int index) {
                            var TimeOff = TimeOffController
                                .to
                                .employeeTimeOffModel
                                ?.data
                                ?.data
                                ?.commonLeaveDetails?[index];
                            var userLeaveList;
                            if (TimeOffController.to.employeeTimeOffModel?.data
                                    ?.data?.userLeaveDetails !=
                                null) {
                              print("TimeOff id${TimeOff?.id}");
                              userLeaveList = TimeOffController
                                  .to
                                  .employeeTimeOffModel
                                  ?.data
                                  ?.data!
                                  .userLeaveDetails
                                  ?.where((element) =>
                                      element.leaveTypeId.toString() ==
                                      TimeOff?.id.toString())
                                  .toList();
                            }
                            TimeOffController.to.total_leave +=
                                TimeOff?.leaveDays ?? 0;
                            TimeOffController.to.taken_leave +=
                                int.parse(userLeaveList.length.toString());
                            TimeOffController.to.remaining_leave =
                                TimeOffController.to.total_leave -
                                    TimeOffController.to.taken_leave;
                            return Container(
                              height: 50,
                              child: leaveCount(
                                image1: "assets/icons/annual.svg",
                                title1: '${TimeOff?.leaveType}',
                                text1:
                                    '${userLeaveList?.length ?? 0}/${TimeOff?.leaveDays ?? 0}',
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 25),
                        widget.type=="admin"?CustomText(
                            text: "leave_history",
                            color: AppColors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.start):
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                                text: "leave_history",
                                color: AppColors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                textAlign: TextAlign.start),
                            InkWell(
                              onTap: (){
                                Get.to(()=>LeavePermissionTab());
                              },
                              child: Text(
                                'view_all',
                                style: TextStyle(
                                  color: AppColors.blue,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.blue
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            color: ThemeController.to.checkThemeCondition() == true ? AppColors.grey.withOpacity(0.3) : AppColors.lightWhite,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: TabBar(
                              labelColor: AppColors.lightWhite,
                              unselectedLabelColor: AppColors.blue,
                              indicator: BoxDecoration(
                                gradient: AppColors.primaryColor1,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              controller: TimeOffController.to.tabController,
                              tabs: [
                                Tab(text: 'Leave'),
                                Tab(text: 'Permission'),
                              ]),
                        ),
                        Expanded(
                          child: TabBarView(children: [
                            LeaveTabScreen(),
                            PermissionTabScreen()
                          ]),
                        )
                      ],
                    ),
                  ),
                // ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  leaveCount(
      {required String image1, required String title1, required String text1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset(image1),
            SizedBox(width: 10),
            Column(
              children: [
                commonSingleDataDisplay(
                    title1: title1.isEmpty || title1 == null || title1 == "null"
                        ? "-"
                        : title1,
                    text1: title1.isEmpty || title1 == null || text1 == "null"
                        ? "-"
                        : text1,
                    titleFontSize: 13,
                    titleFontWeight: FontWeight.w400,
                    textFontSize: 14,
                    textFontWeight: FontWeight.w600,
                    textFontColor: AppColors.black),
              ],
            )
          ],
        ),
      ],
    );
  }

}
