
import 'package:dreamhrms/controller/theme_controller.dart';
import 'package:dreamhrms/screen/settings/approval_settings/leave_approval.dart';
import 'package:dreamhrms/screen/settings/company_settings.dart';
import 'package:dreamhrms/screen/settings/dashboard_settings/dashboard_settings.dart';
import 'package:dreamhrms/screen/settings/leave_settings.dart';
import 'package:dreamhrms/screen/settings/notification_settings.dart';
import 'package:dreamhrms/screen/settings/role_settings/role.dart';
import 'package:dreamhrms/screen/settings/system_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

import '../constants/colors.dart';
import '../controller/common_controller.dart';
import '../controller/settings/company/company_settings.dart';
import '../controller/settings/settings.dart';
import '../services/provision_check.dart';
import '../services/utils.dart';
import '../widgets/Custom_rich_text.dart';
import '../widgets/Custom_text.dart';
import '../widgets/back_to_screen.dart';
import '../widgets/common_button.dart';
import '../widgets/common_searchable_dropdown/MainCommonSearchableDropDown.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((value) async {
      SettingsController.to.branchLoader = true;
      SettingsController.to.branch.text="";
      await SettingsController.to.getBranchList();
      // SettingsController.to.branchLoader = false;
    });
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: CustomText(
            text: "settings",
            color: AppColors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            appBar: true),
        actions: [
         ObxValue(
            (data) =>Padding(
              padding: const EdgeInsets.only(right: 20),
              child: FlutterSwitch(
                  height: 25,
                  width: 50,
                  padding: 2,
                  valueFontSize: 11,
                  activeColor: AppColors.blue,
                  activeTextColor: AppColors.grey,
                  inactiveColor: AppColors.lightGrey,
                  inactiveTextColor: AppColors.grey,
                  value: ThemeController.to.isDarkTheme,
                  onToggle: (val) {
                    ThemeController.to.isDarkTheme = val;
                    Get.changeThemeMode(
                      ThemeController.to.isDarkTheme
                          ? ThemeMode.dark
                          : ThemeMode.light,
                    );
                    ThemeController.to.saveThemeStatus();
                  }),
            ),
            false.obs,
          )
        ],
      ),
      body: Obx(
        () => Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomRichText(
                    textAlign: TextAlign.left,
                    text: "settings_title",
                    color: AppColors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    textSpan: ' *',
                    textSpanColor: AppColors.red),
                SizedBox(height: 10),
                SettingsController.to.branchLoader == true
                    ? Skeleton(height: 35, width: Get.width)
                    : MainSearchableDropDown(
                        title: 'office_name',
                        title1: 'office_fulladdress',
                        hint: "branch_hint",
                        items: SettingsController.to.branchListModel?.data
                                ?.where((datum) => datum.deletedAt == null)
                                .map((datum) => datum.toJson())
                                .toList() ??
                            [],
                        controller: SettingsController.to.branch,
                        onChanged: (data) {
                          SettingsController.to.branchId.text =
                              data['id'].toString();
                          print("test data response $data");
                        }),
                getList(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getList(BuildContext context) {
    return  ViewProvisionedWidget(provision: "settings", type: "view",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widgets(
              image: "assets/icons/notes.svg",
              title: "company_setting",
              text: "Loreum ipsum dolor sit ament, consectetur",
              onPressed: () {
                Get.to(() => CompanySettings());
                CompanySettingsController.to.getInitialize();
              }),
          widgets(
              image: "assets/icons/notes.svg",
              title: "system_setting",
              text: "Loreum ipsum dolor sit ament, consectetur",
              onPressed: () {
                Get.to(() => SystemSettings());
              }),
          widgets(
              image: "assets/icons/notification.svg",
              title: "notification_setting",
              text: "Loreum ipsum dolor sit ament, consectetur",
              onPressed: () {
                Get.to(() => NotificationSettings());
              }),
          widgets(
              image: "assets/icons/flag.svg",
              title: "role_privileges",
              text: "Loreum ipsum dolor sit ament, consectetur",
              onPressed: () {
                Get.to(() => RoleSettings());
              },
            ),
          widgets(
              image: "assets/icons/dahsboard_icon.svg",
              title: "dashboard_settings",
              text: "Loreum ipsum dolor sit ament, consectetur",
              onPressed: () {
                Get.to(() => DashBoardSettings());
              },
          ),
          widgets(
              image: "assets/icons/out.svg",
              title: "leave_setting",
              text: "Loreum ipsum dolor sit ament, consectetur",
              onPressed: () {
                Get.to(() => LeaveSettings());
              }),
          widgets(
              image: "assets/icons/thumbsUp.svg",
              title: "approval_setting",
              text: "Loreum ipsum dolor sit ament, consectetur",
              onPressed: () {
                Get.to(() => LeaveApproval());
              }),
          widgets(
              image: "assets/icons/trash.svg",
              title: "delete_setting",
              text: "Loreum ipsum dolor sit ament, consectetur",
              onPressed: () {
                showAlertDialog(context);
              }),
        ],
      ),
    );
  }

  Widget widgets(
      {required String image,
      required String title,
      required text,
      required Null Function() onPressed,
      bool? validation = true}) {
    return InkWell(
        onTap: () {
          if (validation == true) {
            if (SettingsController.to.branchId.text != "") {
              onPressed();
            } else {
              UtilService()
                  .showToast("error", message: "Choose the Branch".toString());
            }
          } else {
            onPressed();
          }
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 15),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.lightGrey),
              borderRadius: BorderRadius.circular(8)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 38,
                width: 38,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: ThemeController.to.checkThemeCondition() == true ? AppColors.lightWhite.withOpacity(0.3) : AppColors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8)),
                child: SvgPicture.asset(
                  image,
                  width: 17,
                  height: 17,
                  color: ThemeController.to.checkThemeCondition() == true ? AppColors.white : AppColors.black,
                ),
              ), //
              SizedBox(width: 10),
              Expanded(
                child: CustomText(
                  text: title,
                  color: AppColors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ));
  }

  showAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //delete_blue.svg
                SvgPicture.asset(
                  'assets/icons/delete_blue.svg',
                ),
                SizedBox(height: 10),
                CustomText(
                  text: "delete_organization",
                  color: AppColors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 8),
                RichText(
                    text: TextSpan(
                        text: "delete_alert",
                        style: TextStyle(
                            color: AppColors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                        children: [
                      TextSpan(
                          text: " ${SettingsController.to.branch.text??""}",
                          style: TextStyle(
                              color: ThemeController.to.checkThemeCondition() == true ? AppColors.white : AppColors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500)),
                      TextSpan(
                          text: " ${"business_org"}",
                          style: TextStyle(
                              color: AppColors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w500))
                    ])),
                SizedBox(height: 15),
                Obx(
                  () =>
                      ProvisionsWithIgnorePointer(
                    provision: 'Settings',
                    type: "delete",
                    child: SizedBox(
                      width: double.infinity / 1.2,
                      child: CommonButton(
                        text: "delete",
                        textColor: AppColors.white,
                        fontSize: 16,
                        buttonLoader: CommonController.to.buttonLoader,
                        fontWeight: FontWeight.w500,
                        onPressed: () async {
                          CommonController.to.buttonLoader = true;
                          await SettingsController.to.organizationDelete();
                          CommonController.to.buttonLoader = false;
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                BackToScreen(text: "cancel", arrowIcon: false, onPressed: (){Get.back();})
              ],
            ),
          );
        });
  }




}
