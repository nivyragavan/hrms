import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../services/HttpHelper.dart';
import '../../services/api_service.dart';
import '../../services/utils.dart';
import '../../widgets/encrypt_decrypt.dart';
import '../common_controller.dart';

enum OffBoardingType { Resignation, Termination }

class EmployeeOffBoardingController extends GetxController {
  static EmployeeOffBoardingController get to =>
      Get.put(EmployeeOffBoardingController());
 @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    resigningEmployee.text = GetStorage().read("emp_name");
    terminatedEmployee.text = GetStorage().read("emp_name");
  }
  static final HttpHelper _http = HttpHelper();
  final offBoardingType = OffBoardingType.Resignation.obs;
  TextEditingController resigningEmployee = TextEditingController();
  TextEditingController terminatedEmployee = TextEditingController();
  TextEditingController resignationDate = TextEditingController();
  TextEditingController terminationDate = TextEditingController();
  TextEditingController resignationReason = TextEditingController();
  TextEditingController terminationReason = TextEditingController();
  TextEditingController noticeDate = TextEditingController();
  TextEditingController terminationType = TextEditingController();
  TextEditingController terminationTypeId = TextEditingController();
  TextEditingController lastDate = TextEditingController();
  TextEditingController userId = TextEditingController();

  terminationOffBoarding(String userId) async {
    var body = {
      "user_id": userId,
      "type": "1",
      "termination_type": terminationTypeId.text,
      "last_date": lastDate.text,
      "termination_date": terminationDate.text,
      "leave_reason": terminationReason.text
    };
    debugPrint(body.toString());
    try {
      var response = GetStorage().read("RequestEncryption") == true
          ? await _http.multipartPostData(
              url: "${Api.empOffBoarding}",
              encryptMessage:
                  await LibSodiumAlgorithm().encryptionMessage(body),
              auth: true)
          : await _http.post(Api.addHoliday, body,
              auth: true, contentHeader: false);
      if (response['code'] == "200") {
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

  resignationOffBoarding(String userId) async {
    var body = {
      "user_id": userId,
      "type": "0",
      "resign_date": resignationDate.text,
      "notice_date": noticeDate.text,
      "leave_reason": resignationReason.text
    };
    debugPrint(body.toString());
    try {
      var response = GetStorage().read("RequestEncryption") == true
          ? await _http.multipartPostData(
              url: "${Api.empOffBoarding}",
              encryptMessage:
                  await LibSodiumAlgorithm().encryptionMessage(body),
              auth: true)
          : await _http.post(Api.empOffBoarding, body,
              auth: true, contentHeader: false);
      if (response['code'] == "200") {
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
}
