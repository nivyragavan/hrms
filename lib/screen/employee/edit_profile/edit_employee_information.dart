import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localization/localization.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

import '../../../constants/colors.dart';
import '../../../controller/common_controller.dart';
import '../../../controller/department/add_department_controller.dart';
import '../../../controller/department/deparrtment_controller.dart';
import '../../../controller/edit_employee_profile_controller.dart';
import '../../../controller/employee/dependancy_controller.dart';
import '../../../controller/employee/employee_controller.dart';
import '../../../controller/employee/personal_controller.dart';
import '../../../controller/employee_details_controller/profile_controller.dart';
import '../../../widgets/Custom_rich_text.dart';
import '../../../widgets/Custom_text.dart';
import '../../../widgets/back_to_screen.dart';
import '../../../widgets/common.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/common_datePicker.dart';
import '../../../widgets/common_searchable_dropdown/MainCommonSearchableDropDown.dart';
import '../../../widgets/common_textformfield.dart';
import '../../../widgets/image_picker.dart';

class EditEmployeeInformation extends StatelessWidget {
  EditEmployeeInformation({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 1)).then((value) async {
      EditEmployeeProfileController.to.personalLoader = true;
      PersonalController.to.imageController.text = "";
      CommonController.to.imageBase64="";
      await DepartmentController.to.getDepartmentList();
      await EmployeeController.to.getLineManagerList();
      await EditEmployeeProfileController.to.setControllerEmployeeInformation(
          ProfileController.to.profileModel?.data?.data);
    });
    return Scaffold(
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
              text: "edit_employee_information",
              color: AppColors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Obx(() => SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonController.to.imageLoader &&
                            EditEmployeeProfileController.to.personalLoader
                        ? Skeleton(width: 70, height: 70)
                        : Row(
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.grey.withAlpha(40),
                                  ),
                                  borderRadius: BorderRadius.circular(14),
                                  // image: DecorationImage(
                                  //     fit: BoxFit.cover,
                                  //     image: NetworkImage(
                                  //         '${commonNetworkImageDisplay('${PersonalController.to.imageController.text.toString()}')}')),
                                ),
                                child: AddDepartmentController.to.isNetworkImage(
                                    PersonalController
                                        .to.imageController.text) &&
                                    PersonalController
                                        .to.imageController.text !=
                                        ""
                                    ? Image.network(
                                  '${commonNetworkImageDisplay('${PersonalController.to.imageController.text.toString()}')}',
                                  fit: BoxFit.cover,
                                  errorBuilder: (BuildContext?
                                  context,
                                      Object? exception,
                                      StackTrace? stackTrace) {
                                    return Image.asset(
                                      "assets/images/user.jpeg",
                                      fit: BoxFit.contain,
                                    );
                                  },
                                ):PersonalController
                                    .to.imageController.text !=
                                    ""
                                    ? Image.file(File(
                                    '${PersonalController.to.imageController.text.toString()}')):Image.asset(
                                  "assets/images/user.jpeg",
                                  fit: BoxFit.contain,
                                ),
                              ),
                                  // : Container(
                                  //     height: 70,
                                  //     width: 70,
                                  //     decoration: BoxDecoration(
                                  //       borderRadius: BorderRadius.circular(14),
                                  //     ),
                                  //     child: Image.file(File(
                                  //         '${PersonalController.to.imageController.text.toString()}')),
                                  //   ),
                              SizedBox(
                                width: 14,
                              ),
                              InkWell(
                                onTap: () {
                                  _onImageSelectedFromGallery(
                                    PersonalController.to.imageController,
                                  );
                                },
                                child: Container(
                                  width: Get.width * 0.50,
                                  height: 40,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: AppColors.lightGrey)),
                                  child: CustomText(
                                      text:'change_profile',
                                      color: AppColors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              )
                            ],
                          ),
                    SizedBox(height: 30),
                    CustomRichText(
                        textAlign: TextAlign.left,
                        text: 'first_name',
                        color: AppColors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        textSpan: '*',
                        textSpanColor: AppColors.red),
                    SizedBox(height: 10),
                    EditEmployeeProfileController.to.personalLoader
                        ? Skeleton(
                            width: Get.width,
                            height: 30,
                          )
                        : CommonTextFormField(
                            controller:
                                DependencyController.to.firstNameController,
                            isBlackColors: true,
                            keyboardType: TextInputType.name,
                            validator: (String? data) {
                              if (data == "" || data == null) {
                              return "first_name_validator";
                              } else {
                                return null;
                              }
                            },
                          ),
                    SizedBox(height: 20),
                    CustomRichText(
                        textAlign: TextAlign.left,
                        text: 'last_name',
                        color: AppColors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        textSpan: '*',
                        textSpanColor: AppColors.red),
                    SizedBox(height: 10),
                    EditEmployeeProfileController.to.personalLoader
                        ? Skeleton(
                            width: Get.width,
                            height: 30,
                          )
                        : CommonTextFormField(
                            controller:
                                DependencyController.to.lastNameController,
                            isBlackColors: true,
                            keyboardType: TextInputType.name,
                            validator: (String? data) {
                              if (data == "" || data == null) {
                                return "last_name_validator";
                              } else {
                                return null;
                              }
                            },
                          ),
                    SizedBox(height: 20),
                    CustomRichText(
                        textAlign: TextAlign.left,
                        text: 'emp_id',
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
                                EmployeeController.to.employeeIdController,
                            isBlackColors: true,
                            filled: true,
                            fillColor: AppColors.grey.withOpacity(0.2),
                            keyboardType: TextInputType.name,
                            validator: (String? data) {
                              if (data == "" || data == null) {
                                return  "required_emp_id";
                              } else {
                                return null;
                              }
                            },
                          ),
                    SizedBox(height: 20),
                    CustomRichText(
                        textAlign: TextAlign.left,
                        text: 'department',
                        color: AppColors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        textSpan: '*',
                        textSpanColor: AppColors.red),
                    EditEmployeeProfileController.to.personalLoader
                        ? Skeleton(width: Get.width, height: 30)
                        : DepartmentController.to.showDepartmentList
                            ? Skeleton(width: Get.width, height: 30)
                            : MainSearchableDropDown(
                                title: 'department_name',
                                filled: true,
                                fillColor: AppColors.white,
                                isRequired: true,
                                error:'department',
                                items: DepartmentController
                                    .to.departmentModel?.data
                                    ?.map((datum) => datum.toJson())
                                    .toList(),
                                controller:
                                    EmployeeController.to.departmentController,
                                onChanged: (data) async {
                                  EmployeeController.to.departmentIDController
                                      .text = data['department_id'].toString();
                                  await DepartmentController.to
                                      .storePositionModel(EmployeeController
                                          .to.departmentIDController.text);
                                }),
                    SizedBox(height: 10),
                    CustomRichText(
                        textAlign: TextAlign.left,
                       text: 'phone_number',
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
                                PersonalController.to.phoneNumberController,
                            isBlackColors: true,
                            filled: true,
                            fillColor: AppColors.white,
                            keyboardType: TextInputType.name,
                            validator: (String? data) {
                              if (data == "" || data == null) {
                                print("Empty data");
                                return "phone_number_validator";
                              } else {
                                return null;
                              }
                            },
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomRichText(
                        textAlign: TextAlign.left,
                       text: 'email',
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
                                PersonalController.to.emailAddressController,
                            isBlackColors: true,
                            filled: true,
                            fillColor: AppColors.white,
                            keyboardType: TextInputType.name,
                            validator: (String? data) {
                              if (data == "" || data == null) {
                                return "required_email";
                              } else {
                                return null;
                              }
                            },
                          ),
                    SizedBox(height: 20),
                    CustomRichText(
                        textAlign: TextAlign.left,
                        text: 'positions',
                        color: AppColors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        textSpan: '*',
                        textSpanColor: AppColors.red),
                    EditEmployeeProfileController.to.personalLoader
                        ? Skeleton(width: Get.width, height: 30)
                        : AddDepartmentController.to.positionLoader
                            ? Skeleton(width: Get.width, height: 30)
                            : MainSearchableDropDown(
                                title: 'position_name',
                                filled: true,
                                fillColor: AppColors.white,
                                isRequired: true,
                        error: 'position_type',
                                items: DepartmentController
                                        .to.positionModel?.data?[0].positions
                                        ?.map((datum) => datum.toJson())
                                        .toList() ??
                                    [],
                                controller: EmployeeController
                                    .to.positionTypeController,
                                onChanged: (data) {
                                  EmployeeController.to.positionIdController
                                      .text = data['id'];
                                }),
                    SizedBox(height: 10),
                    CustomRichText(
                        textAlign: TextAlign.left,
                        text: 'line_manager',
                        color: AppColors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        textSpan: '*',
                        textSpanColor: AppColors.red),
                    EditEmployeeProfileController.to.personalLoader
                        ? Skeleton(width: Get.width, height: 30)
                        : EmployeeController.to.lineMangerLoader
                            ? Skeleton(width: Get.width, height: 30)
                            : MainSearchableDropDown(
                                title: 'first_name',
                                title1: 'last_name',
                                filled: true,
                                fillColor: AppColors.white,
                                isRequired: true,
                                error: 'line_manager',
                                items: EmployeeController
                                    .to.lineManagerModel?.data
                                    ?.map((dataum) => dataum.toJson())
                                    .toList(),
                                controller:
                                    EmployeeController.to.lineManagerController,
                                onChanged: (data) {
                                  EmployeeController.to.lineManagerIdController
                                      .text = data['id'].toString();
                                }),
                    SizedBox(height: 10),
                    CustomRichText(
                        textAlign: TextAlign.left,
                        text: 'date_of_birth',
                        color: AppColors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        textSpan: '*',
                        textSpanColor: AppColors.red),
                    SizedBox(height: 10),
                    EditEmployeeProfileController.to.personalLoader
                        ? Skeleton(width: Get.width, height: 30)
                        : DatePicker(
                            controller: DependencyController.to.dob,
                            focusedBorder:
                                BorderSide(color: Colors.grey, width: 1.7),
                            disabledBorder:
                                BorderSide(color: Colors.black, width: 1),
                            hintText: "YYYY-MM-DD",
                            dateFormat: 'yyyy-MM-dd',
                            validator: (String? data) {
                              if (data == "" || data == null) {
                                return "required_date_of_birth";
                              } else {
                                return null;
                              }
                            },
                          ),
                    SizedBox(height: 20),
                    CustomRichText(
                        textAlign: TextAlign.left,
                        text: 'date_join',
                        color: AppColors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        textSpan: '*',
                        textSpanColor: AppColors.red),
                    SizedBox(height: 10),
                    EditEmployeeProfileController.to.personalLoader
                        ? Skeleton(width: Get.width, height: 30)
                        : DatePicker(
                            controller: EditEmployeeProfileController
                                .to.joinDateController,
                            focusedBorder:
                                BorderSide(color: Colors.grey, width: 1.7),
                            disabledBorder:
                                BorderSide(color: Colors.black, width: 1),
                            hintText: "YYYY-MM-DD",
                            dateFormat: 'yyyy-MM-dd',
                            validator: (String? data) {
                              if (data == "" || data == null) {
                                return "date_join_validation";
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
                            buttonLoader:CommonController.to.buttonLoader,
                            fontWeight: FontWeight.w500,
                            // textAlign: TextAlign.center,
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                CommonController.to.buttonLoader=true;
                                await EditEmployeeProfileController.to
                                    .postEmployeeInformation();
                                CommonController.to.buttonLoader=false;
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
              )),
        ),
      ),
    );
  }

  imagePicker(BuildContext context1,
      {required bool showGallery,
      required bool showCamera,
      required TextEditingController controller}) {
    showBottomSheet(
        context: context1,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return CustomImagePicker(
              controller: controller,
              showGallery: true,
              showCamera: false,
            );
          });
        });
  }

  void _onImageSelectedFromGallery(controller) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      CommonController.to.imageLoader = true;
      controller.text = pickedFile.path ?? "";
      CommonController.to.imageBase64=await convertImageToBase64(pickedFile);
      AddDepartmentController.to.imageFormat = "";
      CommonController.to.imageLoader = false;
    }
  }
}
