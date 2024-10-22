import 'package:dreamhrms/model/admin_timesheet_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';

import '../../constants/colors.dart';
import '../../controller/employee_details_controller/time_sheet_controller.dart';
import '../../widgets/Custom_text.dart';
import '../../widgets/common.dart';
import '../../widgets/no_record.dart';
import '../employee/employee_details/profile.dart';
import '../employee/employee_details/time_sheet.dart';

class AdminTimeSheet extends StatelessWidget {
  const AdminTimeSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((value) async {
      TimeSheetController.to.setDateFormat();
      await TimeSheetController.to.getAdminTimeSheet(false);
    });
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
              text: "timesheet",
              color: AppColors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: InkWell(
                      onTap: () {
                        showDateDialog(context, onChanged: () {
                          TimeSheetController.to.getAdminTimeSheet(true);
                        });
                      },
                      child: Container(
                        height: 45,
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        // width: Get.width * 0.60,
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
                                  text: TimeSheetController.to.attendanceDate,
                                  color: AppColors.blue,
                                  fontSize: 16,
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
                  SizedBox(height: 20),
                  getListData(context)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  getListData(BuildContext context) {
    return commonLoader(
      loader: TimeSheetController.to.showTimeSheetList,
      length: MediaQuery.of(context).size.height.toInt(),
      singleRow: true,
      child: TimeSheetController
                  .to.adminTimeSheetModel?.data?.userData?.length ==
              0
          ? NoRecord()
          : ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: TimeSheetController
                      .to.adminTimeSheetModel?.data?.userData?.length ??
                  0,
              itemBuilder: (BuildContext context, int index) {
                var TimeSheetList = TimeSheetController
                    .to.adminTimeSheetModel?.data?.userData?[index];
                return Column(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      padding: EdgeInsets.all(15),
                      width: Get.width,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.lightGrey),
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 50.0,
                              height: 50.0,
                              child: Image.network(
                                commonNetworkImageDisplay(
                                    '${TimeSheetList?.profileImage}'),
                                fit: BoxFit.cover,
                                width: 58.0,
                                height: 58.0,
                                errorBuilder: (BuildContext? context,
                                    Object? exception, StackTrace? stackTrace) {
                                  return Image.asset(
                                    "assets/images/user.jpeg",
                                    fit: BoxFit.contain,
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: Get.width * 0.45,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: '${TimeSheetList?.name ?? "-"}',
                                    color: AppColors.secondaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  SizedBox(height: 8),
                                  CustomText(
                                    text:'${TimeSheetList?.jobPosition == ""  || TimeSheetList?.jobPosition==null ? "-" :TimeSheetList?.jobPosition?.positionName}',
                                    color: AppColors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            CustomText(
                                text:
                                    '${getTotalWorkTime(TimeSheetList?.workData) ?? "00:00:00"}', //'${TimeSheetList?.workData?[0].workedHours}',
                                color: AppColors.grey,
                                fontSize: 13,
                                fontWeight: FontWeight.w600),
                            const SizedBox(
                              height: 8,
                              width: 4,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }

  durationConverter(Duration duration) {
    int seconds = duration.inSeconds;
    int hours = seconds ~/ 3600;
    seconds %= 3600;
    int minutes = seconds ~/ 60;
    seconds %= 60;

    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  getTotalWorkTime(List<WorkDatum>? workData) {
    Duration totalWorkedHours = Duration();
    for (var workData in workData!) {
      String? workedHoursString =
          workData.workedHours == "" ? "00:00:00" : workData.workedHours;
      if (workedHoursString != "" && workedHoursString != null) {
        List<String>? hoursMinutesSeconds = workedHoursString?.split(':');
        print('workedHoursString$workedHoursString');
        print('hoursMinutesSeconds$hoursMinutesSeconds');
        int hours = int.parse(hoursMinutesSeconds![0]);
        int minutes = int.parse(hoursMinutesSeconds[1]);
        int seconds = int.parse(hoursMinutesSeconds[2]);

        Duration duration =
            Duration(hours: hours, minutes: minutes, seconds: seconds);
        totalWorkedHours += duration;
      }
    }
    print("totalWorkedHours$totalWorkedHours");
    return durationConverter(totalWorkedHours);
  }
}
