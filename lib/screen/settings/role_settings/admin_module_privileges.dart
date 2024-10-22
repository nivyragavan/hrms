import 'package:dreamhrms/model/settings/role/role_settings_model.dart';
import 'package:dreamhrms/widgets/no_record.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

import '../../../constants/colors.dart';
import '../../../controller/common_controller.dart';
import '../../../controller/settings/role/role_settings_controller.dart';
import '../../../widgets/Custom_text.dart';
import '../../../widgets/back_to_screen.dart';
import '../../../widgets/common.dart';
import '../../../widgets/common_button.dart';
import '../../employee/employee_details/profile.dart';

class AdminModulePrivileges extends StatelessWidget {
  final ListElement? roleList;
  const AdminModulePrivileges(this.roleList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((value) async {
      RoleSettingsController.to.showModuleList = true;
      await RoleSettingsController.to.getModuleRoleSettingsList();
      await RoleSettingsController.to.getPermissionRoleSettingsList();
      RoleSettingsController.to.showModuleList = false;
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
          ],
        ),
      ),
      body: Obx(
        () => Padding(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            child: commonLoader(
              loader: RoleSettingsController.to.showModuleList ||
                  RoleSettingsController.to.permissionListLoader,
              length: 10,
              singleRow: true,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    RoleSettingsController.to.modulesRoleSettingsModel?.data
                                ?.data?.length ==
                            0
                        ? NoRecord()
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: RoleSettingsController
                                    .to
                                    .modulesRoleSettingsModel
                                    ?.data
                                    ?.data
                                    ?.length ??
                                0,
                            itemBuilder: (context, index) {
                              final moduleList = RoleSettingsController.to
                                  .modulesRoleSettingsModel?.data?.data?[index];
                              if (moduleList != null &&
                                  roleList?.permissions != null) {
                                roleList?.permissions?.where((permission) {
                                  return permission.moduleId == moduleList.id;
                                }).forEach((permission) {
                                  final lastPart =
                                      permission.name?.split("_").last;
                                  switch (lastPart) {
                                    case "create":
                                      moduleList.create = true;
                                      break;
                                    case "view":
                                      moduleList.view = true;
                                      break;
                                    case "delete":
                                      print("Delete $lastPart $index ");
                                      moduleList.delete = true;
                                      break;
                                  }
                                });
                              }
                              return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        // color: AppColors.white,
                                        border: Border.all(
                                          color:
                                              AppColors.grey.withOpacity(0.3),
                                        ),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CustomText(
                                                text: '${moduleList?.name}',
                                                color: AppColors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                            SizedBox(height: 10),
                                            Obx(
                                              () => RoleSettingsController
                                                      .to.checkerLoader
                                                  ? Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        checkBoxTextWidget(
                                                            text: 'Create',
                                                            index: index,
                                                            value: moduleList
                                                                    ?.create ??
                                                                false,
                                                            loader: true),
                                                        SizedBox(width: 10),
                                                        checkBoxTextWidget(
                                                            text: 'View',
                                                            index: index,
                                                            value: moduleList
                                                                    ?.view ??
                                                                false,
                                                            loader: true),
                                                        SizedBox(width: 10),
                                                        checkBoxTextWidget(
                                                            text: 'Delete',
                                                            index: index,
                                                            value: moduleList
                                                                    ?.delete ??
                                                                false,
                                                            loader: true),
                                                        SizedBox(width: 10),
                                                      ],
                                                    )
                                                  : Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        checkBoxTextWidget(
                                                            text: 'Create',
                                                            value: moduleList
                                                                    ?.create ??
                                                                false,
                                                            index: index,
                                                            key: 1),
                                                        SizedBox(width: 10),
                                                        checkBoxTextWidget(
                                                            text: 'View',
                                                            value: moduleList
                                                                    ?.view ??
                                                                false,
                                                            index: index,
                                                            key: 2),
                                                        SizedBox(width: 10),
                                                        checkBoxTextWidget(
                                                            text: 'Delete',
                                                            value: moduleList
                                                                    ?.delete ??
                                                                false,
                                                            index: index,
                                                            key: 3),
                                                        SizedBox(width: 10),
                                                      ],
                                                    ),
                                            )
                                          ],
                                        )),
                                  ));
                            }),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          child: CommonButton(
                            text: "save",
                            textColor: AppColors.white,
                            fontSize: 16,
                            buttonLoader: CommonController.to.buttonLoader,
                            fontWeight: FontWeight.w500,
                            // textAlign: TextAlign.center,
                            onPressed: () async {
                              CommonController.to.buttonLoader = true;
                              List permission=[];
                              for(int i=0;i<RoleSettingsController.to.modulesRoleSettingsModel!.data!.data!.length;i++){
                                final role=RoleSettingsController.to.modulesRoleSettingsModel!.data!.data?[i];
                                print("Role id: ${role?.id} create ${role?.create} view${role?.view}delete ${role?.delete}");
                                if(role?.create==true){
                                  permission.add(role?.createId);
                                }if(role?.view==true){
                                  permission.add(role?.viewId);
                                }if(role?.delete==true){
                                  permission.add(role?.deleteId);
                                }
                              }
                              print('permission$permission');
                              if (permission != null && permission.length != 0)
                                await RoleSettingsController.to
                                    .assignPermissionRole(
                                        id: roleList?.id,
                                        permissionId: permission.join(','));
                              CommonController.to.buttonLoader = false;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    BackToScreen(
                      text: "cancel",
                      arrowIcon: false,
                      onPressed: () {
                        Get.back();
                      },
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }

  checkBoxTextWidget(
      {required String text,
      required int index,
      required bool value,
      bool? loader = false,
      int? key}) {
    return Column(
      children: [
        CustomText(
            text: text,
            color: AppColors.grey,
            fontSize: 11,
            fontWeight: FontWeight.w400),
        SizedBox(height: 10),
        loader == true
            ? Skeleton(width: 15, height: 15)
            : MSHCheckbox(
                size: 25,
                value: value,
                colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                  checkedColor: Colors.blue,
                ),
                style: MSHCheckboxStyle.fillScaleColor,
                onChanged: (selected) async {
                  RoleSettingsController.to.checkerLoader = true;
                  print("key $key selected$selected");
                  switch (key) {
                    case 1:
                      RoleSettingsController.to.modulesRoleSettingsModel?.data
                          ?.data?[index].create = selected;
                      break;
                    case 2:
                      RoleSettingsController.to.modulesRoleSettingsModel?.data
                          ?.data?[index].view = selected;
                      break;
                    case 3:
                      RoleSettingsController.to.modulesRoleSettingsModel?.data
                          ?.data?[index].delete = selected;
                      break;
                  }
                  RoleSettingsController.to.checkerLoader = false;
                  // Future.delayed(Duration(seconds: 1)).then((value) =>  RoleSettingsController.to.checkerLoader = false);
                },
              ),
      ],
    );
  }
}
