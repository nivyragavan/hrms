import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../../model/admin_timesheet_model.dart';
import '../../model/employee_timesheet_model.dart';
import '../../services/HttpHelper.dart';
import '../../services/api_service.dart';
import '../../services/utils.dart';
import '../../widgets/encrypt_decrypt.dart';
import '../employee/employee_controller.dart';

class TimeSheetController extends GetxController {
  static TimeSheetController get to => Get.put(TimeSheetController());

  static final HttpHelper _http = HttpHelper();
  EmployeeTimeSheetModel? employeeTimeSheetModel;
  AdminTimeSheetModel? adminTimeSheetModel;
  BuildContext? context = Get.context;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  List date = [];

  final _showTimeSheetList = false.obs;

  get showTimeSheetList => _showTimeSheetList.value;

  set showTimeSheetList(value) {
    _showTimeSheetList.value = value;
  }

  final _attendanceDate = "".obs;

  get attendanceDate => _attendanceDate.value;

  set attendanceDate(value) {
    _attendanceDate.value = value;
  }

  final _attendanceStartDate = "".obs;

  get attendanceStartDate => _attendanceStartDate.value;

  set attendanceStartDate(value) {
    _attendanceStartDate.value = value;
  }

  final _attendanceEndDate = "".obs;

  get attendanceEndDate => _attendanceEndDate.value;

  set attendanceEndDate(value) {
    _attendanceEndDate.value = value;
  }

  setDateFormat() {
    print(
      DateTime(DateTime.now().year, DateTime.now().month, 01),
    );
    date.clear();
    date.insert(0,
        "${DateFormat.y().format(DateTime.now())}-${DateFormat.M().format(DateTime.now())}-01");
    date.insert(1,
        "${DateFormat.y().format(DateTime.now())}-${DateFormat.M().format(DateTime.now())}-${DateFormat.d().format(DateTime.now())}");
    attendanceStartDate =
        "${DateFormat.y().format(DateTime.now())}-${DateFormat.M().format(DateTime.now()).padLeft(2, '0')}-${DateFormat.d().format(DateTime.now()).padLeft(2,'0')}";//-01
    attendanceEndDate =
        "${DateFormat.y().format(DateTime.now())}-${DateFormat.M().format(DateTime.now()).padLeft(2, '0')}-${DateFormat.d().format(DateTime.now()).padLeft(2, '0')}";
    //attendance date 01
    attendanceDate = "${DateFormat.d().format(DateTime.now()).padLeft(2,'0')} ${DateFormat.LLL().format(DateTime.now())} -"
        " ${DateFormat.d().format(DateTime.now())} ${DateFormat.LLL().format(DateTime.now())} ${DateFormat.y().format(DateTime.now())} ";
    print("attendance date $attendanceStartDate");
  }

  getTimeSheetList(filter) async {
    showTimeSheetList = true;
    var body = filter != true
        ? {
            "user_id": GetStorage().read("login_userid"),
            "view_type": "report",
            "from_date": attendanceStartDate,
            "to_date": attendanceEndDate,
          }
        : {
            "from_date": date[0],
            "to_date": date[1],
            "user_id": GetStorage().read("login_userid"),
            "view_type": "report"
          };
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
            url: "${Api.timeSheet}",
            encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
            auth: true)
        : await _http.post(Api.timeSheet, body,
            auth: true, contentHeader: false);
    if (response['code'] == "200") {
      employeeTimeSheetModel = EmployeeTimeSheetModel.fromJson(response);
    } else {
      print("error message ..... ${response['message']}");
      UtilService()
          .showToast( "error", message: "Something went wrong. Try again later".toString());
    }
    showTimeSheetList = false;
  }
  List pieGraph = [
    {"attendance": "attendance", "count": 75}
  ];
  getAdminTimeSheet(filter) async {
    showTimeSheetList = true;
    var body = filter != true
        ? {
            "view_type": "report",
            "from_date": attendanceStartDate,
            "to_date": attendanceEndDate
          }
        : {"from_date": date[0], "to_date": date[1], "view_type": "report"};

    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
            url: "${Api.adminTimeSheet}",
            encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
            auth: true)
        : await _http.post(Api.adminTimeSheet, body,
            auth: true, contentHeader: false);
    if (response['code'] == "200") {
      Map<String, dynamic> jsonData =response ;
      adminTimeSheetModel = AdminTimeSheetModel.fromJson(jsonData);
      print(
          'adminTimeSheetModel adminTimeSheetModel${adminTimeSheetModel?.data?.userData?[0].name}');
    } else {
      UtilService()
          .showToast("error", message: response['message'].toString());
    }
    showTimeSheetList = false;
  }
}
