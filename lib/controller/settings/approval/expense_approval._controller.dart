import 'package:dreamhrms/model/asset/approval_employee_list_model.dart';
import 'package:dreamhrms/services/HttpHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ExpenseApprovalType { SequenceApproval, SimultaneousApproval }

class ExpenseApprovalController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    approvalSettingsModel = ApprovalModel(approval: []);
    approvalSettingsModel?.approval
        ?.insert(0, Approval(id: "", firstName: "", lastName: ""));
    super.onInit();
  }

  static ExpenseApprovalController get to =>
      Get.put(ExpenseApprovalController());
  static final HttpHelper _http = HttpHelper();
  BuildContext? context = Get.context;
  final expenseType = ExpenseApprovalType.SequenceApproval.obs;
  ApprovalModel? approvalSettingsModel;
  TextEditingController empName = TextEditingController();


  onClose(){
    empName.clear();
  }
}
