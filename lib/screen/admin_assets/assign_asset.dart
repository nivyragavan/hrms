import 'package:dreamhrms/constants/colors.dart';
import 'package:dreamhrms/controller/assets/assign_asset_controller.dart';
import 'package:dreamhrms/controller/department/deparrtment_controller.dart';
import 'package:dreamhrms/controller/employee/employee_controller.dart';
import 'package:dreamhrms/widgets/Custom_rich_text.dart';
import 'package:dreamhrms/widgets/Custom_text.dart';
import 'package:dreamhrms/widgets/back_to_screen.dart';
import 'package:dreamhrms/widgets/common_datePicker.dart';
import 'package:dreamhrms/widgets/common_textformfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

import '../../../controller/common_controller.dart';
import '../../../controller/department/add_department_controller.dart';
import '../../../widgets/common.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/common_searchable_dropdown/MainCommonSearchableDropDown.dart';
import '../../controller/assets/admin_asset_controller.dart';
import '../../controller/theme_controller.dart';
import '../../services/provision_check.dart';
import '../main_screen.dart';

class AssignAsset extends StatefulWidget {
  AssignAsset({super.key});

  @override
  State<AssignAsset> createState() => _AssignAssetState();
}

class _AssignAssetState extends State<AssignAsset> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero).then((value) async {
      await AdminAssetController.to.getAdminAssetList();
      await EmployeeController.to.getEmployeeList();
    });
    AssignAssetController.to.onClose();
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
                      color: ThemeController.to.checkThemeCondition() == true
                          ? AppColors.white
                          : AppColors.black),
                ),
                SizedBox(width: 8),
                CustomText(
                  text: "assign_assets",
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
        () =>ProvisionsWithIgnorePointer(
          provision:"Assets",type:"create",
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 18.0,
            ),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomRichText(
                        textAlign: TextAlign.left,
                        text: "asset_name",
                        color: AppColors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        textSpan: ' *',
                        textSpanColor: AppColors.red),
                    SizedBox(
                      height: 8,
                    ),
                    AdminAssetController.to.showAssetList
                        ? Skeleton(
                            height: 30,
                            width: Get.width,
                          )
                        : MainSearchableDropDown(
                            isRequired: true,
                            error: "required_asset_name",
                            title: 'name',
                            hint: "select_asset_name",
                            items: AdminAssetController
                                    .to.adminAssetsListModel?.data?.data
                                    ?.map((datum) => datum.toJson())
                                    .toList() ??
                                [],
                            controller: AssignAssetController.to.assetName,
                            onChanged: (data) {
                              AssignAssetController.to.assetID.text =
                                  data['asset_id'].toString();
                              AssignAssetController.to.id.text =
                                  data['id'].toString();
                            }),
                    SizedBox(height: 15),
                    CustomRichText(
                        textAlign: TextAlign.left,
                        text: "asset_id",
                        color: AppColors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        textSpan: ' *',
                        textSpanColor: AppColors.red),
                    SizedBox(
                      height: 8,
                    ),
                    CommonTextFormField(
                      controller: AssignAssetController.to.assetID,
                      isBlackColors: true,
                      validator: (String? data) {
                        if (data!.isEmpty) {
                          return "required_asset_id";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 15),
                    CustomText(
                      textAlign: TextAlign.left,
                      text: "assigned_to",
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    EmployeeController.to.isLoading
                        ? Skeleton(
                            height: 30,
                            width: Get.width,
                          )
                        : MainSearchableDropDown(
                            isRequired: true,
                            error: "required_emp_name",
                            title: 'first_name',
                            title1: 'last_name',
                            hint: "select_emp",
                            items: EmployeeController
                                    .to.employeeListModel?.data?.data?.data
                                    ?.map((datum) => datum.toJson())
                                    .toList() ??
                                [],
                            controller: AssignAssetController.to.empName,
                            onChanged: (data) {
                              AssignAssetController.to.empId.text =
                                  data['id'].toString();
                              AssignAssetController.to.empName.text =
                                  data['first_name'].toString();
                              final value = EmployeeController
                                  .to.employeeListModel?.data?.data?.data
                                  ?.where((data) =>
                                      data.firstName ==
                                      AssignAssetController.to.empName.text)
                                  .toList();
                              if (value!.first.department != null) {
                                AssignAssetController.to.depName.text = value
                                    .first.department!.departmentName
                                    .toString();
                                AssignAssetController.to.position.text = value
                                    .first.jobPosition!.position!.positionName
                                    .toString();
                                AssignAssetController.to.addDepartment = true;
                              } else {
                                AssignAssetController.to.addDepartment = false;
                                AssignAssetController.to.depName.clear();
                                AssignAssetController.to.position.clear();
                              }
                            }),
                    SizedBox(height: 15),
                    if (AssignAssetController.to.addDepartment == true)
                      buildEmployeeDetails(),
                    CustomText(
                      textAlign: TextAlign.left,
                      text: "assign_date",
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    DatePicker(
                      controller: AssignAssetController.to.assignDate,
                      hintText: 'select_date',
                      dateFormat: 'yyyy-MM-dd',
                      validator: (String? data) {
                        if (data!.isEmpty) {
                          return "required_purchase_date";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 15),
                    CustomText(
                      textAlign: TextAlign.left,
                      text: "required_return_date",
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    DatePicker(
                      controller: AssignAssetController.to.expectedReturnDate,
                      hintText: 'select_date',
                      dateFormat: 'yyyy-MM-dd',
                      validator: (String? data) {
                        if (data!.isEmpty) {
                          return "required_purchase_date";
                        } else {
                          return null;
                        }
                      },
                    ),
                    Row(
                      children: [
                        Transform.scale(
                          scale: 0.8,
                          child: CupertinoSwitch(
                              activeColor: Colors.blue,
                              applyTheme: true,
                              value: AssignAssetController.to.emailNotification,
                              onChanged: (value) {
                                AssignAssetController.to.emailNotification =
                                    value;
                              }),
                        ),
                        CustomText(
                          textAlign: TextAlign.left,
                          text: "send_email_notification_to_employee",
                          color: AppColors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity / 1.2,
                      child: CommonButton(
                        text: "Save",
                        textColor: AppColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        buttonLoader:CommonController.to.buttonLoader,
                        onPressed: () async {
                          if (formKey.currentState?.validate() == true) {
                            CommonController.to.buttonLoader = true;
                           await AssignAssetController.to.assignAssets();
                            CommonController.to.buttonLoader = false;
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    // SizedBox(
                    //   width: double.infinity / 1.2,
                    //   child: CommonButton(
                    //     isCancel: true,
                    //     text: "Cancel",
                    //     textColor: AppColors.black,
                    //     fontSize: 16,
                    //     fontWeight: FontWeight.w500,
                    //     // textAlign: TextAlign.center,
                    //     onPressed: () {},
                    //   ),
                    // ),
                    BackToScreen(text: "cancel", arrowIcon: false, onPressed: (){})
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  buildEmployeeDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          textAlign: TextAlign.left,
          text: "Department",
          color: AppColors.black,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(
          height: 8,
        ),
        DepartmentController.to.showDepartmentList
            ? Skeleton(
                height: 30,
                width: Get.width,
              )
            : MainSearchableDropDown(
                isRequired: true,
                error: "Required Department Name",
                hint: "Select Department",
                title: "department_name",
                items: DepartmentController.to.departmentModel?.data
                        ?.map((datum) => datum.toJson())
                        .toList() ??
                    [],
                controller: AssignAssetController.to.depName,
                onChanged: (data) async {
                  AssignAssetController.to.depName.text =
                      data['department_name'];
                  AssignAssetController.to.depId.text = data['department_id'];
                  await DepartmentController.to
                      .storePositionModel(AssignAssetController.to.depId.text);
                }),
        SizedBox(height: 15),
        CustomText(
          textAlign: TextAlign.left,
          text: "Position",
          color: AppColors.black,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(
          height: 8,
        ),
        EmployeeController.to.personalLoader ||
                AddDepartmentController.to.positionLoader
            ? Skeleton(width: Get.width, height: 30)
            : MainSearchableDropDown(
                title: 'position_name',
                hint: "Select Position",
                filled: true,
                fillColor: AppColors.white,
                isRequired: true,
                error: "Required Position Type",
                items: DepartmentController.to.positionModel?.data?[0].positions
                        ?.map((datum) => datum.toJson())
                        .toList() ??
                    [],
                controller: AssignAssetController.to.position,
                onChanged: (data) {
                  AssignAssetController.to.position.text =
                      data['position_name'];
                }),
      ],
    );
  }
}
