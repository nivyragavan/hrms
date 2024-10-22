import 'package:dreamhrms/controller/settings/settings.dart';
import 'package:dreamhrms/model/settings/system/leave_approval_settings_model.dart';
import 'package:dreamhrms/screen/main_screen.dart';
import 'package:dreamhrms/services/HttpHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../model/asset/approval_employee_list_model.dart';
import '../../../model/settings/system/approval_settings_list_model.dart';
import '../../../model/settings/system/user_master_model.dart';
import '../../../services/api_service.dart';
import '../../../services/utils.dart';
import '../../../widgets/encrypt_decrypt.dart';
import '../../common_controller.dart';

enum LeaveApprovalType { SequenceApproval, SimultaneousApproval }

class LeaveApprovalController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    approvalModel = ApprovalModel(approval: []);
    approvalModel?.approval
        ?.insert(0, Approval(id: "", firstName: "", lastName: ""));
    super.onInit();
  }

  static LeaveApprovalController get to => Get.put(LeaveApprovalController());
  static final HttpHelper _http = HttpHelper();
  BuildContext? context = Get.context;
  final approvalType = LeaveApprovalType.SequenceApproval.obs;
  ApprovalModel? approvalModel;
  ApprovalSettingsListModel? approvalSettingsModel;
  TextEditingController empName = TextEditingController();
  TextEditingController branchId = TextEditingController();
  UserMasterModel? userMasterModel;
  LeaveApprovalSettingsModel? leaveApprovalSettingsModel;
  List<ApprovalDataList> _approvalSettingListModel = [];
  List<ApprovalDataList> get approvalSettingListModel {
    return _approvalSettingListModel;
  }
  set approvalSettingListModel(List<ApprovalDataList> newData) {
    _approvalSettingListModel = newData;
  }
  List<LeaveApprovalSettingsModel> _updateData = [];
  List<LeaveApprovalSettingsModel> get updateData {
    return _updateData;
  }
  set updateData(List<LeaveApprovalSettingsModel> newData) {
    _updateData = newData;
  }
  final _showList = false.obs;
  get showList => _showList.value;
  set showList(value) {
    _showList.value = value;
  }
  final _showApproverList = false.obs;
  get showApproverList => _showApproverList.value;
  set showApproverList(value) {
    _showApproverList.value = value;
  }
  int _approverCount = 1;
  get approverCount => _approverCount;
  set approverCount(value) {
    _approverCount = value;
  }

  final _approverItemLoader = false.obs;
  get approverItemLoader => _approverItemLoader.value;
  set approverItemLoader(value) {
    _approverItemLoader.value = value;
  }

  final _approverLoader = false.obs;
  get approverLoader => _approverLoader.value;
  set approverLoader(value) {
    _approverLoader.value = value;
  }
  List<Map<String, dynamic>>? updatedLeaveSettings = [];
  postLeaveSettingsApproval() async {
     updatedLeaveSettings =
        LeaveApprovalController.to.updateData
            .map((data) => {
                  "approver_id": data.approverId,
                  "approver_level": data.approverLevel,
                })
            .toList();
    var body = {
      "default_leave_approval":
          approvalType.value == "SequenceApproval" ? "1" : "2",
      "branch_id": SettingsController.to.branchId.text,
      "approvers": updatedLeaveSettings,
    };
    debugPrint(body.toString());
    try {
      var response = GetStorage().read("RequestEncryption") == true
          ? await _http.multipartPostData(
              url: "${Api.approvalLeaveSettings}",
              encryptMessage:
                  await LibSodiumAlgorithm().encryptionMessage(body),
              auth: true)
          : await _http.post(Api.approvalLeaveSettings, body,
              auth: true, contentHeader: false);
      if (response['code'] == "200") {
        print("response ${response.toString()}");
        UtilService()
            .showToast("success", message: response['message'].toString());
        Get.to(()=> MainScreen());
      } else {
        UtilService()
            .showToast("error", message: response['message'].toString());
      }
    } catch (e) {
      print("Exception on the api$e");
      CommonController.to.buttonLoader = false;
    }
  }

  getUserMaster() async {
    showList = true;
    var response = await _http.get(
      Api.userMaster,
      auth: true,
    );
    if (response['code'] == "200") {
      userMasterModel = UserMasterModel.fromJson(response);
      print(response['message']);

    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
    showList = false;
  }

  getApprovalSettingsList() async {
    showApproverList = true;
    var body = {'branch_id': SettingsController.to.branchId.text};
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
            url: "${Api.approvalList}",
            encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
            auth: true)
        : await _http.post(Api.approvalList, body,
            auth: true, contentHeader: false);
    if (response['code'] == "200") {
      approvalSettingsModel = ApprovalSettingsListModel.fromJson(response);
       updateData = approvalSettingsModel!.data!.approvalListData!.map((item) {
        return LeaveApprovalSettingsModel(
          approverId: (item.approverId ?? 0).toString(),
          approverLevel: (item.approverLevel ?? 0).toString(),
          // Add other properties as needed
        );
      }).toList();
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }

  }

  setApprovalListInformation() {
    approverItemLoader = true;
    if (approvalSettingsModel?.data?.approvalListData != null &&
        userMasterModel?.data != null) {
      approvalSettingsModel?.data?.approvalListData?.forEach((approvalItem) {
        userMasterModel?.data?.forEach((userItem) {
          if (approvalItem.approverId == userItem.id) {
            print(" Items ${approvalItem.approverId} ${userItem.id}");
            final localData = approvalItem;
            localData.firstName = userItem.firstName;
            localData.lastName = userItem.lastName;
            approvalSettingListModel.add(localData);
          }
        });
      });
    }
    print(approvalSettingListModel.length);
    approverItemLoader = false;

  }

  clear() {
    empName.clear();
    updatedLeaveSettings?.clear();
    approvalSettingListModel.clear();
    updateData.clear();
  }
}
