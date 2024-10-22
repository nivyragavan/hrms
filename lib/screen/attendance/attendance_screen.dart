import 'package:d_chart/d_chart.dart';
import 'package:dreamhrms/controller/department/deparrtment_controller.dart';
import 'package:dreamhrms/screen/employee/employee_details/profile.dart';
import 'package:dreamhrms/widgets/Custom_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

import '../../constants/colors.dart';
import '../../controller/attendance/attendance_controller.dart';
import '../../controller/employee_details_controller/time_sheet_controller.dart';
import '../../services/provision_check.dart';
import '../../widgets/Custom_text.dart';
import '../../widgets/common.dart';
import '../employee/employee_details/time_sheet.dart';
import 'attendance_history_screen.dart';

class AttendanceScreen extends StatelessWidget {
  final bool backNavigation;
  AttendanceScreen({Key? key, required this.backNavigation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((value) async {
      await TimeSheetController.to.setDateFormat();
      await AttendanceController.to.attendanceList(false);
      DepartmentController.to.getDepartmentList();
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
            type:"view",
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: TextButton.icon(
                  onPressed: () {
                    Get.to(() => AttendanceHistoryScreen(
                        date: TimeSheetController.to.attendanceDate,
                        type: 'admin',
                        loader: AttendanceController.to.loader,
                        adminAttendanceHistory: AttendanceController
                            .to.attendanceModel?.data!.workedHours));
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
        padding: const EdgeInsets.all(20),
        child: Obx(
          () => SingleChildScrollView(
            child: ViewProvisionedWidget(
              provision: "Attendance",
              type:"view",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AttendanceController.to.showAttendanceList
                      ? Skeleton(width: Get.width, height: 40)
                      : Center(
                          child: InkWell(
                            onTap: () {
                              showDateDialog(context, onChanged: () {
                                AttendanceController.to.attendanceList(true);
                              });
                            },
                            child: Container(
                              height: 45,
                              // width: Get.width * 0.60,
                              margin: EdgeInsets.symmetric(horizontal: 40),
                              decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.lightGrey),
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(5))),
                              child: Obx(
                                () => Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.arrow_back_ios_outlined,
                                        color: AppColors.grey, size: 20),
                                    Spacer(),
                                    Icon(Icons.calendar_today_outlined,
                                        color: AppColors.blue, size: 20),
                                    SizedBox(width: 8),
                                    CustomText(
                                        text:
                                            TimeSheetController.to.attendanceDate,
                                        color: AppColors.blue,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                    Spacer(),
                                    Icon(Icons.arrow_forward_ios_outlined,
                                        color: AppColors.grey, size: 20),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: AttendanceController.to.showAttendanceList
                        ? ClipOval(
                            child: Skeleton(
                            width: 100.0,
                            height: 100.0,
                          ))
                        : Stack(
                            children: [
                              DChartPie(
                                data: AttendanceController.to.pieGraph.map((e) {
                                  return {
                                    'domain': e['attendance'],
                                    'measure': e['count']
                                  };
                                }).toList(),
                                fillColor: (pieData, index) {
                                  switch (pieData['domain']) {
                                    case 'present':
                                      return AppColors.blue;
                                    case 'absent':
                                      return AppColors.lightGrey;
                                    case 'permission':
                                      return Colors.amber;
                                    case 'late entry':
                                      return Colors.red;
                                    default:
                                      return AppColors.grey;
                                  }
                                },
                                donutWidth: 10,
                                strokeWidth: 5,
                                labelLineThickness: 0,
                                labelColor: AppColors.white,
                                labelLineColor: Colors.transparent,
                              ),
                              AttendanceController.to.showAttendanceList
                                  ? Skeleton(width: Get.width, height: 20)
                                  : Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CustomText(
                                              text: 'total_emps',
                                              color: AppColors.grey,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          CustomText(
                                              text:
                                                  '${AttendanceController.to.attendanceModel?.data?.headerCalculation?.usersCount ?? "-"}',
                                              color: AppColors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700)
                                        ],
                                      ),
                                    )
                            ],
                          ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  AttendanceController.to.showAttendanceList
                      ? Skeleton(width: Get.width, height: 20)
                      : CustomRichText(
                          text: '${"men"}: ',
                          color: AppColors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          textAlign: TextAlign.start,
                          textSpan:
                              '${AttendanceController.to.attendanceModel?.data?.headerCalculation?.maleUsers ?? "-"} Employee',
                          textSpanColor: AppColors.blue,
                          textSpanFontSize: 14,
                          textSpanFontWeight: FontWeight.w500,
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  AttendanceController.to.showAttendanceList
                      ? Skeleton(width: Get.width, height: 20)
                      : CustomRichText(
                          text: '${"women"}: ',
                          color: AppColors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          textAlign: TextAlign.start,
                          textSpan:
                              '${AttendanceController.to.attendanceModel?.data?.headerCalculation?.femaleUsers ?? "-"} Employee',
                          textSpanColor: AppColors.blue,
                          textSpanFontSize: 14,
                          textSpanFontWeight: FontWeight.w500,
                        ),
                  SizedBox(
                    height: 30,
                  ),
                  commonLoader(
                    loader: AttendanceController.to.showAttendanceList,
                    length: 2,
                    child: Row(
                      children: [
                        SizedBox(
                          width: Get.width * 0.43,
                          child: Row(
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                    color: AppColors.blue,
                                    border: Border.all(
                                        color: AppColors.lightGrey, width: 2),
                                    shape: BoxShape.circle),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              CustomText(
                                  text: 'present_emp',
                                  color: AppColors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400)
                            ],
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.43,
                          child: Row(
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                    color: AppColors.grey.withOpacity(0.5),
                                    border: Border.all(
                                        color: AppColors.lightGrey, width: 2),
                                    shape: BoxShape.circle),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              CustomText(
                                  text: 'absent_emp',
                                  color: AppColors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  commonLoader(
                    loader: AttendanceController.to.showAttendanceList,
                    length: 2,
                    child: Row(
                      children: [
                        SizedBox(
                          width: Get.width * 0.43,
                          child: Row(
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                    color: AppColors.red,
                                    border: Border.all(
                                        color: AppColors.lightGrey, width: 2),
                                    shape: BoxShape.circle),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              CustomText(
                                  text: 'late_emp',
                                  maxLines: 2,
                                  color: AppColors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400)
                            ],
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.43,
                          child: Row(
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    border: Border.all(
                                        color: AppColors.lightGrey, width: 2),
                                    shape: BoxShape.circle),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: CustomText(
                                    text: 'permission_emp',
                                    color: AppColors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  commonLoader(
                    loader: AttendanceController.to.showAttendanceList,
                    length: 2,
                    child: Row(
                      children: [
                        SizedBox(
                          width: Get.width * 0.55,
                          child: Row(
                            children: [
                              Image.asset('assets/images/blue_clock.png'),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                      text: 'present',
                                      color: AppColors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  CustomText(
                                      text:
                                          '${AttendanceController.to.attendanceModel?.data?.headerCalculation?.presentUsers ?? "-"}',
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
                            Image.asset('assets/images/red_clock.png'),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                    text: 'absent',
                                    color: AppColors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                                SizedBox(
                                  height: 5,
                                ),
                                CustomText(
                                    text:
                                        '${AttendanceController.to.attendanceModel?.data?.headerCalculation?.absentUsers ?? "-"}',
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
                    loader: AttendanceController.to.showAttendanceList,
                    length: 2,
                    child: Row(
                      children: [
                        SizedBox(
                          width: Get.width * 0.55,
                          child: Row(
                            children: [
                              Image.asset('assets/images/yellow_clock.png'),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                      text: 'late_login',
                                      color: AppColors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  CustomText(
                                      text:
                                          '${AttendanceController.to.attendanceModel?.data?.headerCalculation?.lateEntryUsers ?? "-"}',
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
                            Image.asset('assets/images/green_clock.png'),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                    text: 'permission',
                                    color: AppColors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                                SizedBox(
                                  height: 5,
                                ),
                                CustomText(
                                    text:
                                        '${AttendanceController.to.attendanceModel?.data?.headerCalculation?.permissionUsers ?? "-"}',
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
          ),
        ),
      ),
    );
  }
}
