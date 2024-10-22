import 'package:dreamhrms/controller/department/add_department_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../model/department_model.dart';
import '../../model/position_model.dart';
import '../../services/HttpHelper.dart';
import '../../services/api_service.dart';
import '../../services/utils.dart';
import '../../widgets/encrypt_decrypt.dart';

class DepartmentController extends GetxController {
  static DepartmentController get to => Get.put(DepartmentController());

  static final HttpHelper _http = HttpHelper();

  final _showDepartmentList = false.obs;

  get showDepartmentList => _showDepartmentList.value;

  set showDepartmentList(value) {
    _showDepartmentList.value = value;
  }

  final _positionSwitch = false.obs;

  get positionSwitch => _positionSwitch.value;

  set positionSwitch(value) {
    _positionSwitch.value = value;
  }

  final _switchLoader = false.obs;

  get switchLoader => _switchLoader.value;

  set switchLoader(value) {
    _switchLoader.value = value;
  }

  BuildContext? context = Get.context;
  DepartmentModel? departmentModel;
  PositionModel? positionModel;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 0)).then((value) async {
          print("department.............");
          await DepartmentController.to.getDepartmentList();
          DepartmentController.to.showDepartmentList = true;
          await AddDepartmentController.to.getGradeList();
          DepartmentController.to.showDepartmentList = false;
        });
  }

  storePositionModel(String id) {
    AddDepartmentController.to.positionLoader = true;
    final value = departmentModel?.data
        ?.where((data) => data.departmentId == id)
        .toList();
    var filteredData = {
      "data": [value?.first.toJson()]
    };
    print("Position filteredData ${filteredData}");
    positionModel = PositionModel.fromJson(filteredData);
    print("Position model ${positionModel}");
    AddDepartmentController.to.positionController.text = "";
    AddDepartmentController.to.descRequired = false;
    Future.delayed(Duration(seconds: 1)).then((value) => AddDepartmentController.to.positionLoader = false);
  }

  getDepartmentList() async {
    showDepartmentList = true;
    var response = await _http.get(Api.departmentList, auth: true);
    if (response['code'] == "200") {
      departmentModel = DepartmentModel.fromJson(response);
      print(
          'departmentModel${DepartmentController.to.departmentModel?.data?.length}');
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
    showDepartmentList = false;
  }

  PositionStatus(int status, String departmentId) async {
    var body = {"status": "$status", "id": "$departmentId"};
    print("body request data $body");
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
            url: "${Api.positionStatusChange}",
            encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
            auth: true)
        : await _http.post(Api.positionStatusChange, body,
            auth: true, contentHeader: false);
    if (response['code'] == "200") {
      print('Department Response ${response}');
      await getDepartmentList();
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
  }


  checkProfileImage(int? length) {
    if (length! > 3) {
      return true;
    } else {
      return false;
    }
  }
}
