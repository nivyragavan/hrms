import 'package:dreamhrms/controller/employee_details_controller/asset_controller.dart';
import 'package:dreamhrms/screen/off_boarding/off_boarding_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:localization/localization.dart';

import '../../../constants/colors.dart';
import '../../../widgets/Custom_rich_text.dart';
import '../../../widgets/Custom_text.dart';
import '../../../widgets/common.dart';
import '../../../widgets/common_button.dart';

class AssetsInfo extends StatelessWidget {
  const AssetsInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      
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
                  top: Get.height*0.25,
                  left: 0,
                  right: 0,
                  child: Container(
                    height:500,width: Get.width,
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: const BorderRadius.all(Radius.circular(30))),
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height:20 ),
                          CustomText(
                            text: "asset_info",
                            color: AppColors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(height: 20),
                          commonDataDisplay(
                              title1: "asset_name",
                              text1: "${AssetController.to.employeeAssetModel?.data?.data?[AssetController.to.selectedIndex].data?.asset?.category??"-"}",
                              title2: "asset_id",
                              text2: "${AssetController.to.employeeAssetModel?.data?.data?[AssetController.to.selectedIndex].data?.asset?.assetId??"-"}",
                              titleFontSize1: 13,
                              titleFontSize2: 13,
                              textFontSize1: 14,
                              textFontSize2: 14),
                          commonDataDisplay(
                              title1: "device_type",
                              text1: "${AssetController.to.employeeAssetModel?.data?.data?[AssetController.to.selectedIndex].data?.asset?.brand??"-"}",
                              title2: "serial_number",
                              text2: "${AssetController.to.employeeAssetModel?.data?.data?[AssetController.to.selectedIndex].data?.asset?.serialNumber??"-"}",
                              titleFontSize1: 13,
                              titleFontSize2: 13,
                              textFontSize1: 14,
                              textFontSize2: 14),
                          commonDataDisplay(
                              title1: "purchase_date",
                              text1: "${AssetController.to.employeeAssetModel?.data?.data?[AssetController.to.selectedIndex].data?.asset?.purchaseDate??"-"}",
                              title2: "purchase_cost",
                              text2: "${AssetController.to.employeeAssetModel?.data?.data?[AssetController.to.selectedIndex].data?.asset?.cost??"-"}",
                              titleFontSize1: 13,
                              titleFontSize2: 13,
                              textFontSize1: 14,
                              textFontSize2: 14),
                        ],
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical:20),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: CommonButton(
                      text: "report_issue",
                      textColor: AppColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
                      iconText:true,
                      icons:Icons.flag_outlined,
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
