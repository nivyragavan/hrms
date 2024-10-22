import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';

import '../../model/team/admin_team_model.dart';
import '../../model/team/employee_team_model.dart';
import '../../services/HttpHelper.dart';
import '../../services/api_service.dart';
import '../../services/utils.dart';
import '../../widgets/encrypt_decrypt.dart';
import '../employee/employee_controller.dart';

class TeamController extends GetxController{
  static TeamController get to=>Get.put(TeamController());
  EmployeeTeamModel? employeeTeamModel;
  AdminTeamsModel? adminTeamsModel;
  static final HttpHelper _http = HttpHelper();
  BuildContext? context = Get.context;
final _showTeamList=false.obs;

  get showTeamList => _showTeamList.value;

  set showTeamList(value) {
    _showTeamList.value = value;
  }

  getEmployeeTeamList() async {
    showTeamList=true;
    var body={
      "user_id":EmployeeController.to.selectedUserId.toString()
    };
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
        url: "${Api.employeeTeamList}",
        encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
        auth: true)
        : await _http.post(Api.employeeTeamList, body,
        auth: true, contentHeader: false);

    if (response['code'] == "200") {
      employeeTeamModel = EmployeeTeamModel.fromJson(response);
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
    showTeamList=false;
  }

  getAdminTeamList() async {
    showTeamList=true;
    // var body={
    //   "user_id":EmployeeController.to.selectedUserId.toString()
    // };
    // var response = GetStorage().read("RequestEncryption") == true
    //     ? await _http.multipartPostData(
    //     url: "${Api.adminTeamList}",
    //     encryptMessage: await LibSodiumAlgorithm().encryptionMessage(""),
    //     auth: true)
    //     : await _http.post(Api.adminTeamList, body,
    //     auth: true, contentHeader: false);
    var response=await _http.post(Api.adminTeamList, "",
        auth: true, contentHeader: false);
    if (response['code'] == "200") {
      adminTeamsModel = AdminTeamsModel.fromJson(response);
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
    showTeamList=false;

  }
}