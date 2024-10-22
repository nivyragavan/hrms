import 'package:dreamhrms/constants/colors.dart';
import 'package:dreamhrms/screen/off_boarding/off_boarding_screen.dart';
import 'package:dreamhrms/widgets/common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:skeleton_animation/skeleton_animation.dart';
import '../../controller/common_controller.dart';
import '../../controller/employee/employee_controller.dart';
import '../../controller/employee_details_controller/employee_offboarding_controller.dart';
import '../../controller/theme_controller.dart';
import '../../widgets/Custom_text.dart';
import '../../widgets/back_to_screen.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_datePicker.dart';
import '../../widgets/common_searchable_dropdown/MainCommonSearchableDropDown.dart';
import '../../widgets/common_textformfield.dart';

class EmployeeOffBoarding extends StatelessWidget {
  final String? userId;
  EmployeeOffBoarding({super.key, this.userId =  ""});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
                    Get.back();
                  },
                  child: Icon(Icons.arrow_back_ios_new_outlined,
                      color: ThemeController.to.checkThemeCondition() == true
                          ? AppColors.white
                          : AppColors.black),
                ),
                SizedBox(width: 8),
                CustomText(
                  text: "OffBoarding",
                  color: AppColors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ],
        ),
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
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
                          padding:
                              const EdgeInsets.only(left: 6.0, bottom: 12.0),
                          child: RadioListTile<OffBoardingType>(
                              contentPadding: const EdgeInsets.only(right: 8.0),
                              dense: true,
                              title: CustomText(
                                  text: "Resignation",
                                  color: EmployeeOffBoardingController
                                              .to.offBoardingType.value.name ==
                                          'Resignation'
                                      ? AppColors.darkBlue
                                      : AppColors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                              value: OffBoardingType.Resignation,
                              groupValue: EmployeeOffBoardingController
                                  .to.offBoardingType.value,
                              onChanged: (value) {
                                EmployeeOffBoardingController
                                    .to.offBoardingType.value = value!;
                              }),
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
                          () => Padding(
                            padding:
                                const EdgeInsets.only(left: 6.0, bottom: 12.0),
                            child: RadioListTile<OffBoardingType>(
                                contentPadding:
                                    const EdgeInsets.only(right: 8.0),
                                dense: true,
                                title: CustomText(
                                    text: "Termination",
                                    color: EmployeeOffBoardingController.to
                                                .offBoardingType.value.name ==
                                            'Termination'
                                        ? AppColors.darkBlue
                                        : AppColors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                                value: OffBoardingType.Termination,
                                groupValue: EmployeeOffBoardingController
                                    .to.offBoardingType.value,
                                onChanged: (value) {
                                  EmployeeOffBoardingController
                                      .to.offBoardingType.value = value!;
                                }),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                if (EmployeeOffBoardingController
                        .to.offBoardingType.value.name ==
                    'Resignation')
                  buildResignationType(),
                SizedBox(
                  height: 16,
                ),
                if (EmployeeOffBoardingController
                        .to.offBoardingType.value.name ==
                    'Termination')
                  buildTerminationType(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildResignationType() {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
                text: "resigning_employee",
                color: AppColors.black,
                fontSize: 12,
                fontWeight: FontWeight.w500),
            SizedBox(
              height: 8,
            ),
            // EmployeeController.to.isLoading
            //     ? Skeleton(
            //         height: 30,
            //         width: Get.width,
            //       )
            //     : MainSearchableDropDown(
            //         isRequired: true,
            //         error: "Required Employee Name",
            //         title: 'first_name',
            //         title1: 'last_name',
            //         hint: "Select Employee",
            //         items: EmployeeController
            //                 .to.employeeListModel?.data?.data?.data
            //                 ?.map((datum) => datum.toJson())
            //                 .toList() ??
            //             [],
            //         controller:
            //             EmployeeOffBoardingController.to.resigningEmployee,
            //         onChanged: (data) {
            //           EmployeeOffBoardingController.to.userId.text =
            //               data['id'].toString();
            //         }),
            CommonTextFormField(
              controller: EmployeeOffBoardingController.to.resigningEmployee,
              isBlackColors: true,
              keyboardType: TextInputType.name,
              readOnly: true,
              validator: (String? data) {
                if (data!.isEmpty) {
                  return "Required Name";
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 15,
            ),
            CustomText(
                text: "notice_date",
                color: AppColors.black,
                fontSize: 12,
                fontWeight: FontWeight.w500),
            SizedBox(
              height: 8,
            ),
            DatePicker(
              controller: EmployeeOffBoardingController.to.noticeDate,
              hintText: 'Select Date',
              dateFormat: 'yyyy-MM-dd',
              validator: (String? data) {
                if (data!.isEmpty) {
                  return "Required Purchase Date";
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 15,
            ),
            CustomText(
                text: "resignation_date",
                color: AppColors.black,
                fontSize: 12,
                fontWeight: FontWeight.w500),
            SizedBox(
              height: 8,
            ),
            DatePicker(
              controller: EmployeeOffBoardingController.to.resignationDate,
              hintText: 'Select Date',
              dateFormat: 'yyyy-MM-dd',
              validator: (String? data) {
                if (data!.isEmpty) {
                  return "Required Purchase Date";
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 15,
            ),
            CustomText(
                text: "resignation_reason",
                color: AppColors.black,
                fontSize: 12,
                fontWeight: FontWeight.w500),
            SizedBox(
              height: 8,
            ),
            CommonTextFormField(
              controller: EmployeeOffBoardingController.to.resignationReason,
              isBlackColors: true,
              maxlines: 3,
              keyboardType: TextInputType.name,
              validator: (String? data) {
                if (data!.isEmpty) {
                  return "Required Reason";
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  child: CommonButton(
                      text: "save_next",
                      textColor: AppColors.white,
                      fontSize: 12,
                      buttonLoader: CommonController.to.buttonLoader,
                      fontWeight: FontWeight.w500,
                      // textAlign: TextAlign.center,
                      onPressed: () async {
                        if (formKey.currentState?.validate() == true) {
                          CommonController.to.buttonLoader = true;
                          await EmployeeOffBoardingController.to
                              .resignationOffBoarding(userId.toString());
                          Get.to(()=>OffBoardingScreen());
                          CommonController.to.buttonLoader = false;
                        }
                      }),
                ),
              ],
            ),
            SizedBox(height: 20),
            BackToScreen(
              text: "cancel",
              arrowIcon: false,
              onPressed: () {
                Get.back();
              },
            ),
            SizedBox(height: 20),
            BackToScreen(
              text: "Skip",
              filled: true,
              arrowIcon: false,
              onPressed: () {
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }

  buildTerminationType() {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // CustomText(
            //     text: "termination_employee",
            //     color: AppColors.black,
            //     fontSize: 12,
            //     fontWeight: FontWeight.w500),
            // SizedBox(
            //   height: 8,
            // ),
            // EmployeeController.to.isLoading
            //     ? Skeleton(
            //         height: 30,
            //         width: Get.width,
            //       )
            //     : MainSearchableDropDown(
            //         isRequired: true,
            //         error: "Required Employee Name",
            //         title: 'first_name',
            //         title1: 'last_name',
            //         hint: "Select Employee",
            //         items: EmployeeController
            //                 .to.employeeListModel?.data?.data?.data
            //                 ?.map((datum) => datum.toJson())
            //                 .toList() ??
            //             [],
            //         controller:
            //             EmployeeOffBoardingController.to.terminatedEmployee,
            //         onChanged: (data) {
            //           EmployeeOffBoardingController.to.userId.text = data['id'].toString();
            //         }),
            // SizedBox(
            //   height: 15,
            // ),
            CustomText(
                text: "termination_type",
                color: AppColors.black,
                fontSize: 12,
                fontWeight: FontWeight.w500),
            SizedBox(
              height: 8,
            ),
            MainSearchableDropDown(
                isRequired: true,
                error: "Required Termination Type",
                title: 'type',
                hint: "Select Type",
                items: [
                  {'type': 'Mis Conduct'},
                  {'type': 'Low Performance'},
                  {'type': 'Worst Performance'},
                  {'type': 'Bad Behaviour'}
                ],
                controller: EmployeeOffBoardingController.to.terminationType,
                onChanged: (data) {
                  if (data == "Mis Conduct") {
                    EmployeeOffBoardingController.to.terminationTypeId.text =
                        "1";
                  } else if (data == "Low Performance") {
                    EmployeeOffBoardingController.to.terminationTypeId.text =
                        "2";
                  } else if (data == "Worst Performance") {
                    EmployeeOffBoardingController.to.terminationTypeId.text =
                        "3";
                  } else {
                    EmployeeOffBoardingController.to.terminationTypeId.text =
                        "4";
                  }
                }),
            SizedBox(
              height: 15,
            ),
            CustomText(
                text: "termination_date",
                color: AppColors.black,
                fontSize: 12,
                fontWeight: FontWeight.w500),
            SizedBox(
              height: 8,
            ),
            DatePicker(
              controller: EmployeeOffBoardingController.to.terminationDate,
              hintText: 'Select Date',
              dateFormat: 'yyyy-MM-dd',
              validator: (String? data) {
                if (data!.isEmpty) {
                  return "Required Notice Date";
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 15,
            ),
            CustomText(
                text: "last_date",
                color: AppColors.black,
                fontSize: 12,
                fontWeight: FontWeight.w500),
            SizedBox(
              height: 8,
            ),
            DatePicker(
              controller: EmployeeOffBoardingController.to.lastDate,
              hintText: 'Select Date',
              dateFormat: 'yyyy-MM-dd',
              validator: (String? data) {
                if (data!.isEmpty) {
                  return "Required Last Date";
                } else {
                  return null;
                }
              },
            ),
            SizedBox(height: 15,),
            CustomText(
                text: "terminated_reason",
                color: AppColors.black,
                fontSize: 12,
                fontWeight: FontWeight.w500),
            SizedBox(
              height: 8,
            ),
            CommonTextFormField(
              controller: EmployeeOffBoardingController.to.terminationReason,
              isBlackColors: true,
              maxlines: 3,
              keyboardType: TextInputType.name,
              validator: (String? data) {
                if (data!.isEmpty) {
                  return "Required Reason";
                } else {
                  return null;
                }
              },
            ),
            SizedBox(height: 8,),
            Row(
              children: [
                Expanded(
                  child: CommonButton(
                    text: "save_next",
                    textColor: AppColors.white,
                    fontSize: 12,
                    buttonLoader: CommonController.to.buttonLoader,
                    fontWeight: FontWeight.w500,
                    // textAlign: TextAlign.center,
                    onPressed: () async {
                      if (formKey.currentState?.validate() == true) {
                        CommonController.to.buttonLoader = true;
                        await EmployeeOffBoardingController.to
                            .terminationOffBoarding(userId.toString());
                        CommonController.to.buttonLoader = false;
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            BackToScreen(
              text: "cancel",
              arrowIcon: false,
              onPressed: () {
                Get.back();
              },
            ),
            SizedBox(height: 20),
            BackToScreen(
              text: "Skip",
              filled: true,
              arrowIcon: false,
              onPressed: () {
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
