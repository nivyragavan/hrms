import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../../model/attendance/employee_attendance_model.dart';
import '../../services/HttpHelper.dart';
import '../../services/api_service.dart';
import '../../services/utils.dart';
import '../../widgets/encrypt_decrypt.dart';
import '../common_controller.dart';

class EmployeeAttendanceController extends GetxController {
  static EmployeeAttendanceController get to =>
      Get.put(EmployeeAttendanceController());

  static final HttpHelper _http = HttpHelper();
  EmployeeAttendanceModel? employeeAttendanceModel;

  TextEditingController fromDateController=TextEditingController();
  TextEditingController toDateController=TextEditingController();

  final _employeeAttendanceLoader = false.obs;

  get employeeAttendanceLoader => _employeeAttendanceLoader.value;

  set employeeAttendanceLoader(value) {
    _employeeAttendanceLoader.value = value;
  }

  final _punchType="".obs;

  get punchType => _punchType.value;

  set punchType(value) {
    _punchType.value = value;
  }

  getEmployeeAttendanceList({required String type}) async {
    employeeAttendanceLoader = true;
    if(type=="1"){
      DateTime current_date = DateTime.now();
      EmployeeAttendanceController.to.fromDateController.text=DateFormat('yyyy-MM-dd').format(current_date);
      EmployeeAttendanceController.to.toDateController.text=DateFormat('yyyy-MM-dd').format(current_date);
    }
    var body = {
      "user_id": GetStorage().read('login_userid'),
      "from_date": fromDateController.text,
      "to_date": toDateController.text,
      "type": '${type}'
    };
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
            url: "${Api.employeeAttendance}",
            encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
            auth: true)
        : await _http.post(Api.employeeAttendance, body,
            auth: true, contentHeader: false);
    if (response['code'] == "200") {
      employeeAttendanceModel = EmployeeAttendanceModel.fromJson(response);
      print("Punch details ${employeeAttendanceModel?.data?.livePunchIn} out ${employeeAttendanceModel?.data?.livePunchOut}");
      employeeAttendanceModel?.data?.livePunchIn=="00:00:00"?punchType="Check In":
      employeeAttendanceModel?.data?.livePunchOut=="00:00:00"?punchType="Check Out":punchType="Check In";
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
    employeeAttendanceLoader = false;
  }

  postPunch({required String currentTime}) async {
    var body={
      punchType=="Check In"?"punch_in":"punch_out": '$currentTime'
    };
    print("body$body");
    try{
      var response = GetStorage().read("RequestEncryption") == true
          ? await _http.multipartPostData(
          url: "${Api.manualPunch}",
          encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
          auth: true)
          : await _http.post(Api.manualPunch, body,
          auth: true, contentHeader: false);
      print('response code${response['code']}');
      if (response['code'].toString() == "200") {
        await getEmployeeAttendanceList(type: "1");
        UtilService().showToast("success", message: response['message'].toString());
      } else {
        UtilService().showToast("error", message: response['message'].toString());
      }
    }catch (e) {
      print("Exception on the api$e");
      CommonController.to.buttonLoader = false;
    }

  }

}
