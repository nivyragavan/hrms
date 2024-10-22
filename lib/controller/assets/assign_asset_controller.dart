import 'package:dreamhrms/controller/common_controller.dart';
import 'package:dreamhrms/services/utils.dart';
import 'package:dreamhrms/widgets/encrypt_decrypt.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../services/HttpHelper.dart';
import '../../services/api_service.dart';

class AssignAssetController extends GetxController {
  static AssignAssetController get to => Get.put(AssignAssetController());
  static final HttpHelper _http = HttpHelper();
  BuildContext? context = Get.context;
  TextEditingController assetName = TextEditingController();
  TextEditingController assetID = TextEditingController();
  TextEditingController id = TextEditingController();
  TextEditingController assignedTo = TextEditingController();
  TextEditingController depName = TextEditingController();
  TextEditingController depId = TextEditingController();
  TextEditingController empName = TextEditingController();
  TextEditingController empId = TextEditingController();
  TextEditingController position = TextEditingController();
  TextEditingController assignDate = TextEditingController();
  TextEditingController expectedReturnDate = TextEditingController();

  final _emailNotification = false.obs;

  get emailNotification => _emailNotification.value;

  set emailNotification(value) {
    _emailNotification.value = value;
  }

  final _addDepartment = false.obs;

  get addDepartment => _addDepartment.value;

  set addDepartment(value) {
    _addDepartment.value = value;
  }


  assignAssets() async {
    var body = {
      "asset_id": id.text,
      "employee_id": empId.text,
      "assign_date": assignDate.text,
      "expected_return_date": expectedReturnDate.text,
      "email_notification":emailNotification == true ? "1":"0",
    };
    print(body);
    try {
      var response = GetStorage().read("RequestEncryption") == true
          ? await _http.multipartPostData(
              url: "${Api.assignAsset}",
              encryptMessage:
                  await LibSodiumAlgorithm().encryptionMessage(body),
              auth: true)
          : await _http.post(Api.addAsset, body,
              auth: true, contentHeader: false);
      if (response['code'] == "200") {
        Get.back();
        // Get.to(() => Leave());
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

  onClose() {
    assetName.clear();
    assetID.clear();
    assignedTo.clear();
    depName.clear();
    empName.clear();
    empId.clear();
    position.clear();
    id.clear();
    assignDate.clear();
    expectedReturnDate.clear();
    Get.delete<AssignAssetController>();
  }
}
