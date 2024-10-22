import 'package:dreamhrms/controller/schedule_controller.dart';
import 'package:dreamhrms/screen/main_screen.dart';
import 'package:dreamhrms/screen/schedule/add_schedule_view.dart';
import 'package:dreamhrms/screen/schedule/calender_view.dart';
import 'package:dreamhrms/widgets/Custom_text.dart';
import 'package:dreamhrms/widgets/common.dart';
import 'package:dreamhrms/widgets/no_record.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';
import '../../constants/colors.dart';
import '../../controller/theme_controller.dart';
import '../../model/schedue_datewise_model.dart';
import '../../services/provision_check.dart';
import '../employee/employee_details/profile.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  ScheduleDateWiseModel scheduleDateWiseModel = ScheduleDateWiseModel(
    firstData: [], // Initialize the list with an empty list
    secondData: [],
    thirdData: [],
    fourData: [],
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero).then((value) async {
      ScheduleController.to.scheduleLoader = true;
      await ScheduleController.to.getDataList();
      await ScheduleController.to.getScheduleList();
      await ScheduleController.to.getFilteredList(
          ScheduleController.to.scheduleListModel, scheduleDateWiseModel);
      ();
      ScheduleController.to.scheduleLoader = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      color: ThemeController.to.checkThemeCondition() == true ? AppColors.white : AppColors.black),
                ),
                SizedBox(width: 8),
                CustomText(
                  text: "schedule",
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
                  ScheduleController.to.onClose();
                  Get.to(() => AddSchedule());
                },
                child: Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    color: AppColors.blue,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: Icon(Icons.add, color: AppColors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child:   ViewProvisionedWidget(
          provision: "Shift& Schedule",
          type:"view",
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Calender(isSingleDate: false),
                  commonLoader(
                    length: MediaQuery.of(context).size.height.toInt(),
                    loader: ScheduleController.to.scheduleLoader,
                    singleRow: true,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          scheduleList(ScheduleController.to.dateList[0],
                              scheduleDateWiseModel.firstData),
                          scheduleList(ScheduleController.to.dateList[1],
                              scheduleDateWiseModel.secondData),
                          scheduleList(ScheduleController.to.dateList[2],
                              scheduleDateWiseModel.thirdData),
                          scheduleList(ScheduleController.to.dateList[3],
                              scheduleDateWiseModel.fourData),
                        ],
                      ),
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

  Widget scheduleList(String scheduleDate, List<dynamic>? scheduleList) {
    DateTime date = DateFormat("yyyy-MM-dd").parse(scheduleDate);

    String formattedDate = DateFormat("dd MMMM, EEEE").format(date);

    Color getColorFromHex(String hexColor) {
      try {
        hexColor = hexColor.replaceAll("#", "");
        if (hexColor.length == 6) {
          hexColor = "ff" + hexColor; // Add alpha value if it's missing
        }
        int colorValue = int.parse(hexColor, radix: 16);
        return Color(colorValue);
      } catch (e) {
        print("Error parsing hexColor: $hexColor");
        return Colors.grey;
      }
    }


    return Obx(
      () => commonLoader(
        length: 6,
        loader: ScheduleController.to.scheduleLoader,
        singleRow: true,
        child: ScheduleController.to.scheduleListModel?.data?.data?.length == 0
            ? NoRecord()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  CustomText(
                    text: formattedDate,
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 10),
                  ListView.builder(
                    itemCount: scheduleList?.length ?? 0,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      var ScheduleInformation = scheduleList?[index];
                      String startTime =
                          ScheduleInformation?.shiftStartTime ?? "";
                      String endTime = ScheduleInformation?.shiftEndTime ?? "";
                      String shiftHrs = ScheduleInformation?.shiftHours ?? "";
                      String duration = ScheduleInformation?.duration ?? "";
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 4.0),
                        child: Container(
                          height: 68,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(
                              color: getColorFromHex(
                                  '${ScheduleInformation?.shiftColor}'),
                            ),
                          ),
                          child: ListTile(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16.0),
                            leading: Container(
                              height: 30,
                              width: 3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(11.0),
                                color: getColorFromHex(
                                    '${ScheduleInformation?.shiftColor}'),
                              ),
                            ),
                            title: CustomText(
                                text: "${ScheduleInformation?.shiftName}",
                                color: AppColors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                            subtitle: (startTime.isNotEmpty &&
                                    endTime.isNotEmpty)
                                ? CustomText(
                                    text: "${startTime.substring(0, 5)} -"
                                        "${endTime.substring(0, 5)} (${shiftHrs.substring(1, 2)}h)",
                                    color: AppColors.black,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400)
                                : CustomText(
                                text: "${duration}",
                                color: AppColors.black,
                                fontSize: 11,
                                fontWeight: FontWeight.w400),
                            trailing: ClipOval(
                              child: SizedBox(
                                width: 50.0,
                                height: 50.0,
                                child: Image.network(
                                  commonNetworkImageDisplay(
                                      '${ScheduleInformation?.imageSrc}'),
                                  fit: BoxFit.cover,
                                  errorBuilder: (BuildContext? context,
                                      Object? exception,
                                      StackTrace? stackTrace) {
                                    return Image.asset(
                                      "assets/images/user.jpeg",
                                      fit: BoxFit.contain,
                                    );
                                  },
                                  width: 50.0,
                                  height: 50.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
