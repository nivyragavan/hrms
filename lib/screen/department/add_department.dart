import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:dreamhrms/controller/department/add_department_controller.dart';
import 'package:dreamhrms/controller/department/deparrtment_controller.dart';
import 'package:dreamhrms/screen/employee/employee_details/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localization/localization.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

import '../../constants/colors.dart';
import '../../controller/common_controller.dart';
import '../../services/provision_check.dart';
import '../../widgets/Custom_rich_text.dart';
import '../../widgets/Custom_text.dart';
import '../../widgets/back_to_screen.dart';
import '../../widgets/common.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_searchable_dropdown/MainCommonSearchableDropDown.dart';
import '../../widgets/common_textformfield.dart';
import '../../widgets/common_widget_icon_button.dart';

class AddDepartment extends StatelessWidget {
  final String option;
  const AddDepartment({Key? key, required this.option}) : super(key: key);
  static final formKeyValidation = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((value) async {
      print('option$option');
      await AddDepartmentController.to.getGradeList();
      AddDepartmentController.to.department = "edit";
      AddDepartmentController.to.position = "edit";
    });
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            navBackButton(),
            SizedBox(width: 8),
            CustomText(
              text: option == "Add" ? "add_dept" : "edit_dept",
              color: AppColors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: ProvisionsWithIgnorePointer(
          provision: 'Department',
          type: "create",
          child: SingleChildScrollView(
            child: Obx(() => AddDepartmentController.to.loader == true
                ? commonLoader(
                    loader: AddDepartmentController.to.loader, length: 5)
                : option == "SubEdit"
                    ? editSubDepartment(context)
                    : addDepartment(context)),
          ),
        ),
      ),
    );
  }

  addDepartment(BuildContext context) {
    return Form(
      key: formKeyValidation,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomRichText(
                  textAlign: TextAlign.left,
                  text: "department_name",
                  color: AppColors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  textSpan: ' *',
                  textSpanColor: AppColors.red),
              CommonIconButton(
                icon: Icon(Icons.add, color: AppColors.white),
                width: 36,
                height: 36,
                onPressed: () {
                  showAddDepartmentDialog(context);
                },
              ),
            ],
          ),
          SizedBox(height: 10),
          AddDepartmentController.to.departmentLoader == true
              ? Skeleton(
                  height: 30,
                  width: Get.width,
                )
              : option == "HeaderEdit"
                  ? CommonTextFormField(
                      controller: AddDepartmentController.to.deptNameController,
                      isBlackColors: true,
                      keyboardType: TextInputType.name,
                      validator: (String? data) {
                        if (data == "" || data == null) {
                          return "department_name";
                        } else {
                          return null;
                        }
                      },
                    )
                  : MainSearchableDropDown(
                      title: 'department_name',
                      error: "department_name",
                      initialValue:
                          AddDepartmentController.to.deptNameController.text,
                      items: DepartmentController.to.departmentModel?.data
                          ?.map((datum) => datum.toJson())
                          .toList(),
                      controller: AddDepartmentController.to.deptNameController,
                      isRequired: true,
                      onChanged: (data) async {
                        departmentNameOnChanged(data);
                      },
                    ),
          if (AddDepartmentController.to.addDepartment == true)
            positionGrade(context),
          SizedBox(height: 20),
          AddDepartmentController.to.descRequired
              ? CustomRichText(
                  textAlign: TextAlign.left,
                  text: "description",
                  color: AppColors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  textSpan: " *",
                  textSpanColor: AppColors.red,
                )
              : CustomRichText(
                  textAlign: TextAlign.left,
                  text: "description",
                  color: AppColors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
          SizedBox(height: 10),
          CommonTextFormField(
            controller: AddDepartmentController.to.descriptionController,
            isBlackColors: true,
            maxlines: 3,
            keyboardType: TextInputType.name,
            validator: (String? data) {
              if (data == "" || data == null) {
                return "description_validate";
              } else {
                return null;
              }
            },
          ),
          SizedBox(height: 20),
          CustomRichText(
            textAlign: TextAlign.left,
            text: "dept_icon",
            color: AppColors.black,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            textSpan: " *",
            textSpanColor: AppColors.red,
          ),
          SizedBox(height: 10),
          CommonController.to.imageLoader == true
              ? Skeleton()
              : AddDepartmentController.to.departmentImage.text != ""
                  ? InkWell(
                      onTap: () async {
                        _onImageSelectedFromGallery(
                            AddDepartmentController.to.departmentImage);
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.grey.withAlpha(40),
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: AddDepartmentController.to.imageFormat ==
                                    "Network" ||
                                AddDepartmentController.to.isNetworkImage(
                                    AddDepartmentController
                                        .to.departmentImage.text)
                            ? Image.network(
                                AddDepartmentController.to.departmentImage.text)
                            : Image.file(File(AddDepartmentController
                                .to.departmentImage.text
                                .toString())),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DottedBorder(
                          color: Colors.grey.withOpacity(0.5),
                          strokeWidth: 2,
                          dashPattern: [10, 6],
                          child: InkWell(
                            onTap: () {
                              AddDepartmentController.to.imageFormat = "";
                              _onImageSelectedFromGallery(
                                  AddDepartmentController.to.departmentImage);
                            },
                            child: Container(
                              height: 80,
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomRichText(
                                      textAlign: TextAlign.center,
                                      text: "drop_your_files_here_or",
                                      color: AppColors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      textSpan: 'browser',
                                      textSpanColor: AppColors.blue),
                                  SizedBox(height: 10),
                                  CustomText(
                                    text: "maximum_size",
                                    color: AppColors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        if (AddDepartmentController.to.departmentImage.text ==
                            "")
                          CustomText(
                              text: "department_icon_req",
                              color: AppColors.red,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                      ],
                    ),
          SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                child: CommonButton(
                  text: "save",
                  textColor: AppColors.white,
                  fontSize: 16,
                  buttonLoader: CommonController.to.buttonLoader,
                  fontWeight: FontWeight.w500,
                  // textAlign: TextAlign.center,
                  onPressed: () async {
                    if (formKeyValidation.currentState!.validate() &&
                        AddDepartmentController.to.departmentImage.text != "") {
                      print(
                          "body data ${option} ${AddDepartmentController.to.position} ${AddDepartmentController.to.department}");
                      CommonController.to.buttonLoader = true;
                      await AddDepartmentController.to
                          .postAddDepartment(value: option);
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
          )
        ],
      ),
    );
  }

  editSubDepartment(context) {
    return Form(
      key: formKeyValidation,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          positionGrade(context),
          Row(
            children: [
              Expanded(
                child: CommonButton(
                  text: "save",
                  textColor: AppColors.white,
                  fontSize: 16,
                  buttonLoader: CommonController.to.buttonLoader,
                  fontWeight: FontWeight.w500,
                  // textAlign: TextAlign.center,
                  onPressed: () async {
                    if (formKeyValidation.currentState!.validate() &&
                        AddDepartmentController.to.departmentImage.text != "") {
                      print(
                          "getBody data ${option} ${AddDepartmentController.to.position} ${AddDepartmentController.to.department}");
                      CommonController.to.buttonLoader = true;
                      await AddDepartmentController.to
                          .postAddDepartment(value: option);
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
          )
        ],
      ),
    );
  }

  showAddDepartmentDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return Dialog(
              alignment: Alignment.center,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              child: Container(
                  height: 250,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "add_dept_name",
                            color: AppColors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(height: 20),
                          CustomRichText(
                            textAlign: TextAlign.left,
                            text: "department_name",
                            color: AppColors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(height: 15),
                          CommonTextFormField(
                            controller:
                                AddDepartmentController.to.popupNameController,
                            isBlackColors: true,
                            keyboardType: TextInputType.name,
                            onChanged: (data) {},
                          ),
                          SizedBox(height: 30),
                          Align(
                            alignment: Alignment.centerRight,
                            child: CommonButton(
                              text: "save",
                              textColor: AppColors.white,
                              fontSize: 16,
                              buttonLoader: CommonController.to.buttonLoader,
                              fontWeight: FontWeight.w500,
                              // textAlign: TextAlign.center,
                              onPressed: () async {
                                AddDepartmentController.to.departmentLoader =
                                    true;
                                CommonController.to.buttonLoader = true;
                                Future.delayed(Duration(seconds: 1))
                                    .then((value) {
                                  if (AddDepartmentController
                                          .to.popupNameController.text.length >
                                      0)
                                    AddDepartmentController
                                            .to.deptNameController.text =
                                        AddDepartmentController
                                            .to.popupNameController.text;
                                  AddDepartmentController
                                      .to.popupNameController.text = "";
                                  AddDepartmentController
                                      .to.descriptionController.text = "";
                                  AddDepartmentController
                                      .to.departmentImage.text = "";
                                  AddDepartmentController.to.department = "add";
                                  AddDepartmentController.to.descRequired =
                                      true;
                                  AddDepartmentController.to.addDepartment =
                                      false;
                                  AddDepartmentController.to.departmentLoader =
                                      false;
                                  CommonController.to.buttonLoader = false;
                                  Get.back();
                                });
                              },
                            ),
                          ),
                        ],
                      ))),
            );
          });
        });
  }

  showAddPositionDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => Dialog(
              alignment: Alignment.center,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              child: Container(
                  height: 250,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "add_position",
                            color: AppColors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(height: 20),
                          CustomRichText(
                            textAlign: TextAlign.left,
                            text: "position",
                            color: AppColors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(height: 15),
                          CommonTextFormField(
                            controller:
                                AddDepartmentController.to.popupNameController,
                            isBlackColors: true,
                            keyboardType: TextInputType.name,
                          ),
                          SizedBox(height: 30),
                          Align(
                            alignment: Alignment.centerRight,
                            child: CommonButton(
                              text: "save",
                              textColor: AppColors.white,
                              fontSize: 16,
                              buttonLoader: CommonController.to.buttonLoader,
                              fontWeight: FontWeight.w500,
                              // textAlign: TextAlign.center,
                              onPressed: () {
                                AddDepartmentController.to.positionLoader =
                                    true;
                                CommonController.to.buttonLoader = false;
                                Future.delayed(Duration(seconds: 1))
                                    .then((value) {
                                  AddDepartmentController.to.position = "add";
                                  if(AddDepartmentController
                                      .to.popupNameController.text.length>0)AddDepartmentController
                                          .to.positionController.text =
                                      AddDepartmentController
                                          .to.popupNameController.text;
                                  AddDepartmentController
                                      .to.popupNameController.text = "";
                                  AddDepartmentController.to.positionLoader =
                                      false;
                                  CommonController.to.buttonLoader = false;
                                  Get.back();
                                });
                              },
                            ),
                          ),
                        ],
                      ))),
            ));
  }

  Widget positionGrade(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomRichText(
                textAlign: TextAlign.left,
                text: "position",
                color: AppColors.black,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                textSpan: '(Leave this empty for Department)',
                textSpanColor: AppColors.grey),
            CommonIconButton(
              icon: Icon(Icons.add, color: AppColors.white),
              width: 36,
              height: 36,
              onPressed: () {
                showAddPositionDialog(context);
              },
            ),
          ],
        ),
        SizedBox(height: 10),
        AddDepartmentController.to.positionLoader == true
            ? SizedBox(
                width: 20,
                height: 20,
                child: Skeleton(height: 30, width: Get.width))
            : option == "SubEdit"
                ? CommonTextFormField(
                    controller: AddDepartmentController.to.positionController,
                    isBlackColors: true,
                    keyboardType: TextInputType.name,
                    validator: (String? data) {
                      if (data == "" || data == null) {
                        return "position";
                      } else {
                        return null;
                      }
                    },
                  )
                : MainSearchableDropDown(
                    title: 'position_name',
                    isRequired: true,
                    error: "position",
                    items: DepartmentController
                            .to.positionModel?.data?[0].positions
                            ?.map((datum) => datum.toJson())
                            .toList() ??
                        [],
                    controller: AddDepartmentController.to.positionController,
                    onChanged: (data) async {
                      AddDepartmentController.to.positionController.text =
                          data['position_name'].toString();
                      AddDepartmentController.to.positionIdController.text =
                          data['id'].toString();
                      AddDepartmentController.to.gradeIdController.text =
                          data['id'].toString();
                      AddDepartmentController.to.gradeLoader = true;
                      await AddDepartmentController.to.getGradeName(
                          AddDepartmentController.to.gradeIdController.text);
                      AddDepartmentController.to.position = "edit";
                    },
                  ),
        SizedBox(height: 20),
        CustomRichText(
          textAlign: TextAlign.left,
          text: "grade",
          color: AppColors.black,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        SizedBox(height: 10),
        AddDepartmentController.to.gradeLoader
            ? Skeleton(height: 30, width: Get.width)
            : MainSearchableDropDown(
                title: 'grade_name',
                isRequired: true,
                error: "grade",
                items: AddDepartmentController.to.gradeModel?.data
                    ?.map((datum) => datum.toJson())
                    .toList(),
                // initialValue:  AddDepartmentController.to.gradeController.text,
                controller: AddDepartmentController.to.gradeController,
                onChanged: (data) {
                  AddDepartmentController.to.gradeController.text =
                      data['grade_name'].toString();
                  AddDepartmentController.to.gradeIdController.text =
                      data['id'].toString();
                },
              ),
      ],
    );
  }

  void _onImageSelectedFromGallery(controller) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      CommonController.to.imageLoader = true;
      controller.text = pickedFile.path ?? "";
      AddDepartmentController.to.imageFormat = "";
      CommonController.to.imageLoader = false;
    }
  }

  departmentNameOnChanged(data) async {
    AddDepartmentController.to.deptIdController.text =
        data['department_id'].toString();
    AddDepartmentController.to.deptNameController.text =
        data['department_name'].toString();
    AddDepartmentController.to.descriptionController.text = data['description'];
    AddDepartmentController.to.departmentImage.text = data['department_icon'];
    AddDepartmentController.to.imageFormat = "Network";
    AddDepartmentController.to.department = "edit";
    AddDepartmentController.to.addDepartment = true;
    AddDepartmentController.to.descRequired = true;
    await DepartmentController.to
        .storePositionModel(AddDepartmentController.to.deptIdController.text);
  }
}
