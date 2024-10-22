import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../json/Localjson.dart';
import '../../model/attendance/attendance_model.dart';
import '../../services/HttpHelper.dart';
import '../../services/api_service.dart';
import '../../services/utils.dart';
import '../../widgets/encrypt_decrypt.dart';
import '../employee_details_controller/time_sheet_controller.dart';
import '../login_controller.dart';

class AttendanceController extends GetxController {
  static AttendanceController get to => Get.put(AttendanceController());

  static final HttpHelper _http = HttpHelper();
  AttendanceModel? attendanceModel;

  List pieGraph = [];

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  final _showAttendanceList = false.obs;

  get showAttendanceList => _showAttendanceList.value;

  set showAttendanceList(value) {
    _showAttendanceList.value = value;
  }

  final _loader = false.obs;

  get loader => _loader.value;

  set loader(value) {
    _loader.value = value;
  }

  attendanceList(filter) async {
    print("LoginController.to.loginModel?.data?.original?.user?.id${GetStorage().read("login_userid")}");
    showAttendanceList = true;
    var body = filter == true
        ? {
            "from_date": TimeSheetController.to.date[0],
            "to_date": TimeSheetController.to.date[1],
            "option": "all",
            "type": "1",
            "user_id": GetStorage().read("login_userid"),
          }
        : {
            "option": "all",
            "type": "1",
            // "user_id": GetStorage().read("login_userid"),
            "from_date": TimeSheetController.to.attendanceStartDate,
            "to_date": TimeSheetController.to.attendanceEndDate,
          };
    pieGraph.clear();
    pieGraph.add({"attendance": "absent", "count": 50});
    pieGraph.add({"attendance": "present", "count": 50});
    pieGraph.add({"attendance": "permission", "count": 50});
    pieGraph.add({"attendance": "late entry", "count": 50});

    // pieGraph.add({
    //   "attendance": "present",
    //   "count": int.tryParse(
    //           attendanceModel?.data?.headerCalculation?.presentUsers ??
    //               "".replaceAll('%', '')) ??
    //       20
    // }); //'${attendanceModel?.data?.headerCalculation?.presentUsers??0}'});
    // pieGraph.add({
    //   "attendance": "absent",
    //   "count": int.tryParse(
    //           attendanceModel?.data?.headerCalculation?.absentUsers ??
    //               "".replaceAll('%', '')) ??
    //       20
    // }); //'${attendanceModel?.data?.headerCalculation?.presentUsers??0}'});
    // pieGraph.add({
    //   "attendance": "permission",
    //   "count": int.tryParse(
    //           attendanceModel?.data?.headerCalculation?.permissionUsers ??
    //               "".replaceAll('%', '')) ??
    //       20
    // }); //'${attendanceModel?.data?.headerCalculation?.presentUsers??0}'});
    // pieGraph.add({
    //   "attendance": "late entry",
    //   "count": int.tryParse(
    //           attendanceModel?.data?.headerCalculation?.lateEntryUsers ??
    //               "".replaceAll('%', '')) ??
    //       20
    // });

    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
            url: "${Api.adminAttendance}",
            encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
            auth: true)
        : await _http.post(Api.adminAttendance, body,
            auth: true, contentHeader: false);
    if (response['code'] == "200") {
      attendanceModel = AttendanceModel.fromJson(response);
      // pieGraph.add( {"attendance": "absent", "count": 100});//'${attendanceModel?.data?.headerCalculation?.absentUsers??0}'});
      // pieGraph.add( {"attendance": "permission", "count": 100});//'${attendanceModel?.data?.headerCalculation?.permissionUsers??0}'});
      // pieGraph.add( {"attendance": "late", "count":100});// '${attendanceModel?.data?.headerCalculation?.lateEntryUsers??0}'});
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
    showAttendanceList = false;
  }
}
