import 'package:dreamhrms/controller/dashboard_controller.dart';
import 'package:dreamhrms/controller/face_controller.dart';
import 'package:dreamhrms/screen/dashboard/dashboard_announcement.dart';
import 'package:dreamhrms/screen/dashboard/dashboard_employee.dart';
import 'package:dreamhrms/screen/dashboard/dashboard_events.dart';
import 'package:dreamhrms/screen/dashboard/dashboard_leave.dart';
import 'package:dreamhrms/screen/dashboard/dashboard_recuirement.dart';
import 'package:dreamhrms/screen/dashboard/dashboard_team.dart';
import 'package:dreamhrms/screen/employee/employee_details/profile.dart';
import 'package:dreamhrms/widgets/Custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

import '../constants/colors.dart';
import '../controller/attendance/employee_attendance_controller.dart';
import '../controller/common_controller.dart';
import '../controller/theme_controller.dart';
import '../services/provision_check.dart';
import '../widgets/back_to_screen.dart';
import '../widgets/common_button.dart';
import '../widgets/common_drawerappbar.dart';
import 'drawer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((value) async {
      CommonController.to.buttonLoader = false;
      if (GetStorage().read("role") == "employee") {
        await EmployeeAttendanceController.to
            .getEmployeeAttendanceList(type: "1");
      }
    });
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: AppColors.primaryColor1,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: AppBar(
              centerTitle: false,
              elevation: 0,
              leadingWidth: 20.0,
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(),
              leading: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.leftToRight,
                        child: HomeMainDrawer(),
                      ),
                    );
                  },
                  child: Icon(Icons.menu, color: AppColors.white)),
              title: Padding(
                padding: const EdgeInsets.only(right: 40),
                child: Image.asset('assets/images/logo_white.png'),
              ),
              actions: [AppBarDrawer()],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              if (GetStorage().read('role') == "employee")
                buildEmployeeDashboard(),
              if (GetStorage().read('role') == "admin")
                // SizedBox(
                //   height: 20,
                // ),
                buildAdminDashboard(),
              SizedBox(
                height: 20,
              ),
              CustomText(
                text: "total_emps",
                color: AppColors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              DashboardLeave(),
              SizedBox(
                height: 20,
              ),
              CustomText(
                text: "events",
                color: AppColors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              DashboardEvents(),
              SizedBox(
                height: 20,
              ),
              CustomText(
                text: "recruitment",
                color: AppColors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              DashboardRecruitment(),
              SizedBox(
                height: 20,
              ),
              CustomText(
                text: "announcement",
                color: AppColors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              DashboardAnnouncement(),
              SizedBox(
                height: 20,
              ),
              CustomText(
                text: "my_team_members",
                color: AppColors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              DashboardTeam(),
            ],
          ),
        ),
      ),
    );
  }

  buildEmployeeDashboard() {
    return Obx(
      () => commonLoader(
        length: 1,
        loader: EmployeeAttendanceController.to.employeeAttendanceLoader,
        width: Get.width,
        singleRow: true,
        child: ViewProvisionedWidget(
          provision: "Attendance",
          type: "view",
          child: Container(
            // width: MediaQuery.of(context).size.width * 0.99,
            decoration: ThemeController.to.checkThemeCondition() == true
                ? BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: AppColors.grey.withOpacity(0.40)),
                  )
                : BoxDecoration(
                    gradient: AppColors.attendanceBg,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: AppColors.grey.withOpacity(0.40)),
                  ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                children: [
                  ListTile(
                    leading: Container(
                        height: 50,
                        // width: 50,
                        decoration: BoxDecoration(
                          // gradient: AppColors.attendanceBg,
                          borderRadius: BorderRadius.circular(10.0),
                          // color: AppColors.lightBlue
                        ),
                        child: SvgPicture.asset(
                            'assets/icons/attendance_timer_icon.svg')),
                    title: CustomText(
                      text: "online_attendance",
                      color: AppColors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    subtitle: Row(
                      children: [
                        Icon(
                          Icons.access_time_outlined,
                          color: AppColors.black,
                          size: 16,
                        ),
                        // CustomText(
                        //   text:
                        //       '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} ',
                        //   color: AppColors.black,
                        //   fontSize: 14,
                        //   fontWeight: FontWeight.w600,
                        // ),
                        // SizedBox(
                        //   width: 8,
                        // ),
                        CustomText(
                          text:
                              "${DateFormat('EEEE, dd MMM yyyy').format(now)}",
                          color: AppColors.grey,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Column(
                      children: [
                        Flex(
                          direction: Axis.horizontal,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                CustomText(
                                  text: "punch_in",
                                  color: AppColors.grey,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                                CustomText(
                                  text:
                                      "${EmployeeAttendanceController.to.employeeAttendanceModel?.data?.livePunchIn ?? "00:00:00"}",
                                  color: AppColors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                CustomText(
                                  text: "break",
                                  color: AppColors.grey,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                                CustomText(
                                  text:
                                      "${EmployeeAttendanceController.to.employeeAttendanceModel?.data?.todayUserBreakHours ?? "00:00:00"}",
                                  color: AppColors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                CustomText(
                                  text: "punch_out",
                                  color: AppColors.grey,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                                CustomText(
                                  text:
                                      "${EmployeeAttendanceController.to.employeeAttendanceModel?.data?.livePunchOut ?? "00:00:00"}",
                                  color: AppColors.black,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Flex(
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            getPunchDetails(),
                            SizedBox(width: 6),
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: AppColors.grey.withOpacity(0.1)),
                              child: Center(
                                child: Image.asset(
                                  'assets/images/Coffee.png',
                                  height: 20,
                                  width: 20,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  buildAdminDashboard() {
    return Obx(
      () => commonLoader(
        length: 1,
        loader: DashboardController.to.loader,
        width: Get.width,
        singleRow: true,
        child: Container(
          height: Get.height * 0.14,
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: ScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: Get.height * 0.25,
                width: Get.width * 0.50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  // color: Colors.white,
                  border: Border(
                    bottom: BorderSide(
                        color: AppColors.grey.withOpacity(0.4), width: 3),
                    top: BorderSide(
                        color: AppColors.grey.withOpacity(0.4), width: 1),
                    left: BorderSide(
                        color: AppColors.grey.withOpacity(0.4), width: 1),
                    right: BorderSide(
                        color: AppColors.grey.withOpacity(0.4), width: 1),
                  ),
                ),
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                      height: MediaQuery.of(context).size.height * 0.16,
                      width: 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.deepPurpleAccent,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: DashboardController.to.dashboardAdminModel?.data
                                  ?.employee?.totalCount ??
                              "",
                          color: AppColors.grey,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        CustomText(
                          text: "324",
                          color: AppColors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: 16,
              );
            },
            itemCount: 4,
          ),
        ),
      ),
    );
  }

  getPunchDetails() {
    return InkWell(
      onTap: () {
        showPunchPopUpDialog();
      },
      child: Container(
        height: 40,
        width: Get.width * 0.65,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.green, AppColors.blue],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              EmployeeAttendanceController.to.punchType == "Check In"
                  ? Icons.login_outlined
                  : Icons.login_outlined,
              color: AppColors.white,
            ),
            SizedBox(width: 5),
            CustomText(
              text:
                  '${EmployeeAttendanceController.to.punchType} ${EmployeeAttendanceController.to.employeeAttendanceModel?.data?.todayUserWorkedHours ?? "00:00:00"}',
              color: AppColors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
      // ),
    );
  }
}

showPunchPopUpDialog() {
  DateTime now = DateTime.now();
  String currentTime =
      '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
  return Get.dialog(
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Material(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/icons/tick.svg'),
                    SizedBox(height: 15),
                    CustomText(
                      text:
                          '${EmployeeAttendanceController.to.punchType == "Check In" ? "Punching in at" : "Punching out at"}',
                      color: AppColors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    CustomText(
                      text: '${currentTime ?? ""}',
                      color: AppColors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                    SizedBox(height: 20),
                    Obx(
                      () => Row(
                        children: [
                          Expanded(
                            child: CommonButton(
                              text: "confirm",
                              textColor: AppColors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              buttonLoader: CommonController.to.buttonLoader,
                              onPressed: () async {
                                CommonController.to.buttonLoader = true;
                                bool isVerified =
                                    await FaceController.to.doFaceReco();
                                print("isverified $isVerified");
                                CommonController.to.buttonLoader = false;
                                if (isVerified == true) {
                                  CommonController.to.buttonLoader = true;
                                  await EmployeeAttendanceController.to
                                      .postPunch(
                                          currentTime: currentTime.toString());
                                }
                                // Get.back();
                                CommonController.to.buttonLoader = false;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
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
      ],
    ),
  );
}
