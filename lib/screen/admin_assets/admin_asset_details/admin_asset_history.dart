import 'package:dreamhrms/controller/department/deparrtment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import '../../../constants/colors.dart';
import '../../../controller/assets/admin_asset_controller.dart';
import '../../../controller/theme_controller.dart';
import '../../../widgets/Custom_text.dart';
import '../../../widgets/common.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/no_record.dart';
import '../../employee/employee_details/profile.dart';

class AdminAssetsHistory extends StatelessWidget {
  const AdminAssetsHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((value) async => await DepartmentController.to.getDepartmentList());
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        child: Stack(
          children: [
            Image.asset(
              "assets/images/assets.png",
              fit: BoxFit.fill,
              width: Get.width,
            ),
           Positioned(
      top: Get.height * 0.25,
          left: 0,
          right: 0,
          child:getHistoryData(),
      ),

            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: CommonButton(
                  text: "report_issue".i18n(),
                  textColor: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.center,
                  iconText: true,
                  icons: Icons.flag_outlined,
                  onPressed: () {
                    // Get.to(()=>MainScreen());
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  getHistoryData(){
    return commonLoader(
      loader: AdminAssetController.to.showAssetList,
      length: 5,
      singleRow: true,
      child: SingleChildScrollView(
        child: AdminAssetController
            .to.adminAssetsListModel?.data?.data?[AdminAssetController.to.selectedIndex].assign?.length == 0 ? NoRecord():
        ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: AdminAssetController
                .to.adminAssetsListModel?.data?.data![AdminAssetController.to.selectedIndex].assign?.length ?? 0,
            itemBuilder: (context, index) {
              var data =  AdminAssetController
                  .to.adminAssetsListModel?.data?.data![AdminAssetController.to.selectedIndex].assign?[index];
              return  Container(
                height: 350,
                width: Get.width,
                decoration: BoxDecoration(
                    color: ThemeController.to.checkThemeCondition() == true ? AppColors.black : AppColors.white,
                    borderRadius:
                    const BorderRadius.all(Radius.circular(30))),
                child: Padding(
                  padding:  EdgeInsets.only(bottom: 50),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          CustomText(
                            text: "asset_history",
                            color: AppColors.black,
                            fontSize: 16,
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
                                          commonNetworkImageDisplay("${data?.createdBy?.profileImage}"),
                                          fit: BoxFit.cover,
                                          width: 38.0,
                                          height: 38.0,
                                        )),
                                    SizedBox(width: 8),
                                    commonSingleDataDisplay(
                                        title1: "owner".i18n(),
                                        text1: "${data?.createdBy?.firstName} ${data?.createdBy?.lastName}",
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
                                        commonNetworkImageDisplay("${data?.employeeId?.profileImage}"),
                                        fit: BoxFit.cover,
                                        width: 38.0,
                                        height: 38.0,
                                      )),
                                  SizedBox(width: 8),
                                  commonSingleDataDisplay(
                                    title1: "user".i18n(),
                                    text1:
                                    "${data?.employeeId?.firstName} ${data?.employeeId?.lastName}",
                                    titleFontSize: 13,
                                    textFontSize: 14,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          commonDataDisplay(
                              title1: "assignee".i18n(),
                              text1:"${data?.createdBy?.firstName} ${data?.createdBy?.lastName}",
                              title2: "given_date".i18n(),
                              text2:"${data?.assignDate}",
                              titleFontSize1: 13,
                              titleFontSize2: 13,
                              textFontSize1: 14,
                              textFontSize2: 14),
                          commonDataDisplay(
                              title1: "department".i18n(),
                              text1: "${data?.employeeId?.department?.departmentName ?? ""}",
                              title2: "position_values".i18n(),
                              text2: "${data?.employeeId?.jobPosition?.position?.positionName ?? ""}",
                              titleFontSize1: 13,
                              titleFontSize2: 13,
                              textFontSize1: 14,
                              textFontSize2: 14),
                          commonDataDisplay(
                              title1: "return_date".i18n(),
                              text1: "${data?.expectedReturnDate ?? "-"}",
                              title2: "location".i18n(),
                              text2: "${data?.employeeId?.city?.name ?? ""}",
                              titleFontSize1: 13,
                              titleFontSize2: 13,
                              textFontSize1: 14,
                              textFontSize2: 14),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
