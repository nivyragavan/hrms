import 'package:dreamhrms/controller/on_boarding/on_boarding_checklist_controller.dart';
import 'package:dreamhrms/model/on_boarding_model/checklist_assign_list.dart';
import 'package:dreamhrms/model/on_boarding_model/task_details_model.dart';
import 'package:dreamhrms/screen/on_boarding/on_boarding_screen.dart';
import 'package:dreamhrms/services/utils.dart';
import 'package:dreamhrms/widgets/common_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';
import 'package:skeleton_animation/skeleton_animation.dart';
import '../../constants/colors.dart';
import '../../controller/common_controller.dart';
import '../../controller/employee/personal_controller.dart';
import '../../controller/on_boarding/on_boarding_controller.dart';
import '../../controller/signup_controller.dart';
import '../../controller/theme_controller.dart';
import '../../services/provision_check.dart';
import '../../widgets/Custom_rich_text.dart';
import '../../widgets/Custom_text.dart';
import '../../widgets/back_to_screen.dart';
import '../../widgets/common.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_datePicker.dart';
import '../../widgets/common_searchable_dropdown/MainCommonSearchableDropDown.dart';
import '../../widgets/common_textformfield.dart';
import '../../widgets/custom_dotted_border.dart';

class TaskDetailsScreen extends StatelessWidget {
  final int currentIndex;
  final Datum taskDetails;
  final DateTime effectiveDate;
  TaskDetailsScreen({
    Key? key,
    required this.taskDetails,
    required this.currentIndex,
    required this.effectiveDate,
  }) : super(key: key);

