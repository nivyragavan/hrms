import 'package:dreamhrms/controller/holiday_controller.dart';
import 'package:dreamhrms/model/holiday_model.dart';
import 'package:dreamhrms/screen/employee/employee_details/profile.dart';
import 'package:dreamhrms/screen/holidays/add_holiday.dart';
import 'package:dreamhrms/screen/holidays/holiday_Calendar.dart';
import 'package:dreamhrms/screen/main_screen.dart';
import 'package:dreamhrms/widgets/no_record.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart' hide Data;
import 'package:localization/localization.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../../constants/colors.dart';
import '../../controller/common_controller.dart';
import '../../controller/theme_controller.dart';
import '../../widgets/Custom_text.dart';
import '../../widgets/common_alert_dialog.dart';


class HolidaysScreen extends StatelessWidget {
  const HolidaysScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
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
                InkWell(
                  onTap: () {
                    Get.to(() => MainScreen());
                  },
                  child: Icon(Icons.arrow_back_ios_new_outlined,
                      color: ThemeController.to.checkThemeCondition() == true
                          ? AppColors.white
                          : AppColors.black),
                ),
                SizedBox(width: 8),
                CustomText(
                  text: "holidays",
                  color: AppColors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
            if(GetStorage().read('role')!="employee")Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                onTap: () async {
                  await HolidayController.to.clear();
                  Get.to(() => AddHoliday());
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
            () => Column(
          children: [
            HolidayCalender(),
            SizedBox(
              height: 16,
            ),
            Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: commonLoader(
                    length: height.toInt(),
                    loader: HolidayController.to.showList,
                    singleRow: true,
                    child: HolidayController.to.holidayListModel?.data?.length == 0
                        ? NoRecord()
                        : ListView.builder(
                      itemCount: HolidayController
                          .to.holidayListModel?.data?.length ??
                          0,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        var holiday = HolidayController
                            .to.holidayListModel?.data
                            ?.elementAt(index);
                        String dateString = holiday?.holidayDate ?? "";
                        DateTime dateTime = DateTime.parse(dateString);
                        return SizedBox(
                          height: 80,
                          child: TimelineTile(
                            alignment: TimelineAlign.manual,
                            lineXY: 0.15,
                            beforeLineStyle: LineStyle(
                                color: AppColors.grey.withOpacity(0.2),
                                thickness: 1.2),
                            indicatorStyle: IndicatorStyle(
                                width: 12,
                                color: AppColors.blue,
                                indicatorXY: 0.5),
                            startChild: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                    text: "${dateTime.day}",
                                    color: AppColors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                                CustomText(
                                    text:
                                    "${holiday?.day?.substring(0, 3) ?? ""}"
                                        ,
                                    color: AppColors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ],
                            ),
                            endChild:Container(
                              decoration: BoxDecoration(

                                  border: Border.all(
                                      color: AppColors.grey.withOpacity(0.5)),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Slidable(
                                closeOnScroll: true,
                                endActionPane: ActionPane(
                                  extentRatio: 0.35,
                                  motion: const BehindMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) {
                                        editHoliday(holiday);
                                      },
                                      backgroundColor: AppColors.blue,
                                      foregroundColor: Colors.white,
                                      icon: Icons.edit_outlined,
                                    ),
                                    SlidableAction(
                                      onPressed: (context) {
                                        commonAlertDialog(
                                          icon: Icons.delete_outline,
                                          context: context,
                                          title: "${"delete_holiday"}?",
                                          description:
                                          'All details in this Holiday will be deleted.',
                                          actionButtonText: "delete",
                                          onPressed: () async {
                                            CommonController
                                                .to.buttonLoader = true;
                                            await HolidayController.to
                                                .deleteHoliday(
                                                holiday!.id.toString());
                                            CommonController
                                                .to.buttonLoader = false;
                                          },
                                        );
                                      },
                                      backgroundColor: AppColors.red,
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete_outline,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(8),
                                          bottomRight: Radius.circular(8)),
                                    ),
                                  ],
                                ),
                                child: Container(
                                  height: 43,
                                  width: double.infinity / 1.3,
                                  color: ThemeController.to.checkThemeCondition() == true ? AppColors.black : AppColors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0, top: 10.0),
                                    child: CustomText(
                                        text:
                                        "${holiday?.holidayName ?? ""}"
                                            ,
                                        color: AppColors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  editHoliday(Data? holiday) {
    Get.to(() => AddHoliday(
      isEdit: true,
    ));
    HolidayController.to.holidayName.text = holiday?.holidayName ?? "";
    HolidayController.to.holidayDate.text = CommonController.to.dateConversion(holiday!.holidayDate.toString() , GetStorage().read("date_format"))?? "";
    HolidayController.to.holidayId.text = holiday?.id.toString() ?? "";
  }
}

