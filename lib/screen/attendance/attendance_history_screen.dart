import 'package:dreamhrms/controller/attendance/attendance_controller.dart';
import 'package:dreamhrms/controller/theme_controller.dart';
import 'package:dreamhrms/model/attendance/employee_attendance_model.dart';
import 'package:dreamhrms/screen/employee/employee_details/profile.dart';
import 'package:dreamhrms/widgets/Custom_rich_text.dart';
import 'package:dreamhrms/widgets/no_record.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';

import '../../constants/colors.dart';
import '../../controller/department/deparrtment_controller.dart';
import '../../model/attendance/attendance_model.dart';
import '../../widgets/Custom_text.dart';
import '../../widgets/common.dart';

class AttendanceHistoryScreen extends StatelessWidget {
  final String date;
  final String type;
  final bool loader;
  final List<WorkedHours>? adminAttendanceHistory;
  final List<WorkedHour>? employeeAttendanceHistory;
  AttendanceHistoryScreen({
    super.key,
    required this.date,
    required this.type,
    required this.loader,
    this.adminAttendanceHistory,
    this.employeeAttendanceHistory,
  });

  @override
  Widget build(BuildContext context) {
    // loader = true;
    // Future.delayed(Duration(seconds: 2)).then((value) {
    //   widget.
    //   getArguments['loader'] = false;
    // });
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            navBackButton(),
            SizedBox(width: 8),
            CustomText(
              text: "attendance_history",
              color: AppColors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Obx(
            () => commonLoader(
              singleRow: true,
              loader: AttendanceController.to.loader,
              length: MediaQuery.of(context).size.height.toInt(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomRichText(
                    text: date.toString(),
                    color: AppColors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.start,
                    textSpan: '',
                    textSpanColor: AppColors.grey,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // attendanceHistory?.length == 0 ||
                  //         attendanceHistory?.length == null
                  //     ? NoRecord()
                  //     :
                  type == 'admin'
                      ? adminAttendanceHistory?.length == 0 ||
                              adminAttendanceHistory?.length == null
                          ? NoRecord()
                          : adminAttendanceHistoryList()
                      : employeeAttendanceHistory?.length == 0 ||
                              employeeAttendanceHistory?.length == null
                          ? NoRecord()
                          : employeeAttendanceHistoryList()
                  // buildCarsTable()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  adminAttendanceHistoryList() {
    return ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: adminAttendanceHistory?.length ?? 0,
        itemBuilder: (context, index) {
          var attendanceWorkedList = adminAttendanceHistory?[index];
          final value = DepartmentController.to.departmentModel?.data
              ?.where((data) =>
                  data.departmentName == attendanceWorkedList?.department)
              .toList();
          final data;
          String? position;
          if (value != "" && value != null) {
            if (value.length > 0) {
              data = value[0]
                  .positions
                  ?.where((data) => data.id == attendanceWorkedList?.position)
                  .toList();

              if (data.length > 0) {
                position = data?[0].positionName;
              } else {
                position = "-";
              }
            } else {
              position = "-";
            }
          }
          return Container(
            width: Get.width,
            constraints: const BoxConstraints(
              maxHeight: 130,
            ),
            margin: EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.lightGrey),
                borderRadius: BorderRadius.circular(8)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      commonNetworkImageDisplay(
                          '${attendanceWorkedList?.profileImage}'),
                    ),
                  ),
                  title: CustomText(
                      text: '${attendanceWorkedList?.username??"-"}',
                      color: AppColors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                  subtitle: CustomText(
                      text: '${attendanceWorkedList?.department??"-"}',
                      color: AppColors.grey,
                      fontSize: 11,
                      fontWeight: FontWeight.w400),
                  trailing: Container(
                    height: 24,
                    width: 24,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: attendanceWorkedList?.status == "Absent" &&
                                ThemeController.to.checkThemeCondition() == true
                            ? AppColors.red.withOpacity(0.4)
                            : attendanceWorkedList?.status == "Absent" &&
                                    ThemeController.to.checkThemeCondition() ==
                                        false
                                ? AppColors.lightRed
                                : ThemeController.to.checkThemeCondition() ==
                                        true
                                    ? AppColors.green.withOpacity(0.4)
                                    : AppColors.lightGreen,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4))),
                    child: CustomText(
                      text:
                          "${attendanceWorkedList?.status == "Absent" ? "A" : "P"}",
                      color: attendanceWorkedList?.status == "Absent"
                          ? AppColors.red
                          : AppColors.green,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      SizedBox(
                        width: Get.width * 0.28,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                                text: 'check_in',
                                color: AppColors.grey,
                                fontSize: 11,
                                fontWeight: FontWeight.w400),
                            SizedBox(
                              height: 5,
                            ),
                            CustomText(
                                text: '${attendanceWorkedList?.login}',
                                color: AppColors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.28,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                                text: 'check_out',
                                color: AppColors.grey,
                                fontSize: 11,
                                fontWeight: FontWeight.w400),
                            SizedBox(
                              height: 5,
                            ),
                            CustomText(
                                text: '${attendanceWorkedList?.logOut}',
                                color: AppColors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                              text: 'working_hrs',
                              color: AppColors.grey,
                              fontSize: 11,
                              fontWeight: FontWeight.w400),
                          SizedBox(
                            height: 5,
                          ),
                          CustomText(
                              text: '${attendanceWorkedList?.workedHours}',
                              color: AppColors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  employeeAttendanceHistoryList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
          width: Get.width,
          height: Get.height * 0.80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          margin: const EdgeInsets.only(bottom: 30),
          child: DataTable2(
              columnSpacing: 5,
              horizontalMargin: 12,
              minWidth: 300,
              columns: [
                DataColumn(
                    label: setTitle(
                        text: "date",
                        color: AppColors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w600)),
                DataColumn(
                    label: setTitle(
                        text: "check_in",
                        color: AppColors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w600)),
                DataColumn(
                    label: setTitle(
                        text: "check_out",
                        color: AppColors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w600)),
                DataColumn(
                    label: setTitle(
                        text: "working_hrs",
                        color: AppColors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w600)),
                DataColumn(
                    label: setTitle(
                        text: "status",
                        color: AppColors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w600)),
              ],
              rows: List.generate(employeeAttendanceHistory?.length ?? 0,
                  (index) {
                final attendanceWorkedList = employeeAttendanceHistory?[index];
                DateTime dateTime =
                    DateTime.parse(attendanceWorkedList!.date.toString());
                return DataRow(cells: [
                  DataCell(Padding(
                    padding: const EdgeInsets.only(top: 3, bottom: 3),
                    child: Column(
                      children: [
                        CustomText(
                          text: '${DateFormat('dd').format(dateTime)}',
                          color: AppColors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        CustomText(
                          text: '${DateFormat('EEE').format(dateTime)}',
                          color: AppColors.grey,
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  )),
                  DataCell(
                    CustomText(
                      text: '${attendanceWorkedList.login ?? "-"}',
                      color: AppColors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  DataCell(
                    CustomText(
                      text: '${attendanceWorkedList.logOut ?? "-"}',
                      color: AppColors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  DataCell(
                    CustomText(
                      text: '${attendanceWorkedList.workedHours ?? "-"}',
                      color: AppColors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  DataCell(
                    CustomText(
                      text: '${attendanceWorkedList.status ?? "-"}',
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ]);
              }))),
    );
  }

  setTitle(
      {required String text,
      required Color color,
      required double fontSize,
      required FontWeight fontWeight}) {
    return CustomText(
      text: text,
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }

}
