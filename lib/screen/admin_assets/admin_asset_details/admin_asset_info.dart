import 'package:dreamhrms/controller/employee_details_controller/asset_controller.dart';
import 'package:dreamhrms/controller/theme_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:localization/localization.dart';

import '../../../constants/colors.dart';
import '../../../controller/assets/admin_asset_controller.dart';
import '../../../widgets/Custom_rich_text.dart';
import '../../../widgets/Custom_text.dart';
import '../../../widgets/common.dart';
import '../../../widgets/common_button.dart';

class AdminAssetsInfo extends StatelessWidget {
  const AdminAssetsInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      
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
              top: Get.height*0.25,
              left: 0,
              right: 0,
              bottom: 20,
              child: Container(
                height:350,width: Get.width,
                decoration: BoxDecoration(
                    color: ThemeController.to.checkThemeCondition() == true ? AppColors.black : AppColors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(30))),
                child: Padding(
                  padding:  EdgeInsets.only(bottom: 50),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height:20 ),
                          CustomText(
                            text: "asset_info",
                            color: AppColors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(height: 20),
                          commonDataDisplay(
                              title1: "asset_name",
                              text1: "${AdminAssetController.to.adminAssetsListModel?.data?.data?[AdminAssetController.to.selectedIndex].category??"-"}",
                              title2: "asset_id",
                              text2: "${AdminAssetController.to.adminAssetsListModel?.data?.data?[AdminAssetController.to.selectedIndex].assetId??"-"}",
                              titleFontSize1: 13,
                              titleFontSize2: 13,
                              textFontSize1: 14,
                              textFontSize2: 14),
                          commonDataDisplay(
                              title1: "device_type",
                              text1: "${AdminAssetController.to.adminAssetsListModel?.data?.data?[AdminAssetController.to.selectedIndex].brand??"-"}",
                              title2: "serial_number",
                              text2: "${AdminAssetController.to.adminAssetsListModel?.data?.data?[AdminAssetController.to.selectedIndex].serialNumber??"-"}",
                              titleFontSize1: 13,
                              titleFontSize2: 13,
                              textFontSize1: 14,
                              textFontSize2: 14),
                          commonDataDisplay(
                              title1: "brand",
                              text1: "${AdminAssetController.to.adminAssetsListModel?.data?.data?[AdminAssetController.to.selectedIndex].brand??"-"}",
                              title2: "model",
                              text2: "${AdminAssetController.to.adminAssetsListModel?.data?.data?[AdminAssetController.to.selectedIndex].model??"-"}",
                              titleFontSize1: 13,
                              titleFontSize2: 13,
                              textFontSize1: 14,
                              textFontSize2: 14),
                          commonDataDisplay(
                              title1: "asset_status",
                              text1: "${AdminAssetController.to.adminAssetsListModel?.data?.data?[AdminAssetController.to.selectedIndex].status?.name??"-"}",
                              title2: "supplier",
                              text2: "${AdminAssetController.to.adminAssetsListModel?.data?.data?[AdminAssetController.to.selectedIndex].supplier??"-"}",
                              titleFontSize1: 13,
                              titleFontSize2: 13,
                              textFontSize1: 14,
                              textFontSize2: 14),
                          commonDataDisplay(
                              title1: "purchase_date",
                              text1: "${AdminAssetController.to.adminAssetsListModel?.data?.data?[AdminAssetController.to.selectedIndex].purchaseDate??"-"}",
                              title2: "purchase_cost",
                              text2: "${AdminAssetController.to.adminAssetsListModel?.data?.data?[AdminAssetController.to.selectedIndex].cost??"-"}",
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30,vertical:0),
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
}
