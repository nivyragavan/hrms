import 'package:dreamhrms/services/HttpHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResignationApprovalController extends GetxController {
  static ResignationApprovalController get to =>
      Get.put(ResignationApprovalController());
  static final HttpHelper _http = HttpHelper();
  BuildContext? context = Get.context;

  TextEditingController member = TextEditingController();
  TextEditingController noticeDays = TextEditingController();


  onClose(){
    member.clear();
    noticeDays.clear();
  }
}
