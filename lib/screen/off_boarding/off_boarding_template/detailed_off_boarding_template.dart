import 'package:dreamhrms/model/on_boarding_model/template_list_model.dart';
import 'package:dreamhrms/screen/employee/employee_details/profile.dart';
import 'package:dreamhrms/screen/off_boarding/off_boarding_template/add_task_screen.dart';
import 'package:dreamhrms/screen/off_boarding/off_boarding_template/edit_task_screen.dart';
import 'package:dreamhrms/widgets/no_record.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';

import '../../../constants/colors.dart';
import '../../../controller/common_controller.dart';
import '../../../controller/off_boarding/off_boarding_controller.dart';
import '../../../controller/theme_controller.dart';
import '../../../services/provision_check.dart';
import '../../../widgets/Custom_text.dart';
import '../../../widgets/back_to_screen.dart';
import '../../../widgets/common_alert_dialog.dart';
import '../../../widgets/common_button.dart';
import 'off_boarding_template.dart';

class DetailedOffBoardingTemplateScreen extends StatelessWidget {
  final Datum templateListModel;
  const DetailedOffBoardingTemplateScreen(
      {Key? key, required this.templateListModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((value) async {
      OffBoardingController.to.clearValues();
      await OffBoardingController.to.getTemplateList();
    });
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
                    Get.offAll(OffBoardingTemplateScreen());
                  },
                  child: Icon(Icons.arrow_back_ios_new_outlined,
                      color: ThemeController.to.checkThemeCondition() == true ? AppColors.white : AppColors.black),
                ),
                SizedBox(width: 8),
                SizedBox(
                  width: Get.width * 0.68,
                  child: CustomText(
                    text: templateListModel.templateName!,
                    color: AppColors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            ProvisionsWithIgnorePointer(
              provision: "Offboarding",
              type:"create",
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: InkWell(
                  onTap: () {
                    Get.to(() => AddTaskScreen(
                          templateListModel: templateListModel.id,
                        ));
                  },
                  child: Container(
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryColor1,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    child: Icon(Icons.add, color: AppColors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      body: Obx(() {
        return Padding(
          padding: EdgeInsets.all(20),
          child: commonLoader(
            length: 6,
            singleRow: true,
            loader: OffBoardingController.to.showList,
            child: templateListModel.task?.length == 0
                ? NoRecord()
                : ListView.separated(
                    itemCount: templateListModel.task?.length ?? 0,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var taskList = templateListModel.task?[index];
                      return InkWell(
                        onTap: () {
                          onBoardingDetailsBottomSheet(index);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: ThemeController.to.checkThemeCondition() == true ? AppColors.black : AppColors.white,
                              border: Border.all(
                                  color: AppColors.grey.withOpacity(0.5)),
                              borderRadius: BorderRadius.circular(8)),
                          child: Slidable(
                            closeOnScroll: true,
                            endActionPane: ActionPane(
                              extentRatio: 0.3,
                              motion: const BehindMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    Get.to(() => EditTaskScreen(
                                          templateListModel:
                                              templateListModel.id!,
                                          taskListModel:
                                              templateListModel.task![index],
                                        ));
                                  },
                                  backgroundColor: AppColors.blue,
                                  foregroundColor: Colors.white,
                                  icon: Icons.edit_outlined,
                                ),
                                SlidableAction(
                                  onPressed: (context) {
                                    commonAlertDialog(
                                      icon: Icons.delete_outline,
                                      context:context,
                                      title: "delete_task ?",
                                      description: 'all_details_in_this_task_will_be_deleted.',
                                      actionButtonText: "delete",
                                      onPressed: () async {
                                        CommonController.to.buttonLoader = true;
                                        await OffBoardingController.to.deleteTask(templateListModel.task![index]);
                                        CommonController.to.buttonLoader = false;
                                      }, provision: 'offboarding', provisionType: 'delete',
                                    );
                                  },
                                  backgroundColor: AppColors.red,
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete_outline,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(8),
                                      bottomRight: Radius.circular(8)),
                                ),
                              ],
                            ),
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              color: ThemeController.to.checkThemeCondition() == true ? AppColors.black : AppColors.white,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    child: (taskList?.taskType == "checkbox")
                                        ? SvgPicture.asset(
                                        'assets/icons/checkbox.svg',
                                      color: ThemeController.to
                                          .checkThemeCondition() ==
                                          true
                                          ? AppColors.white
                                          : AppColors.black,)
                                        : (taskList?.taskType == "file")
                                        ? SvgPicture.asset(
                                        'assets/icons/file.svg',
                                      color: ThemeController.to
                                          .checkThemeCondition() ==
                                          true
                                          ? AppColors.white
                                          : AppColors.black,
                                    )
                                        : (taskList?.taskType ==
                                        "custom_field")
                                        ? SvgPicture.asset(
                                        'assets/icons/edit.svg',
                                      color: ThemeController.to
                                          .checkThemeCondition() ==
                                          true
                                          ? AppColors.white
                                          : AppColors.black,
                                    )
                                        : SvgPicture.asset(
                                        'assets/icons/edit.svg',
                                      color: ThemeController.to
                                          .checkThemeCondition() ==
                                          true
                                          ? AppColors.white
                                          : AppColors.black,
                                    ),
                                  ),
                                  title: Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: CustomText(
                                        text: taskList!.taskName.toString(),
                                        color: AppColors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  subtitle: CustomText(
                                      text: taskList.description.toString(),
                                      color: AppColors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  trailing: Container(
                                    width: 28,
                                    height: 28,
                                    decoration: BoxDecoration(
                                        color: AppColors.lightGrey,
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Icon(
                                      Icons.chevron_right,
                                      color: AppColors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 15,
                      );
                    },
                  ),
          ),
        );
      }),
    );
  }

  onBoardingDetailsBottomSheet(int index) {
    return Get.bottomSheet(SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: ThemeController.to.checkThemeCondition() == true ? AppColors.black : AppColors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40))),
        child: Column(
          children: [buildOffBoardingDetailsInformation(index)],
        ),
      ),
    ));
  }

  buildOffBoardingDetailsInformation(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            width: 75,
            height: 4,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColors.grey),
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        CustomText(
            text: templateListModel.task![index].taskName ?? "-",
            color: AppColors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600),
        const SizedBox(
          height: 25,
        ),
        CustomText(
            text: "task_type",
            color: AppColors.grey,
            fontSize: 11,
            fontWeight: FontWeight.w400),
        const SizedBox(
          height: 10,
        ),
        CustomText(
            text: templateListModel.task![index].taskType ?? "-",
            color: AppColors.black,
            fontSize: 12,
            fontWeight: FontWeight.w400),
        const SizedBox(
          height: 20,
        ),
        CustomText(
            text: "task_name",
            color: AppColors.grey,
            fontSize: 11,
            fontWeight: FontWeight.w400),
        const SizedBox(
          height: 10,
        ),
        CustomText(
            text: templateListModel.task![index].taskName ?? "-",
            color: AppColors.black,
            fontSize: 12,
            fontWeight: FontWeight.w400),
        const SizedBox(
          height: 20,
        ),
        CustomText(
            text: "assignee",
            color: AppColors.grey,
            fontSize: 11,
            fontWeight: FontWeight.w400),
        const SizedBox(
          height: 10,
        ),
        CustomText(
            text: templateListModel.task![index].assignRole ?? "-",
            color: AppColors.black,
            fontSize: 12,
            fontWeight: FontWeight.w400),
        const SizedBox(
          height: 20,
        ),
        CustomText(
            text: "due_date",
            color: AppColors.grey,
            fontSize: 11,
            fontWeight: FontWeight.w400),
        const SizedBox(
          height: 10,
        ),
        CustomText(
            text:
                "${templateListModel.task![index].noOfDays ?? "-"} days ${templateListModel.task![index].dueDate ?? "-"} joining date",
            color: AppColors.black,
            fontSize: 12,
            fontWeight: FontWeight.w400),
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
                onPressed: () {},
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
    );
  }
}
