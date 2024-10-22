import 'package:dreamhrms/widgets/common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

import '../../constants/colors.dart';
import '../../controller/common_controller.dart';
import '../../controller/settings/system/system_settings_controller.dart';
import '../../widgets/Custom_rich_text.dart';
import '../../widgets/Custom_text.dart';
import '../../widgets/back_to_screen.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_searchable_dropdown/MainCommonSearchableDropDown.dart';

class SystemSettings extends StatelessWidget {
  const SystemSettings({Key? key}) : super(key: key);
  static final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((value) async {
      await SystemSettingsController.to.clearValues();
      await SystemSettingsController.to.timeZoneList();
      await SystemSettingsController.to.systemList();
      await SystemSettingsController.to.dateTimeFormatList();
      await SystemSettingsController.to.languageList();
      await SystemSettingsController.to.currencyList();

    });
    return Scaffold(
        
        appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          title: Row(
            children: [
              navBackButton(),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: CustomText(
                    text: "system_settings",
                    color: AppColors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.start),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Obx(
              () => Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomRichText(
                        textAlign: TextAlign.left,
                        text: "time_zone",
                        color: AppColors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        textSpan: ' *',
                        textSpanColor: AppColors.red),
                    SizedBox(height: 5),
                    SystemSettingsController.to.systemSettingsLoader == true
                        ? Skeleton(
                            height: 35,
                            width: Get.width,
                          )
                        : MainSearchableDropDown(
                            title: 'timezone_name',
                            title1: 'alias_name',
                            isRequired: true,
                            error: "time_zone",
                            items: SystemSettingsController
                                .to.timeZoneListModel?.data
                                ?.map((datum) => datum.toJson())
                                .toList(),
                            controller:
                                SystemSettingsController.to.timeZoneController,
                            onChanged: (data) {
                              SystemSettingsController.to
                                .timeZoneIdController.text =
                                    data['id'].toString();
                            },
                          ),
                    SizedBox(height: 10),
                    CustomRichText(
                        textAlign: TextAlign.left,
                        text: "short_date_format",
                        color: AppColors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        textSpan: ' *',
                        textSpanColor: AppColors.red),
                    SizedBox(height: 5),
                    SystemSettingsController.to.systemSettingsLoader == true
                        ? Skeleton(
                            height: 35,
                            width: Get.width,
                          )
                        : MainSearchableDropDown(
                            title: 'format',
                            isRequired: true,
                            error:"short_date_format",
                            items: SystemSettingsController
                                .to.dateTimeFormatListModel?.data?.dateFormat
                                ?.map((datum) => datum.toJson())
                                .toList(),
                            controller:
                                SystemSettingsController.to.dateFormatController,
                            onChanged: (data) {
                              SystemSettingsController.to.dateFormatIdController
                                  .text = data['id'].toString();
                            },
                          ),
                    SizedBox(height: 10),
                    CustomRichText(
                        textAlign: TextAlign.left,
                        text: "day_week",
                        color: AppColors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        textSpan: ' *',
                        textSpanColor: AppColors.red),
                    SizedBox(height: 5),
                    SystemSettingsController.to.systemSettingsLoader == true
                        ? Skeleton(
                            height: 35,
                            width: Get.width,
                          )
                        : MainSearchableDropDown(
                            title: 'days',
                            // hint: "hint_day_week",
                            isRequired: true,
                            error: "day_week",
                            items: [
                              {"days":'Sunday'},
                              {"days":'Monday'},
                              {"days":'Tuesday'},
                              {"days":'Wednesday'},
                              {"days":'Thursday'},
                              {"days":'Friday'},
                              {"days":'Saturday'},
                            ],
                            controller:
                                SystemSettingsController.to.weekController,
                            onChanged: (data) {},
                          ),
                    SizedBox(height: 10),
                    CustomRichText(
                        textAlign: TextAlign.left,
                        text: "time_format",
                        color: AppColors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        textSpan: ' *',
                        textSpanColor: AppColors.red),
                    SizedBox(height: 5),
                    SystemSettingsController.to.systemSettingsLoader == true
                        ? Skeleton(
                            height: 35,
                            width: Get.width,
                          )
                        : MainSearchableDropDown(
                            title: 'format',
                            // hint: "hint_time_format",
                            isRequired: true,
                            error:  "time_format",
                            items: SystemSettingsController
                                .to.dateTimeFormatListModel?.data?.timeformat
                                ?.map((datum) => datum.toJson())
                                .toList(),
                            controller:
                                SystemSettingsController.to.timeFormatController,
                            onChanged: (data) {
                              SystemSettingsController.to.timeFormatIdController
                                  .text = data['id'].toString();
                            },
                          ),
                    SizedBox(height: 10),
                    CustomRichText(
                        textAlign: TextAlign.left,
                        text: "language",
                        color: AppColors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        textSpan: ' *',
                        textSpanColor: AppColors.red),
                    SizedBox(height: 5),
                    SystemSettingsController.to.systemSettingsLoader == true
                        ? Skeleton(
                            height: 35,
                            width: Get.width,
                          )
                        : MainSearchableDropDown(
                            title: 'name',
                            // hint: "hint_language",
                            isRequired: true,
                            error: "language",
                            items: SystemSettingsController
                                .to.languageListModel?.data
                                ?.map((datum) => datum.toJson())
                                .toList(),
                            controller:
                                SystemSettingsController.to.languageController,
                            onChanged: (data) {
                              SystemSettingsController.to.languageIdController
                                  .text = data['id'].toString();
                            },
                          ),
                    SizedBox(height: 10),
                    CustomRichText(
                        textAlign: TextAlign.left,
                        text: "currency",
                        color: AppColors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        textSpan: ' *',
                        textSpanColor: AppColors.red),
                    SizedBox(height: 5),
                    SystemSettingsController.to.systemSettingsLoader == true
                        ? Skeleton(
                            height: 35,
                            width: Get.width,
                          )
                        : MainSearchableDropDown(
                            title: 'name',
                            // hint: "hint_currency",
                            isRequired: true,
                            error:  "currency",
                            items: SystemSettingsController
                                .to.currencyListModel?.data
                                ?.map((datum) => datum.toJson())
                                .toList(),
                            controller:
                                SystemSettingsController.to.currencyController,
                            onChanged: (data) {
                              SystemSettingsController.to.currencyIdController
                                  .text = data['id'].toString();
                            },
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
                              CommonController.to.buttonLoader = true;
                              if (formKey.currentState!.validate()) {
                              await (SystemSettingsController.to.systemSettingsListModel?.data?.length!=0 &&
                                    SystemSettingsController.to.systemSettingsListModel?.data != null)
                                    ? await SystemSettingsController.to.saveSystemSettings(option:'edit'):
                                     await SystemSettingsController.to.saveSystemSettings(option:"add");
                              await SystemSettingsController.to.systemList();
                              }
                              CommonController.to.buttonLoader = false;
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
        ));
  }
}
