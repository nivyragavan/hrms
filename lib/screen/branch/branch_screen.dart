import 'package:dreamhrms/controller/branch_controller.dart';
import 'package:dreamhrms/model/branch_model/branch_list_model.dart';
import 'package:dreamhrms/screen/branch/add_branch_screen.dart';
import 'package:dreamhrms/screen/employee/employee_details/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:localization/localization.dart';
import '../../constants/colors.dart';
import '../../controller/common_controller.dart';
import '../../controller/employee_details_controller/employee_offboarding_controller.dart';
import '../../controller/settings/settings.dart';
import '../../controller/theme_controller.dart';
import '../../widgets/Custom_text.dart';
import '../../widgets/common_alert_dialog.dart';
import '../../widgets/no_record.dart';
import '../employee/employee_offboarding.dart';
import '../main_screen.dart';

class BranchScreen extends StatelessWidget {
  const BranchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      await BranchController.to.branchList();
    });
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
                    Get.offAll(MainScreen());
                  },
                  child: Icon(Icons.arrow_back_ios_new_outlined,
                      color: ThemeController.to.checkThemeCondition() == true
                          ? AppColors.white
                          : AppColors.black),
                ),
                SizedBox(width: 8),
                CustomText(
                  text: "branches",
                  color: AppColors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                onTap: () {
                  print("Address");
                BranchController.to.clearValues();
                  CommonController.to.clearValues();
                  Get.to(() => AddBranchScreen());
                },
                child: Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryColor1,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: Icon(Icons.add, color: AppColors.white),
                ),
              ),
            )
          ],
        ),
      ),
      body: Obx(() {
        return Padding(
          padding: EdgeInsets.all(20),
          child: buildBranchList(context),
        );
      }),
    );
  }

  buildBranchList(BuildContext context) {
    return commonLoader(
        length: MediaQuery.of(context).size.height.toInt(),
        singleRow: true,
        loader: BranchController.to.showList,
        child: BranchController.to.branchListModel?.data?.length == 0
            ? NoRecord()
            : ListView.separated(
                shrinkWrap: true,
                itemCount:
                    BranchController.to.branchListModel?.data?.length ?? 0,
                itemBuilder: (context, index) {
                  final branchList =
                      BranchController.to.branchListModel?.data?[index];
                  return Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.grey.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: Get.width,
                              height: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(branchList?.officeImage ??
                                        "https://im.proptiger.com/1/1750008/6/sapling-landmarks-elevation-21663090.jpeg"),
                                  ),
                                ),
                              ),
                              Positioned(
                                  top: 10,
                                  right: 10,
                                  child: CircleAvatar(
                                    radius: 15,
                                    backgroundColor: AppColors.lightWhite,
                                    child: PopupMenuButton(
                                      icon: Icon(
                                        Icons.more_vert,
                                        color: AppColors.grey,
                                        size: 15,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      itemBuilder: (BuildContext context) =>
                                          <PopupMenuEntry<String>>[
                                        PopupMenuItem(
                                          onTap: () {
                                            branchEdit(branchList);
                                          },
                                          height: 30,
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                "assets/icons/edit_out.svg",
                                                color: ThemeController.to
                                                            .checkThemeCondition() ==
                                                        true
                                                    ? AppColors.white
                                                    : AppColors.black,
                                                width: 14,
                                                height: 14,
                                              ),
                                              SizedBox(
                                                width: 12,
                                              ),
                                              CustomText(
                                                  text: "edit",
                                                  color: AppColors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500)
                                            ],
                                          ),
                                        ),
                                        PopupMenuItem(
                                          height: 30,
                                          child: InkWell(
                                            onTap: () {
                                              commonAlertDialog(
                                                icon: Icons.delete_outline,
                                                title: "delete_branch",
                                                context: context,
                                                description:
                                                    'all_details_in_this_branch_will_be_deleted.'
                                                        ,
                                                actionButtonText: "delete",
                                                provision: 'settings',
                                                provisionType: "delete",
                                              onPressed: () async {
                                                CommonController.to.buttonLoader = true;
                                                await BranchController.to
                                                    .deleteTask(BranchController
                                                    .to
                                                    .branchListModel!
                                                    .data![index]);
                                                CommonController.to.buttonLoader =
                                                false;
                                              },
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                "assets/icons/trash.svg",
                                                color: ThemeController.to
                                                            .checkThemeCondition() ==
                                                        true
                                                    ? AppColors.white
                                                    : AppColors.black,
                                                width: 14,
                                                height: 14,
                                              ),
                                              SizedBox(
                                                width: 12,
                                              ),
                                              CustomText(
                                                  text: "delete",
                                                  color: AppColors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500)
                                            ],
                                          ),
                                        ),
                                      ),
                                      PopupMenuItem(
                                          height: 30,
                                          child: InkWell(
                                            onTap: () {
                                              commonAlertDialog(
                                                icon:  branchList.setHq == 1
                                                    ? Icons.remove_circle_outline : Icons.check_circle_outline,
                                                title: branchList.setHq == 1
                                                    ? "remove_hq" : "set_as_hq",
                                                description: branchList.setHq == 1
                                                    ?'this_branch_will_be_removed_from_head_quarters'
                                                    :'this_branch_will_be_set_as_head_quarters',
                                                actionButtonText: branchList.setHq == 1
                                                    ? "remove" : "set",
                                                provision: 'branches', provisionType: 'create',
                                                context: context,
                                                onPressed: () async {
                                                  CommonController.to.buttonLoader = true;
                                                  await BranchController.to.setAsHQ(index);
                                                  CommonController.to.buttonLoader = false;
                                                },
                                              );
                                            },
                                            child: Row(
                                              children: [
                                                SvgPicture.asset(
                                                  "assets/icons/building.svg",
                                                  color: ThemeController.to
                                                              .checkThemeCondition() ==
                                                          true
                                                      ? AppColors.white
                                                      : AppColors.black,
                                                  width: 14,
                                                  height: 14,
                                                ),
                                                SizedBox(
                                                  width: 12,
                                                ),
                                                CustomText(
                                                    text: branchList!.setHq == 1
                                                        ? "remove_hq"
                                                        : "set_as_hq",
                                                    color: AppColors.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500)
                                              ],
                                            ),
                                          ))
                                    ],
                                  ),
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            CustomText(
                                text: branchList!.officeName ?? "-",
                                color: AppColors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                            SizedBox(
                              width: 10,
                            ),
                            branchList.setHq == 1
                                ? Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 3, horizontal: 6),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: ThemeController.to
                                                    .checkThemeCondition() ==
                                                true
                                            ? AppColors.grey.withOpacity(0.3)
                                            : AppColors.lightGrey,
                                        borderRadius: BorderRadius.circular(6)),
                                    child: CustomText(
                                        text: 'Headquarter',
                                        color: AppColors.grey,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                  )
                                : SizedBox()
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: Get.width * 0.45,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                      text: 'number_of_employee',
                                      color: AppColors.grey,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  CustomText(
                                      text: '${branchList.branchUserCount??"-"}',
                                      color: AppColors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500)
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                    text: 'status',
                                    color: AppColors.grey,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400),
                                SizedBox(
                                  height: 5,
                                ),
                                FlutterSwitch(
                                    height: 22,
                                    width: 50,
                                    padding: 2,
                                    valueFontSize: 11,
                                    activeColor: AppColors.blue,
                                    activeTextColor: AppColors.grey,
                                    // inactiveColor: AppColors.lightGrey,
                                    inactiveTextColor: AppColors.grey,
                                    value: branchList.deletedAt==null ?true:false,
                                    onToggle: (val) {
                                      commonAlertDialog(
                                        icon: Icons.remove_circle_outline,
                                        title: branchList.deletedAt==null ?"deactivate_branch":"activate_branch",
                                        description:branchList.deletedAt==null?'this_branch_will_be_deactivated':'this_branch_will_be_activated',
                                        actionButtonText:branchList.deletedAt==null?"deactivate":"activate",
                                        context: context,
                                        provision: 'branches', provisionType: 'create',
                                        onPressed: () async {
                                          Get.back();
                                          CommonController.to.buttonLoader = true;
                                          await BranchController.to.statusChange(index);
                                          CommonController.to.buttonLoader = false;
                                        },
                                      );
                                    },
                                  ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: Get.width * 0.45,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                      text: 'clock_in_limit(radius)',
                                      color: AppColors.grey,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  CustomText(
                                      text: branchList
                                              .clockLimitRadius?.distance ??
                                          "-",
                                      color: AppColors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500)
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                    text: 'geofencing',
                                    color: AppColors.grey,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400),
                                SizedBox(
                                  height: 5,
                                ),
                                FlutterSwitch(
                                  height: 22,
                                  width: 50,
                                  padding: 2,
                                  valueFontSize: 11,
                                  activeColor: AppColors.blue,
                                  activeTextColor: AppColors.grey,
                                  // inactiveColor: AppColors.lightGrey,
                                  inactiveTextColor: AppColors.grey,
                                  value: branchList.geofencingStatus == 1
                                      ? true
                                      : false,
                                  onToggle: (val) {
                                    commonAlertDialog(
                                      icon:  branchList.geofencingStatus == 1
                                          ? Icons.remove_circle_outline : Icons.check_circle_outline,
                                      title: branchList.geofencingStatus == 1
                                          ? "deactivate_geofencing?" : "activate_geofencing?",
                                    description: branchList.geofencingStatus == 1
                                    ?'geofencing_for_this_branch_will_be_deactivated'
                                        :'geofencing_for_this_branch_will_be_activated',
                                    actionButtonText: branchList.geofencingStatus == 1
                                    ? "deactivate" : "activate",
                                      provision: 'branches', provisionType: 'create',
                                      context: context,
                                      onPressed: () async {
                                        Get.back();
                                        CommonController.to.buttonLoader = true;
                                        await BranchController.to.geoFencingStatusChange(index);
                                        CommonController.to.buttonLoader = false;
                                      },
                                    );
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        CustomText(
                            text: 'Address',
                            color: AppColors.grey,
                            fontSize: 11,
                            fontWeight: FontWeight.w400),
                        SizedBox(
                          height: 8,
                        ),
                        CustomText(
                            text: branchList.officeFullAddress ?? "-",
                            color: AppColors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w500)
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 20,
                  );
                },
              ));
  }

  branchEdit(Datum? branchList) {
    BranchController.to.isEdit = "Edit";
    BranchController.to.officeName.text = branchList!.officeName.toString();
    BranchController.to.officeFullAddress.text =
        branchList.officeFullAddress.toString();
    BranchController.to.latitude = branchList.latitude ?? 11.05022464095414;
    BranchController.to.longitude = branchList.longitude ?? 77.01854346852336;
    BranchController.to.destLocation =
        LatLng(BranchController.to.latitude, BranchController.to.longitude);
    BranchController.to.officeAddress.text =
        branchList.officeAddress.toString();
    BranchController.to.radiusController.text =
        branchList.clockLimitRadius!.distance.toString();
    BranchController.to.radiusId.text =
        branchList.clockLimitRadius!.id.toString();
    BranchController.to.branchId = branchList.id ?? 0;
    BranchController.to.enableGeoFencingStatus =
        branchList.geofencingStatus == 1 ? true : false;
    BranchController.to.allowArea = branchList.allowArea == 1 ? true : false;
    BranchController.to.officeImage.text = branchList.officeImage;
    Get.to(() => AddBranchScreen());
  }
}
