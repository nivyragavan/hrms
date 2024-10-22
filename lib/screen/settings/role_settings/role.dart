import 'package:dreamhrms/controller/common_controller.dart';
import 'package:dreamhrms/controller/settings/role/role_settings_controller.dart';
import 'package:dreamhrms/screen/employee/employee_details/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:localization/localization.dart';

import '../../../constants/colors.dart';
import '../../../controller/branch_controller.dart';
import '../../../controller/employee/employee_controller.dart';
import '../../../widgets/Custom_rich_text.dart';
import '../../../widgets/Custom_text.dart';
import '../../../widgets/back_to_screen.dart';
import '../../../widgets/common.dart';
import '../../../widgets/common_alert_dialog.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/common_textformfield.dart';
import '../../../widgets/no_record.dart';
import 'admin_module_privileges.dart';

class RoleSettings extends StatelessWidget {
  const RoleSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((value) async {
      await RoleSettingsController.to.getRoleSettingsList();
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
                navBackButton(),
                SizedBox(width: 8),
                CustomText(
                  text: "role_privileges",
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
                  RoleSettingsController.to.roleNameController.text = "";
                  showAddRoleDialog(context, type: "add");
                  // Get.back();
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
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Obx(() => commonLoader(
            length:MediaQuery.of(context).size.height.toInt(),
            loader: RoleSettingsController.to.showRoleList,
            height: 50,
            singleRow: true,
            child: RoleSettingsController
                        .to.showRoleList ==
                    0
                ? NoRecord()
                : ListView.builder(
                    itemCount: RoleSettingsController
                            .to.roleSettingsListModel?.data?.data?.list?.length ??
                        0,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      final roleList = RoleSettingsController
                          .to.roleSettingsListModel?.data?.data?.list?[index];
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                        child: Container(
                          decoration: BoxDecoration(
                              // color: AppColors.white,
                              border: Border.all(
                                color: AppColors.grey.withOpacity(0.3),
                                // width: 1.0,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: Get.width * 0.45,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CustomText(
                                                    text:
                                                        '${roleList?.name ?? "-"}',
                                                    color: AppColors.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  SizedBox(height: 8),
                                                  // CustomText(
                                                  //   text:
                                                  //       '${roleList?.guardName ?? "-"}',
                                                  //   color:
                                                  //       AppColors.secondaryColor,
                                                  //   fontSize: 12,
                                                  //   fontWeight: FontWeight.w400,
                                                  // ),
                                                  SizedBox(height: 8),
                                                  CustomText(
                                                    text:
                                                        '${roleList?.createdAt?.day}/${roleList?.createdAt?.month}/${roleList?.createdAt?.year}',
                                                    color: AppColors.grey,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    Spacer(),
                                    PopupMenuButton(
                                      icon: Icon(Icons.more_vert,
                                          color: AppColors.grey),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      itemBuilder: (BuildContext context) =>
                                          <PopupMenuEntry<String>>[
                                        PopupMenuItem(
                                          height: 30,
                                          child: InkWell(
                                            onTap: () {
                                              RoleSettingsController.to
                                                  .roleNameController.text = "";
                                              RoleSettingsController
                                                  .to.roleIdController.text = "";
                                              RoleSettingsController.to
                                                      .roleNameController.text =
                                                  '${roleList?.name ?? ""}';
                                              RoleSettingsController
                                                  .to
                                                  .roleIdController
                                                  .text = '${roleList?.id ?? ""}';
                                              Get.back();
                                              showAddRoleDialog(context,
                                                  type: "edit");
                                            },
                                            child: Row(
                                              children: [
                                                // SizedBox(width:14,height:14,child: Image.asset('assets/images/role/edit.png')),
                                                SvgPicture.asset(
                                                  "assets/icons/role/edit.svg",
                                                  color: AppColors.black,
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
                                        ),
                                        PopupMenuItem(
                                          height: 30,
                                          child: InkWell(
                                            onTap: () {
                                              Get.back();
                                              Get.to(
                                                  () => AdminModulePrivileges(roleList));
                                            },
                                            child: Row(
                                              children: [
                                                SvgPicture.asset(
                                                 "assets/icons/role/privilege.svg",
                                                  color: AppColors.black,
                                                  width: 14,
                                                  height: 14,
                                                ),
                                                SizedBox(
                                                  width: 12,
                                                ),
                                                CustomText(
                                                    text: "privileges",
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
                                                RoleSettingsController.to
                                                    .roleIdController.text = "";
                                                RoleSettingsController.to
                                                        .roleIdController.text =
                                                    '${roleList?.id ?? ""}';
                                                Get.back();
                                                showDeleteAlertDialog(context);
                                              },
                                              child: Row(
                                                children: [
                                                  // SizedBox(width:16,height:161,child: Image.asset('assets/images/role/delete.png')),
                                                  SvgPicture.asset(
                                                    "assets/icons/role/delete.svg",
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
                                            ))
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ))),
      ),
    );
  }

  showAddRoleDialog(BuildContext context, {required String type}) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "add_role",
                        color: AppColors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          height: 36,
                          width: 36,
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: AppColors.bgbrown,
                              border: Border.all(
                                  color: AppColors.bgbrown.withOpacity(0.20)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: SvgPicture.asset(
                            "assets/icons/cancel.svg",
                            color: AppColors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  CustomRichText(
                      textAlign: TextAlign.left,
                      text: "role_name",
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      textSpan: ' *',
                      textSpanColor: AppColors.red),
                  SizedBox(height: 15),
                  CommonTextFormField(
                    controller: RoleSettingsController.to.roleNameController,
                    isBlackColors: true,
                    keyboardType: TextInputType.name,
                  ),
                  SizedBox(height: 30),
                  Obx(
                    () => Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 90,
                            child: CommonButton(
                                iconText: false,
                                text: 'submit',
                                iconSize: 18,
                                textColor: AppColors.white,
                                buttonLoader: CommonController.to.buttonLoader,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                onPressed: () async {
                                  CommonController.to.buttonLoader = true;
                                  type == "add"
                                      ? await RoleSettingsController.to
                                          .addRole()
                                      : await RoleSettingsController.to
                                          .editRole();
                                  Get.back();
                                  CommonController.to.buttonLoader = false;
                                }),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 90,
                            child: BackToScreen(
                                text: "cancel",
                                filled: true,
                                icon: "assets/icons/cancel.svg",
                                arrowIcon: false,
                                onPressed: () {
                                  Get.back();
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  showDeleteAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: AlertDialog(
              content: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                            text: "delete_roles",
                            color: AppColors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            height: 36,
                            width: 36,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                color: AppColors.bgbrown,
                                border: Border.all(
                                    color: AppColors.bgbrown.withOpacity(0.20)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: SvgPicture.asset(
                              "assets/icons/cancel.svg",
                              color: AppColors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                        width: 43,
                        height: 44,
                        child: Image.asset(
                          'assets/images/delete.png',
                        )),
                    SizedBox(height: 10),
                    CustomText(
                        text:
                            "All employee information/file in this task will be deleted.",
                        color: AppColors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                    SizedBox(height: 25),
                    Obx(
                      () => Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 90,
                              child: CommonButton(
                                  iconText: false,
                                  text: 'submit',
                                  iconSize: 18,
                                  textColor: AppColors.white,
                                  buttonLoader:
                                      CommonController.to.buttonLoader,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  onPressed: () async {
                                    CommonController.to.buttonLoader = true;
                                    await RoleSettingsController.to
                                        .deleteRole();
                                    Get.back();
                                    CommonController.to.buttonLoader = false;
                                  }),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 90,
                              child: BackToScreen(
                                  text: "cancel",
                                  filled: true,
                                  icon: "assets/icons/cancel.svg",
                                  arrowIcon: false,
                                  onPressed: () {
                                    Get.back();
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
