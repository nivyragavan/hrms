import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../model/settings/BranchModel.dart';
import '../../services/HttpHelper.dart';
import '../../services/api_service.dart';
import '../../services/utils.dart';
import '../../widgets/encrypt_decrypt.dart';
import '../common_controller.dart';

class SettingsController extends GetxController {
  static SettingsController get to => Get.put(SettingsController());
  static final HttpHelper _http = HttpHelper();
  BranchListModel? branchListModel;
  TextEditingController branchId = TextEditingController();
  TextEditingController branch = TextEditingController();
  final _branchLoader = false.obs;

  get branchLoader => _branchLoader.value;

  set branchLoader(value) {
    _branchLoader.value = value;
  }

  getBranchList() async {
    branchLoader = true;
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
            url: "${Api.branchList}",
            encryptMessage: await LibSodiumAlgorithm().encryptionMessage({}),
            auth: true)
        : await _http.post(Api.branchList, {},
            auth: true, contentHeader: false);
    if (response['code'] == "200") {
      branchListModel = BranchListModel.fromJson(response);
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
    branchLoader = false;
  }

  organizationDelete() async {
    var body = {
      "branch_id": '${SettingsController.to.branchId.text}',
    };
    try {
      var response = GetStorage().read("RequestEncryption") == true
          ? await _http.multipartPostData(
              url: "${Api.organizationDelete}",
              encryptMessage:
                  await LibSodiumAlgorithm().encryptionMessage(body),
              auth: true)
          : await _http.post(Api.organizationDelete, body,
              auth: true, contentHeader: false);
      if (response['code'] == "200") {
        UtilService()
            .showToast("success", message: response['message'].toString());
        branch.text="";
        branchId.text="";
        Get.back();
        getBranchList();
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
