import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../model/settings/notification_Settings_model.dart';
import '../../../model/settings/upload_notification_settings.dart';
import '../../../screen/settings/notification_settings.dart';
import '../../../services/HttpHelper.dart';
import '../../../services/api_service.dart';
import '../../../services/utils.dart';
import '../../../widgets/encrypt_decrypt.dart';
import '../../common_controller.dart';
import '../settings.dart';

class NotificationSettingsController extends GetxController {
  static NotificationSettingsController get to =>
      Get.put(NotificationSettingsController(), permanent: true);
  static final HttpHelper _http = HttpHelper();
  NotificationSettingsModel? notificationSettingsModel;

  final _notificationLoader = false.obs;

  get notificationLoader => _notificationLoader.value;

  set notificationLoader(value) {
    _notificationLoader.value = value;
  }

  final _emailController = false.obs;

  get emailController => _emailController.value;

  set emailController(value) {
    _emailController.value = value;
  }

  getNotificationSettingsList() async {
    notificationLoader = true;
    var body = {"branch_id": SettingsController.to.branchId.text};
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
            url: "${Api.notificationSettingsList}",
            encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
            auth: true)
        : await _http.post(Api.notificationSettingsList, body,
            auth: true, contentHeader: false);
    if (response['code'] == "200") {
      notificationSettingsModel = NotificationSettingsModel.fromJson(response);
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
    notificationLoader = false;
  }

  uploadNotificationSettings() async {
    final uploadNotificationSettingsModel = UploadNotificationSettingsModel(
      notification: [],
      branchId: "",
    );
    for (int i = 0;
        i <
            int.parse(
                notificationSettingsModel?.data!.length.toString() ?? "0");
        i++) {
      print("duration ${notificationSettingsModel?.data?[i].duration==null}");
      uploadNotificationSettingsModel.notification?.insert(
          uploadNotificationSettingsModel.notification!.length,
          notificationSettingsModel?.data?[i].duration!=null && notificationSettingsModel?.data?[i].duration!="null"?
          Notifications(
              source: notificationSettingsModel?.data?[i].id,
              user_type: notificationSettingsModel?.data?[i].type=="employee"?"1":"2",
              push: notificationSettingsModel?.data?[i].push,
              email: notificationSettingsModel?.data?[i].email,
              sms: notificationSettingsModel?.data?[i].sms,
              status: "0",
              duration: notificationSettingsModel?.data?[i].duration
          )
              :Notifications(
            source: notificationSettingsModel?.data?[i].id,
            user_type: notificationSettingsModel?.data?[i].type=="employee"?"1":"2",
            push: notificationSettingsModel?.data?[i].push,
            email: notificationSettingsModel?.data?[i].email,
            sms: notificationSettingsModel?.data?[i].sms,
            status: "0",
          ));
    }
    final List<Map<String, dynamic>> notificationJsonList =
        uploadNotificationSettingsModel.notification
                ?.map((notification) => notification.toJson())
                .toList() ??
            [];
    List<Map<String, dynamic>> filteredList = notificationJsonList.map((map) {
      if (map["duration"] == null) {
        map.remove("duration");
      }
      return map;
    }).toList();
    var body = {"notification": filteredList, "branch_id": '${SettingsController.to.branchId.text}'};
    try {
      var response = GetStorage().read("RequestEncryption") == true
          ? await _http.multipartPostData(
              url: "${Api.notificationSave}",
              encryptMessage:
                  await LibSodiumAlgorithm().encryptionMessage(body),
              auth: true)
          : await _http.post(Api.notificationSave, body,
              auth: true, contentHeader: false);
      if (response['code'] == "200") {
        print("api response of the notification save $response");
        UtilService()
            .showToast("success", message: response['message'].toString());
        Get.back();
        Get.to(()=>NotificationSettings());
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
