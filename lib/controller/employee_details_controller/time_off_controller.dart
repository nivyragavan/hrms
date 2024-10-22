import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../model/leave/leave_history_model.dart';
import '../../model/time_off_model.dart';
import '../../services/HttpHelper.dart';
import '../../services/api_service.dart';
import '../../services/utils.dart';
import '../../widgets/encrypt_decrypt.dart';
import '../employee/employee_controller.dart';

class TimeOffController extends GetxController {
  static TimeOffController get to => Get.put(TimeOffController());

  static final HttpHelper _http = HttpHelper();
  BuildContext? context = Get.context;
  EmployeeTimeOffModel? employeeTimeOffModel;
  TabController? tabController;

  final _showTimeOffList = false.obs;

  get showTimeOffList => _showTimeOffList.value;

  set showTimeOffList(value) {
    _showTimeOffList.value = value;
  }

  final _countLoader=false.obs;

  get countLoader => _countLoader.value;

  set countLoader(value) {
    _countLoader.value = value;
  }

  final _permissionButton = false.obs;

  get permissionButton => _permissionButton.value;

  set permissionButton(value) {
    _permissionButton.value = value;
  }

  final _leaveButton = true.obs;

  get leaveButton => _leaveButton.value;

  set leaveButton(value) {
    _leaveButton.value = value;
  }

  LeaveHistory? leaveHistory;
  LeaveHistory? permissionHistory;

  final _showList = false.obs;
  get showList => _showList.value;

  set showList(value) {
    _showList.value = value;
  }

  final _userId = "".obs;

  get userId => _userId.value;

  set userId(value) {
    _userId.value = value;
  }

  int total_leave = 0;
  int taken_leave = 0;
  int remaining_leave = 0;
  getTimeOffList() async {
    showTimeOffList = true;
    var body = {"user_id": EmployeeController.to.selectedUserId.toString()};
    print("body $body");
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
            url: "${Api.time_off}",
            encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
            auth: true)
        : await _http.post(Api.time_off, body,
            auth: true, contentHeader: false);
    if (response['code'] == "200") {
      employeeTimeOffModel = EmployeeTimeOffModel.fromJson(response);
      TimeOffController.to.countLoader=true;
      Future.delayed(Duration(seconds: 2)).then((value){
        TimeOffController.to.countLoader=false;
      });
    } else {
      UtilService()
          .showToast("error", message: response['message'].toString());
    }
    showTimeOffList = false;
  }

  getLeaveHistory() async {
    showList = true;
    var body = {"request_type": "leave"};
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
        url: "${Api.leaveHistory}",
        encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
        auth: true)
        : await _http.post(Api.leaveHistory, body,
        auth: true, contentHeader: false);
    if (response['code'] == "200") {
      // List<dynamic> historyList = response['data']['history_list']['data'];
      // List<dynamic> filteredHistoryList = historyList
      //     .where((element) =>
      // element['user_id'].toString() ==
      //     EmployeeController.to.selectedUserId.toString())
      //     .toList();
      //
      // if (filteredHistoryList.isNotEmpty) {
      //   leaveHistory = LeaveHistory.fromJson({
      //     "data": {
      //       "history_list": {"data": filteredHistoryList}
      //     }
      //   });
      // }
      leaveHistory = LeaveHistory.fromJson(response);
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
    showList = false;
  }

  getPermissionHistory() async {
    showList = true;
    var body = {"request_type": "permission"};
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
        url: "${Api.leaveHistory}",
        encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
        auth: true)
        : await _http.post(Api.leaveHistory, body,
        auth: true, contentHeader: false);
    if (response['code'] == "200") {
      List<dynamic> historyList = response['data']['history_list']['data'];
      List<dynamic> filteredHistoryList = historyList
          .where((element) =>
      element['user_id'].toString() ==
          EmployeeController.to.selectedUserId.toString())
          .toList();

      if (filteredHistoryList.isNotEmpty) {
        permissionHistory = LeaveHistory.fromJson({
          "data": {
            "history_list": {"data": filteredHistoryList}
          }
        });
      }
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
    showList = false;
  }
}
