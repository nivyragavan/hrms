import 'package:dreamhrms/screen/employee/employee_details/profile.dart';
import 'package:dreamhrms/widgets/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:localization/localization.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

import '../../../constants/colors.dart';
import '../../../controller/common_controller.dart';
import '../../../controller/employee/employee_controller.dart';
import '../../../controller/settings/dashboard_settings_controller.dart';
import '../../../widgets/Custom_rich_text.dart';
import '../../../widgets/Custom_text.dart';
import '../../../widgets/back_to_screen.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/common_searchable_dropdown/MainCommonSearchableDropDown.dart';
import '../../../widgets/no_record.dart';

class DashBoardSettings extends StatelessWidget {
  DashBoardSettings({Key? key}) : super(key: key);

  List Dashboard = [
    {"title": "Leave Report", "status": 1},
    {"title": "Leave Request", "status": 1},
    {"title": "Job Vacancy Summary", "status": 1},
    {"title": "Online Summary", "status": 1},
    {"title": "Attendance Report", "status": 1},
    {"title": "Ticket Raised", "status": 1},
    {"title": "Events", "status": 1},
    {"title": "Recruitment", "status": 1},
    {"title": "My Team members", "status": 1},
    {"title": "Announcement", "status": 1},
    {"title": "Working Format", "status": 1},
    {"title": "Employee Report", "status": 1},
  ];

  @override
  Widget build(BuildContext context) {
    DashBoardSettingsController.to.dashboardSetting = true;
    Future.delayed(Duration.zero).then((value) async {
      await EmployeeController.to.getRoleList();
      DashBoardSettingsController.to.dashboardSetting = false;
    });
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            navBackButton(),
            SizedBox(width: 8),
            CustomText(
              text: "dashboard_settings",
              color: AppColors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomRichText(
                    textAlign: TextAlign.left,
                    text: "role",
                    color: AppColors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    textSpan: ' *',
                    textSpanColor: AppColors.red),
                SizedBox(height: 5),
                EmployeeController.to.roleLoader == true
                    ? Skeleton(
                        height: 35,
                        width: Get.width,
                      )
                    : MainSearchableDropDown(
                        title: 'name',
                        // hint: "Select Role",
                        filled: true,
                        fillColor: AppColors.white,
                        isRequired: true,
                        error: "role",
                        items: EmployeeController.to.roleModel?.data?.data
                            ?.map((dataum) => dataum.toJson())
                            .toList(),
                        controller:
                            DashBoardSettingsController.to.roleController,
                        onChanged: (data) async {
                          DashBoardSettingsController.to.roleIdController.text =
                              data['id'].toString();
                          await DashBoardSettingsController.to
                              .getDashboardSettingsList();
                        }),
                SizedBox(height: 10),
                CustomText(
                  text: "widgets",
                  color: AppColors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 10),
                // Obx(() =>
                commonLoader(
                  length: MediaQuery.of(context).size.height.toInt(),
                  singleRow: true,
                  loader: DashBoardSettingsController.to.dashboardSetting,
                  child: DashBoardSettingsController.to
                              .dashboardSettingsListModel?.data?.data?.length ==
                          0
                      ? NoRecord()
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: DashBoardSettingsController
                                  .to
                                  .dashboardSettingsListModel
                                  ?.data
                                  ?.data
                                  ?.length ??
                              0,
                          itemBuilder: (context, index) {
                            final dashboardList = DashBoardSettingsController.to
                                .dashboardSettingsListModel?.data?.data?[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                        text:
                                            '${dashboardList?.type ?? ""}',
                                        color: AppColors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      commonFlutterSwitch(
                                          width: 20,
                                          height: 20,
                                          value: dashboardList?.status ==
                                                      null ||
                                                  dashboardList?.status == 0 ||
                                                  dashboardList?.status == "0"
                                              ? "0"
                                              : dashboardList?.status
                                                  .toString(),
                                          onToggle: (data) async {
                                            DashBoardSettingsController
                                                .to.dashboardSetting = true;
                                            dashboardList?.status =
                                                data == true ? "1" : "0";
                                            DashBoardSettingsController
                                                .to.dashboardSetting = false;
                                          }),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Visibility(
                                    visible: DashBoardSettingsController
                                        .to
                                        .dashboardSettingsListModel
                                        ?.data
                                        ?.data
                                        ?.length != index + 1,
                                    child: Divider(
                                      color: AppColors.grey.withOpacity(0.10),
                                      thickness: 2,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                ),
                // ),
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
                          await DashBoardSettingsController.to
                              .postDashboardSettings();
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
    );
  }
}
