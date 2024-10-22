import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../model/employee_asset_model.dart';
import '../../services/HttpHelper.dart';
import '../../services/api_service.dart';
import '../../services/utils.dart';
import '../../widgets/encrypt_decrypt.dart';
import '../employee/employee_controller.dart';

class AssetController extends GetxController {
  static AssetController get to => Get.put(AssetController());

  static final HttpHelper _http = HttpHelper();

  final _showAssetList = false.obs;

  get showAssetList => _showAssetList.value;

  set showAssetList(value) {
    _showAssetList.value = value;
  }
  final _selectedIndex=0.obs;

  get selectedIndex => _selectedIndex.value;

  set selectedIndex(value) {
    _selectedIndex.value = value;
  }

  BuildContext? context = Get.context;
  EmployeeAssetModel? employeeAssetModel;
  getAssetList() async {
    showAssetList = true;
    var body = {"user_id": EmployeeController.to.selectedUserId.toString()};
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
            url: "${Api.assets}",
            encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
            auth: true)
        : await _http.post(Api.assets, body,
            auth: true, contentHeader: false);
    print("return response assets controller ${response}");
    if (response['code'] == "200") {
      employeeAssetModel = EmployeeAssetModel.fromJson(response);
    } else {
      UtilService()
          .showToast("error", message: response['message'].toString());
    }
    showAssetList = false;
  }

}
