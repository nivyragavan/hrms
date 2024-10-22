import 'package:dreamhrms/constants/colors.dart';
import 'package:dreamhrms/controller/theme_controller.dart';
import 'package:dreamhrms/screen/employee/employee_details/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:localization/localization.dart';

import '../../../controller/employee_details_controller/team_controller.dart';
import '../../../widgets/Custom_text.dart';
import '../../../widgets/MultiExpansion.dart';
import '../../../widgets/common.dart';
import '../../../widgets/no_record.dart';

class EmployeeTeams extends StatelessWidget {
  const EmployeeTeams({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      await TeamController.to.getEmployeeTeamList();
    });
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "teams",
                  color: AppColors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 20),
                getListData(context)

              ],
            ),
          ),
        ),
      ),
    );
  }

  getListData(BuildContext context){
    return  Obx(() =>
        commonLoader(
          loader: TeamController.to.showTeamList,
          length: MediaQuery.of(context).size.height.toInt(),
          singleRow: true,
          child: TeamController
              .to.employeeTeamModel?.data?.data == null
              ? NoRecord()
              : ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: 1,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        child: MultiExpansionTileWidget(
                            mainIndex: index,
                            title: CustomText(
                              text:
                              '${TeamController.to.employeeTeamModel?.data?.data?.firstName ?? "-"} ${TeamController.to.employeeTeamModel?.data?.data?.lastName ?? "-"}',
                              color: AppColors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            subTitle: CustomText(
                              textAlign: TextAlign.start,
                              text:
                              "${TeamController.to.employeeTeamModel?.data?.data?.department?.departmentName ?? "-"}",
                              color: AppColors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            image: Image.network(
                                commonNetworkImageDisplay(
                                    '${TeamController.to.employeeTeamModel?.data?.data?.profileImage}'),
                                fit: BoxFit.cover,
                                width: 40.0,
                                height: 40.0),
                            expansionList: TeamController
                                .to
                                .employeeTeamModel
                                ?.data
                                ?.data!
                                .children,
                            editIcon: SvgPicture.asset(
                                "assets/icons/eye_open.svg"),
                            value: "Team",
                            editicon: false,
                            editOnPressed: () async {},
                            ContainerOnClick: () {
                              //   Get.toNamed('/TeamProfile',
                              //       arguments: index);
                            }
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ));
  }
}
