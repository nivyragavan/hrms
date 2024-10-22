import 'package:dreamhrms/screen/settings/notification_settings/shift_schedule_notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:localization/localization.dart';

import '../../../constants/colors.dart';
import '../../../controller/common_controller.dart';
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
import '../../../widgets/no_record.dart';
import '../../employee/employee_details/profile.dart';

class ManagerAlerts extends StatelessWidget {
  const ManagerAlerts({Key? key}) : super(key: key);
  static final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Obx(
                () =>
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    commonLoader(
                      length: 2,
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
                          NotificationSettingsController.to.notificationSettingsModel?.data?.length ?? 0,
                          physics: ScrollPhysics(),
                          itemBuilder: (context, index) {
                            print("length ${NotificationSettingsController.to.notificationSettingsModel?.data?.length}");
                            print("NotificationSettingsCont${NotificationSettingsController.to.notificationSettingsModel?.data?[index].type}");
                            return Visibility(
                              visible: NotificationSettingsController.to.notificationSettingsModel?.data?[index].type=="manager",
                              child: Padding(
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
                              ),
                            );
                            // if(NotificationSettingsController.to.notificationSettingsModel?.data?[index]
                            //     .type == "manager"){
                            //   return Padding(
                            //       padding: EdgeInsets.symmetric(vertical: 10),
                            //       child: Container(
                            //         decoration: BoxDecoration(
                            //             color: AppColors.white,
                            //             border: Border.all(
                            //               color:
                            //               AppColors.grey.withOpacity(0.3),
                            //             ),
                            //             borderRadius: const BorderRadius.all(
                            //                 Radius.circular(10))),
                            //         child: Padding(
                            //             padding: EdgeInsets.symmetric(
                            //                 horizontal: 20, vertical: 10),
                            //             child: Column(
                            //               crossAxisAlignment:
                            //               CrossAxisAlignment.start,
                            //               children: [
                            //                 CustomText(
                            //                     text:
                            //                     '${NotificationSettingsController.to.notificationSettingsModel?.data?[index].source ?? ""}',
                            //                     color: AppColors.black,
                            //                     fontSize: 14,
                            //                     fontWeight: FontWeight.w600),
                            //                 SizedBox(height: 10),
                            //                 Row(
                            //                   crossAxisAlignment:
                            //                   CrossAxisAlignment.start,
                            //                   mainAxisAlignment:
                            //                   MainAxisAlignment
                            //                       .spaceBetween,
                            //                   children: [
                            //                     notificationToggle(
                            //                         text: "Email",
                            //                         index: index,
                            //                         value: NotificationSettingsController
                            //                             .to
                            //                             .notificationSettingsModel
                            //                             ?.data?[index]
                            //                             .push),
                            //                     SizedBox(width: 10),
                            //                     notificationToggle(
                            //                         index: index,
                            //                         value: NotificationSettingsController
                            //                             .to
                            //                             .notificationSettingsModel
                            //                             ?.data?[index]
                            //                             .push,
                            //                         text: "Push"),
                            //                     SizedBox(width: 10),
                            //                     notificationToggle(
                            //                         index: index,
                            //                         value: NotificationSettingsController
                            //                             .to
                            //                             .notificationSettingsModel
                            //                             ?.data?[index]
                            //                             .sms,
                            //                         text: "Text"),
                            //                     SizedBox(width: 10),
                            //                   ],
                            //                 )
                            //               ],
                            //             )),
                            //       )
                            //   );
                            // }
                          }),
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
                              CommonController.to.buttonLoader=true;
                              await NotificationSettingsController.to
                                  .uploadNotificationSettings();
                              CommonController.to.buttonLoader=false;
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



