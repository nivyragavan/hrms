import 'package:dreamhrms/controller/employee_details_controller/time_sheet_controller.dart';
import 'package:dreamhrms/screen/employee/employee_details/profile.dart';
import 'package:dreamhrms/widgets/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';

import '../../../constants/colors.dart';
import '../../../widgets/Custom_text.dart';
import '../../../widgets/common.dart';
import '../../../widgets/no_record.dart';

class TimeSheet extends StatelessWidget {
  const TimeSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((value) async {
      TimeSheetController.to.setDateFormat();
      await TimeSheetController.to.getTimeSheetList(false);
    });
    return Scaffold(
      appBar: GetStorage().read("role")=="employee"?
      AppBar(
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
                  text: "timesheet",
                  color: AppColors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ],
        ),
      ):null,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(GetStorage().read("role")=="admin")CustomText(
                    text: "timesheet",
                    color: AppColors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  if(GetStorage().read("role")=="admin")SizedBox(height: 20),
                  Center(
                    child: InkWell(
                      onTap: () {
                        showDateDialog(context, onChanged: () {
                          TimeSheetController.to.getTimeSheetList(true);
                        });
                      },
                      child: Container(
                        height: 45,
                        margin: EdgeInsets.symmetric(horizontal: 30),
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
                  .to.employeeTimeSheetModel?.data?.workData?.length ==
              0
          ? NoRecord()
          : ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: TimeSheetController
                      .to.employeeTimeSheetModel?.data?.workData?.length ??
                  0,
              itemBuilder: (BuildContext context, int index) {
                var TimeSheetList = TimeSheetController
                    .to.employeeTimeSheetModel?.data?.workData?[index];
                return TimeSheetList!.workedHours!.isEmpty
                    ? getWeekOffList(TimeSheetList.date.toString())
                    : Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 15),
                            padding: EdgeInsets.all(15),
                            width: Get.width,
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColors.lightGrey),
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                        text: '${TimeSheetList.day ?? "-"}',
                                        color: AppColors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_today_outlined,
                                          color: AppColors.grey,
                                          size: 12,
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        CustomText(
                                            text:
                                                '${TimeSheetList.date ?? "-"}',
                                            color: AppColors.grey,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        SvgPicture.asset(
                                            "assets/icons/break.svg"),
                                        SizedBox(width: 3),
                                        CustomText(
                                            text: 'NA',
                                            color: AppColors.grey,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/clock.svg",
                                      color: index / 2 == 1
                                          ? AppColors.green
                                          : AppColors.red,
                                    ),
                                    SizedBox(width: 5),
                                    CustomText(
                                        text:
                                            '${TimeSheetList.workedHours ?? "-"}',
                                        color: AppColors.darkClrGreen,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        textAlign: TextAlign.start),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
              },
            ),
    );
  }

  getWeekOffList(String date) {
    String weekOffDate =
        DateFormat('dd MMM yyyy EEEE').format(DateTime.parse(date));
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: Container(
        height: 30,
        decoration: BoxDecoration(
          color: AppColors.yellow,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: "week_off",
              color: AppColors.black,
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
            CustomText(
              text: ": ${weekOffDate}",
              color: AppColors.grey,
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
      ),
    );
  }
}

showDateDialog(BuildContext context, {required Null Function() onChanged}) {
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: Container(
                height: 400,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Column(
                    children: [
                      Expanded(child: DatePicker()),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: CustomText(
                              onPressed: () {
                                onChanged();
                                Navigator.pop(context);
                              },
                              text: "done",
                              color: AppColors.blue,
                              fontSize: 15,
                              fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                )),
          ));
}
