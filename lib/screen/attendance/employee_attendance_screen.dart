import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

import '../../constants/colors.dart';
import '../../controller/attendance/employee_attendance_controller.dart';
import '../../controller/branch_controller.dart';
import '../../controller/employee_details_controller/time_sheet_controller.dart';
import '../../controller/login_controller.dart';
import '../../services/provision_check.dart';
import '../../services/utils.dart';
import '../../widgets/Custom_rich_text.dart';
import '../../widgets/Custom_text.dart';
import '../../widgets/back_to_screen.dart';
import '../../widgets/common.dart';
import '../employee/employee_details/profile.dart';
import '../home.dart';
import '../schedule/calender_view.dart';
import 'attendance_history_screen.dart';

class EmployeeAttendance extends StatelessWidget {
  final bool backNavigation;
  const EmployeeAttendance({Key? key, required this.backNavigation})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((value) async {
      await TimeSheetController.to.setDateFormat();
      DateTime current_date = DateTime.now();
      EmployeeAttendanceController.to.fromDateController.text =
          DateFormat('yyyy-MM-dd').format(current_date);
      EmployeeAttendanceController.to.toDateController.text =
          DateFormat('yyyy-MM-dd').format(current_date.add(Duration(days: 7)));
      await EmployeeAttendanceController.to
          .getEmployeeAttendanceList(type: "2");
    });
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            if (backNavigation) navBackButton(),
            SizedBox(width: 8),
            CustomText(
              text: "attendance",
              color: AppColors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
        actions: [
          ProvisionsWithIgnorePointer(
            provision: "Attendance",
            type: "view",
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: TextButton.icon(
                  onPressed: () {
                    final fromDate = DateFormat('yyyy-MM-dd').parse(
                        EmployeeAttendanceController
                            .to.fromDateController.text);
                    final toDate = DateFormat('yyyy-MM-dd').parse(
                        EmployeeAttendanceController.to.toDateController.text);
                    final formattedDateRange =
                        '${DateFormat('dd MMM').format(fromDate)} - ${DateFormat('dd MMM yyyy').format(toDate)}';

                    Get.to(() => AttendanceHistoryScreen(
                        date: formattedDateRange,
                        type: 'employee',
                        loader: EmployeeAttendanceController
                            .to.employeeAttendanceLoader,
                        employeeAttendanceHistory: EmployeeAttendanceController
                            .to.employeeAttendanceModel?.data!.workedHours));
                  },
                  icon: SvgPicture.asset('assets/icons/files.svg'),
                  label: CustomText(
                      text: 'history',
                      color: AppColors.blue,
                      fontSize: 14,
                      fontWeight: FontWeight.w600)),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 20),
        child: Obx(() => SingleChildScrollView(
              child: ViewProvisionedWidget(
                provision: "Attendance",
                type: "view",
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0),
                        child: Calender(
                          isSingleDate: false,
                          day: 7,
                          type: "attendance",
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    EmployeeAttendanceController.to.employeeAttendanceLoader
                        ? ClipOval(
                            child: Skeleton(
                            width: 100.0,
                            height: 100.0,
                          ))
                        : ProvisionsWithIgnorePointer(
                            provision: "Attendance",
                            type: "create",
                            child: InkWell(
                              onTap: () async {
                                print(
                                    "radius detection ${GetStorage().read('company_radius_detection')}");
                                if (GetStorage()
                                        .read('company_radius_detection')
                                        .toString() ==
                                    1.toString()) {
                                  await BranchController.to
                                      .getLatLngFromAddress();
                                  print(
                                      "lattitude${BranchController.to.latitude} ");
                                  print(
                                      "longitude${BranchController.to.longitude} ");
                                  if (await validateRadius()) {
                                    showPunchPopUpDialog();
                                  }
                                } else {
                                  showPunchPopUpDialog();
                                }
                              },
                              child: SizedBox(
                                width: 150,
                                height: 150,
                                child:
                                    EmployeeAttendanceController.to.punchType ==
                                            "Check In"
                                        ? SvgPicture.asset(
                                            "assets/icons/check_in.svg")
                                        : SvgPicture.asset(
                                            "assets/icons/check_out.svg"),
                              ),
                            ),
                          ),
                    const SizedBox(
                      height: 15,
                    ),
                    EmployeeAttendanceController.to.employeeAttendanceLoader
                        ? Skeleton(width: Get.width, height: 40)
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: SvgPicture.asset(
                                    "assets/icons/location.svg",
                                    color: AppColors.grey,
                                  )),
                              const SizedBox(
                                height: 15,
                              ),
                              CustomRichText(
                                  textAlign: TextAlign.center,
                                  text: "${"your_loc"}: ",
                                  color: AppColors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  textSpan:
                                      '${LoginController.to.loginModel?.data?.original?.user?.city?.name ?? "-"}',
                                  textSpanColor: AppColors.blue),
                            ],
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    EmployeeAttendanceController.to.employeeAttendanceLoader
                        ? Skeleton(width: Get.width, height: 40)
                        : BackToScreen(
                            text: "take_break",
                            arrowIcon: true,
                            icon: "assets/icons/break.svg",
                            onPressed: () {},
                          ),
                    const SizedBox(
                      height: 15,
                    ),
                    commonLoader(
                      loader: EmployeeAttendanceController
                          .to.employeeAttendanceLoader,
                      length: 4,
                      child: Row(
                        children: [
                          SizedBox(
                            width: Get.width * 0.50,
                            child: Row(
                              children: [
                                Image.asset(
                                    'assets/images/attendance/check_in.png'),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                        text: 'check_in',
                                        color: AppColors.grey,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    CustomText(
                                        text:
                                            "${EmployeeAttendanceController.to.employeeAttendanceModel?.data?.livePunchIn ?? "00:00:00"}",
                                        color: AppColors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Image.asset(
                                  'assets/images/attendance/check_out.png'),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                      text: 'check_out',
                                      color: AppColors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  CustomText(
                                      text:
                                          "${EmployeeAttendanceController.to.employeeAttendanceModel?.data?.livePunchOut ?? "00:00:00"}",
                                      color: AppColors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    commonLoader(
                      loader: EmployeeAttendanceController
                          .to.employeeAttendanceLoader,
                      length: 4,
                      child: Row(
                        children: [
                          SizedBox(
                            width: Get.width * 0.45,
                            child: Row(
                              children: [
                                Image.asset(
                                    'assets/images/attendance/break.png'),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                        text: 'break',
                                        color: AppColors.grey,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    CustomText(
                                        text:
                                            "${EmployeeAttendanceController.to.employeeAttendanceModel?.data?.todayUserBreakHours ?? "00:00:00"}",
                                        color: AppColors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Image.asset(
                                  'assets/images/attendance/working_hrs.png'),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                      text: 'working_hrs',
                                      color: AppColors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  CustomText(
                                      text:
                                          "${EmployeeAttendanceController.to.employeeAttendanceModel?.data?.todayUserWorkedHours ?? "00:00:00"}",
                                      color: AppColors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

validateRadius() {
  double apiLat = double.parse(GetStorage().read("company_latitude"));
  debugPrint("From  Api ${apiLat.toString()}");
  double apiLong = double.parse(GetStorage().read("company_longitude"));
  debugPrint("From APi ${apiLong.toString()}");
  double apiRadius = double.parse(GetStorage().read("company_radius"));
  debugPrint('API radius $apiRadius');
  double currentLat = BranchController.to.latitude;
  double currentLong = BranchController.to.longitude;
  if ((currentLat != null) && (currentLong != null)) {
    debugPrint('API radius $apiRadius');
    debugPrint("Current Lat $currentLat");
    debugPrint("Current Long $currentLong");
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((apiLat - currentLat) * p) / 2 +
        cos(currentLat * p) *
            cos(apiLat * p) *
            (1 - cos((apiLong - currentLong) * p)) /
            2;
    double distance = 12742 * asin(sqrt(a)) * 1000;
    debugPrint(distance.runtimeType.toString());
    debugPrint('Calculated Distance: $distance');
    if (distance <= apiRadius) {
      print("within radius");
      debugPrint('Distance is within the radius');
      return true;
    } else {
      print("user not within  radius");
      UtilService()
          .showToast("error", message: "location_exceed_radius");
      return false;
    }
  }
}
