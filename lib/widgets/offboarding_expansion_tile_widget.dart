import 'package:dreamhrms/model/on_boarding_model/checklist_assign_list.dart' hide State;
import 'package:dreamhrms/widgets/Custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';

import '../constants/colors.dart';
import '../controller/common_controller.dart';
import '../controller/off_boarding/off_boarding_checklist_controller.dart';
import '../controller/theme_controller.dart';
import '../screen/off_boarding/task_details_screen.dart';
import 'back_to_screen.dart';
import 'circular_progress_indicator_widget.dart';
import 'common_alert_dialog.dart';
import 'common_button.dart';

class OffBoardingExpansionTileWidget extends StatefulWidget {
  final CustomText title;
  final CustomText subTitle;
  final Widget image;
  final VoidCallback? editOnPressed;
  final VoidCallback? ContainerOnClick;
  final int mainIndex;
  final SvgPicture? editIcon;
  final String? value;
  final bool? editicon;
  final DateTime? effectiveDate;
  final String? offBoardingFor;
  final ImageProvider<Object>? offBoardingImage;
  final String? templateName;
  final int? taskLength;
  const OffBoardingExpansionTileWidget(
      {Key? key,
        required this.title,
        required this.subTitle,
        this.editOnPressed,
        this.ContainerOnClick,
        required this.image,
        required this.mainIndex,
        this.editIcon,
        this.value,
        this.editicon = true,
        this.effectiveDate,
        this.offBoardingFor, this.offBoardingImage, this.templateName, this.taskLength})
      : super(key: key);

  @override
  State<OffBoardingExpansionTileWidget> createState() =>
      _OffBoardingExpansionTileWidgetState();
}

