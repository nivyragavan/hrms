import 'package:dotted_border/dotted_border.dart';
import 'package:dreamhrms/constants/colors.dart';
import 'package:dreamhrms/controller/leave_add_permission_controller.dart';
import 'package:dreamhrms/controller/leave_controller.dart';
import 'package:dreamhrms/widgets/common_searchable_dropdown/MainCommonSearchableDropDown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localization/localization.dart';
import 'package:skeleton_animation/skeleton_animation.dart';
import '../../controller/common_controller.dart';
import '../../services/provision_check.dart';
import '../../services/utils.dart';
import '../../widgets/Custom_rich_text.dart';
import '../../widgets/Custom_text.dart';
import '../../widgets/back_to_screen.dart';
import '../../widgets/common.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_datePicker.dart';
import '../../widgets/common_textformfield.dart';

class AddLeave extends StatefulWidget {
  final Null Function() backBtnOnPressed;
  AddLeave({super.key, required this.backBtnOnPressed});

  @override
  State<AddLeave> createState() => _AddLeaveState();
}

class _AddLeaveState extends State<AddLeave> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero).then((value) async {
      await LeaveController.to.getLeaveMasterTypes();
      await LeaveController.to.getLeaveTypes();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                  text: "add_leave",
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
        () => ProvisionsWithIgnorePointer(
          provision: "Leave",
          type: "create",
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 18.0,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomRichText(
                        textAlign: TextAlign.left,
                        text: "leaves_type",
                        color: AppColors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        textSpan: ' *',
                        textSpanColor: AppColors.red),
                    SizedBox(
                      height: 8,
                    ),
                    LeaveController.to.showType
                        ? Skeleton(
                            height: 30,
                            width: double.infinity,
                          )
                        : MainSearchableDropDown(
                            title: 'name',
                            isRequired: true,
                            error: "required_leave_type",
                            hint: 'select_type',
                            items: LeaveController.to.leaveMasterModel?.data
                                ?.map((datum) => datum.toJson())
                                .toList(),
                            controller: LeaveAddPermissionController.to.leaveType,
                            onChanged: (data) {
                              LeaveAddPermissionController.to.leaveTypeId.text =
                                  data['id'].toString();
                             LeaveAddPermissionController.to.availableLeave = data['available_leave'];
                            }),
                    Row(
                      children: [
                        CustomText(
                          text: "current_leave_available",
                          color: AppColors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        CustomText(
                          text:
                              "${LeaveAddPermissionController.to.availableLeave.toString()}"
                                  ,
                          color: AppColors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    CustomRichText(
                        textAlign: TextAlign.left,
                        text: "start_of_leave",
                        color: AppColors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        textSpan: ' *',
                        textSpanColor: AppColors.red),
                    SizedBox(height: 8),
                    DatePicker(
                      controller: LeaveAddPermissionController.to.startDate,
                      hintText: 'start_date',
                      dateFormat: 'yyyy-MM-dd',
                      validator: (String? data) {
                        if (data!.isEmpty) {
                          return "required_start_leave";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (newValue) {
                        if (newValue!.isNotEmpty) {
                          LeaveAddPermissionController.to.isStartDateEnabled =
                              true;
                          debugPrint(LeaveAddPermissionController
                              .to.isStartDateEnabled
                              .toString());
                        }
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomRichText(
                        textAlign: TextAlign.left,
                        text: "end_of_leave",
                        color: AppColors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        textSpan: ' *',
                        textSpanColor: AppColors.red),
                    SizedBox(height: 8),
                    LeaveAddPermissionController.to.isStartDateEnabled == true
                        ? DatePicker(
                            controller: LeaveAddPermissionController.to.endDate,
                            hintText: 'end_date',
                            dateFormat: 'yyyy-MM-dd',
                            validator: (String? data) {
                              if (data!.isEmpty) {
                                return "required_end_leave";
                              } else {
                                return null;
                              }
                            },
                            onSaved: (newValue) {
                              if (newValue!.isNotEmpty) {
                                LeaveAddPermissionController.to
                                    .updateDifferenceInDays(
                                        CommonController.to.formatDate(LeaveAddPermissionController
                                            .to.startDate.value.text),
                                    CommonController.to.formatDate(newValue));
                              }
                            },
                          )
                        : _buildDisabledEndDate(),
                    SizedBox(height: 15),
                    Visibility(
                      visible: LeaveAddPermissionController.to.isSameDate,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomRichText(
                              textAlign: TextAlign.left,
                              text: "time_range",
                              color: AppColors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              textSpan: ' *',
                              textSpanColor: AppColors.red),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            height: 40,
                             width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                color: AppColors.grey.withAlpha(40),
                              ),
                            ),
                            child: Flex(
                              direction: Axis.horizontal,
                              children: [
                                Obx(
                                  () => Row(
                                    children: [
                                      Radio<LeaveType>(
                                        value: LeaveType.Full,
                                        groupValue: LeaveAddPermissionController
                                            .to.leaveDuration.value,
                                        onChanged: (LeaveType? value) {
                                          LeaveAddPermissionController
                                              .to.leaveDuration.value = value!;
                                          LeaveAddPermissionController
                                              .to.leaveDurationId = "1";
                                          LeaveAddPermissionController
                                                  .to.noOfDays.value =
                                              TextEditingValue(text: "1");
                                          print(LeaveAddPermissionController
                                              .to.noOfDays.value);
                                        },
                                      ),
                                      CustomText(
                                          text: "full",
                                          color: LeaveAddPermissionController.to
                                                      .leaveDuration.value.name ==
                                                  'Full'
                                              ? AppColors.darkBlue
                                              : AppColors.grey,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Obx(
                                  () => Row(
                                    children: [
                                      Radio<LeaveType>(
                                        value: LeaveType.FirstHalf,
                                        groupValue: LeaveAddPermissionController
                                            .to.leaveDuration.value,
                                        onChanged: (LeaveType? value) {
                                          LeaveAddPermissionController
                                              .to.leaveDuration.value = value!;
                                          LeaveAddPermissionController
                                              .to.leaveDurationId = "2";
                                          LeaveAddPermissionController
                                                  .to.noOfDays.value =
                                              TextEditingValue(text: "0.5");
                                        },
                                      ),
                                      SizedBox(
                                        width: 0,
                                      ),
                                      CustomText(
                                          text: "first_half",
                                          color: LeaveAddPermissionController.to
                                                      .leaveDuration.value.name ==
                                                  'First Half'
                                              ? AppColors.darkBlue
                                              : AppColors.grey,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Flexible(
                                  child: Obx(
                                    () => Row(
                                      children: [
                                        Radio<LeaveType>(
                                          value: LeaveType.SecondHalf,
                                          groupValue: LeaveAddPermissionController
                                              .to.leaveDuration.value,
                                          onChanged: (LeaveType? value) {
                                            LeaveAddPermissionController
                                                .to.leaveDuration.value = value!;
                                            LeaveAddPermissionController
                                                .to.leaveDurationId = "3";
                                            LeaveAddPermissionController
                                                    .to.noOfDays.value =
                                                TextEditingValue(text: "0.5");
                                          },
                                        ),
                                        CustomText(
                                            text: "second_half",
                                            color: LeaveAddPermissionController
                                                        .to
                                                        .leaveDuration
                                                        .value
                                                        .name ==
                                                    'Second Half'
                                                ? AppColors.darkBlue
                                                : AppColors.grey,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    CustomText(
                      text: "no.of.day",
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(height: 8),
                    CommonTextFormField(
                      controller: LeaveAddPermissionController.to.noOfDays,
                      isBlackColors: true,
                      readOnly: true,
                      keyboardType: TextInputType.number,
                      validator: (String? data) {
                        if (data!.isEmpty) {
                          return "required_number_of_days";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 15),
                    CustomText(
                      text: "leave_reason",
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(height: 8),
                    CommonTextFormField(
                      action: TextInputAction.done,
                      hintText: "leave_reason",
                      controller: LeaveAddPermissionController.to.leaveReason,
                      isBlackColors: true,
                      maxlines: 3,
                      validator: (String? data) {
                        if (data!.isEmpty) {
                          return "required_leave_reason";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 15),
                    CustomText(
                      text: "attachment",
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 8),
                    CommonController.to.imageLoader == true
                        ? Skeleton(
                            width: double.infinity,
                          )
                        : DottedBorder(
                            color: Colors.grey.withOpacity(0.5),
                            strokeWidth: 2,
                            dashPattern: [10, 6],
                            child: InkWell(
                              onTap: () {
                                _onImageSelectedFromGallery(
                                    LeaveAddPermissionController.to.imageName);
                                // pickFiles(
                                //     controller:
                                //         LeaveAddPermissionController.to.imageName,
                                //     binary: LeaveAddPermissionController
                                //         .to.imageFormat,
                                //     key: "");
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
                                        textSpan: 'Browser',
                                        textSpanColor: AppColors.blue),
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
                    if (LeaveAddPermissionController.to.imageName.text == "")
                      SizedBox(height: 8),
                    if (LeaveAddPermissionController.to.imageName.text.isNotEmpty)
                      SizedBox(height: 8),
                    CustomText(
                      text: LeaveAddPermissionController.to.imageName.text,
                      color: AppColors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: double.infinity / 1.2,
                      child: CommonButton(
                        text: "Submit",
                        textColor: AppColors.white,
                        buttonLoader: CommonController.to.buttonLoader,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        onPressed: () async {
                          if (formKey.currentState?.validate() == true) {
                            CommonController.to.buttonLoader = true;
                            await LeaveAddPermissionController.to
                                .addLeave(backBtnOnPressed: widget.backBtnOnPressed);
                            CommonController.to.buttonLoader = false;
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 15),
                    SizedBox(
                      // width: double.infinity / 1.2,
                      child: BackToScreen(
                          text: "cancel",
                          filled: true,
                          icon: "assets/icons/cancel.svg",
                          iconColor: AppColors.grey,
                          arrowIcon: false,
                          onPressed:(){
                            Get.back();
                          }),

                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

  _buildDisabledEndDate() {
    return TextFormField(
      validator: (String? data) {
        if (data!.isEmpty) {
          return "required_end_leave";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(15),
          isDense: false,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: AppColors.lightGrey, width: 1.7),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.lightGrey, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.lightGrey, width: 1),
          ),
          hintText: "End Date",
          // errorText: widget.errorText,
          hintStyle: TextStyle(fontSize: 14, color: AppColors.grey),
          suffixIcon: const Icon(
            Icons.calendar_today_outlined,
            size: 14,
            color: Colors.black,
          )),
      readOnly: true,
      onTap: () {
        UtilService().showToast("success", message: "Required Start Date");
      },
      //  onSaved: widget.onSaved,
    );
  }

  void _onImageSelectedFromGallery(controller) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      CommonController.to.imageLoader = true;
      controller.text = pickedFile.path ?? "";
      LeaveAddPermissionController.to.imageFormat.text = "";
      CommonController.to.imageLoader = false;
    }
  }
}
