import 'package:dreamhrms/controller/branch_controller.dart';
import 'package:dreamhrms/controller/settings/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../model/settings/dashboard_settings/dashboard_list_model.dart';
import '../../services/HttpHelper.dart';
import '../../services/api_service.dart';
import '../../services/utils.dart';
import '../../widgets/encrypt_decrypt.dart';
import '../common_controller.dart';

class DashBoardSettingsController extends GetxController{
  static DashBoardSettingsController get to =>Get.put(DashBoardSettingsController());
  static final HttpHelper _http = HttpHelper();
  TextEditingController roleController=TextEditingController();
  TextEditingController roleIdController=TextEditingController();

  DashboardSettingsListModel? dashboardSettingsListModel;

  final _dashboardSetting=false.obs;

  get dashboardSetting => _dashboardSetting.value;

  set dashboardSetting(value) {
    _dashboardSetting.value = value;
  }

  getDashboardSettingsList()async {
    dashboardSetting = true;
    var body = {
    "role_id":roleIdController.text,
    "branch_id":SettingsController.to.branchId.text
    };
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
        url: "${Api.dashboardSettingsList}",
        encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
        auth: true)
        : await _http.post(Api.dashboardSettingsList, body,
        auth: true, contentHeader: false);
    if (response['code'] == "200") {
      dashboardSettingsListModel = DashboardSettingsListModel.fromJson(response);
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
    dashboardSetting = false;
  }

  postDashboardSettings()async{
    dashboardSetting=true;
    List<Map<String, dynamic>>? settingsdata = dashboardSettingsListModel?.data?.data?.map((item) {
      return {
        "widget_id": item.id,
        "status": item.status==1||item.status=="1"?1:0
      };
    }).toList();

    var body={
      "branch_id":'${SettingsController.to.branchId.text.toString()??""}',
      "role_id":'${DashBoardSettingsController.to.roleIdController.text.toString()??""}',
      "settingsdata":settingsdata
    };
    print("Dashboard body $body");
    try {
      var response = GetStorage().read("RequestEncryption") == true
          ? await _http.multipartPostData(
          url: "${Api.updateDashboardSettings}",
          encryptMessage:
          await LibSodiumAlgorithm().encryptionMessage(body),
          auth: true)
          : await _http.post(Api.updateDashboardSettings, body,
          auth: true, contentHeader: false);
      if (response['code'] == "200") {
        print("api response of the company save $response");
        UtilService()
            .showToast("success", message: response['message'].toString());
        await getDashboardSettingsList();
      } else {
        UtilService()
            .showToast("error", message: response['message'].toString());
      }
    } catch (e) {
      print("Exception on the api$e");
      CommonController.to.buttonLoader = false;
    }
    dashboardSetting=false;
  }

}