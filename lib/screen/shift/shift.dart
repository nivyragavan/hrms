import 'package:dreamhrms/controller/add_shift_controller.dart';
import 'package:dreamhrms/controller/theme_controller.dart';
import 'package:dreamhrms/model/shift_list_model.dart';
import 'package:dreamhrms/screen/employee/employee_details/profile.dart';
import 'package:dreamhrms/screen/shift/add_shift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import '../../constants/colors.dart';
import '../../controller/common_controller.dart';
import '../../controller/shift_controller.dart';
import '../../services/provision_check.dart';
import '../../widgets/Custom_text.dart';
import '../../widgets/common.dart';
import '../../widgets/no_record.dart';
import '../main_screen.dart';

class Shift extends StatelessWidget {
  const Shift({super.key});

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
                      color: ThemeController.to.checkThemeCondition() == true
                          ? AppColors.white
                          : AppColors.black),
                ),
                SizedBox(width: 8),
                CustomText(
                  text: "shift",
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
                  AddShiftController.to.isEdit = "";
                  AddShiftController.to.isEdit == ""
                      ? AddShiftController.to.onClose()
                      : null;
                  Get.to(() => AddShiftScreen());
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
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Obx(
            () => commonLoader(
              length: MediaQuery.of(context).size.height.toInt(),
              loader: ShiftController.to.showShift,
              singleRow: true,
              child: Column(
                children: [
                  ViewProvisionedWidget(
                    provision: "Shift& Schedule",
                    type: "view",
                    child:
                        ShiftController.to.shiftListModel?.data?.list?.length ==
                                0
                            ? NoRecord()
                            : ListView.separated(
                                physics: ScrollPhysics(),
                                itemCount: ShiftController.to.shiftListModel
                                        ?.data?.list?.length ??
                                    0,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  var data = ShiftController
                                      .to.shiftListModel?.data?.list?[index];
                                  return InkWell(
                                      onTap: () {
                                        _showBottomSheet(
                                            context,
                                            MediaQuery.of(context).size.height,
                                            data);
                                      },
                                      child: _buildShiftContainer(
                                          data, context, index));
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(
                                    height: 15,
                                  );
                                },
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

  Widget _buildShiftContainer(
      ListArray? data, BuildContext context, int index) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              color: ThemeController.to.checkThemeCondition() == true
                  ? AppColors.black
                  : AppColors.white,
              border: Border.all(
                color: AppColors.grey.withOpacity(0.3),
              ),
              borderRadius: const BorderRadius.all(Radius.circular(14))),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            child: Column(
              children: [
                commonDataDisplay(
                  title1: "shift_name",
                  textFontSize1: 13,
                  textFontSize2: 13,
                  titleFontSize1: 11,
                  titleFontSize2: 11,
                  text1: '${data?.shiftName}',
                  title2: "maximum_hours",
                  text2: '${timeTo12Hrs(data?.maxHours ?? "", "h'h' mm'm'")}',
                ),
                SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: Get.width * 0.40,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                              text: "shift_type",
                              color: AppColors.grey,
                              fontSize: 11,
                              fontWeight: FontWeight.w400),
                          SizedBox(height: 4),
                          CustomText(
                              text: '${data?.shiftType}',
                              color: AppColors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                        ],
                      ),
                    ),
                    SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                            text: "color",
                            color: AppColors.grey,
                            fontSize: 11,
                            fontWeight: FontWeight.w400),
                        SizedBox(height: 4),
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              color: getColorFromHex('${data?.color}')),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 5,
          top: 4,
          child: PopupMenuButton(
            constraints: BoxConstraints(maxWidth: 100, maxHeight: 38),
            icon: Icon(Icons.more_vert, color: AppColors.grey),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem(
                child: GestureDetector(
                  onTap: () {
                    _edit(data, index);
                  },
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 25.0),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/edit_out.svg",
                            color: AppColors.black,
                            width: 14,
                            height: 14,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          CustomText(
                            text: 'edit',
                            color: AppColors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    int colorValue = int.parse(hexColor, radix: 16);
    return Color(0xFF000000 + colorValue);
  }

  _showBottomSheet(BuildContext context, double height, ListArray? data) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25.0),
            ),
            color: ThemeController.to.checkThemeCondition() == true
                ? AppColors.black
                : AppColors.white,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Center(
                    child: Container(
                      height: 4,
                      width: 75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: AppColors.grey,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  CustomText(
                    text: '${data?.shiftName}',
                    color: AppColors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: Get.width * 0.40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                            text: "shift_color",
                            color: AppColors.grey,
                            fontSize: 13,
                            fontWeight: FontWeight.w400),
                        SizedBox(height: 4),
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              color: getColorFromHex('${data?.color}')),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: Get.width * 0.40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                            text: "maximum_hours",
                            color: AppColors.grey,
                            fontSize: 13,
                            fontWeight: FontWeight.w400),
                        SizedBox(height: 4),
                        CustomText(
                            text:
                                '${timeTo12Hrs(data?.maxHours ?? "", "h'h'm'm'")}',
                            color: AppColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: Get.width * 0.40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                            text: "shift_type",
                            color: AppColors.grey,
                            fontSize: 13,
                            fontWeight: FontWeight.w400),
                        SizedBox(height: 4),
                        CustomText(
                            text: '${data?.shiftType}',
                            color: AppColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  CustomText(
                      text: "working_time",
                      color: AppColors.grey,
                      fontSize: 13,
                      fontWeight: FontWeight.w400),
                  SizedBox(height: 4),
                  SizedBox(
                    height: (data?.workTime?.length ?? 0) < 3
                        ? 80
                        : MediaQuery.of(context).size.height * 0.30,
                    child: ListView.builder(
                      itemCount: data?.workTime?.length ?? 0,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        var workingTime = data?.workTime;
                        var duration = workingTime?[index].duration ?? "";
                        var breakTime = workingTime?[index].breakTime ?? "";
                        var startTime = workingTime?[index].startTime ?? "";
                        var endTime = workingTime?[index].endTime ?? "";
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: Get.width * 0.25,
                                    child: CustomText(
                                        text: '${workingTime?[index].days}',
                                        color: AppColors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    // width: Get.width * 0.35,
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/Laptop.png',
                                          height: 16,
                                          width: 16,
                                        ),
                                        SizedBox(width: 8),
                                        CustomText(
                                            text: data?.shiftType == "1"
                                                ? '${timeTo12Hrs(startTime, "hh:mm a")} -'
                                                    ' ${timeTo12Hrs(endTime, "hh:mm a")}  '
                                                : '${timeTo12Hrs(duration ?? "", "h'h' mm'm'")}',
                                            color: AppColors.grey,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              data?.shiftType == "1"
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              'assets/images/Coffee.png',
                                              height: 16,
                                              width: 16,
                                            ),
                                            SizedBox(width: 8),
                                            CustomText(
                                                text:
                                                    "${timeTo12Hrs(breakTime ?? "", "hh")}h",
                                                color: AppColors.grey,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400)
                                          ],
                                        )
                                      ],
                                    )
                                  : SizedBox()
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String timeTo12Hrs(String time, String dateFormat) {
    DateTime date24Hour =
        DateFormat("HH:mm:ss").parse(time.removeAllWhitespace);
    String formattedTime = DateFormat(dateFormat).format(date24Hour);
    return formattedTime;
  }

  _edit(ListArray? data, int index) async {
    AddShiftController.to.isEdit = "Edit";
    AddShiftController.to.shiftId = int.parse(data?.id ?? "");
    String maxHrs = CommonController.to.timeConversion(
        data?.maxHours ?? "", GetStorage().read("global_time").toString());
    AddShiftController.to.totalWorkHrs.text = "${maxHrs}";
    AddShiftController.to.currentColor.value =
        getColorFromHex('${data?.color}');
    // For Duration.
    if (data?.shiftType == "2") {
      AddShiftController.to.durationType.value = ShiftType.Duration;
      AddShiftController.to.isEditingType = "Duration";
      AddShiftController.to.shiftName.text = data?.shiftName ?? "";
      AddShiftController.to.durationBasedList.clear();
      AddShiftController.to.updatedDurationBasedList.clear();
      //picking up the data where workTime days and duration list's days are equal
      AddShiftController.to.durationLoader = true;
      for (var item in data!.workTime!) {
        int existingIndex = AddShiftController.to.durationBasedList.indexWhere(
          (durationItem) => durationItem.days == item.days,
        );
        if (existingIndex != -1) {
          // Update the duration value only if the index exists
          String duration = CommonController.to.timeConversion(
              item.duration, GetStorage().read("global_time").toString());
          AddShiftController.to.durationBasedList[existingIndex].duration.text =
              "${duration}";
          AddShiftController.to.durationBasedList.add(
            AddShiftController.to.durationBasedList.elementAt(existingIndex),
          );
          AddShiftController.to.updatedDurationBasedList.add(
              AddShiftController.to.durationBasedList.elementAt(existingIndex));
        }
      }
      AddShiftController.to.durationLoader = false;
      Get.back();
      Get.to(() => AddShiftScreen());
    }

    // For Clock
    else if (data?.shiftType == "1") {
      AddShiftController.to.durationType.value = ShiftType.Clock;
      AddShiftController.to.shiftName.text = data?.shiftName ?? "";
      AddShiftController.to.updatedClockBasedList.clear();
      AddShiftController.to.clockBasedList.clear();
      AddShiftController.to.isEditingType = "Clock";
      for (var item in data!.workTime!) {
        int existingIndex = AddShiftController.to.clockBasedList.indexWhere(
          (durationItem) => durationItem.days == item.days,
        );
        if (existingIndex != -1) {
          String startTime = CommonController.to.timeConversion(
              item.startTime.toString(),
              GetStorage().read("global_time").toString());
          String endTime = CommonController.to.timeConversion(
              item.endTime.toString(),
              GetStorage().read("global_time").toString());
          String breakTime = CommonController.to.timeConversion(
              item.breakTime.toString(),
              GetStorage().read("global_time").toString());
          AddShiftController.to.clockBasedList[existingIndex].active = true;
          // Add the clock-based values at the existing index
          AddShiftController.to.clockBasedList[existingIndex].startTime.text =
              "${startTime}";
          AddShiftController.to.clockBasedList[existingIndex].endTime.text =
              "${endTime}";
          AddShiftController.to.clockBasedList[existingIndex].breakTime.text =
              "${breakTime}";
          AddShiftController.to.clockBasedList.add(
            AddShiftController.to.clockBasedList.elementAt(existingIndex),
          );
          AddShiftController.to.updatedClockBasedList.add(
              AddShiftController.to.clockBasedList.elementAt(existingIndex));
        }
        Get.back();
        Get.to(() => AddShiftScreen());
      }
    }
  }
}
