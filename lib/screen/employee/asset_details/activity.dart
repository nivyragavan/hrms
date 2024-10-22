import 'package:dreamhrms/screen/off_boarding/off_boarding_screen.dart';
import 'package:dreamhrms/controller/employee_details_controller/asset_controller.dart';
import 'package:dreamhrms/screen/employee/employee_details/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:localization/localization.dart';

import '../../../constants/colors.dart';
import '../../../widgets/Custom_text.dart';
import '../../../widgets/common.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/no_record.dart';
import '../../../widgets/stacket_image_widget.dart';

class Activity extends StatelessWidget {
  const Activity({Key? key}) : super(key: key);

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
                Positioned(
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
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            CustomText(
                              text: "activity",
                              color: AppColors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                            SizedBox(height: 20),
                            getListData()
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

  getListData() {
    return commonLoader(
      loader: AssetController.to.showAssetList,
      length: 5,
      singleRow: true,
      child:AssetController.to.employeeAssetModel?.data?.data?.length == 0 ?
      NoRecord():
      ListView.builder(
          shrinkWrap: true,
          itemCount: AssetController.to.employeeAssetModel?.data?.data?.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            var data = AssetController.to.employeeAssetModel?.data?.data?[index];
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    // left: index!=4?BorderSide(
                    //   color: Colors.grey, // Border color
                    //   width: 1.0, // Border width
                    // ):BorderSide.none,
                  )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: data?.employee?.createdAt??"",
                      color: AppColors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        buildExpandedBox(
                          color: Colors.white,
                          children: [
                            buildStackedImages(direction: TextDirection.rtl,showCount:false,
                                images: [
                                  data?.employee?.profileImage ?? ""
                                ]),
                          ],
                        ),
                        SizedBox(width: 5),
                        commonSingleDataDisplay(
                            title1: "${data?.employee?.firstName} Shared  Edit Access to",
                            text1: "${data?.employee?.lastName}",
                            titleFontSize: 13,
                            textFontSize: 13,
                            textFontColor:AppColors.blue),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
