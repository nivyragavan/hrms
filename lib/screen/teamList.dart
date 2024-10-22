import 'package:dreamhrms/screen/team_profile.dart';
import 'package:dreamhrms/widgets/animator_rotate.dart';
import 'package:dreamhrms/widgets/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';

import '../constants/colors.dart';
import '../controller/employee_details_controller/team_controller.dart';
import '../widgets/Custom_text.dart';
import '../widgets/MultiExpansion.dart';
import '../widgets/no_record.dart';
import 'employee/employee_details/profile.dart';

class AdminTeams extends StatelessWidget {
  const AdminTeams({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((value) async {
      // await TeamController.to.getTeam();
      await TeamController.to.getAdminTeamList();
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
              text: "teams",
              color: AppColors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Obx(
            () => Column(
              children: [
                commonLoader(
                  loader: TeamController.to.showTeamList,
                  length: MediaQuery.of(context).size.height.toInt(),
                  singleRow: true,
                  child: TeamController
                              .to.adminTeamsModel?.data?.data == null
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
                                              '${TeamController.to.adminTeamsModel?.data?.data?.firstName ?? "-"} ${TeamController.to.adminTeamsModel?.data?.data?.lastName ?? "-"}',
                                          color: AppColors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        subTitle: CustomText(
                                          textAlign: TextAlign.start,
                                          text:
                                              "${TeamController.to.adminTeamsModel?.data?.data?.department?.departmentName ?? "-"}",
                                          color: AppColors.grey,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        image: Image.network(
                                            commonNetworkImageDisplay(
                                                '${TeamController.to.adminTeamsModel?.data?.data?.profileImage}'),
                                            fit: BoxFit.cover,
                                            width: 40.0,
                                            height: 40.0),
                                        expansionList: TeamController
                                            .to
                                            .adminTeamsModel
                                            ?.data
                                            ?.data!
                                            .children,
                                        editIcon: SvgPicture.asset(
                                            "assets/icons/eye_open.svg"),
                                        value: "Team",
                                        editicon: false,
                                        editOnPressed: () async {},
                                        ContainerOnClick: () {
                                          Get.to(()=>TeamProfileDetails(profileDetails:TeamController.to.adminTeamsModel?.data?.data));
                                          // Get.toNamed('/TeamProfile',
                                          //     arguments: TeamController.to.adminTeamsModel?.data?.data);
                                        }),
                                  ),
                                ],
                              ),
                            );
                          }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
