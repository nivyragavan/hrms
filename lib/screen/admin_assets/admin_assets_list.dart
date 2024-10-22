import 'package:dreamhrms/controller/assets/add_asset_controller.dart';
import 'package:dreamhrms/controller/common_controller.dart';
import 'package:dreamhrms/model/asset/admin_asset_list.dart' hide State;
import 'package:dreamhrms/screen/admin_assets/edit_asset.dart';
import 'package:dreamhrms/screen/employee/employee_details/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';

import '../../constants/colors.dart';
import '../../../widgets/Custom_text.dart';
import '../../../widgets/no_record.dart';
import '../../controller/assets/admin_asset_controller.dart';
import '../../controller/theme_controller.dart';
import '../../services/provision_check.dart';
import '../../widgets/common_alert_dialog.dart';
import '../main_screen.dart';
import 'add_asset.dart';
import 'admin_assets_details.dart';

class AdminAssets extends StatelessWidget {
  const AdminAssets({Key? key}) : super(key: key);

  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   //AdminAssetController.to.showAssetList = true;
  //   AdminAssetController.to.getAdminAssetList();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Get.to(() => MainScreen());
                  },
                  child: Icon(Icons.arrow_back_ios_new_outlined,
                      color: ThemeController.to.checkThemeCondition() == true
                          ? AppColors.white
                          : AppColors.black),
                ),
                SizedBox(width: 8),
                CustomText(
                  text: "assets",
                  color: AppColors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                onTap: () async {
                  AddAssetController.to.clear();
                  AddAssetController.to.getCode();
                  Get.to(() => AddAsset());
                },
                child: Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                      color: AppColors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Icon(Icons.add, color: AppColors.white),
                ),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // CustomText(
                //   text: "assets",
                //   color: AppColors.black,
                //   fontSize: 20,
                //   fontWeight: FontWeight.w600,
                // ),
                SizedBox(height: 20),
                getListData(context)
              ],
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
      loader: AdminAssetController.to.showAssetList,
      child: ViewProvisionedWidget(
        provision:"Assets",type:"view",
        child: AdminAssetController.to.adminAssetsListModel?.data?.data?.length ==
                0
            ? NoRecord()
            : ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: AdminAssetController
                        .to.adminAssetsListModel?.data?.data?.length ??
                    0,
                itemBuilder: (context, index) {
                  var ownerImg =
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyx2HIw5F6Yw-a6-5k6Qo9NM1A8GsXOCapnQ&usqp=CAU";
                  var data = AdminAssetController
                      .to.adminAssetsListModel?.data?.data?[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: InkWell(
                      onTap: () {
                        AdminAssetController.to.selectedIndex=index;
                        Get.to(() => AdminAssetsDetails());
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color:
                                  ThemeController.to.checkThemeCondition() == true
                                      ? AppColors.black
                                      : AppColors.white,
                              border: Border.all(
                                color: AppColors.grey.withOpacity(0.3),
                                // width: 1.0,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child:  Slidable(
                            closeOnScroll: true,
                            endActionPane: ActionPane(
                              extentRatio: 0.3,
                              motion: const BehindMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    editAsset(data);
                                  },
                                  backgroundColor: AppColors.blue,
                                  foregroundColor: Colors.white,
                                  icon: Icons.edit_outlined,
                                ),
                                SlidableAction(
                                  onPressed: (context) {
                                    commonAlertDialog(
                                      icon: Icons.delete_outline,
                                      context: context,
                                      title: "delete_asset",
                                      description:
                                      'all_details_in_this_asset_will_be_deleted.',
                                      actionButtonText: "delete",
                                      onPressed: () async {
                                        CommonController.to.buttonLoader = true;
                                              await AddAssetController.to.deleteAsset(data?.id ?? "0");
                                        CommonController.to.buttonLoader = false;
                                      },
                                      provision: 'assets', provisionType: 'delete',
                                    );
                                  },
                                  backgroundColor: AppColors.red,
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete_outline,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(8),
                                      bottomRight: Radius.circular(8)),
                                ),
                              ],
                            ),
                            child: Container(
                              margin: EdgeInsets.all(10),
                              color:  ThemeController.to.checkThemeCondition() == true
                                  ? AppColors.black
                                  : AppColors.white,

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.network(
                                    '${data?.attachment?.fileName ?? ownerImg}',
                                    fit: BoxFit.cover,
                                    width: 58.0,
                                    height: 58.0,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(
                                        width: Get.width * 0.48,
                                        child: Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomText(
                                                  text: '${data?.assetId ?? "-"}',
                                                  color: AppColors.secondaryColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                SizedBox(height: 8),
                                                CustomText(
                                                  text: '${data?.name ?? "-"}',
                                                  color: AppColors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                SizedBox(height: 8),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                        Icons
                                                            .calendar_today_outlined,
                                                        size: 11,
                                                        color: AppColors.grey),
                                                    SizedBox(width: 8),
                                                    CustomText(
                                                      text:
                                                          '${data?.purchaseDate ?? "-"}',
                                                      color: AppColors.grey,
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 20,
                                          width: 40,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: data?.status?.name ==
                                                  "Active"
                                                  ? ThemeController.to
                                                  .checkThemeCondition() ==
                                                  true
                                                  ? AppColors.green
                                                  .withOpacity(0.4)
                                                  : AppColors.lightGreen
                                                  : data?.status?.name ==
                                                  "Deployed"
                                                  ? ThemeController.to
                                                  .checkThemeCondition() ==
                                                  true
                                                  ? AppColors.blue
                                                  .withOpacity(0.4)
                                                  : AppColors.lightBlue
                                                  : data?.status?.name ==
                                                  "Pending"
                                                  ? ThemeController.to
                                                  .checkThemeCondition() ==
                                                  true
                                                  ? AppColors.yellow
                                                  .withOpacity(
                                                  0.4)
                                                  : AppColors
                                                  .bgLightYellow
                                                  : data?.status?.name ==
                                                  "Archived"
                                                  ? AppColors.grey
                                                  .withOpacity(
                                                  0.15)
                                                  : ThemeController.to
                                                  .checkThemeCondition() ==
                                                  true
                                                  ? AppColors.red
                                                  .withOpacity(0.4)
                                                  : AppColors.lightRed,
                                              borderRadius: const BorderRadius.all(
                                                  Radius.circular(2))),
                                          child: CustomText(
                                            text: '${data?.status?.name ?? "-"}',
                                            color: data?.status?.name == "Active"
                                                ? AppColors.green
                                                : data?.status?.name == "Deployed"
                                                    ? AppColors.darkBlue
                                                    : data?.status?.name ==
                                                            "Pending"
                                                        ? AppColors.yellow
                                                        : data?.status?.name ==
                                                                "Archived"
                                                            ? AppColors.grey
                                                            : AppColors.red,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        InkWell(
                                          onTap: () {
                                            AdminAssetController.to.selectedIndex =
                                                index;
                                            Get.to(() => AdminAssetsDetails());
                                          },
                                          child: Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            size: 20,
                                            color: AppColors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                        ),
                      ),
                    ),
                  );
                }),
      ),
    );
  }

  editAsset(Data1? data) {
    AddAssetController.to.isEdit == true;
    AddAssetController.to.assetName.text = data?.name ?? "";
    AddAssetController.to.assetID.text = data?.assetId ?? "";
    AddAssetController.to.masterId.text = data?.id ?? "";
    AddAssetController.to.deviceCategories.text = data?.category ?? "";
    AddAssetController.to.brand.text = data?.brand ?? "";
    AddAssetController.to.model.text = data?.model ?? "";
    AddAssetController.to.supplier.text = data?.supplier ?? "";
    AddAssetController.to.serialNumber.text = data?.serialNumber ?? "";
    AddAssetController.to.warrantyExpirationDate.text =
        data?.warrantyExpiryDate ?? "";
    AddAssetController.to.purchaseDate.text = data?.purchaseDate ?? "";
    AddAssetController.to.purchaseAmount.text = data?.cost ?? "";
    AddAssetController.to.assetStatus.text = data?.status?.name ?? "";
    AddAssetController.to.assetStatusId.text = data?.status?.id ?? "";
    AddAssetController.to.imageName.text =
        data?.attachment?.fileName.toString() ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyx2HIw5F6Yw-a6-5k6Qo9NM1A8GsXOCapnQ&usqp=CAU";
    AddAssetController.to.attachmentId.text =
        data?.attachment?.id.toString() ?? "";
    Get.to(()=> EditAsset());
  }
}
