import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

import '../../../constants/colors.dart';
import '../../../controller/common_controller.dart';
import '../../../controller/department/add_department_controller.dart';
import '../../../controller/edit_employee_profile_controller.dart';
import '../../../controller/employee/dependancy_controller.dart';
import '../../../controller/employee/employee_controller.dart';
import '../../../controller/employee/personal_controller.dart';
import '../../../controller/employee_details_controller/profile_controller.dart';
import '../../../controller/shift_controller.dart';
import '../../../controller/signup_controller.dart';
import '../../../widgets/Custom_rich_text.dart';
import '../../../widgets/Custom_text.dart';
import '../../../widgets/back_to_screen.dart';
import '../../../widgets/common.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/common_searchable_dropdown/MainCommonSearchableDropDown.dart';
import '../../../widgets/common_textformfield.dart';
import '../../../widgets/common_timePicker.dart';

class EditPersonalInformation extends StatelessWidget {
  EditPersonalInformation({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((value) async {
      EditEmployeeProfileController.to.personalLoader = true;
      await PersonalController.to.getMasterList();
      await SignupController.to.getCountryList();
      await AddDepartmentController.to.getGradeList();
      await ShiftController.to.getShiftList();
      await EditEmployeeProfileController.to.setControllerPersonalInformation(
          ProfileController.to.profileModel?.data?.data);
    });
    return GestureDetector(
      onTap: () {
        EditEmployeeProfileController.to.personalLoader = false;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          // leading: Icon(Icons.arrow_back_ios_new_outlined,color: AppColors.black),
          title: Row(
            children: [
              navBackButton(),
              SizedBox(width: 8),
              CustomText(
                text: "edit_personal_information",
                color: AppColors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
        body: GestureDetector(
          child: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Obx(
                () => SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomRichText(
                          textAlign: TextAlign.left,
                          text: 'grade',
                          color: AppColors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          textSpan: '*',
                          textSpanColor: AppColors.red),
                      SizedBox(height: 10),
                      EditEmployeeProfileController.to.personalLoader
                          ? Skeleton(width: Get.width, height: 30)
                          : CommonTextFormField(
                              controller: EmployeeController.to.gradeController,
                              isBlackColors: true,
                              readOnly: true,
                              fillColor: AppColors.grey.withOpacity(0.2),
                              filled: true,
                              keyboardType: TextInputType.text,
                              validator: (String? data) {
                                if (data == "" || data == null) {
                                  return "grade_validation";
                                } else {
                                  return null;
                                }
                              },
                            ),
                      SizedBox(height: 10),
                      CustomRichText(
                          textAlign: TextAlign.left,
                          text: 'shift',
                          color: AppColors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          textSpan: '*',
                          textSpanColor: AppColors.red),
                      EditEmployeeProfileController.to.personalLoader
                          ? Skeleton(width: Get.width, height: 30)
                          : ShiftController.to.showShift
                              ? Skeleton(width: Get.width, height: 30)
                              : MainSearchableDropDown(
                                  title: 'shift_name',
                                  filled: true,
                                  fillColor: AppColors.white,
                                  isRequired: true,
                                  error: 'shift',
                                  items: ShiftController
                                      .to.shiftListModel?.data?.list
                                      ?.map((datum) => datum.toJson())
                                      .toList(),
                                  controller:
                                      EmployeeController.to.shiftController,
                                  onChanged: (data) {
                                    EmployeeController
                                        .to.shiftIdController.text = data['id'];
                                    EmployeeController.to.shiftTimeLoader =
                                        true;
                                    EmployeeController.to.shiftTimeController
                                        .text = data['max_hours'];
                                    EmployeeController.to.shiftTimeLoader =
                                        false;
                                  }),
                      SizedBox(height: 10),
                      CustomRichText(
                          textAlign: TextAlign.left,
                          text: 'shift_time',
                          color: AppColors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          textSpan: '*',
                          textSpanColor: AppColors.red),
                      SizedBox(height: 10),
                      EditEmployeeProfileController.to.personalLoader ||
                              EmployeeController.to.shiftTimeLoader
                          ? Skeleton(width: Get.width, height: 30)
                          : CommonTimePicker(
                              controller:
                                  EmployeeController.to.shiftTimeController,
                              readOnly: true,
                              focusedBorder:
                                  BorderSide(color: Colors.grey, width: 1.7),
                              disabledBorder:
                                  BorderSide(color: Colors.black, width: 1),
                              // hintText: "HH:MM",
                              // timeFormat: 'HH:mm:ss',
                              validator: (String? data) {
                                if (data == "" || data == null) {
                                  print("Empty data");
                                  return "shift_time_validation";
                                } else {
                                  return null;
                                }
                              },
                            ),
                      SizedBox(height: 10),
                      CustomRichText(
                          textAlign: TextAlign.left,
                          text: 'gender',
                          color: AppColors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          textSpan: '*',
                          textSpanColor: AppColors.red),
                      EditEmployeeProfileController.to.personalLoader
                          ? Skeleton(width: Get.width, height: 30)
                          : PersonalController.to.masterLoader == true
                              ? Skeleton(width: Get.width, height: 30)
                              : MainSearchableDropDown(
                                  title: 'gender',
                                  isRequired: true,
                                  error: 'gender',
                                  items: PersonalController
                                      .to.employeeMasterModel?.data?[0].gender
                                      ?.map((status) {
                                    return {"gender": status};
                                  }).toList(),
                                  controller:
                                      DependencyController.to.genderController,
                                  onChanged: (data) {}),
                      SizedBox(height: 10),
                      CustomRichText(
                          textAlign: TextAlign.left,
                          text: 'marital_status',
                          color: AppColors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          textSpan: '*',
                          textSpanColor: AppColors.red),
                      EditEmployeeProfileController.to.personalLoader
                          ? Skeleton(width: Get.width, height: 30)
                          : PersonalController.to.masterLoader == true
                              ? Skeleton(width: Get.width, height: 30)
                              : MainSearchableDropDown(
                                  title: 'status',
                                  isRequired: true,
                                  error: 'marital_status',
                                  items: PersonalController
                                      .to
                                      .employeeMasterModel
                                      ?.data?[0]
                                      .maritalStatus
                                      ?.map((status) {
                                    return {"status": status};
                                  }).toList(),
                                  controller: DependencyController
                                      .to.maritalStatusController,
                                  onChanged: (data) {}),
                      SizedBox(height: 10),
                      CustomRichText(
                          textAlign: TextAlign.left,
                          text: 'emp_type',
                          color: AppColors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          textSpan: '*',
                          textSpanColor: AppColors.red),
                      EditEmployeeProfileController.to.personalLoader
                          ? Skeleton(width: Get.width, height: 30)
                          : PersonalController.to.masterLoader
                              ? Skeleton(width: Get.width, height: 30)
                              : MainSearchableDropDown(
                                  title: 'type',
                                  filled: true,
                                  fillColor: AppColors.white,
                                  isRequired: true,
                                  error: 'emp_type',
                                  items: PersonalController
                                      .to
                                      .employeeMasterModel
                                      ?.data?[0]
                                      .employmentType
                                      ?.map((datum) => datum.toJson())
                                      .toList(),
                                  controller: EmployeeController
                                      .to.employeeTypeController,
                                  onChanged: (data) {
                                    EmployeeController
                                        .to
                                        .employeeTypeIdController
                                        .text = data['id'];
                                  }),
                      SizedBox(height: 10),
                      CustomRichText(
                          textAlign: TextAlign.left,
                          text: 'status',
                          color: AppColors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          textSpan: '*',
                          textSpanColor: AppColors.red),
                      EditEmployeeProfileController.to.personalLoader
                          ? Skeleton(width: Get.width, height: 30)
                          : MainSearchableDropDown(
                              title: 'type',
                              filled: true,
                              fillColor: AppColors.white,
                              isRequired: true,
                              error: 'status',
                              items: [
                                {"type": "Active", "id": "1"},
                                {"type": "InActive", "id": "0"}
                              ],
                              controller: EditEmployeeProfileController
                                  .to.statusController,
                              onChanged: (data) {
                                EditEmployeeProfileController
                                    .to.statusIdController.text = data['id'];
                              }),
                      SizedBox(height: 10),
                      CustomRichText(
                          textAlign: TextAlign.left,
                          text: 'blood',
                          color: AppColors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          textSpan: '*',
                          textSpanColor: AppColors.red),
                      EditEmployeeProfileController.to.personalLoader
                          ? Skeleton(width: Get.width, height: 30)
                          : PersonalController.to.masterLoader == true
                              ? Skeleton(width: Get.width, height: 30)
                              : MainSearchableDropDown(
                                  title: 'blood',
                                  isRequired: true,
                                  error: 'blood',
                                  items: PersonalController.to
                                      .employeeMasterModel?.data?[0].bloodGroup
                                      ?.map((status) {
                                    return {"blood": status};
                                  }).toList(),
                                  controller:
                                      DependencyController.to.bloodController,
                                  onChanged: (data) {}),
                      SizedBox(height: 10),
                      CustomRichText(
                          textAlign: TextAlign.left,
                          text: 'country',
                          color: AppColors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          textSpan: '*',
                          textSpanColor: AppColors.red),
                      EditEmployeeProfileController.to.personalLoader
                          ? Skeleton(width: Get.width, height: 30)
                          : SignupController.to.countryLoader
                              ? Skeleton(width: Get.width, height: 30)
                              : MainSearchableDropDown(
                                  title: 'name',
                                  isRequired: true,
                                  error: 'country',
                                  items: SignupController.to.countryModel?.data
                                      ?.map((datum) => datum.toJson())
                                      .toList(),
                                  controller: DependencyController
                                      .to.nationalityController,
                                  onChanged: (data) async {
                                    DependencyController
                                        .to
                                        .nationalityControllerId
                                        .text = data['id'].toString();
                                    await PersonalController.to.getStateList(
                                        DependencyController
                                            .to.nationalityControllerId.text);
                                  }),
                      SizedBox(height: 10),
                      CustomRichText(
                          textAlign: TextAlign.left,
                          text: 'state',
                          color: AppColors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          textSpan: '*',
                          textSpanColor: AppColors.red),
                      EditEmployeeProfileController.to.personalLoader
                          ? Skeleton(width: Get.width, height: 30)
                          : PersonalController.to.stateLoader
                              ? Skeleton(width: Get.width, height: 30)
                              : MainSearchableDropDown(
                                  title: 'name',
                                  isRequired: true,
                                  error: 'state',
                                  items: PersonalController.to.stateModel?.data
                                      ?.map((datum) => datum.toJson())
                                      .toList(),
                                  controller:
                                      DependencyController.to.stateController,
                                  onChanged: (data) async {
                                    DependencyController.to.stateControllerId
                                        .text = data['id'].toString();
                                    print(
                                        "State ${DependencyController.to.nationalityController.text}"
                                        "${DependencyController.to.stateController.text}"
                                        "${DependencyController.to.cityController.text}");
                                    await PersonalController.to.getCityList(
                                        DependencyController
                                            .to.stateControllerId.text);
                                  }),
                      SizedBox(height: 10),
                      CustomRichText(
                          textAlign: TextAlign.left,
                          text: 'city',
                          color: AppColors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          textSpan: '*',
                          textSpanColor: AppColors.red),
                      EditEmployeeProfileController.to.personalLoader
                          ? Skeleton(width: Get.width, height: 30)
                          : PersonalController.to.cityLoader
                              ? Skeleton(width: Get.width, height: 30)
                              : MainSearchableDropDown(
                                  title: 'name',
                                  isRequired: true,
                                  error: 'city',
                                  items: PersonalController.to.cityModel?.data
                                      ?.map((datum) => datum.toJson())
                                      .toList(),
                                  controller:
                                      DependencyController.to.cityController,
                                  onChanged: (data) {
                                    DependencyController.to.cityControllerId
                                        .text = data['id'].toString();
                                    print(
                                        "city ${DependencyController.to.nationalityController.text}"
                                        "${DependencyController.to.stateController.text}"
                                        "${DependencyController.to.cityController.text}");
                                  }),
                      SizedBox(height: 10),
                      CustomRichText(
                          textAlign: TextAlign.left,
                          text: 'personal_mail',
                          color: AppColors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          textSpan: '*',
                          textSpanColor: AppColors.red),
                      SizedBox(height: 10),
                      EditEmployeeProfileController.to.personalLoader
                          ? Skeleton(width: Get.width, height: 30)
                          : CommonTextFormField(
                              controller: DependencyController
                                  .to.personalEmailController,
                              isBlackColors: true,
                              keyboardType: TextInputType.emailAddress,
                              validator: (String? data) {
                                if (data == "" || data == null) {
                                  return "required_email";
                                } else if (!RegExp(
                                        r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                                    .hasMatch(data)) {
                                  return "required_email_format";
                                } else {
                                  return null;
                                }
                              },
                            ),
                      SizedBox(height: 10),
                      CustomRichText(
                          textAlign: TextAlign.left,
                          text: 'personal_phone_number',
                          color: AppColors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          textSpan: '*',
                          textSpanColor: AppColors.red),
                      SizedBox(height: 10),
                      EditEmployeeProfileController.to.personalLoader
                          ? Skeleton(width: Get.width, height: 30)
                          : CommonTextFormField(
                              controller:
                                  DependencyController.to.phoneNumberController,
                              isBlackColors: true,
                              filled: true,
                              fillColor: AppColors.white,
                              keyboardType: TextInputType.name,
                              validator: (String? data) {
                                if (data == "" || data == null) {
                                  return "phone_number_validator";
                                } else if (data.length != 10) {
                                  return "phone_no_validation";
                                } else {
                                  return null;
                                }
                              },
                            ),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            child: CommonButton(
                              text: "save_changes",
                              textColor: AppColors.white,
                              fontSize: 16,
                              buttonLoader: CommonController.to.buttonLoader,
                              fontWeight: FontWeight.w500,
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  CommonController.to.buttonLoader = true;
                                  await EditEmployeeProfileController.to
                                      .postPersonalInformation();
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
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
