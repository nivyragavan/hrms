import 'package:dreamhrms/model/team/admin_team_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import '../controller/employee/employee_controller.dart';
import '../controller/team_lsit_controller.dart';
import '../widgets/Custom_text.dart';
import '../widgets/common.dart';
import '../widgets/common_button.dart';
import 'employee/employee_details.dart';
import 'employee/employee_details/profile.dart';

class TeamProfileDetails extends StatelessWidget {
  final Data? profileDetails;
   TeamProfileDetails({Key? key, this.profileDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        // leading: Icon(Icons.arrow_back_ios_new_outlined,color: AppColors.black),
        title: Row(
          children: [
            navBackButton(),
            SizedBox(width: 8),
            CustomText(
              text: "profile_details",
              color: AppColors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
      body:  Container(
        width: Get.width,
        height: Get.height,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                Center(
                  child:
                  // TeamListController.to.loader == true
                  //     ? Container(
                  //         height: 92,
                  //         width: 92,
                  //         child: Skeleton(),
                  //       )
                  //     :
                  Container(
                          height: 92,
                          width: 92,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                    commonNetworkImageDisplay(
                                        '${profileDetails?.profileImage.toString()}'),
                                  ),
                                  fit: BoxFit.cover),
                              color: AppColors.white,
                              border: Border.all(
                                color: AppColors.grey,
                              ),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(14))),
                        ),
                ),
                SizedBox(height: 15),
                CustomText(
                  text:
                      '${profileDetails?.firstName} ${profileDetails?.lastName}',
                  color: AppColors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 5),
                CustomText(
                  text:
                      '${profileDetails?.department?.departmentName ?? "-"}',
                  color: AppColors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 10),
                detailsWidget(),
                SizedBox(height: 10),
                contactWidget(),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: CommonButton(
                text: "view_profile",
                textColor: AppColors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.center,
                iconText: false,
                onPressed: () {
                  EmployeeController.to.selectedUserId =
                      '${profileDetails?.jobPosition?.userId ?? null}';
                  if (EmployeeController.to.selectedUserId != null)
                    Get.to(() => EmployeeDetails());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  detailsWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: "details",
                color: AppColors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
                color: AppColors.white,
                border: Border.all(
                  color: AppColors.grey.withOpacity(0.3),
                  // width: 1.0,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(14))),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: commonLoader(
                loader: TeamListController.to.loader,
                length: 3,
                child: Column(
                  children: [
                    commonDataDisplay(
                        title1: "name",
                        text1:
                            '${profileDetails?.firstName ?? "-"} ${profileDetails?.lastName}',
                        title2: "job_title",
                        text2:
                            '${profileDetails?.jobPosition?.position?.positionName ?? "-"}'),
                    commonDataDisplay(
                        title1: "join_date",
                        text1: '${profileDetails?.createdAt?.day}-${profileDetails?.createdAt?.month}-${profileDetails?.createdAt?.year}'??"-",
                        title2: "line_manager",
                        text2: '${profileDetails?.jobPosition?.lineManager ?? "-"}',),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  contactWidget() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: "contact",
              color: AppColors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(
                color: AppColors.grey.withOpacity(0.3),
                // width: 1.0,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(14))),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: commonLoader(
              loader: TeamListController.to.loader,
              length: 3,
              child: Column(
                children: [
                  commonSingleDataDisplay(
                    title1: "mobile",
                    text1:
                        '${profileDetails?.mobileNumber ?? "-"}',
                    titleFontSize: 11,
                    textFontSize: 13,
                  ),
                  commonSingleDataDisplay(
                    title1: "email",
                    text1:
                        '${profileDetails?.personalEmail ?? "-"}',
                    titleFontSize: 11,
                    textFontSize: 13,
                  ),
                  commonSingleDataDisplay(
                    title1: "location",
                    text1: '${profileDetails?.city?.name ?? "-"}',
                    titleFontSize: 11,
                    textFontSize: 13,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