  TaskDetailsModel taskDetailsModel = TaskDetailsModel(taskDetails: []);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 1)).then((value) async {
      PersonalController.to.masterLoader = true;
      SignupController.to.countryLoader = true;
      taskDetailsModel = TaskDetailsModel(taskDetails: []);
      await PersonalController.to.getMasterList();
      await SignupController.to.getCountryList();
      SignupController.to.countryLoader = false;
      PersonalController.to.masterLoader = false;
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
                Get.to(OnBoardingScreen());
              },
              child: Icon(Icons.arrow_back_ios_new_outlined,
                  color: ThemeController.to.checkThemeCondition() == true
                      ? AppColors.white
                      : AppColors.black),
            ),
            SizedBox(width: 8),
            CustomText(
              text: "task_details",
              color: AppColors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
      body: Obx(() => Padding(
        padding: const EdgeInsets.all(20),
        child: ProvisionsWithIgnorePointer(
          provision: "Onboarding",
          type: "create",
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                      text:
                          taskDetails.template?.task?[currentIndex].taskName ??
                              "-",
                      color: AppColors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: Get.width * 0.40,
                        child: CustomText(
                            text: "onboarding_for",
                            color: AppColors.grey,
                            fontSize: 11,
                            fontWeight: FontWeight.w400),
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundImage: taskDetails.user!.profileImage ==
                                    null
                                ? Image.asset('assets/images/user.jpeg').image
                                : Image.network(taskDetails.user!.profileImage!)
                                    .image,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          CustomText(
                              text: taskDetails.user!.firstName ?? "-",
                              color: AppColors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: Get.width * 0.40,
                        child: CustomText(
                            text: "due_date",
                            color: AppColors.grey,
                            fontSize: 11,
                            fontWeight: FontWeight.w400),
                      ),
                      CustomText(
                          text: DateFormat('dd-MM-yyyy').format(getDueDate(
                            dueDate: taskDetails
                                .template?.task?[currentIndex].dueDate,
                            days: taskDetails
                                .template?.task?[currentIndex].noOfDays,
                          )),
                          color: AppColors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w400)
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: Get.width * 0.40,
                        child: CustomText(
                            text: "assignee",
                            color: AppColors.grey,
                            fontSize: 11,
                            fontWeight: FontWeight.w400),
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundImage: taskDetails.hr!.profileImage ==
                                    null
                                ? Image.asset('assets/images/user.jpeg').image
                                : Image.network(taskDetails.hr!.profileImage!)
                                    .image,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          CustomText(
                              text: taskDetails.hr?.firstName ?? "-",
                              color: AppColors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomText(
                      text: taskDetails
                              .template?.task?[currentIndex].description ??
                          "-",
                      color: AppColors.grey,
                      fontSize: 13,
                      fontWeight: FontWeight.w400),
                  const SizedBox(
                    height: 20,
                  ),
                  if (taskDetails.template?.task?[currentIndex].taskType ==
                      "file")
                    taskFile(),
                  if (taskDetails.template?.task?[currentIndex].taskType ==
                      "custom_field")
                    taskCustomField(),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ProvisionsWithIgnorePointer(
                          provision: "Onboarding",
                          type: "create",
                          child: CommonButton(
                            text: "mark_as_completed",
                            textColor: AppColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            buttonLoader: CommonController.to.buttonLoader,
                            onPressed: () async {
                              CommonController.to.buttonLoader = true;
                              if (taskDetails
                                      .template?.task?[currentIndex].taskType ==
                                  "custom_field") {
                                for (int i = 0;
                                    i <
                                        OnBoardingController
                                            .to.customField.length;
                                    i++) {
                                  taskDetailsModel.taskDetails.insert(
                                      i,
                                      TaskDetails(
                                          id: taskDetails
                                              .template
                                              ?.task?[currentIndex]
                                              .taskForm?[i]
                                              .id,
                                          fieldType: taskDetails
                                              .template
                                              ?.task?[currentIndex]
                                              .taskForm?[i]
                                              .fieldType,
                                          answer: OnBoardingController
                                              .to.customField[i].text));
                                }
                                await OnBoardingChecklistController.to
                                    .userTaskAnswer(
                                        userId: taskDetails.user!.id!,
                                        taskId: taskDetails
                                            .template!.task![currentIndex].id!,
                                        taskDetails: taskDetailsModel.taskDetails,
                                        taskType: "custom_field");
                              }
                              if (taskDetails
                                      .template?.task?[currentIndex].taskType ==
                                  "file") {
                                for (int i = 0;
                                    i < OnBoardingController.to.document.length;
                                    i++) {
                                  taskDetailsModel.taskDetails.insert(
                                      i,
                                      TaskDetails(
                                          id: taskDetails
                                              .template
                                              ?.task?[currentIndex]
                                              .taskForm?[0]
                                              .id,
                                          fieldType: taskDetails
                                              .template
                                              ?.task?[currentIndex]
                                              .taskForm?[0]
                                              .fieldType,
                                          answer: OnBoardingController
                                              .to.document[i].text));
                                }
                                await OnBoardingChecklistController.to
                                    .userTaskAnswerFile(
                                        userId: taskDetails.user!.id!,
                                        taskId: taskDetails
                                            .template!.task![currentIndex].id!,
                                        taskDetails: taskDetailsModel.taskDetails,
                                        taskType: "file");
                              }
                              if (taskDetails.template?.task?[currentIndex]
                                          .taskType ==
                                      "checkbox" ||
                                  taskDetails.template?.task?[currentIndex]
                                          .taskType ==
                                      "none") {
                                await OnBoardingChecklistController.to
                                    .userTaskAnswer(
                                  userId: taskDetails.user!.id!,
                                  taskId: taskDetails
                                      .template!.task![currentIndex].id!,
                                );
                              }
                              int nextIndex = currentIndex + 1;
                              if (nextIndex >=
                                  taskDetails.template!.task!.length) {
                                commonAlertDialog(
                                    icon: Icons.check_circle_outline,
                                    title: "complete_onboarding ?",
                                    description:
                                        "do_you_want_to_complete_this_employee's_onboarding ?"
                                            ,
                                    actionButtonText: "complete",
                                    onPressed: () {
                                      Get.to(() => OnBoardingScreen());
                                    },
                                    context: context);
                              } else {
                                if (nextIndex <
                                    taskDetails.template!.task!.length) {
                                  Get.back();
                                 PersonalController.to.masterLoader = true;
                                  Future.delayed(Duration(seconds: 1)).then((value){
                                    Get.to(() => TaskDetailsScreen(
                                      taskDetails: taskDetails,
                                      currentIndex: nextIndex,
                                      effectiveDate: effectiveDate,
                                    ));
                                  });
                                }
                              }
                              CommonController.to.buttonLoader = false;
                            },
                          ),
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
                      CommonController.to.buttonLoader = false;
                      Get.back();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        // )
        // ),
      )),
    );
  }

  getDueDate({String? dueDate, int? days}) {
    final DateTime effective_date = effectiveDate;
    if (dueDate == "After") {
      return effective_date.add(Duration(days: days!));
    } else {
      return effective_date.subtract(Duration(days: days!));
    }
  }

  taskFile() {
    OnBoardingController.to.documentName = List.generate(
        getOptionsItemCount(), (index) => TextEditingController());
    OnBoardingController.to.document = List.generate(
        getOptionsItemCount(), (index) => TextEditingController());
    return ListView.separated(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: getOptionsItemCount(),
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomDottedBorder(
              onPressed: () async {
                await pickFiles(
                  loader: OnBoardingController.to.loader,
                  controller: OnBoardingController.to.documentName[index],
                  binary: OnBoardingController.to.document[index],
                  key: "Document",
                );
              },
            ),
            SizedBox(
              height: 8,
            ),
            Obx(() {
              return CommonController.to.fileLoader == true
                  ? SizedBox()
                  : CustomText(
                      text: OnBoardingController.to.documentName[index].text,
                      color: AppColors.green,
                      fontSize: 13,
                      fontWeight: FontWeight.w600);
            })
          ],
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 15,
        );
      },
    );
  }

  int getOptionsItemCount() {
    final fileForm =
        taskDetails.template?.task?[currentIndex].taskForm?.firstWhere(
      (form) => form.fieldType == 'file',
      orElse: () => null!,
    );

    if (fileForm != null) {
      int itemCount = int.tryParse(fileForm.options ?? '') ?? 0;
      return itemCount;
    } else {
      return 0;
    }
  }

  taskCustomField() {
    OnBoardingController.to.customField = List.generate(
        taskDetails.template?.task?[currentIndex].taskType == "custom_field"
            ? taskDetails.template!.task![currentIndex].taskForm?.length ?? 0
            : 0,
        (index) => TextEditingController());
    return ListView.separated(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount:
          taskDetails.template?.task?[currentIndex].taskType == "custom_field"
              ? taskDetails.template!.task![currentIndex].taskForm?.length ?? 0
              : 0,
      itemBuilder: (context, index) {
        var formDetails =
            taskDetails.template!.task![currentIndex].taskForm?[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (formDetails!.fieldType == "text")
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomRichText(
                      textAlign: TextAlign.left,
                      text: formDetails.fieldName ?? "-",
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      textSpan: '*',
                      textSpanColor: AppColors.red),
                  SizedBox(height: 10),
                  CommonTextFormField(
                    controller: OnBoardingController.to.customField[index],
                    isBlackColors: true,
                    keyboardType: TextInputType.text,
                    validator: (String? data) {
                      if (data == "" || data == null) {
                        print("Empty data");
                        return "Required ${formDetails.fieldName}";
                      } else {
                        return null;
                      }
                    },
                  ),
                ],
              ),
            if (formDetails.fieldType == "number")
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomRichText(
                      textAlign: TextAlign.left,
                      text: formDetails.fieldName ?? "-",
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      textSpan: '*',
                      textSpanColor: AppColors.red),
                  SizedBox(height: 10),
                  CommonTextFormField(
                    controller: OnBoardingController.to.customField[index],
                    isBlackColors: true,
                    keyboardType: TextInputType.number,
                    validator: (String? data) {
                      if (data == "" || data == null) {
                        print("Empty data");
                        return "Required ${formDetails.fieldName}";
                      } else {
                        return null;
                      }
                    },
                  ),
                ],
              ),
            if (formDetails.fieldType == "date")
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomRichText(
                      textAlign: TextAlign.left,
                      text: 'date_of_birth',
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      textSpan: '*',
                      textSpanColor: AppColors.red),
                  SizedBox(height: 10),
                  DatePicker(
                    controller: OnBoardingController.to.customField[index],
                    focusedBorder: BorderSide(color: Colors.grey, width: 1.7),
                    disabledBorder: BorderSide(color: Colors.black, width: 1),
                    hintText: "YYYY-MM-DD",
                    dateFormat: 'yyyy-MM-dd',
                    validator: (String? data) {
                      if (data == "" || data == null) {
                        print("Empty data");
                        return "required_date_of_birth";
                      } else {
                        return null;
                      }
                    },
                  ),
                ],
              ),
            if (formDetails.fieldType == "email")
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomRichText(
                      textAlign: TextAlign.left,
                      text: 'email',
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      textSpan: '*',
                      textSpanColor: AppColors.red),
                  SizedBox(height: 10),
                  CommonTextFormField(
                    controller: OnBoardingController.to.customField[index],
                    isBlackColors: true,
                    keyboardType: TextInputType.emailAddress,
                    validator: (String? data) {
                      if (data == "" || data == null) {
                        print("Empty data");
                        return "required_email";
                      } else {
                        return null;
                      }
                    },
                  ),
                ],
              ),
            if (formDetails.fieldType == "drop_down")
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomRichText(
                      textAlign: TextAlign.left,
                      text: formDetails.fieldName ?? "-",
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      textSpan: '*',
                      textSpanColor: AppColors.red),
                  SizedBox(height: 10),
                  Obx(
                    () => PersonalController.to.masterLoader ||
                            SignupController.to.countryLoader
                        ? Skeleton(width: Get.width, height: 35)
                        : MainSearchableDropDown(
                            title: formDetails.fieldName == "Nationality"
                                ? "name"
                                : formDetails.fieldName == "Gender"
                                    ? "gender"
                                    : formDetails.fieldName == "Marital Status"
                                        ? "status"
                                        : "",
                            hint: formDetails.fieldName == "Nationality"
                                ? "Select Nationality"
                                : formDetails.fieldName == "Gender"
                                    ? "Select Gender"
                                    : formDetails.fieldName == "Marital Status"
                                        ? "Select Marital Status"
                                        : "",
                            isRequired: true,
                            error: formDetails.fieldName == "Nationality"
                                ? "Nationality"
                                : formDetails.fieldName == "Gender"
                                    ? "Gender"
                                    : formDetails.fieldName == "Marital Status"
                                        ? "Marital Status"
                                        : "",
                            items: getList(formDetails),
                            controller:
                                OnBoardingController.to.customField[index],
                            onChanged: (data) {}),
                  )
                ],
              ),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 15,
        );
      },
    );
  }

  getList(TaskForm formDetails) {
    if (formDetails.fieldName == "Nationality") {
      return SignupController.to.countryModel?.data
          ?.map((datum) => datum.toJson())
          .toList();
    } else if (formDetails.fieldName == "Gender") {
      return PersonalController.to.employeeMasterModel?.data?[0].gender
          ?.map((status) {
        return {"gender": status};
      }).toList();
    } else {
      if (formDetails.fieldName == "Marital Status") {
        return PersonalController.to.employeeMasterModel?.data?[0].maritalStatus
            ?.map((status) {
          return {"status": status};
        }).toList();
      }
    }
  }
}
