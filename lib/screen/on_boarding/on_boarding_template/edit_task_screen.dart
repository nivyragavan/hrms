import 'package:dreamhrms/screen/employee/employee_details/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

import '../../../constants/colors.dart';
import '../../../controller/common_controller.dart';
import '../../../controller/on_boarding/on_boarding_controller.dart';
import '../../../controller/theme_controller.dart';
import '../../../model/on_boarding_model/template_list_model.dart';
import '../../../widgets/Custom_rich_text.dart';
import '../../../widgets/Custom_text.dart';
import '../../../widgets/back_to_screen.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/common_searchable_dropdown/MainCommonSearchableDropDown.dart';
import '../../../widgets/common_textformfield.dart';
import '../../schedule/multi_select_dropdown.dart';

class EditTaskScreen extends StatelessWidget {
  final int templateListModel;
  final Task taskListModel;
  EditTaskScreen(
      {Key? key, required this.templateListModel, required this.taskListModel})
      : super(key: key);

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((value) async {
      OnBoardingController.to.showType == true;
      OnBoardingController.to.clearValues();
      await OnBoardingController.to.getTaskType();
      await OnBoardingController.to.getTaskRole();
      await OnBoardingController.to.getCustomField();
      await OnBoardingController.to.setEditTaskInfo(taskListModel);
      if (OnBoardingController.to.maximumFileNumber != null) {
        try {
          OnBoardingController.to.initialValue = int.parse(OnBoardingController.to.maximumFileNumber.text);
        } catch (e) {
          print("Error parsing maximumFileNumber: $e");
        }
      }
      OnBoardingController.to.showType == false;
    });
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(Icons.arrow_back_ios_new_outlined,
                  color:ThemeController.to.checkThemeCondition() == true ? AppColors.white : AppColors.black),
            ),
            SizedBox(width: 8),
            CustomText(
              text: "edit_task",
              color: AppColors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
      body: Obx(() {
        return Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: commonLoader(
              length: 6,
              singleRow: true,
              loader: OnBoardingController.to.showType,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomRichText(
                        textAlign: TextAlign.left,
                        text: 'task_name',
                        color: AppColors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        textSpan: '*',
                        textSpanColor: AppColors.red),
                    SizedBox(height: 10),
                    CommonTextFormField(
                      controller: OnBoardingController.to.taskName,
                      isBlackColors: true,
                      keyboardType: TextInputType.name,
                      validator: (String? data) {
                        if (data == "" || data == null) {
                          return "required_task_name";
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
                        text: 'task_type',
                        color: AppColors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        textSpan: '*',
                        textSpanColor: AppColors.red),
                    MainSearchableDropDown(
                        title: 'task_type',
                        hint: "select_task_type",
                        isRequired: true,
                        error: "task_type",
                        items: OnBoardingController.to.taskTypeModel?.data?.data
                            ?.map((type) {
                          return {
                            "task_type": type.type,
                            "task_type_id": type.id,
                          };
                        }).toList(),
                        controller: OnBoardingController.to.taskType,
                        onChanged: (data) async {
                          OnBoardingController.to.taskTypeId.text =
                              data["task_type_id"];
                          print(
                              "task type id ${OnBoardingController.to.taskTypeId.text}");
                          await OnBoardingController.to.getCustomField();
                          if (OnBoardingController.to.taskTypeId.text == "3") {
                            taskListModel.taskType = "custom_field";
                          } else if (OnBoardingController.to.taskTypeId.text ==
                              "2") {
                            taskListModel.taskType = "file";
                          } else {
                            taskListModel.taskType = "";
                          }
                        }),
                    if (taskListModel.taskType == "custom_field")
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomRichText(
                              textAlign: TextAlign.left,
                              text: 'custom_fields',
                              color: AppColors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              textSpan: '*',
                              textSpanColor: AppColors.red),
                          SizedBox(height: 10),
                          MultiSelectDropDown(
                              title: "select_custom_fields",
                              items: OnBoardingController
                                      .to.customFieldModel?.data?.data
                                      ?.map((type) => "${type.type}")
                                      .toList() ??
                                  [],
                              onChanged: (value) {
                                OnBoardingController
                                    .to.selectedCustomFieldItems = value;
                              },
                              selectedItems: OnBoardingController
                                  .to.selectedCustomFieldItems),
                        ],
                      ),
                    if (taskListModel.taskType == "file")
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomRichText(
                              textAlign: TextAlign.left,
                              text: 'maximum_file_number',
                              color: AppColors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              textSpan: '*',
                              textSpanColor: AppColors.red),
                          SizedBox(height: 10),
                          SizedBox(
                            height: 50,
                            child: Center(
                              child: NumberInputWithIncrementDecrement(
                                controller:
                                    OnBoardingController.to.maximumFileNumber,
                                initialValue: OnBoardingController
                                            .to.initialValue,
                                min: 0,
                                max: 10,
                                textAlign: TextAlign.left,
                                incIcon: Icons.keyboard_arrow_up_outlined,
                                decIcon: Icons.keyboard_arrow_down_outlined,
                                incIconSize: 20,
                                decIconSize: 20,
                                numberFieldDecoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                ),
                                widgetContainerDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: AppColors.lightGrey, width: 1),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomRichText(
                        textAlign: TextAlign.left,
                        text: 'assign_role',
                        color: AppColors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        textSpan: '*',
                        textSpanColor: AppColors.red),
                    MainSearchableDropDown(
                        title: 'assign_role',
                        hint: "select_assign_role",
                        isRequired: true,
                        error: "assign_role",
                        items: OnBoardingController.to.taskRoleModel?.data?.data
                            ?.map((type) {
                          return {"assign_role": type.type};
                        }).toList(),
                        controller: OnBoardingController.to.assignRole,
                        onChanged: (data) {}),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomRichText(
                        textAlign: TextAlign.left,
                        text: 'day',
                        color: AppColors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        textSpan: '*',
                        textSpanColor: AppColors.red),
                    SizedBox(height: 10),
                    CommonTextFormField(
                      controller: OnBoardingController.to.day,
                      isBlackColors: true,
                      keyboardType: TextInputType.name,
                      validator: (String? data) {
                        if (data == "" || data == null) {
                          return "required_day";
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
                        text: 'join_date',
                        color: AppColors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        textSpan: '*',
                        textSpanColor: AppColors.red),
                    MainSearchableDropDown(
                        title: 'join_date',
                        hint: "select_join_date",
                        isRequired: true,
                        error: "join_date",
                        items: [
                          {"join_date": "before"},
                          {"join_date": "after"}
                        ],
                        controller: OnBoardingController.to.joinDate,
                        onChanged: (data) {}),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomRichText(
                        textAlign: TextAlign.left,
                        text: 'template_description',
                        color: AppColors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        textSpan: '*',
                        textSpanColor: AppColors.red),
                    SizedBox(height: 10),
                    CommonTextFormField(
                      controller: OnBoardingController.to.taskDescription,
                      isBlackColors: true,
                      maxlines: 3,
                      keyboardType: TextInputType.name,
                      validator: (String? data) {
                        if (data == "" || data == null) {
                          print("Empty data");
                          return "required_description";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CommonButton(
                            text: "save",
                            textColor: AppColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            buttonLoader: CommonController.to.buttonLoader,
                            onPressed: () async{
                              if (formKey.currentState!.validate()) {
                                CommonController.to.buttonLoader = true;
                                final customFields = OnBoardingController
                                    .to.customFieldModel?.data?.data
                                    ?.where((element) => OnBoardingController
                                        .to.selectedCustomFieldItems
                                        .contains("${element.type}"));
                                if (taskListModel.taskType == "custom_field") {
                                  await OnBoardingController.to.editTask(
                                      customFields: customFields!
                                          .map((e) => e.type)
                                          .join(","),
                                      templateIndex: templateListModel,
                                      taskIndex: taskListModel.id!);
                                } else {
                                  await OnBoardingController.to.editTask(
                                    templateIndex: templateListModel,
                                    taskIndex: taskListModel.id!,
                                  );
                                }
                                CommonController.to.buttonLoader = false;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
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
        );
      }),
    );
  }
}
