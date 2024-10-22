import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../model/asset/admin_asset_list.dart';
import '../../services/HttpHelper.dart';
import '../../services/api_service.dart';
import '../../services/utils.dart';
import '../../widgets/encrypt_decrypt.dart';

class AdminAssetController extends GetxController{
  static AdminAssetController get to=>Get.put(AdminAssetController());

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAdminAssetList();
  }
  static final HttpHelper _http = HttpHelper();
  AdminAssetsListModel? adminAssetsListModel;
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

  getAdminAssetList() async {
    showAssetList = true;
    var response = await _http.post(Api.adminAssetList, "",
        auth: true, contentHeader: false);
    if (response['code'] == "200") {
      adminAssetsListModel = AdminAssetsListModel.fromJson(response);
      print("Admin asset list $response");
    } else {
      UtilService()
          .showToast("error", message: response['message'].toString());
    }
    showAssetList = false;
  }
}