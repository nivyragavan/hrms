import 'package:dreamhrms/constants/colors.dart';
import 'package:dreamhrms/controller/common_controller.dart';
import 'package:dreamhrms/controller/department/add_department_controller.dart';
import 'package:dreamhrms/controller/department/deparrtment_controller.dart';
import 'package:dreamhrms/controller/employee/employee_controller.dart';
import 'package:dreamhrms/controller/schedule_controller.dart';
import 'package:dreamhrms/controller/shift_controller.dart';
import 'package:dreamhrms/screen/schedule/multi_select_dropdown.dart';
import 'package:dreamhrms/services/utils.dart';
import 'package:dreamhrms/widgets/Custom_rich_text.dart';
import 'package:dreamhrms/widgets/Custom_text.dart';
import 'package:dreamhrms/widgets/common.dart';
import 'package:dreamhrms/widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:skeleton_animation/skeleton_animation.dart';
import '../../services/provision_check.dart';
import '../../widgets/back_to_screen.dart';
import '../../widgets/common_searchable_dropdown/MainCommonSearchableDropDown.dart';

class AddSchedule extends StatefulWidget {
  const AddSchedule({super.key});

  @override
  State<AddSchedule> createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {
  @override
  void initState() {
    // TODO: implement initState
     super.initState();
     DepartmentController.to.getDepartmentList();
     EmployeeController.to.getEmployeeList();

  }
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
                navBackButton(),
                SizedBox(width: 8),
                CustomText(
                  text: "new_schedule",
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
        child:  ProvisionsWithIgnorePointer(
          provision: "Shift& Schedule",
          type:"create",
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
            child: Obx(
              () => Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomRichText(
                        textAlign: TextAlign.left,
                        text: "shift_templates",
                        color: AppColors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        textSpan: ' *',
                        textSpanColor: AppColors.red),
                    SizedBox(
                      height: 8,
                    ),
                    ShiftController.to.showShift
                        ? Skeleton(
                            height: 30,
                            width: Get.width,
                          )
                        : MainSearchableDropDown(
                            isRequired: true,
                            error: "shift_name_validator",
                            title: 'shift_name',
                            hint: "select_templates",
                            items: ShiftController.to.shiftListModel?.data?.list
                                ?.map((datum) => datum.toJson())
                                .toList(),
                            controller: ScheduleController.to.templateCtrl,
                            onChanged: (data) {
                              print("test data response $data");
                              ScheduleController.to.templateIdCtrl =
                                  TextEditingController(
                                      text: data?['id'].toString());
                            }),
                    SizedBox(
                      height: 8,
                    ),
                    Flex(
                      direction: Axis.horizontal,
                      children: [
                        Container(
                          height: 50,
                          width: Get.width * 0.40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: AppColors.grey.withAlpha(40),
                            ),
                          ),
                          child: Obx(
                            () => RadioListTile<ScheduleType>(
                              contentPadding: EdgeInsets.zero,
                              dense: true,
                              title: CustomText(
                                  text: "employee",
                                  color: ScheduleController
                                          .to.isEmployeeRadioEnabled.value
                                      ? AppColors.darkBlue
                                      : AppColors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                              value: ScheduleType.Employee,
                              groupValue: ScheduleController.to.type.value,
                              onChanged: (ScheduleType? value) {
                                ScheduleController.to.type.value = value!;
                                ScheduleController.to.isDepRadioEnabled.value =
                                    false;
                                ScheduleController.to.isEmployeeRadioEnabled.value =
                                    true;
                                ScheduleController.to.selectedDepartmentItems
                                    .clear();
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Container(
                          height: 50,
                          width: Get.width * 0.40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: AppColors.grey.withAlpha(40),
                            ),
                          ),
                          child: Obx(
                            () => RadioListTile<ScheduleType>(
                              contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                              dense: true,
                              title: CustomText(
                                  text: "department",
                                  color:
                                      ScheduleController.to.isDepRadioEnabled.value
                                          ? AppColors.black
                                          : AppColors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                              value: ScheduleType.Department,
                              groupValue: ScheduleController.to.type.value,
                              onChanged: (ScheduleType? value) {
                                ScheduleController.to.type.value = value!;
                                ScheduleController.to.isEmployeeRadioEnabled.value =
                                    false;
                                ScheduleController.to.isDepRadioEnabled.value =
                                    true;
                                ScheduleController.to.selectedEmployeeItems.clear();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    CustomText(
                        text: "assign",
                        color: AppColors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                    SizedBox(height: 8),
                    ScheduleController.to.isDepRadioEnabled.value == true
                        ? MultiSelectDropDown(
                            title: "select_dept",
                            requiredField: true,
                            items: DepartmentController.to.departmentModel?.data
                                    ?.map((datum) => datum.departmentName ?? "")
                                    .toList() ??
                                [],
                            onChanged: (value) {
                              print("Selected Departments: $value");
                              ScheduleController.to.selectedDepartmentItems = value;
                            },
                            selectedItems:
                                ScheduleController.to.selectedDepartmentItems)
                        : EmployeeController.to.isLoading
                            ? Skeleton(
                                height: 30,
                                width: Get.width,
                              )
                            : MultiSelectDropDown(
                                title: "select_emp",
                                requiredField: true,
                                items: EmployeeController
                                        .to.employeeListModel?.data?.data?.data
                                        ?.map((datum) =>
                                            "${datum.firstName} ${datum.lastName}" ??
                                            "")
                                        .toList() ??
                                    [],
                                onChanged: (value) {
                                  ScheduleController.to.selectedEmployeeItems =
                                      value;
                                },
                                selectedItems:
                                    ScheduleController.to.selectedEmployeeItems),
                    SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity / 1.2,
                      child: CommonButton(
                        text: "Save",
                        textColor: AppColors.white,
                        fontSize: 16,
                        buttonLoader: CommonController.to.buttonLoader,
                        fontWeight: FontWeight.w500,
                        onPressed: () async {
                          if (formKey.currentState?.validate() == true) {
                            if (ScheduleController
                                .to.selectedEmployeeItems.isNotEmpty ||
                                ScheduleController
                                    .to.selectedDepartmentItems.isNotEmpty) {
                              if (ScheduleController.to
                                  .isEmployeeRadioEnabled ==
                                  true) {
                                final empIds = EmployeeController
                                    .to.employeeListModel?.data?.data?.data
                                    ?.where((element) =>
                                    ScheduleController
                                        .to.selectedEmployeeItems
                                        .contains(
                                        "${element.firstName} ${element
                                            .lastName}"))
                                    .toList();
                                CommonController.to.buttonLoader = true;
                                await ScheduleController.to.assignSchedule(
                                    id: empIds!.map((e) => e.id).toList(),
                                    type: "user");
                                CommonController.to.buttonLoader = false;
                                ScheduleController.to.getScheduleList();
                              } else
                              if (ScheduleController.to.isDepRadioEnabled ==
                                  true) {
                                final depIds = DepartmentController
                                    .to.departmentModel?.data
                                    ?.where((element) =>
                                    ScheduleController
                                        .to.selectedDepartmentItems
                                        .contains(element.departmentName))
                                    .toList();
                                final departmentIds = depIds!
                                    .map((e) => int.parse(e.departmentId ?? ""))
                                    .toList();
                                CommonController.to.buttonLoader = true;
                                await ScheduleController.to.assignSchedule(
                                    id: departmentIds, type: "department");
                                CommonController.to.buttonLoader = false;
                                ScheduleController.to.getScheduleList();
                              }
                            } else {
                              UtilService().showToast("error",
                                  message: "Please Choose Employee or Department");
                            }
                          }
                        }
                      ),
                    ),
                    SizedBox(height: 15),
                    BackToScreen(
                        text: "cancel",
                        arrowIcon: false,
                        onPressed: () {
                          Get.back();
                        })
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
