import 'package:dreamhrms/controller/employee/personal_controller.dart';
import 'package:dreamhrms/controller/shift_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:localization/localization.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

import '../../../constants/colors.dart';
import '../../../controller/common_controller.dart';
import '../../../controller/department/add_department_controller.dart';
import '../../../controller/department/deparrtment_controller.dart';
import '../../../controller/employee/employee_controller.dart';
import '../../../controller/employee_details_controller/profile_controller.dart';
import '../../../widgets/Custom_rich_text.dart';
import '../../../widgets/Custom_text.dart';
import '../../../widgets/back_to_screen.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/common_datePicker.dart';
import '../../../widgets/common_searchable_dropdown/MainCommonSearchableDropDown.dart';
import '../../../widgets/common_textformfield.dart';
import '../../../widgets/common_timePicker.dart';

class EmployeeScreen extends StatelessWidget {
  EmployeeScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    EmployeeController.to.personalLoader = true;
    Future.delayed(Duration(seconds: 2)).then((value) async {
      await EmployeeController.to.clearValues();
      EmployeeController.to.employeeIdController.text =
          GetStorage().read("emp_id") ?? "";
      await ShiftController.to.getShiftList();
      await PersonalController.to.getMasterList();
      await DepartmentController.to.getDepartmentList();
      await AddDepartmentController.to.getGradeList();
      await EmployeeController.to.getLineManagerList();
      await EmployeeController.to.getRoleList();
      if (EmployeeController.to.isEmployee == "Edit")
        await EmployeeController.to.setControllerEmployeeInformation(
            ProfileController.to.profileModel?.data?.data);
      EmployeeController.to.personalLoader = false;
    });
    return Scaffold(
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                      text: 'basic_information',
                      color: AppColors.blue,
                      fontSize: 13,
                      fontWeight: FontWeight.w400),
                  SizedBox(height: 20),
                  CustomRichText(
                      textAlign: TextAlign.left,
                      text: 'emp_id',
                      color: AppColors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      textSpan: '*',
                      textSpanColor: AppColors.red),
                  SizedBox(height: 10),
                  EmployeeController.to.personalLoader
                      ? Skeleton(width: Get.width, height: 35)
                      : CommonTextFormField(
                          controller:
                              EmployeeController.to.employeeIdController,
                          readOnly: true,
                          enable: false,
                          // filled: true,
                          // fillColor: AppColors.lightGrey,
                          keyboardType: TextInputType.name,
                          validator: (String? data) {
                            if (data == "" || data == null) {
                              return "required_emp_id";
                            } else {
                              return null;
                            }
                          },
                        ),
                  SizedBox(height: 15),
                  CustomRichText(
                      textAlign: TextAlign.left,
                      text: 'effective_date',
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      textSpan: '*',
                      textSpanColor: AppColors.red),
                  SizedBox(height: 10),
                  EmployeeController.to.personalLoader
                      ? Skeleton(width: Get.width, height: 35)
                      : DatePicker(
                          controller:
                              EmployeeController.to.effectiveDateController,
                          focusedBorder:
                              BorderSide(color: Colors.grey, width: 1.7),
                          disabledBorder:
                              BorderSide(color: Colors.black, width: 1),
                          hintText: "YYYY-MM-DD",
                          dateFormat: 'yyyy-MM-dd',
                          showPicker: false,
                          displayCurrentDate: true,
                          validator: (String? data) {
                            if (data == "" || data == null) {
                              return "effective_date_validation";
                            } else {
                              return null;
                            }
                          },
                        ),
                  SizedBox(height: 15),
                  CustomRichText(
                      textAlign: TextAlign.left,
                      text: 'emp_type',
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      textSpan: '*',
                      textSpanColor: AppColors.red),
                  EmployeeController.to.personalLoader ||
                          PersonalController.to.masterLoader
                      ? Skeleton(width: Get.width, height: 35)
                      : MainSearchableDropDown(
                          title: 'type',
                          // title: 'id',
                          // filled: true,
                          // fillColor: AppColors.white,
                          isRequired: true,
                          error: 'emp_type',
                          items: PersonalController
                              .to.employeeMasterModel?.data?[0].employmentType
                              ?.map((datum) => datum.toJson())
                              .toList(),
                          controller:
                              EmployeeController.to.employeeTypeController,
                          onChanged: (data) {
                            EmployeeController
                                .to.employeeTypeIdController.text = data['id'];
                            print(
                                "employeeTypeController ${EmployeeController.to.employeeTypeIdController.text}");
                          }),
                  SizedBox(height: 10),
                  CustomRichText(
                      textAlign: TextAlign.left,
                      text: 'shift',
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      textSpan: '*',
                      textSpanColor: AppColors.red),
                  EmployeeController.to.personalLoader ||
                          ShiftController.to.showShift
                      ? Skeleton(width: Get.width, height: 30)
                      : MainSearchableDropDown(
                          title: 'shift_name',
                          // title: 'id',
                          // filled: true,
                          // fillColor: AppColors.white,
                          isRequired: true,
                          error:'shift',
                          items: ShiftController.to.shiftListModel?.data?.list
                              ?.map((datum) => datum.toJson())
                              .toList(),
                          controller: EmployeeController.to.shiftController,
                          onChanged: (data) {
                            EmployeeController.to.shiftLoader=true;
                            print("shift list $data");
                            EmployeeController.to.shiftIdController.text =
                                data['id'];
                            EmployeeController.to.shiftTimeController.text = data['max_hours'];
                            EmployeeController.to.shiftTimeController.text = CommonController.to.timeConversion(EmployeeController.to.shiftTimeController.text, GetStorage().read("global_time").toString());
                            EmployeeController.to.shiftLoader=false;
                          }),
                  SizedBox(height: 15),
                  CustomRichText(
                      textAlign: TextAlign.left,
                      text: 'shift_time',
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      textSpan: '*',
                      textSpanColor: AppColors.red),
                  SizedBox(height: 10),
                  EmployeeController.to.shiftLoader|| EmployeeController.to.personalLoader
                      ? Skeleton(width: Get.width, height: 35)
                      : CommonTimePicker(
                          controller: EmployeeController.to.shiftTimeController,
                          focusedBorder:
                              BorderSide(color: Colors.grey, width: 1.7),
                          disabledBorder:
                              BorderSide(color: Colors.black, width: 1),
                          // hintText: "HH:MM",
                          timeFormat: 'HH:mm:ss',
                          readOnly: true,
                          validator: (String? data) {
                            if (data == "" || data == null) {
                              return "shift_time_validation";
                            } else {
                              return null;
                            }
                          },
                        ),
                  SizedBox(height: 15),
                  CustomRichText(
                      textAlign: TextAlign.left,
                      text: 'probation_period',
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      textSpan: '*',
                      textSpanColor: AppColors.red),
                  EmployeeController.to.personalLoader
                      ? Skeleton(width: Get.width, height: 35)
                      : MainSearchableDropDown(
                          title: 'probation',
                          // filled: true,
                          // fillColor: AppColors.white,
                          isRequired: true,
                          error:'probation_period',
                          items: {
                            "1 Month",
                            "2 Month",
                            "3 Month",
                          }.map((probation) {
                            return {"probation": probation};
                          }).toList(),
                          controller:
                              EmployeeController.to.probationPeriodController,
                          onChanged: (data) {}),
                  SizedBox(height: 15),
                  CustomRichText(
                      textAlign: TextAlign.left,
                      text: 'start_probation_period',
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      textSpan: '*',
                      textSpanColor: AppColors.red),
                  SizedBox(height: 10),
                  EmployeeController.to.personalLoader
                      ? Skeleton(width: Get.width, height: 35)
                      : DatePicker(
                          controller: EmployeeController
                              .to.probationStartDateController,
                          focusedBorder:
                              BorderSide(color: Colors.grey, width: 1.7),
                          disabledBorder:
                              BorderSide(color: Colors.black, width: 1),
                          hintText: "YYYY-MM-DD",
                          dateFormat: 'yyyy-MM-dd',
                          validator: (String? data) {
                            if (data == "" || data == null) {
                              return "start_probation_period_validation";
                            } else {
                              return null;
                            }
                          },
                        ),
                  SizedBox(height: 15),
                  CustomRichText(
                      textAlign: TextAlign.left,
                      text: 'end_probation_period',
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      textSpan: '*',
                      textSpanColor: AppColors.red),
                  SizedBox(height: 10),
                  EmployeeController.to.personalLoader
                      ? Skeleton(width: Get.width, height: 35)
                      : DatePicker(
                          controller:
                              EmployeeController.to.probationEndDateController,
                          focusedBorder:
                              BorderSide(color: Colors.grey, width: 1.7),
                          disabledBorder:
                              BorderSide(color: Colors.black, width: 1),
                          hintText: "YYYY-MM-DD",
                          dateFormat: 'yyyy-MM-dd',
                          validator: (String? data) {
                            if (data == "" || data == null) {
                              return "end_probation_period_validation";
                            } else {
                              return null;
                            }
                          },
                        ),
                  SizedBox(height: 15),
                  CustomText(
                      text: 'job_information',
                      color: AppColors.blue,
                      fontSize: 13,
                      fontWeight: FontWeight.w400),
                  SizedBox(height: 20),
                  CustomRichText(
                      textAlign: TextAlign.left,
                      text: 'department',
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      textSpan: '*',
                      textSpanColor: AppColors.red),
                  EmployeeController.to.personalLoader ||
                          DepartmentController.to.showDepartmentList
                      ? Skeleton(width: Get.width, height: 30)
                      : MainSearchableDropDown(
                          title: 'department_name',
                          filled: true,
                          fillColor: AppColors.white,
                          isRequired: true,
                          error: 'department',
                          items: DepartmentController.to.departmentModel?.data
                              ?.map((datum) => datum.toJson())
                              .toList(),
                          controller:
                              EmployeeController.to.departmentController,
                          onChanged: (data) async {
                            EmployeeController.to.departmentIDController.text =
                                data['department_id'].toString();
                            await DepartmentController.to.storePositionModel(
                                EmployeeController
                                    .to.departmentIDController.text);
                          }),
                  SizedBox(height: 15),
                  CustomRichText(
                      textAlign: TextAlign.left,
                      text: 'position_type',
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      textSpan: '*',
                      textSpanColor: AppColors.red),
                  EmployeeController.to.personalLoader ||
                          AddDepartmentController.to.positionLoader
                      ? Skeleton(width: Get.width, height: 30)
                      : MainSearchableDropDown(
                          title: 'position_name',
                          // title: 'id',
                          // filled: true,
                          // fillColor: AppColors.white,
                          isRequired: true,
                          error: 'position_type',
                          items: DepartmentController
                                  .to.positionModel?.data?[0].positions
                                  ?.map((datum) => datum.toJson())
                                  .toList() ??
                              [],
                          controller:
                              EmployeeController.to.positionTypeController,
                          onChanged: (data) {
                            EmployeeController.to.positionIdController.text =
                                data['id'];
                          }),
                  SizedBox(height: 15),
                  CustomRichText(
                      textAlign: TextAlign.left,
                      text: 'line_manager',
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      textSpan: '*',
                      textSpanColor: AppColors.red),
                  EmployeeController.to.personalLoader ||
                          EmployeeController.to.lineMangerLoader
                      ? Skeleton(width: Get.width, height: 30)
                      : MainSearchableDropDown(
                          title: 'first_name',
                          title1: 'last_name',
                          // filled: true,
                          // fillColor: AppColors.white,
                          isRequired: true,
                          error: 'line_manager',
                          items: EmployeeController.to.lineManagerModel?.data
                              ?.map((dataum) => dataum.toJson())
                              .toList(),
                          controller:
                              EmployeeController.to.lineManagerController,
                          onChanged: (data) {
                            EmployeeController.to.lineManagerIdController.text =
                                data['id'].toString();
                          }),
                  SizedBox(height: 15),
                  CustomRichText(
                      textAlign: TextAlign.left,
                      text: 'grade',
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      textSpan: '*',
                      textSpanColor: AppColors.red),
                  EmployeeController.to.personalLoader
                      ? Skeleton(width: Get.width, height: 35)
                      : MainSearchableDropDown(
                          title: 'grade_name',
                          // filled: true,
                          // fillColor: AppColors.white,
                          isRequired: true,
                          error: 'grade',
                          items: AddDepartmentController.to.gradeModel?.data
                              ?.map((datum) => datum.toJson())
                              .toList(),
                          controller: EmployeeController.to.gradeController,
                          onChanged: (data) {
                            EmployeeController.to.gradeIdController.text =
                                data['id'].toString();
                            print(
                                "gradeController ${EmployeeController.to.gradeIdController.text}data$data");
                          }),
                  SizedBox(height: 15),
                  CustomRichText(
                      textAlign: TextAlign.left,
                      text: 'role',
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      textSpan: '*',
                      textSpanColor: AppColors.red),
                  EmployeeController.to.personalLoader ||
                          EmployeeController.to.lineMangerLoader
                      ? Skeleton(width: Get.width, height: 30)
                      : MainSearchableDropDown(
                          title: 'name',
                          // filled: true,
                          // fillColor: AppColors.white,
                          isRequired: true,
                          error:  'role',
                          items: EmployeeController.to.roleModel?.data?.data
                              ?.map((dataum) => dataum.toJson())
                              .toList(),
                          controller: EmployeeController.to.roleController,
                          onChanged: (data) {
                            EmployeeController.to.roleIdController.text =
                                data['id'].toString();
                            print(
                                "role ${EmployeeController.to.roleIdController.text}");
                          }),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: CommonButton(
                          text: "save_next",
                          textColor: AppColors.white,
                          buttonLoader: CommonController.to.buttonLoader,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          onPressed: ()async {
                            if (formKey.currentState!.validate()) {
                              CommonController.to.buttonLoader = true;
                              EmployeeController.to.isEmployee == "Edit"
                                  ? await EmployeeController.to.editEmployeeInfo()
                                  : await EmployeeController.to.postEmployeeDetails();
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
