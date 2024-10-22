import 'package:dreamhrms/screen/off_boarding/off_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';

import '../../../constants/colors.dart';
import '../../../controller/employee_details_controller/asset_controller.dart';
import '../../../widgets/Custom_text.dart';
import '../../../widgets/common.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/no_record.dart';
import '../employee_details/profile.dart';

class AssetsHistory extends StatelessWidget {
  const AssetsHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Container(
            width: Get.width,
            height: Get.height,
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/assets.png",
                  fit: BoxFit.fill,
                  width: Get.width,
                ),
                commonLoader(
                  loader: AssetController.to.showAssetList,
                  length: 5,
                  singleRow: true,
                  child:AssetController.to.employeeAssetModel?.data?.data?.length == 0 ?
                  NoRecord():  Positioned(
                    top: Get.height * 0.25,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 500,
                      width: Get.width,
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30))),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            CustomText(
                              text: "asset_history".i18n(),
                              color: AppColors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                SizedBox(
                                  width: Get.width * 0.40,
                                  child: Row(
                                    children: [
                                      ClipOval(
                                          child: Image.network(
                                            commonNetworkImageDisplay("${AssetController.to.employeeAssetModel?.data?.data?[AssetController.to.selectedIndex].employee?.profileImage}"),
                                         fit: BoxFit.cover,
                                        width: 38.0,
                                        height: 38.0,
                                      )),
                                      SizedBox(width: 8),
                                      commonSingleDataDisplay(
                                          title1: "owner".i18n(),
                                          text1: "${AssetController.to.employeeAssetModel?.data?.data?[AssetController.to.selectedIndex].assignedBy?.firstName??"-"} ${AssetController.to.employeeAssetModel?.data?.data?[AssetController.to.selectedIndex].assignedBy?.lastName??""}",
                                          titleFontSize: 13,
                                          textFontSize: 14),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10),
                                Row(
                                  children: [
                                    ClipOval(
                                        child: Image.network(
                                          commonNetworkImageDisplay("${AssetController.to.employeeAssetModel?.data?.data?[AssetController.to.selectedIndex].employee?.profileImage}"),
                                          fit: BoxFit.cover,
                                      width: 38.0,
                                      height: 38.0,
                                    )),
                                    SizedBox(width: 8),
                                    commonSingleDataDisplay(
                                      title1: "user".i18n(),
                                      text1:
                                          "${AssetController.to.employeeAssetModel?.data?.data?[AssetController.to.selectedIndex].employee?.firstName ?? "-"} ${AssetController.to.employeeAssetModel?.data?.data?[AssetController.to.selectedIndex].employee?.lastName ?? "-"}",
                                      titleFontSize: 13,
                                      textFontSize: 14,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            commonDataDisplay(
                                title1: "assignee".i18n(),
                                text1:
                                    '${AssetController.to.employeeAssetModel?.data?.data?[AssetController.to.selectedIndex].assignedBy?.firstName ?? "-"} ${AssetController.to.employeeAssetModel?.data?.data?[AssetController.to.selectedIndex].assignedBy?.lastName ?? ""}',
                                title2: "given_date".i18n(),
                                text2:
                                    '${AssetController.to.employeeAssetModel?.data?.data?[AssetController.to.selectedIndex].data?.assignDate ?? "-"}',
                                titleFontSize1: 13,
                                titleFontSize2: 13,
                                textFontSize1: 14,
                                textFontSize2: 14),
                            commonDataDisplay(
                                title1: "return_date".i18n(),
                                text1:
                                    "${AssetController.to.employeeAssetModel?.data?.data?[AssetController.to.selectedIndex].data?.expectedReturnDate ?? "-"}",
                                title2: "location".i18n(),
                                text2: "${AssetController.to.employeeAssetModel?.data?.data?[AssetController.to.selectedIndex].employee?.city?.name ?? "-"}",
                                titleFontSize1: 13,
                                titleFontSize2: 13,
                                textFontSize1: 14,
                                textFontSize2: 14),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: CommonButton(
                      text: "report_issue",
                      textColor: AppColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
                      iconText: true,
                      icons: Icons.flag_outlined,
                      onPressed: () {
                        Get.to(()=>OffBoardingScreen());
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