class _OffBoardingExpansionTileWidgetState
    extends State<OffBoardingExpansionTileWidget> {
  bool isExpanded = false;
  void toggleExpand() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey.withOpacity(0.5)),
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          leading: widget.image,
          title: widget.title,
          subtitle: widget.subTitle,
          iconColor: AppColors.grey,
          trailing: SizedBox(
            width: 30,
            height: 30,
            child: Center(
              child: CircularProgressIndicatorWidget(
                totalSteps: OffBoardingChecklistController.to.checklistAssignListModel
                    ?.data?.data![widget.mainIndex].processData!.totalStep ??
                    0,
                currentStep: OffBoardingChecklistController.to.checklistAssignListModel
                    ?.data?.data![widget.mainIndex].processData!.currentStep ??
                    0,
              ),
            ),
          ),
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: ThemeController.to.checkThemeCondition() == true ? AppColors.grey.withOpacity(0.3) : AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                      text: widget.templateName ?? "-",
                      color: AppColors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                  SizedBox(
                    height: 10,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: widget.taskLength ??
                        0,
                    itemBuilder: (context, index) {
                      var assignedTaskList = OffBoardingChecklistController
                          .to.checklistAssignListModel?.data?.data?[widget.mainIndex];
                      return SingleChildScrollView(
                          child: InkWell(
                              onTap: () {
                                (index == 0)  && (widget.taskLength != OffBoardingChecklistController
                                    .to
                                    .checklistAssignListModel!
                                    .data!
                                    .data![widget.mainIndex]
                                    .processData!
                                    .currentStep)? Get.to(() => TaskDetailsScreen(
                                    currentIndex: OffBoardingChecklistController
                                        .to
                                        .checklistAssignListModel!
                                        .data!
                                        .data![widget.mainIndex]
                                        .processData!
                                        .currentStep!,
                                    taskDetails: assignedTaskList,
                                    effectiveDate : widget.effectiveDate ?? DateTime.now()
                                )) : {};
                              },
                              child: Container(
                                width: Get.width * 0.75,
                                decoration: BoxDecoration(
                                    color: ThemeController.to.checkThemeCondition() == true ? AppColors.black : AppColors.white,
                                    border: Border.all(
                                        color: AppColors.grey.withOpacity(0.5)),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Slidable(
                                  closeOnScroll: true,
                                  endActionPane: ActionPane(
                                    extentRatio: 0.2,
                                    motion: const BehindMotion(),
                                    children: [
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
                                              await OffBoardingChecklistController.to.deleteTask(assignedTaskList!
                                                  .template!.task![index]);
                                              CommonController.to.buttonLoader = false;
                                            },
                                          );
                                          // deleteTaskDialogBox(assignedTaskList!.template!.task![index]);
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
                                    margin:
                                    EdgeInsets.symmetric(horizontal: 10),
                                    color: ThemeController.to.checkThemeCondition() == true ? AppColors.black : AppColors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.check_circle,
                                                color: (assignedTaskList
                                                    ?.processData
                                                    ?.currentStep ==
                                                    0)
                                                    ? AppColors.lightGrey
                                                    : (assignedTaskList
                                                    ?.processData!
                                                    .currentStep != 0
                                                    &&
                                                    index <
                                                        assignedTaskList!
                                                            .processData!
                                                            .currentStep!)
                                                    ? AppColors.blue
                                                    : AppColors.lightGrey,
                                                size: 20,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              SizedBox(
                                                width: Get.width * 0.63,
                                                child: CustomText(
                                                    text: assignedTaskList!
                                                        .template!
                                                        .task![index]
                                                        .taskName ??
                                                        "-",
                                                    color: AppColors.black,
                                                    fontSize: 13,
                                                    fontWeight:
                                                    FontWeight.w500),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 12,
                                              ),
                                              SizedBox(
                                                width: Get.width * 0.29,
                                                child: ListTile(
                                                  title: CustomText(
                                                      text: "Due Date",
                                                      color: AppColors.grey,
                                                      fontSize: 11,
                                                      fontWeight:
                                                      FontWeight.w400),
                                                  subtitle: CustomText(
                                                      text: DateFormat(
                                                          'dd-MM-yyyy')
                                                          .format(getDueDate(
                                                          dueDate:
                                                          assignedTaskList
                                                              .template!
                                                              .task![
                                                          index]
                                                              .dueDate,
                                                          days: assignedTaskList
                                                              .template!
                                                              .task![index]
                                                              .noOfDays)),
                                                      color: AppColors.black,
                                                      fontSize: 12,
                                                      fontWeight:
                                                      FontWeight.w500),
                                                ),
                                              ),
                                              SizedBox(
                                                width: Get.width * 0.40,
                                                child: ListTile(
                                                  leading: CircleAvatar(
                                                    backgroundImage : assignedTaskList.hr!.profileImage == null
                                                        ? Image.asset('assets/images/user.jpeg').image
                                                        : Image.network(assignedTaskList.hr!.profileImage!)
                                                        .image,
                                                  ),
                                                  title: CustomText(
                                                      text: "Assignee",
                                                      color: AppColors.grey,
                                                      fontSize: 11,
                                                      fontWeight:
                                                      FontWeight.w400),
                                                  subtitle: CustomText(
                                                      text:
                                                      "${assignedTaskList.hr!.firstName ?? "-"} ${assignedTaskList.hr!.lastName ?? "-"}",
                                                      color: AppColors.black,
                                                      fontSize: 12,
                                                      fontWeight:
                                                      FontWeight.w500),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )));
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 10,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  deleteTaskDialogBox(Task deleteIndex) {
    return Get.defaultDialog(
        title: "",
        content: Container(
          width: Get.width,
          height: Get.height * 0.30,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Icon(
                Icons.delete_outline,
                color: AppColors.blue,
              ),
              SizedBox(
                height: 18,
              ),
              CustomText(
                  text: 'Delete Task ?',
                  color: AppColors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
              SizedBox(
                height: 18,
              ),
              CustomText(
                  text:
                  'All employee information/file in this task will be deleted.',
                  color: AppColors.grey,
                  fontSize: 14,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w400),
              SizedBox(
                height: 18,
              ),
              Row(
                children: [
                  Expanded(
                    child: CommonButton(
                      text: "Delete",
                      textColor: AppColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      onPressed: () {
                        OffBoardingChecklistController.to.deleteTask(deleteIndex);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 18,
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
        ));
  }

  getDueDate({String? dueDate, int? days}) {
    final DateTime effective_date = widget.effectiveDate ?? DateTime.now();
    if (dueDate == "After") {
      return effective_date.add(Duration(days: days!));
    } else {
      return effective_date.subtract(Duration(days: days!));
    }
  }
}
