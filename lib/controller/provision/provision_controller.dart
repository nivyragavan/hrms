import 'dart:convert';

import 'package:dreamhrms/controller/login_controller.dart';
import 'package:dreamhrms/model/login_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/provision/provision_model.dart';
import '../settings/role/role_settings_controller.dart';

class ProvisionController extends GetxController {
  static ProvisionController get to => Get.put(ProvisionController(),permanent:true);
  ProvisionModel? provisionsModel;

  Map<String, dynamic> provisions={};
  
  setProvisions(List<Permission>? permissions) async {
   await clearSharedPreferences();
    print("setProvisions permission $permissions");
    if (permissions != null && permissions.isNotEmpty) {
      await RoleSettingsController.to.getModuleRoleSettingsList();
      final provisionList = RoleSettingsController.to.modulesRoleSettingsModel?.data?.data;
      print("role to update to the lsit $provisionList");
      if (provisionList != null) {
        print("role to update to the lsit ");
        provisionList.forEach((moduleList) async {
          if (moduleList != null && permissions != null) {
            permissions.where((permission) => permission.moduleId == moduleList.id).forEach((permission) {
              final lastPart = permission.name?.split("_").last;
              switch (lastPart) {
                case "create":
                  moduleList.create = true;
                  break;
                case "view":
                  moduleList.view = true;
                  break;
                case "delete":
                  moduleList.delete = true;
                  break;
              }
              print("provisiona values :lastPart ${permission.name} create${moduleList.create}");
            });
            print("role to update to the lsit ");
            provisions={};
            provisions=RoleSettingsController.to.modulesRoleSettingsModel!.data!.toJson();
            String jsonValue= json.encode(RoleSettingsController.to.modulesRoleSettingsModel!.data!.toJson());

// Store the JSON data in shared preferences
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('roleSettings', jsonValue);
            // await updateProvisionsFromModel();
            print("role to after list ${provisions}");
          }
        });
      }
    }
  }


  Future<bool> getProvisions(String provision, String type) async {
    final role = GetStorage().read('role');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var jsonData = json.decode(prefs.getString('roleSettings')!);
    if (jsonData['data'] != null) {
      for (int i = 0; i < jsonData['data'].length; i++) {
        final moduleList = jsonData['data'][i];
        // print(
        //     "spilitted name${moduleList['name']} split ${moduleList['name'].split("_").first.toString()}${moduleList['name']?.split("_").first.toString().toLowerCase()} send by para provision ${provision.toString().toLowerCase()}");
        if (provision.toString().toLowerCase() == moduleList['name'].toString().toLowerCase()) {
          print("provision $provision type $type moduleList${moduleList} ");
          if (type == "create") {
            return moduleList['create'] == true ? true : false;
          } else {
            if (type == "view") {
              return await moduleList['view']==true?true: false; // Adjusted the return value
            } else {
              if (type == "delete") {
                return moduleList['delete'] == true ? true : false;
              } else {
                return false;
              }
            }
          }
        }
      }
    }
    return false;
  }

}
