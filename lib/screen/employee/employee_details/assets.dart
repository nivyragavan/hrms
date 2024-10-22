import 'package:dreamhrms/screen/admin_assets/add_asset.dart';
import 'package:dreamhrms/screen/employee/assets_details.dart';
import 'package:dreamhrms/screen/employee/employee_details/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:localization/localization.dart';

import '../../../constants/colors.dart';
import '../../../controller/employee_details_controller/asset_controller.dart';
import '../../../services/provision_check.dart';
import '../../../widgets/Custom_text.dart';
import '../../../widgets/common.dart';
import '../../../widgets/common_widget_icon_button.dart';
import '../../../widgets/no_record.dart';

class Assets extends StatefulWidget {
  const Assets({Key? key}) : super(key: key);

  @override
  State<Assets> createState() => _AssetsState();
}

class _AssetsState extends State<Assets> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AssetController.to.getAssetList();
  }

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration.zero).then((value) async {
    //   await AssetController.to.getAssetList();
    // });
    return Scaffold(
      appBar: GetStorage().read('role') == "employee"
          ? AppBar(
              backgroundColor: Colors.transparent,
              centerTitle: false,
              automaticallyImplyLeading: false,
              elevation: 0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      navBackButton(),
                      SizedBox(width: 8),
                      CustomText(
                        text: "assets",
                        color: AppColors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  // ProvisionsWithIgnorePointer(
                  //   provision: "Assets",type:"create",
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(right: 10),
                  //     child: CommonIconButton(
                  //       icon: Icon(Icons.add, color: AppColors.white),
                  //       width: 36,
                  //       height: 36,
                  //       onPressed: () {
                  //         Get.to(() => AddAsset());
                  //       },
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            )
          : null,
      body: ViewProvisionedWidget(
        provision: "Assets",
        type: "view",
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (GetStorage().read('role') == "admin")
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: "assets",
                            color: AppColors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                          CommonIconButton(
                            icon: Icon(Icons.add, color: AppColors.white),
                            width: 36,
                            height: 36,
                            onPressed: () {
                              Get.to(() => AddAsset());
                            },
                          ),
                        ],
                      ),
                    SizedBox(height: 20),
                    getListData(context)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  getListData(BuildContext context) {
    return commonLoader(
      length: MediaQuery.of(context).size.height.toInt(),
      singleRow: true,
      loader: AssetController.to.showAssetList,
      child: AssetController.to.employeeAssetModel?.data?.data?.length == 0
          ? NoRecord()
          : ListView.builder(
              shrinkWrap: true,
              itemCount:
                  AssetController.to.employeeAssetModel?.data?.data?.length ??
                      0,
              itemBuilder: (context, index) {
                var ownerImg =
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyx2HIw5F6Yw-a6-5k6Qo9NM1A8GsXOCapnQ&usqp=CAU";
                var data =
                    AssetController.to.employeeAssetModel?.data?.data?[index];
                print("employee assets $data");
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: InkWell(
                    onTap: () {
                      AssetController.to.selectedIndex = index;
                      Get.to(() => AssetsDetails());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          border: Border.all(
                            color: AppColors.grey.withOpacity(0.3),
                            // width: 1.0,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.network(
                              '${data?.employee?.profileImage ?? ownerImg}',
                              fit: BoxFit.cover,
                              width: 58.0,
                              height: 58.0,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: Get.width * 0.50,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: '${data?.data?.asset?.assetId ?? "-"}',
                                    color: AppColors.secondaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  SizedBox(height: 8),
                                  CustomText(
                                    text: '${data?.data?.asset?.category??""}',
                                    color: AppColors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.calendar_today_outlined,
                                          size: 13, color: AppColors.grey),
                                      SizedBox(width: 8),
                                      CustomText(
                                        text:
                                            '${data?.data?.asset?.purchaseDate ?? "-"}',
                                        color: AppColors.grey,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () {},
                              child: Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 20,
                                color: AppColors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
    );
  }
}
