
import 'package:dreamhrms/services/HttpHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


enum OfferApprovalType { SequenceApproval, SimultaneousApproval }

class OfferApprovalController extends GetxController {
  static OfferApprovalController get to =>
      Get.put(OfferApprovalController());
  static final HttpHelper _http = HttpHelper();
  BuildContext? context = Get.context;
  final expenseType = OfferApprovalType.SequenceApproval.obs;


  onClose(){

  }
}
