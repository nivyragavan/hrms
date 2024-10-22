import 'dart:convert';

import 'package:dreamhrms/controller/settings/notification/notification_settings_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../services/HttpHelper.dart';
import '../../../services/api_service.dart';
import '../../../services/utils.dart';
import '../../../widgets/encrypt_decrypt.dart';
import '../../common_controller.dart';
import '../leave_settings_list_model.dart';
import '../settings.dart';

class LeaveSettingsController extends GetxController {
  static LeaveSettingsController get to => Get.put(LeaveSettingsController());
  static final HttpHelper _http = HttpHelper();

  LeaveSettingsListModel? leaveSettingsListModel;

  TextEditingController annualDays = TextEditingController();
  TextEditingController carryForward = TextEditingController();
  TextEditingController carryForwardDays = TextEditingController();
  TextEditingController EarnedLeave = TextEditingController();
  TextEditingController newLeaveTypeName = TextEditingController();
  TextEditingController newLeaveTypeDays = TextEditingController();

  ///add new policy
  TextEditingController policyNameController = TextEditingController();
  TextEditingController daysController = TextEditingController();

  TextEditingController departmentController = TextEditingController();
  TextEditingController departmentIdController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController positionIdController = TextEditingController();

  TextEditingController dayController = TextEditingController();
  TextEditingController leaveNameController = TextEditingController();


  TextEditingController carryForwarDaysController = TextEditingController();

  List<String> employeeController = <String>[].obs;
  List<String> employeeIdController = <String>[].obs;
  final _edit = false.obs;

  get edit => _edit.value;

  set edit(value) {
    _edit.value = value;
  }

  final _annualLeave = false.obs;

  get annualLeave => _annualLeave.value;

  set annualLeave(value) {
    _annualLeave.value = value;
  }

  final _leaveSettingsLoader = false.obs;

  get leaveSettingsLoader => _leaveSettingsLoader.value;

  set leaveSettingsLoader(value) {
    _leaveSettingsLoader.value = value;
  }

  onClear() {
    annualDays.text = "";
    carryForward.text = "";
    carryForwardDays.text = "";
    EarnedLeave.text = "";
    newLeaveTypeDays.text = "";
    newLeaveTypeName.text = "";
    policyNameController.text = "";
    daysController.text = "";
    employeeController = [];
    departmentController.text = "";
    positionController.text = "";
    dayController.text = "";
    leaveNameController.text = "";
  }

  addLeaveType() async {
    var body = {
      "name": policyNameController.text,
      "no_of_days": newLeaveTypeDays.text,
      "branch_id": SettingsController.to.branchId.text
    };
    try {
      var response = GetStorage().read("RequestEncryption") == true
          ? await _http.multipartPostData(
          url: "${Api.addLeaveSettingsType}",
          encryptMessage:
          await LibSodiumAlgorithm().encryptionMessage(body),
          auth: true)
          : await _http.post(Api.addLeaveSettingsType, body,
          auth: true, contentHeader: false);
      if (response['code'] == "200") {
        print("api response of the company save $response");
        await getLeaveSettings();
        UtilService()
            .showToast("success", message: response['message'].toString());
      } else {
        UtilService()
            .showToast("error", message: response['message'].toString());
      }
    } catch (e) {
      print("Exception on the api$e");
      CommonController.to.buttonLoader = false;
    }
  }

  editLeaveSettingsPolicy(int index) async {
    final leaveSettings = leaveSettingsListModel?.data?.data?[index];
    var body = {
      "id": leaveSettings?.id,
      "name": leaveNameController.text,
      "no_of_days": daysController.text,
      "branch_id": SettingsController.to.branchId.text,
      "carry_forward_status": leaveSettings?.carryForwardStatus ?? 0,
      "carry_forward_days": leaveSettings?.carryForwardDays == null
          ? 0
          : leaveSettings?.carryForwardDays ?? 0,
      "count_weekend_status": leaveSettings?.countWeekendStatus == null
          ? 0
          : leaveSettings?.countWeekendStatus ?? 0,
    };
    try {
      var response = GetStorage().read("RequestEncryption") == true
          ? await _http.multipartPostData(
          url: "${Api.updateLeaveSettingsPolicy}",
          encryptMessage:
          await LibSodiumAlgorithm().encryptionMessage(body),
          auth: true)
          : await _http.post(Api.updateLeaveSettingsPolicy, body,
          auth: true, contentHeader: false);
      if (response['code'] == "200") {
        print("api response of the company save $response");
        await getLeaveSettings();
        UtilService()
            .showToast("success", message: response['message'].toString());
      } else {
        UtilService()
            .showToast("error", message: response['message'].toString());
      }
    } catch (e) {
      print("Exception on the api$e");
      CommonController.to.buttonLoader = false;
    }
  }

