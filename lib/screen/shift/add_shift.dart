import 'package:dreamhrms/constants/colors.dart';
import 'package:dreamhrms/controller/add_shift_controller.dart';
import 'package:dreamhrms/controller/common_controller.dart';
import 'package:dreamhrms/controller/theme_controller.dart';
import 'package:dreamhrms/model/add_shift_model.dart';
import 'package:dreamhrms/screen/shift/shift.dart';
import 'package:dreamhrms/screen/shift/working_time.dart';
import 'package:dreamhrms/widgets/Custom_text.dart';
import 'package:dreamhrms/widgets/common_button.dart';
import 'package:dreamhrms/widgets/common_timePicker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:localization/localization.dart';
import '../../controller/shift_controller.dart';
import '../../services/provision_check.dart';
import '../../services/utils.dart';
import '../../widgets/Custom_rich_text.dart';
import '../../widgets/back_to_screen.dart';
import '../../widgets/color_picker.dart';
import '../../widgets/common_textformfield.dart';

class AddShiftScreen extends StatelessWidget {
  AddShiftScreen({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((value) async {
      AddShiftController.to.isEdit == "Edit"
          ? null
          : AddShiftController.to.setDurationData();
      AddShiftController.to.isEdit == "Edit"
          ? null
          : AddShiftController.to.setClockData();
    });
    return Scaffold(
      bottomNavigationBar: bottomWidget(),
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
                      Get.back();
                      AddShiftController.to.onClose();
                    },
                    child: Icon(Icons.arrow_back_ios_new_outlined,
                        color: ThemeController.to.checkThemeCondition() == true
                            ? AppColors.white
                            : AppColors.black)),
                SizedBox(width: 8),
                CustomText(
                  text: AddShiftController.to.isEdit == "Edit"
                      ? "edit_shift"
                      : "add_shift",
                  color: AppColors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child:   ProvisionsWithIgnorePointer(
          provision: "Shift& Schedule",
          type:"create",
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 18.0),
            child: Obx(
              () => Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomRichText(
                        textAlign: TextAlign.left,
                        text: "shift_name",
                        color: AppColors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        textSpan: ' *',
                        textSpanColor: AppColors.red),
                    SizedBox(
                      height: 8,
                    ),
                    CommonTextFormField(
                      controller: AddShiftController.to.shiftName,
                      isBlackColors: true,
                      keyboardType: TextInputType.name,
                      validator: (String? data) {
                        if (data!.isEmpty) {
                          return "shift_name_validator";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomRichText(
                        textAlign: TextAlign.left,
                        text: "working_hr_day",
                        color: AppColors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        textSpan: ' *',
                        textSpanColor: AppColors.red),
                    SizedBox(
                      height: 8,
                    ),
                    CommonTimePicker(
                      controller: AddShiftController.to.totalWorkHrs,
                      timeFormat: GetStorage().read("global_time").toString(),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomText(
                        text: "choose_color",
                        color: AppColors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        SizedBox(
                          height: 40,
                          width: Get.width * 0.80,
                          child: ListView.separated(
                            itemCount: ShiftController.to.ColorCodeList.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return SizedBox(
                                height: 40,
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        AddShiftController
                                                .to.currentColor.value =
                                            ShiftController.to.ColorCodeList
                                                .elementAt(index);
                                      },
                                      child: CircleAvatar(
                                        radius: 12,
                                        backgroundColor: ShiftController
                                            .to.ColorCodeList
                                            .elementAt(index),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                width: 4,
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        InkWell(
                          onTap: () {
                            colorPicker(
                                context: context,
                                controller:
                                    AddShiftController.to.currentColor.value);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Container(
                              height: 23,
                              width: 23,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.grey.withOpacity(0.5)),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16),
                                ),
                                color: AppColors.white,
                              ),
                              child: Center(child: Text("+")),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomText(
                        text: "choosen_color",
                        color: AppColors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                    SizedBox(
                      height: 5,
                    ),
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: AddShiftController.to.currentColor.value,
                    ),
                    SizedBox(height: 15),
                    WorkingTime(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bottomWidget() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity / 1.2,
              child: CommonButton(
                text: "Save",
                textColor: AppColors.white,
                fontSize: 16,
                buttonLoader: CommonController.to.buttonLoader,
                fontWeight: FontWeight.w500,
                onPressed: () async {
                  CommonController.to.buttonLoader = true;
                  await AddShiftController.to.isEdit == "Edit"
                      ? await callEditShift()
                      : await callAddShift();
                  CommonController.to.buttonLoader = false;
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
            BackToScreen(
                text: "cancel".i18n(),
                arrowIcon: false,
                onPressed: () {
                  Get.back();
                }),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  callAddShift() async {
    if (formKey.currentState?.validate() == true) {
      if (AddShiftController.to.durationType.value.name == 'Duration') {
       if (AddShiftController.to.updatedDurationBasedList.isEmpty) {
          UtilService().showToast("error", message: "Please add Work time");
        } else {
          await AddShiftController.to.addShift();
          await ShiftController.to
              .getShiftList();
          Get.to(() => Shift());
        }
      } else {
        if (AddShiftController.to.updatedClockBasedList.isEmpty) {
          UtilService().showToast("error", message: "Please add Work time");
        } else {
          await AddShiftController.to.addShift();
          Get.to(() => Shift());
          await ShiftController.to
              .getShiftList();
        }
      }
    }
  }

  callEditShift() async {
    if (formKey.currentState?.validate() == true) {
      if (AddShiftController.to.durationType.value.name == 'Duration') {
          if (AddShiftController.to.updatedDurationBasedList.isEmpty) {
          UtilService().showToast("error", message: "Please add Work time");
        } else {
          await AddShiftController.to
              .editShift();
          await ShiftController.to
              .getShiftList();
        }
      } else {
          if (AddShiftController.to.updatedClockBasedList.isEmpty) {
          UtilService().showToast("error", message: "Please add Work time");
        } else {
          await AddShiftController.to
              .editShift();
          await ShiftController.to
              .getShiftList();
        }
      }
    }
  }
}
