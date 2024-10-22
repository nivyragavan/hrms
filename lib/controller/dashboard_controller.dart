import 'package:get/get.dart';

import '../model/dashboard/dashboard_model.dart';
import '../services/HttpHelper.dart';
import '../services/api_service.dart';
import '../services/utils.dart';

class DashboardController extends GetxController{
  static DashboardController get to=>Get.put(DashboardController());
  static final HttpHelper _http = HttpHelper();

  DashboardAdminModel?  dashboardAdminModel;
  final _loader=false.obs;

  get loader => _loader.value;

  set loader(value) {
    _loader.value = value;
  }


  getDashboardAdmin() async {
    loader = true;
    var response = await _http.post(Api.dashboardAdmin, "", auth: true, contentHeader: false);
    if (response['code'] == "200") {
      dashboardAdminModel = DashboardAdminModel.fromJson(response);
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
    loader = false;
  }
}