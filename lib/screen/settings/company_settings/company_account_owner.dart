import 'package:dreamhrms/controller/theme_controller.dart';
import 'package:dreamhrms/screen/settings/company_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:localization/localization.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

import '../../../constants/colors.dart';
import '../../../controller/settings/company/company_settings.dart';
import '../../../widgets/Custom_text.dart';
import '../../../widgets/common.dart';

class CompanyAccountOwner extends StatelessWidget {
  const CompanyAccountOwner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: commonTapHandler,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Obx(()=>
          Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color:  ThemeController.to.checkThemeCondition() == true
                      ? AppColors.black
                      : AppColors.white,
              border: Border.all(
                        color: AppColors.grey.withOpacity(0.3),
                        // width: 1.0,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: CompanySettingsController.to.companyLoader?Skeleton(width: Get.width,height: 70,): Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ClipOval(
                                    child: Image.network(
                                      commonNetworkImageDisplay('${CompanySettingsController.to.companySettingsListModel?.data?.companyLogo??""}'),
                                      fit: BoxFit.cover,
                                      width: 50.0,
                                      height: 50.0,
                                    )),
                                ],
                            ),
                            SizedBox(width: 10,),
                            SizedBox(
                              width: Get.width*0.30,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: "${CompanySettingsController.to.companySettingsListModel?.data?.ownerDetails?.firstName??"-"} ${CompanySettingsController.to.companySettingsListModel?.data?.ownerDetails?.lastName??"-"}",
                                    color: AppColors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  SizedBox(height: 8),
                                  CustomText(
                                    text: "${CompanySettingsController.to.companySettingsListModel?.data?.ownerDetails?.jobTitle??"-"}",
                                    color: AppColors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            Container(
                              height: 30,width: 60,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color:  ThemeController.to.checkThemeCondition() ==
                                      true
                                      ? AppColors.green.withOpacity(0.4)
                                      : AppColors.lightGreen,
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(6))),
                              child:  CustomText(
                                text: CompanySettingsController.to.companySettingsListModel?.data?.status.toString()=="1"?"Active":"InActive",
                                color: CompanySettingsController.to.companySettingsListModel?.data?.status.toString()=="1"?AppColors.green:AppColors.red,
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                textAlign: TextAlign.center,
                              ),
                            ),

                          ],
                        ),
                        SizedBox(height: 10),
                        commonSingleDataDisplay(
                          title1: "email",
                          text1:
                          "${CompanySettingsController.to.companySettingsListModel?.data?.ownerDetails?.email??"-"}",
                          titleFontSize: 11,
                          textFontSize: 13,
                        ),
                        commonSingleDataDisplay(
                          title1: "phone_number",
                          text1:
                          "${CompanySettingsController.to.companySettingsListModel?.data?.ownerDetails?.phoneNumber??"-"}",
                          titleFontSize: 11,
                          textFontSize: 13,
                        ),
                      ],
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