  addLeaveSettingsPolicy(
      {int? settings_id,  required String type, int? id, required List<int?> employee_Id, }) async {
    var body =type=="add"?
    {
      "policy_name": policyNameController.text,
      "no_of_days": daysController.text,
      "leave_settings_id": settings_id,
      "users": employee_Id.join(","),
      "departments": departmentIdController.text,
      "positions":positionIdController.text
    }:
    {
      "id":id,
      "policy_name": policyNameController.text,
      "no_of_days": daysController.text,
      "leave_settings_id": settings_id,
      "users": employee_Id.join(","),
      "departments": departmentIdController.text,
      "positions":positionIdController.text
    };
    print("leave settings body ${jsonEncode(body)}");
    try {
      var response = GetStorage().read("RequestEncryption") == true
          ? await _http.multipartPostData(
          url: "${Api.addLeaveSettingsPolicy}",
          encryptMessage:
          await LibSodiumAlgorithm().encryptionMessage(body),
          auth: true)
          : await _http.post(Api.addLeaveSettingsPolicy, body,
          auth: true, contentHeader: false);
      if (response['code'] == "200") {
        print("api response of the company save $response");
        await getLeaveSettings();
        UtilService()
            .showToast("success", message: response['message'].toString());
      } else {
        UtilService()
            .showToast("error", message: response['message'].toString());
      }
    } catch (e) {
      print("Exception on the api$e");
      CommonController.to.buttonLoader = false;
    }
  }

  editLeaveSettings(int index) async {
    final leaveSettings = leaveSettingsListModel?.data?.data?[index];
    var body = {
      "id": leaveSettings?.id,
      "name": leaveNameController.text,
      "no_of_days": daysController.text,
      "branch_id": SettingsController.to.branchId.text,
      "carry_forward_status": leaveSettings?.carryForwardStatus ?? "",
      "carry_forward_days":LeaveSettingsController.to.carryForwarDaysController.text.length>0?LeaveSettingsController.to.carryForwarDaysController.text: leaveSettings?.carryForwardDays == null
          ? 0
          : leaveSettings?.carryForwardDays ?? "",
      "count_weekend_status": leaveSettings?.countWeekendStatus == null
          ? 0
          : leaveSettings?.countWeekendStatus ?? 0,
    };
    print("payload ${jsonEncode(body)}");
    try {
      var response = GetStorage().read("RequestEncryption") == true
          ? await _http.multipartPostData(
          url: "${Api.editLeaveSettingsType}",
          encryptMessage:
          await LibSodiumAlgorithm().encryptionMessage(body),
          auth: true)
          : await _http.post(Api.editLeaveSettingsType, body,
          auth: true, contentHeader: false);
      if (response['code'] == "200") {
        print("api response of the company save $response");
        Get.back();
        await LeaveSettingsController.to.getLeaveSettings();
        UtilService()
            .showToast("success", message: response['message'].toString());
      } else {
        UtilService()
            .showToast("error", message: response['message'].toString());
      }
    } catch (e) {
      print("Exception on the api$e");
      CommonController.to.buttonLoader = false;
    }
  }


  getLeaveSettings() async {
    leaveSettingsLoader = true;
    var body = {"branch_id": SettingsController.to.branchId.text};
    try {
      var response = GetStorage().read("RequestEncryption") == true
          ? await _http.multipartPostData(
          url: "${Api.leaveSettingsList}",
          encryptMessage:
          await LibSodiumAlgorithm().encryptionMessage(body),
          auth: true)
          : await _http.post(Api.leaveSettingsList, body,
          auth: true, contentHeader: false);
      if (response['code'] == "200") {
        print("api response of the company save $response");
        leaveSettingsListModel = LeaveSettingsListModel.fromJson(response);
      } else {
        UtilService()
            .showToast("error", message: response['message'].toString());
      }
    } catch (e) {
      print("Exception on the api$e");
      CommonController.to.buttonLoader = false;
    }
    leaveSettingsLoader = false;
  }
}