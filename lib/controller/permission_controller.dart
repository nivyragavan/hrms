import 'package:dreamhrms/model/leave/leave_history_model.dart';
import 'package:dreamhrms/model/leave/leave_master.dart';
import 'package:dreamhrms/model/leave/leave_type_model.dart';
import 'package:dreamhrms/services/HttpHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../model/leave/leave_request_model.dart';
import '../services/api_service.dart';
import '../services/utils.dart';
import '../widgets/encrypt_decrypt.dart';

class PermissionController extends GetxController {
  static PermissionController get to => Get.put(PermissionController());
  static final HttpHelper _http = HttpHelper();
  BuildContext? context = Get.context;
  TextEditingController fromDateFilter = TextEditingController();
  TextEditingController toDateFilter = TextEditingController();
  TextEditingController requestType = TextEditingController();
  TabController? tabController;
  LeaveTypeModel? leaveTypeModel;
  LeaveMasterModel? leaveMasterModel;
  LeaveHistory? leaveHistory;
  LeaveRequest? leaveRequest;
  final _showList = false.obs;
  get showList => _showList.value;

  set showList(value) {
    _showList.value = value;
  }
  final _showType = false.obs;
  get showType => _showType.value;

  set showType(value) {
    _showType.value = value;
  }

  final _isExpand = false.obs;
  get isExpand => _isExpand.value;

  set isExpand(value) {
    _isExpand.value = value;
  }

  getLeaveTypes() async {
    showType = true;
    var response =
    await _http.post(Api.leaveType, "", auth: true, contentHeader: false);
    if (response['code'] == "200") {
      leaveTypeModel = LeaveTypeModel.fromJson(response);
      print(leaveTypeModel?.message);
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
    showType = false;
  }

  getLeaveMasterTypes() async {
    showType = true;
    var response =
    await _http.post(Api.leaveMaster, "", auth: true, contentHeader: false);
    if (response['code'] == "200") {
      leaveMasterModel = LeaveMasterModel.fromJson(response);
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
    showType = false;
  }

  getPermissionHistory() async {
    showList = true;
    var body = {"from_date": fromDateFilter.text,"to_date": toDateFilter.text,"request_type": "permission"};
    print("body $body");
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
        url: "${Api.leaveHistory}",
        encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
        auth: true)
        : await _http.post(Api.leaveHistory, body,
        auth: true, contentHeader: false);
    if (response['code'] == "200") {
      debugPrint("Yes");
      leaveHistory = LeaveHistory.fromJson(response);
      leaveRequest = LeaveRequest.fromJson(response);
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
    showList = false;
  }



  @override
  void onClose() {
    fromDateFilter.text = "";
    toDateFilter.text = "";
    Get.delete<PermissionController>();
    super.onClose();
  }
}
