import 'package:dreamhrms/constants/colors.dart';
import 'package:dreamhrms/controller/on_boarding/on_boarding_controller.dart';
import 'package:dreamhrms/screen/employee/employee_details/profile.dart';
import 'package:dreamhrms/widgets/Custom_text.dart';
import 'package:dreamhrms/widgets/common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:localization/localization.dart';

import '../../controller/off_boarding/off_boarding_checklist_controller.dart';
import '../../controller/on_boarding/on_boarding_checklist_controller.dart';
import '../../controller/theme_controller.dart';

class DashboardRecruitment extends StatelessWidget {
  const DashboardRecruitment({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((value) async {
      await OnBoardingChecklistController.to.getChecklist();
      await OffBoardingChecklistController.to.getChecklist();
    });
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            labelColor: AppColors.blue,
            unselectedLabelColor: AppColors.grey,
            indicatorColor: AppColors.blue,
            tabs: [
              Tab(text: "Onboarding"),
              Tab(text: "Offboarding"),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            width: MediaQuery.of(context).size.width * 0.99,
            child: TabBarView(
              children: [
                buildOnboarding(context),
                buildOffBoarding(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildOnboarding(BuildContext context) {
    double itemWidth = MediaQuery.of(context).size.width * 0.65;
    return Obx(()=>
      commonLoader(
        length: 1,
        loader: OnBoardingChecklistController.to.showList,
        width: Get.width,
        singleRow: true,
        child: ListView.builder(
          itemCount: OnBoardingChecklistController.to.checklistModel?.data?.data?.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            var data = OnBoardingChecklistController.to.checklistModel?.data?.data?[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: itemWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: AppColors.grey.withOpacity(0.40)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: ClipOval(
                          child: Image.network(
                            commonNetworkImageDisplay(data?.profileImage ?? ""),
                            fit: BoxFit.cover,
                            width: 50.0,
                            height: 50.0,
                          ),
                        ),
                        title: CustomText(
                          text: "${data?.firstName} ${data?.lastName}",
                          color: AppColors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      // SizedBox(
                      //   height: 8,
                      // ),
                      Spacer(),
                      CustomText(
                        text: "Department",
                        color: AppColors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      CustomText(
                        text: "${data?.department?.departmentName.toString()}",
                        color: AppColors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      // SizedBox(
                      //   height: 12,
                      // ),
                      Spacer(),
                      CustomText(
                        text: "Team Leader",
                        color: AppColors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      CustomText(
                        text: "NA",
                        color: AppColors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      // SizedBox(height: 20),
                      Spacer(),
                      Container(
                        height: 40,
                        width: itemWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: ThemeController.to.checkThemeCondition() == true ? AppColors.grey.withOpacity(0.3) : AppColors.lightBlue,
                        ),
                        child: Center(
                          child: CustomText(
                              text: "Onboarding",
                              color: AppColors.blue,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  buildOffBoarding(BuildContext context) {
    double itemWidth = MediaQuery.of(context).size.width * 0.65;
    return Obx(()=>
        commonLoader(
          length: 1,
          loader: OffBoardingChecklistController.to.showList,
          width: Get.width,
          singleRow: true,
          child: ListView.builder(
            itemCount: OffBoardingChecklistController.to.checklistModel?.data?.data?.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              var data = OnBoardingChecklistController.to.checklistModel?.data?.data?[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: itemWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: AppColors.grey.withOpacity(0.40)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: ClipOval(
                            child: Image.network(
                              commonNetworkImageDisplay(data?.profileImage ?? ""),
                              fit: BoxFit.cover,
                              width: 50.0,
                              height: 50.0,
                            ),
                          ),
                          title: CustomText(
                            text: "${data?.firstName} ${data?.lastName}",
                            color: AppColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        // SizedBox(
                        //   height: 8,
                        // ),
                        Spacer(),
                        CustomText(
                          text: "Department",
                          color: AppColors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        CustomText(
                          text: "${data?.department?.departmentName}",
                          color: AppColors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        // SizedBox(
                        //   height: 12,
                        // ),
                        Spacer(),
                        CustomText(
                          text: "Team Leader",
                          color: AppColors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        CustomText(
                          text: "NA",
                          color: AppColors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        // SizedBox(height: 20),
                        Spacer(),
                        Container(
                          height: 40,
                          width: itemWidth,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            color: ThemeController.to.checkThemeCondition() == true ? AppColors.grey.withOpacity(0.3) : AppColors.lightBlue,
                          ),
                          child: Center(
                            child: CustomText(
                                text: "Offboarding",
                                color: AppColors.blue,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
    );
  }
}