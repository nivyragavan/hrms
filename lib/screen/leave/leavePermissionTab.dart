import 'package:flutter/cupertino.dart';
import 'package:dreamhrms/controller/employee_details_controller/time_off_controller.dart';
import 'package:dreamhrms/screen/employee/employee_details/profile.dart';
import 'package:dreamhrms/screen/employee/employee_details/time_off_tabs/leave_tab_screen.dart';
import 'package:dreamhrms/screen/employee/employee_details/time_off_tabs/permission_tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:localization/localization.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

import '../../constants/colors.dart';
import '../../../controller/leave_add_permission_controller.dart';
import '../../../widgets/Custom_text.dart';
import '../../../widgets/common.dart';
import '../../controller/theme_controller.dart';

class LeavePermissionTab extends StatelessWidget {
  const LeavePermissionTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((value) async {
      // await TimeOffController.to.getTimeOffList();
    });
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        
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
                    text: "leave_history",
                    color: AppColors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Obx(
                () => SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: commonLoader(
                  length: MediaQuery.of(context).size.height.toInt(),
                  loader: TimeOffController.to.showTimeOffList,
                  singleRow: true,
                  child: Container(
                    height: Get.height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            color: ThemeController.to.checkThemeCondition() == true ? AppColors.grey.withOpacity(0.3) : AppColors.lightWhite,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: TabBar(
                              labelColor: AppColors.lightWhite,
                              unselectedLabelColor: AppColors.blue,
                              indicator: BoxDecoration(
                                gradient: AppColors.primaryColor1,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              controller: TimeOffController.to.tabController,
                              tabs: [
                                Tab(text: 'Leave'),
                                Tab(text: 'Permission'),
                              ]),
                        ),
                        Expanded(
                          child: TabBarView(children: [
                            LeaveTabScreen(),
                            PermissionTabScreen()
                          ]),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
