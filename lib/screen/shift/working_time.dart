import 'package:dreamhrms/constants/colors.dart';
import 'package:dreamhrms/controller/add_shift_controller.dart';
import 'package:dreamhrms/widgets/Custom_text.dart';
import 'package:dreamhrms/widgets/common_button.dart';
import 'package:dreamhrms/widgets/common_timePicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:localization/localization.dart';
import '../../controller/theme_controller.dart';
import '../../model/add_shift_model.dart';
import '../../widgets/Custom_rich_text.dart';
import '../../widgets/back_to_screen.dart';
import '../employee/employee_details/profile.dart';

class WorkingTime extends StatelessWidget {
  const WorkingTime({super.key});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomRichText(
            textAlign: TextAlign.left,
            text: "schedule_type",
            color: AppColors.black,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            textSpan: ' *',
            textSpanColor: AppColors.red),
        SizedBox(
          height: 8,
        ),
        Flex(
          direction: Axis.horizontal,
          children: [
            Container(
              height: 43,
              width: MediaQuery.of(context).size.width * 0.45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: AppColors.grey.withAlpha(40),
                ),
              ),
              child: Obx(
                () => Padding(
                  padding: const EdgeInsets.only(left: 6.0, bottom: 12.0),
                  child: RadioListTile<ShiftType>(
                    contentPadding: const EdgeInsets.only(right: 8.0),
                    dense: true,
                    title: CustomText(
                        text: "duration",
                        color: AddShiftController.to.durationType.value.name ==
                                'Duration'
                            ? AppColors.darkBlue
                            : AppColors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                    value: ShiftType.Duration,
                    groupValue: AddShiftController.to.durationType.value,
                    onChanged: (AddShiftController.to.isEdit == "Edit" &&
                            AddShiftController.to.isEditingType == "Duration")
                        ? (ShiftType? value) {
                            AddShiftController.to.durationType.value = value!;
                          }
                        : AddShiftController.to.isEdit == ""
                            ? (ShiftType? value) {
                                AddShiftController.to.durationType.value =
                                    value!;
                              }
                            : null,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 4,
            ),
            Flexible(
              child: Container(
                height: 43,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: AppColors.grey.withAlpha(40),
                  ),
                ),
                child: Obx(
                  () => RadioListTile<ShiftType>(
                    contentPadding: const EdgeInsets.only(bottom: 12.0),
                    dense: true,
                    title: CustomText(
                        text: "clock",
                        color: AddShiftController.to.durationType.value.name ==
                                'Clock'
                            ? AppColors.black
                            : AppColors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                    value: ShiftType.Clock,
                    groupValue: AddShiftController.to.durationType.value,
                    onChanged: (AddShiftController.to.isEdit == "Edit" &&
                            AddShiftController.to.isEditingType == "Clock")
                        ? (ShiftType? value) {
                            AddShiftController.to.durationType.value = value!;
                            AddShiftController.to.isEdit == "Edit"
                                ? null
                                : AddShiftController.to.clockSwitches.clear();
                          }
                        : AddShiftController.to.isEdit == ""
                            ? (ShiftType? value) {
                                AddShiftController.to.durationType.value =
                                    value!;
                                AddShiftController.to.isEdit == "Edit"
                                    ? null
                                    : AddShiftController.to.clockSwitches
                                        .clear();
                              }
                            : null,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        CustomText(
            text: "working_time",
            color: AppColors.black,
            fontSize: 12,
            fontWeight: FontWeight.w500),
        SizedBox(
          height: 8,
        ),
        Obx(() {
          if (AddShiftController.to.durationType.value.name == 'Duration') {
            return commonLoader(
              height: 7,
              length: 7,
              loader: AddShiftController.to.durationLoader,
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: AddShiftController.to.durationBasedList.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  var data =
                      AddShiftController.to.durationBasedList.elementAt(index);
                  return _buildDuration(data, index, context, height);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 16);
                },
              ),
            );
          } else {
            return commonLoader(
              height: 7,
              length: 7,
              loader: AddShiftController.to.clockLoader,
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: AddShiftController.to.clockBasedList.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  var data =
                      AddShiftController.to.clockBasedList.elementAt(index);
                  return _buildClockBased(data, index, context, height);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 16);
                },
              ),
            );
          }
        }),
      ],
    );
  }

  Widget _buildDuration(
      DurationData data, int index, BuildContext context, double height) {
    return GestureDetector(
      onTap: () {
        showDurationBottomSheet(
            context,
            height,
            AddShiftController.to.durationType.value == 'Duration'
                ? true
                : false,
            index,
            data);
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: Colors.grey.withAlpha(40),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Row(
            children: [
              Transform.scale(
                scale: 0.8,
                child: CupertinoSwitch(
                  activeColor: Colors.blue,
                  applyTheme: true,
                  value: data.active,
                  onChanged: (_) {
                    if (data.active) {
                      AddShiftController.to.durationLoader = true;
                      data.active = !data.active;
                      if (data.active) {
                        final updatedData = DurationData(
                            days: data.days,
                            duration: data.duration,
                            active: data.active);
                        AddShiftController.to.durationBasedList[index] =
                            updatedData;
                        AddShiftController.to.durationLoader = false;
                      }
                      else {
                        AddShiftController.to.durationBasedList[index].duration.clear();
                        index ==
                                AddShiftController
                                    .to.updatedDurationBasedList[index]
                            ? AddShiftController.to.updatedDurationBasedList
                                .removeAt(index)
                            : null;
                        AddShiftController.to.durationLoader = false;
                      }
                    } else {
                      showDurationBottomSheet(
                          context,
                          height,
                          AddShiftController.to.durationType.value == 'Duration'
                              ? true
                              : false,
                          index,
                          data);
                      AddShiftController.to.durationLoader = false;
                    }
                  },
                ),
              ),
              SizedBox(
                height: 32,
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data.days,
                    style: TextStyle(
                      color: AppColors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: Get.width * 0.30,
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/Laptop.png',
                              height: 16,
                              width: 16,
                            ),
                            SizedBox(width: 8),
                            Text(
                              "${data.duration.text} ",
                              style: TextStyle(
                                color: AppColors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildClockBased(
      ClockData data, int index, BuildContext context, double height) {
    return Obx(
      () {
        return GestureDetector(
          onTap: () {
            showClockBasedBottomSheet(
                context,
                height,
                AddShiftController.to.durationType != 'Duration' ? true : false,
                index,
                data);
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: Colors.grey.withAlpha(40),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                children: [
                  SizedBox(
                    height: 32,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Transform.scale(
                        scale: 0.8,
                        child: CupertinoSwitch(
                            activeColor: Colors.blue,
                            applyTheme: true,
                            value: data.active,
                            onChanged: (_) {
                              data.active = !data.active;
                              AddShiftController.to.clockLoader = true;
                              final updatedData = ClockData(
                                  days: data.days,
                                  startTime: data.startTime,
                                  endTime: data.endTime,
                                  breakTime: data.breakTime,
                                  active: data.active);
                              AddShiftController.to.clockBasedList[index] =
                                  updatedData;
                              AddShiftController.to.clockLoader = false;
                              AddShiftController.to
                                  .updatedClockBasedList[index] = updatedData;
                            }),
                      ),
                    ],
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        data.days,
                        style: TextStyle(
                          color: AppColors.grey,
                          fontSize: 14,
                        ),
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/Laptop.png',
                                height: 16,
                                width: 16,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "${data.startTime.text}  - ${data.endTime.text} ",
                                style: TextStyle(
                                  color: AppColors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'assets/images/Coffee.png',
                                height: 16,
                                width: 16,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "${data.breakTime.text} ",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  showDurationBottomSheet(BuildContext context, double height, bool isSelected,
      int index, DurationData data) {
    AddShiftController.to.durationWorkHr.text = data.duration.text;
    return showModalBottomSheet(
      backgroundColor: AppColors.transparent,
      isScrollControlled: true,
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
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
                  SizedBox(height: 8),
                  CustomText(
                    text: data.days ?? "",
                    color: AppColors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomText(
                      text: "working_hr_day",
                      color: AppColors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                  SizedBox(
                    height: 8,
                  ),
                  CommonTimePicker(
                      controller: AddShiftController.to.durationWorkHr,
                      timeFormat: GetStorage().read("global_time").toString()),
                  SizedBox(
                    height: 32,
                  ),
                  SizedBox(
                    width: double.infinity / 1.2,
                    child: CommonButton(
                      text: "Save",
                      textColor: AppColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      onPressed: () {
                        AddShiftController.to.durationLoader = true;
                        data.active = !data.active;
                        final updatedData = DurationData(
                            days: data.days,
                            duration: TextEditingController(
                                text:
                                    AddShiftController.to.durationWorkHr.text),
                            active: data.active);
                        AddShiftController.to.durationBasedList[index] =
                            updatedData;
                        AddShiftController.to.durationLoader = false;
                        AddShiftController.to.updateDurationList(index, data);
                        Get.back();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  BackToScreen(
                    text: "cancel",
                    arrowIcon: false,
                    onPressed: () {
                      Get.back();
                      AddShiftController.to.durationWorkHr.clear();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  showClockBasedBottomSheet(BuildContext context, double height,
      bool isSelected, int index, ClockData data) {
    AddShiftController.to.startTime.text = data.startTime.text;
    AddShiftController.to.endTime.text = data.endTime.text;
    AddShiftController.to.breakTime.text = data.breakTime.text;

    return showModalBottomSheet(
      backgroundColor: AppColors.transparent,
      isScrollControlled: true,
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
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
                  SizedBox(height: 8),
                  CustomText(
                    text: data.days,
                    color: AppColors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomText(
                      text: "start_time",
                      color: AppColors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                  SizedBox(
                    height: 8,
                  ),
                  CommonTimePicker(
                      controller: AddShiftController.to.startTime,
                      timeFormat: GetStorage().read("global_time").toString()),
                  SizedBox(
                    height: 16,
                  ),
                  CustomText(
                      text: "end_time",
                      color: AppColors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                  SizedBox(
                    height: 8,
                  ),
                  CommonTimePicker(
                      controller: AddShiftController.to.endTime,
                      timeFormat: GetStorage().read("global_time").toString()),
                  SizedBox(
                    height: 16,
                  ),
                  CustomText(
                      text: "break_time",
                      color: AppColors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                  SizedBox(
                    height: 8,
                  ),
                  CommonTimePicker(
                      controller: AddShiftController.to.breakTime,
                      timeFormat: GetStorage().read("global_time").toString()),
                  SizedBox(
                    height: 32,
                  ),
                  SizedBox(
                    width: double.infinity / 1.2,
                    child: CommonButton(
                      text: "Save",
                      textColor: AppColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      onPressed: () {
                        AddShiftController.to.updateClockList(index, data);
                        Get.back();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  BackToScreen(
                    text: "cancel",
                    arrowIcon: false,
                    onPressed: () {
                      Navigator.pop(context);
                      AddShiftController.to.startTime.clear();
                      AddShiftController.to.endTime.clear();
                      AddShiftController.to.breakTime.clear();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
