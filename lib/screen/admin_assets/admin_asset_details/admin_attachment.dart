import 'package:dreamhrms/constants/colors.dart';
import 'package:dreamhrms/screen/employee/employee_details/profile.dart';
import 'package:dreamhrms/widgets/no_record.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:localization/localization.dart';

import '../../../controller/assets/admin_asset_controller.dart';
import '../../../controller/theme_controller.dart';
import '../../../widgets/Custom_text.dart';
import '../../../widgets/common_button.dart';

class AdminAttachment extends StatelessWidget {
  const AdminAttachment({Key? key}) : super(key: key);

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
                        color: ThemeController.to.checkThemeCondition() == true ? AppColors.black : AppColors.white,
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
                            text: "attachment",
                            color: AppColors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(height: 20),
                          //getImageList(),
                          commonLoader(
                            length: 6,
                            loader: AdminAssetController.to.showAssetList,
                            child:AdminAssetController
                                .to.adminAssetsListModel?.data?.data![AdminAssetController.to.selectedIndex].attachment?.fileName == null ?
                            NoRecord():
                            Container(
                              height: 115,
                              width: Get.width*0.40,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          AdminAssetController.to.adminAssetsListModel?.data?.data?[AdminAssetController.to.selectedIndex].attachment?.fileName??""),  fit: BoxFit.cover),
                                  color: AppColors.white,
                                  border: Border.all(
                                    color: AppColors.grey,
                                  ),
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(8))),
                            ),
                          ),
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
                        // Get.to(()=>MainScreen());
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


  getImageList(){
    return  Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: 2,//AdminAssetController.to.adminAssetsListModel?.data?.data?[AdminAssetController.to.selectedIndex].asset?.attachment!.length??0,//attachment
          itemBuilder: (context, index) {
             return  Padding(
              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
              child: Row(
                children: [
                  Container(
                    height: 115,
                    width: Get.width*0.40,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                              "https://my-media.apjonlinecdn.com/magefan_blog/5_Components_Of_A_Computer_And_Their_Benefits.jpg"),  fit: BoxFit.cover),
                        color: AppColors.white,
                        // border: Border.all(
                        //   color: AppColors.grey,
                        // ),
                        borderRadius:
                        const BorderRadius.all(Radius.circular(8))),
                  ),
                  SizedBox(width: 10),
                  Container(
                    height: 115,
                    width: 160,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyx2HIw5F6Yw-a6-5k6Qo9NM1A8GsXOCapnQ&usqp=CAU"), fit: BoxFit.cover),
                        color: AppColors.white,
                        // border: Border.all(
                        //   color: AppColors.grey,
                        // ),
                        borderRadius:
                        const BorderRadius.all(Radius.circular(8))),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
