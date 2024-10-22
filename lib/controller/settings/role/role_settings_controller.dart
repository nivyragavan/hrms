import 'dart:convert';

import 'package:dreamhrms/controller/login_controller.dart';
import 'package:dreamhrms/model/login_model.dart' as hide;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';

import '../../../model/provision/provision_model.dart';
import '../../../model/settings/role/module_settings_model.dart';
import '../../../model/settings/role/permission_role_list.dart';
import '../../../model/settings/role/role_settings_model.dart';
import '../../../screen/splash.dart';
import '../../../services/HttpHelper.dart';
import '../../../services/api_service.dart';
import '../../../services/utils.dart';
import '../../../widgets/encrypt_decrypt.dart';
import '../../common_controller.dart';
import '../../provision/provision_controller.dart';
import '../settings.dart';

class RoleSettingsController extends GetxController {
  static RoleSettingsController get to => Get.put(RoleSettingsController());
  static final HttpHelper _http = HttpHelper();

  RoleSettingsListModel? roleSettingsListModel;
  PermissionRoleSettingsListModel? permissionRoleSettingsListModel;
  ModulesRoleSettingsModel? modulesRoleSettingsModel;
  ProvisionModel? provisionModel;

  TextEditingController roleNameController = TextEditingController();
  TextEditingController roleIdController = TextEditingController();

  final _showRoleList = false.obs;

  get showRoleList => _showRoleList.value;

  set showRoleList(value) {
    _showRoleList.value = value;
  }

  final _permissionListLoader = false.obs;

  get permissionListLoader => _permissionListLoader.value;

  set permissionListLoader(value) {
    _permissionListLoader.value = value;
  }

  final _showModuleList = false.obs;

  get showModuleList => _showModuleList.value;

  set showModuleList(value) {
    _showModuleList.value = value;
  }

  final _checkerLoader = false.obs;

  get checkerLoader => _checkerLoader.value;

  set checkerLoader(value) {
    _checkerLoader.value = value;
  }

  getRoleSettingsList() async {
    showRoleList = true;
    var body = {"branch_id": SettingsController.to.branchId.text};
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
        url: "${Api.roleSettingsList}",
        encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
        auth: true)
        : await _http.post(Api.roleSettingsList, body,
        auth: true, contentHeader: false);
    if (response['code'] == "200") {
      if(response['data']!=[] && response['data']!=null){
        roleSettingsListModel = RoleSettingsListModel.fromJson(response);
      }
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
    showRoleList = false;
  }

