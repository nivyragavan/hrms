import 'package:dreamhrms/widgets/no_record.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:localization/localization.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

import '../../../constants/colors.dart';
import '../../../controller/common_controller.dart';
import '../../../controller/employee/dependancy_controller.dart';
import '../../../controller/employee/employee_controller.dart';
import '../../../controller/settings/leave/annual_leave_controller.dart';
import '../../../controller/settings/notification/notification_settings_controller.dart';
import '../../../controller/signup_controller.dart';
import '../../../widgets/Custom_rich_text.dart';
import '../../../widgets/Custom_text.dart';
import '../../../widgets/back_to_screen.dart';
import '../../../widgets/common.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/common_searchable_dropdown/MainCommonSearchableDropDown.dart';
import '../../../widgets/common_textformfield.dart';
import '../../../widgets/common_timePicker.dart';
import '../../employee/employee_details/profile.dart';
import '../notification_settings.dart';

class ShiftScheduleNotification extends StatelessWidget {
  const ShiftScheduleNotification({Key? key}) : super(key: key);
  static final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((value) async {
      await NotificationSettingsController.to.getNotificationSettingsList();
    });
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                commonLoader(
                  length: 6,
                  singleRow: true,
                  loader:
                      NotificationSettingsController.to.notificationLoader ||
                          CommonController.to.toggleLoader,
                  child: NotificationSettingsController
                              .to.notificationSettingsModel?.data?.length ==
                          0
                      ? NoRecord()
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount:
                             NotificationSettingsController.to.notificationSettingsModel?.data?.where((element) => element.type=="employee").length ?? 0,
                          physics: ScrollPhysics(),
                          itemBuilder: (context, index) {
                            List<String>? text;


                            if(NotificationSettingsController.to.notificationSettingsModel?.data?[index]
                                .type ==
                                "employee"){
                              if(  NotificationSettingsController.to.notificationSettingsModel?.data?[index].duration!=null &&NotificationSettingsController.to.notificationSettingsModel?.data?[index].duration!="null"){

                                text=NotificationSettingsController.to.notificationSettingsModel?.data?[index].source?.split("0");

                            }

                            return Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                      // color: AppColors.white,
                                      border: Border.all(
                                        color:
                                        AppColors.grey.withOpacity(0.3),
                                      ),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          NotificationSettingsController.to.notificationSettingsModel?.data?[index].duration!=null && NotificationSettingsController.to.notificationSettingsModel?.data?[index].duration!="null" && text!=[]?
                                          Wrap(
                                            alignment: WrapAlignment.start,
                                            children: [
                                              CustomText(
                                                  text:
                                                  '${text?[0] ?? ""}',
                                                  color: AppColors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600),
                                              SizedBox(width: 10),
                                              SizedBox(
                                                width: 70,
                                                height: 30,
                                                child:CommonTimePicker(
                                                  controller:  TextEditingController(
                                                      text: NotificationSettingsController.to.notificationSettingsModel?.data?[index]
                                                          .duration??""),
                                                  contentPadding:false,
                                                  focusedBorder:
                                                  BorderSide(color: Colors.grey, width: 1.7),
                                                  suffixIcon:false,
                                                  disabledBorder:
                                                  BorderSide(color: Colors.black, width: 1),
                                                  // hintText: "HH:MM:SS",
                                                  timeFormat: 'HH:mm:ss',
                                                  readOnly: false,
                                                  validator: (String? data) {
                                                    if (data == "" || data == null) {
                                                      return "Required Shift Time";
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  onSaved: (values){
                                                    NotificationSettingsController.to.notificationSettingsModel?.data?[index]
                                                        .duration=values;
                                                  },
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              CustomText(
                                                  text:
                                                  '${text?[1] ?? ""}',
                                                  color: AppColors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600),
                                            ],
                                          ):
                                          CustomText(
                                              text:
                                              '${NotificationSettingsController.to.notificationSettingsModel?.data?[index].source ?? ""}',
                                              color: AppColors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                          SizedBox(height: 10),
                                          Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              notificationToggle(
                                                  text: "Email",
                                                  index: index,
                                                  value: NotificationSettingsController
                                                      .to
                                                      .notificationSettingsModel
                                                      ?.data?[index]
                                                      .push),
                                              SizedBox(width: 10),
                                              notificationToggle(
                                                  index: index,
                                                  value: NotificationSettingsController
                                                      .to
                                                      .notificationSettingsModel
                                                      ?.data?[index]
                                                      .push,
                                                  text: "Push"),
                                              SizedBox(width: 10),
                                              notificationToggle(
                                                  index: index,
                                                  value: NotificationSettingsController
                                                      .to
                                                      .notificationSettingsModel
                                                      ?.data?[index]
                                                      .sms,
                                                  text: "Text"),
                                              SizedBox(width: 10),
                                            ],
                                          )
                                        ],
                                      )),
                                )
                              );
                            }

                          }),
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: CommonButton(
                        text: "next",
                        textColor: AppColors.white,
                        fontSize: 16,
                        buttonLoader: CommonController.to.buttonLoader,
                        fontWeight: FontWeight.w500,
                        // textAlign: TextAlign.center,
                        onPressed: () async {
                          Get.back();
                          Get.to(() => NotificationSettings(selectedIndex: 1));
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
          ),
        ),
      ),
    );
  }
}
notificationToggle(
    {required String text, String? value, required int index}) {
  return Column(
    children: [
      CustomText(
          text: text,
          color: AppColors.grey,
          fontSize: 11,
          fontWeight: FontWeight.w400),
      SizedBox(height: 10),
      commonFlutterSwitch(
          width: 20,
          height: 20,
          value: getToggleController(key: text, index: index),
          onToggle: (data) async {
            NotificationSettingsController.to.notificationLoader = true;
            await  updateToggleController(key: text, value: data==true?'1':"0", index: index);
            NotificationSettingsController.to.notificationLoader = false;
          }),
    ],
  );
}