  // updateProvisionModel() async {
  //   // print("updating....");
  //   // LoginController.to.loginModel?.data?.original?.user?.roles?[0].permissions = roleSettingsListModel?.data?.data?.list?[0]?.permissions!.cast<hide.Permission>();
  //   // print("updatedd....");
  //   // print("login${LoginController.to.loginModel?.data?.original?.user?.roles?[0].permissions?[0].name}");
  //   await ProvisionController.to.setProvisions(LoginController.to.loginModel?.data?.original?.user?.roles?[0].permissions ?? []);
  // }
  getPermissionRoleSettingsList() async {
    permissionListLoader = true;
    var response = await _http.post(Api.rolePermissionSettingsList, "",
        auth: true, contentHeader: false);
    if (response['code'] == "200") {
      permissionRoleSettingsListModel =
          PermissionRoleSettingsListModel.fromJson(response);
      await storePermissionId();
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
    permissionListLoader = false;
  }

  storePermissionId() {
    modulesRoleSettingsModel!.data!.data!.forEach((module) {
      permissionRoleSettingsListModel!.data!.data!.where((permission) {
        return module.id == permission.moduleId;
      }).forEach((permission) {
        final lastPart = permission.name?.split("_").last;
        print("role permission ${permission.name} id ${permission.id} ");
        switch (lastPart) {
          case "create":
            module.createId = permission.id;
            break;
          case "view":
            module.viewId = permission.id;
            break;
          case "delete":
            module.deleteId = permission.id;
            break;
        }
      });
    });
  }

  assignPermissionRole( {int? id, required String permissionId}) async {
    var body = {
      "branch_id": SettingsController.to.branchId.text,
      "role_id": id,
      "permissions": permissionId
    };
    try {
      print("role and privileages ${jsonEncode(body)}");
      var response = GetStorage().read("RequestEncryption") == true
          ? await _http.multipartPostData(
              url: "${Api.roleAssignPermission}",
              encryptMessage:
                  await LibSodiumAlgorithm().encryptionMessage(body),
              auth: true)
          : await _http.post(Api.roleAssignPermission, body,
              auth: true, contentHeader: false);
      if (response['code'] == "200") {
        print("api response of the company save $response");
        UtilService()
            .showToast("success", message: response['message'].toString());
        await RoleSettingsController.to.getRoleSettingsList();
        // await updateProvisionModel();
        LoginController.to.userEmail.text=GetStorage().read("username");
        LoginController.to.password.text=GetStorage().read("password");
        await LoginController.to.login();
        Get.back();
     } else {
        UtilService()
            .showToast("error", message: response['message'].toString());
      }
    } catch (e) {
      print("Exception on the api$e");
      CommonController.to.buttonLoader = false;
    }
  }

  getModuleRoleSettingsList() async {
    showModuleList = true;
    var response = await _http.post(Api.roleModuleList, "",
        auth: true, contentHeader: false);
    if (response['code'] == "200") {
      modulesRoleSettingsModel = ModulesRoleSettingsModel.fromJson(response);
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
    showModuleList = false;
  }

  addRole() async {
    try {
      var body = {"name": roleNameController.text,"branch_id": SettingsController.to.branchId.text};
      print("body request data $body");
      var response = GetStorage().read("RequestEncryption") == true
          ? await _http.multipartPostData(
              url: "${Api.addRole}",
              encryptMessage:
                  await LibSodiumAlgorithm().encryptionMessage(body),
              auth: true)
          : await _http.post(Api.addRole, body,
              auth: true, contentHeader: false);
      if (response['code'] == "200") {
        UtilService()
            .showToast("success", message: response['message'].toString());
        await getRoleSettingsList();
      } else {
        UtilService()
            .showToast("error", message: response['message'].toString());
      }
    } catch (e) {
      print("Exception on the api$e");
      CommonController.to.buttonLoader = false;
    }
  }

  editRole() async {
    try {
      var body = {"id": roleIdController.text, "name": roleNameController.text,"branch_id": SettingsController.to.branchId.text};
      print("body request data $body");
      var response = GetStorage().read("RequestEncryption") == true
          ? await _http.multipartPostData(
              url: "${Api.editRole}",
              encryptMessage:
                  await LibSodiumAlgorithm().encryptionMessage(body),
              auth: true)
          : await _http.post(Api.editRole, body,
              auth: true, contentHeader: false);
      if (response['code'] == "200") {
        UtilService()
            .showToast("success", message: response['message'].toString());
        await getRoleSettingsList();
      } else {
        UtilService()
            .showToast("error", message: response['message'].toString());
      }
    } catch (e) {
      print("Exception on the api$e");
      CommonController.to.buttonLoader = false;
    }
  }

  deleteRole() async {
    try {
      var body = {
        "id": roleIdController.text,
      };
      print("body request data $body");
      var response = GetStorage().read("RequestEncryption") == true
          ? await _http.multipartPostData(
              url: "${Api.deleteRole}",
              encryptMessage:
                  await LibSodiumAlgorithm().encryptionMessage(body),
              auth: true)
          : await _http.post(Api.deleteRole, body,
              auth: true, contentHeader: false);
      if (response['code'] == "200") {
        UtilService()
            .showToast("success", message: response['message'].toString());
        await getRoleSettingsList();
      } else {
        UtilService()
            .showToast("error", message: response['message'].toString());
      }
    } catch (e) {
      print("Exception on the api$e");
      CommonController.to.buttonLoader = false;
    }
  }
}

