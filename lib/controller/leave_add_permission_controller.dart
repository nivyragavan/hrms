import 'package:dreamhrms/controller/leave_controller.dart';
import 'package:dreamhrms/controller/permission_controller.dart';
import 'package:dreamhrms/screen/leave/leave.dart';
import 'package:dreamhrms/screen/permission/permission.dart';
import 'package:dreamhrms/services/HttpHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import '../services/api_service.dart';
import '../services/utils.dart';
import '../widgets/encrypt_decrypt.dart';
import 'common_controller.dart';

enum LeaveType { Full, FirstHalf, SecondHalf }

class LeaveAddPermissionController extends GetxController {
  static LeaveAddPermissionController get to =>
      Get.put(LeaveAddPermissionController());
  static final HttpHelper _http = HttpHelper();
  BuildContext? context = Get.context;
  final leaveDuration = LeaveType.Full.obs;
  TextEditingController leaveType = TextEditingController();
  //final leaveType = TextEditingController();
  final leaveTypeId = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  TextEditingController totalHours = TextEditingController();
  TextEditingController noOfDays = TextEditingController();
  TextEditingController leaveReason = TextEditingController();
  TextEditingController imageFormat = TextEditingController();
  TextEditingController imageName = TextEditingController();
  TextEditingController permissionStartTime = TextEditingController();
  TextEditingController permissionEndTime = TextEditingController();
  TextEditingController permissionHours = TextEditingController(text: "");
  TextEditingController permissionReason = TextEditingController();
  TextEditingController permissionDate = TextEditingController();
  TextEditingController rejectingReason = TextEditingController();
  TextEditingController leaveId = TextEditingController();

  final _availableLeave = 0.obs;
  final _isStartDateEnabled = false.obs;
  final _isSameDate = false.obs;
  final _isStartTimeEnabled = false.obs;
  final _leaveDurationId = "1".obs;

  int get availableLeave => _availableLeave.value;
  set availableLeave(int value) {
    _availableLeave.value = value;
  }

  // Getter and setter for isStartDateEnabled
  bool get isStartDateEnabled => _isStartDateEnabled.value;
  set isStartDateEnabled(bool value) {
    _isStartDateEnabled.value = value;
  }

  // Getter and setter for isSameDate
  bool get isSameDate => _isSameDate.value;
  set isSameDate(bool value) {
    _isSameDate.value = value;
  }

  // Getter and setter for isStartTimeEnabled
  bool get isStartTimeEnabled => _isStartTimeEnabled.value;
  set isStartTimeEnabled(bool value) {
    _isStartTimeEnabled.value = value;
  }

  // Getter and setter for leaveDurationId
  String get leaveDurationId => _leaveDurationId.value;
  set leaveDurationId(String value) {
    _leaveDurationId.value = value;
  }

  getCurrentLeave(dynamic id) {
    for (var data in LeaveController.to.leaveMasterModel?.data ?? []) {
      if (id == data.id) {
        availableLeave = data.availableLeave;
        debugPrint("${availableLeave.toString()}");
      }
    }
  }

  addLeave({required Null Function() backBtnOnPressed}) async {
    var body = {
      "leave_from": CommonController.to.formatDate(LeaveAddPermissionController.to.startDate.value.text),
      "leave_to": CommonController.to.formatDate(LeaveAddPermissionController.to.endDate.value.text),
      "leave_days": LeaveAddPermissionController.to.noOfDays.value.text,
      "leave_type_id": LeaveAddPermissionController.to.leaveTypeId.value.text,
      "reason_for_leave":
          LeaveAddPermissionController.to.leaveReason.value.text,
      "type": "leave",
      "leave_type": (LeaveAddPermissionController.to.startDate.text ==
              LeaveAddPermissionController.to.endDate.value.text)
          ? LeaveAddPermissionController.to.leaveDurationId
          : "1",
    };
    debugPrint(body.toString());
    try {
      var response = GetStorage().read("RequestEncryption") == true
          ? await _http.multipartPostData(
              url: "${Api.addLeave}",
              encryptMessage:
                  await LibSodiumAlgorithm().encryptionMessage(body),
              auth: true)
          : await _http.post(Api.addLeave, body,
              auth: true, contentHeader: false);
      if (response['code'] == "200") {
        Get.back();
        backBtnOnPressed();
        UtilService()
            .showToast("success", message: response['message'].toString());
        if (response != null) {
          leaveId.text = response['data']['leave_id'];
          debugPrint("Leave Id ${leaveId.text}");
        }
        if (LeaveAddPermissionController.to.leaveId.text != "" &&
            LeaveAddPermissionController.to.imageName.text != "" ) {
          LeaveAddPermissionController.to.addLeaveAttachment();
        }
          else {
          Get.to(()=> Leave());
          await LeaveController.to.getLeaveHistory();
        }
      } else {
        UtilService()
            .showToast("error", message: response['message'].toString());
      }
    } catch (e) {
      print("Exception on the api$e");
      CommonController.to.buttonLoader = false;
    }
  }
  String timeTo24Hrs(String time) {
    DateTime date12Hour = DateFormat("hh:mma").parse(time.removeAllWhitespace);
    String formattedTime = DateFormat("HH:mm").format(date12Hour);
    print(formattedTime);
    return formattedTime;
  }
  addPermission() async {
    var body = {
      "permission_date": CommonController.to.formatDate(permissionDate.value.text),
      "from_time":  CommonController.to.timeConversion(permissionStartTime.value.text,"HH:mm"),
      "to_time": CommonController.to.timeConversion(permissionEndTime.value.text,"HH:mm"),
      "permission_hour": permissionHours.value.text,
      "reason_for_permission": permissionReason.value.text,
      "type": "permission",
      "leave_type_id": "1"
    };
    debugPrint(body.toString());
    try {
      var response = GetStorage().read("RequestEncryption") == true
          ? await _http.multipartPostData(
              url: "${Api.addLeave}",
              encryptMessage:
                  await LibSodiumAlgorithm().encryptionMessage(body),
              auth: true)
          : await _http.post(Api.addLeave, body,
              auth: true, contentHeader: false);
      if (response['code'] == "200") {
        Get.back();
        Get.to(() => PermissionScreen());
        await PermissionController.to.getPermissionHistory();
        UtilService()
            .showToast("success", message: 'Permission Added Successfully');

      } else {
        UtilService()
            .showToast("error", message: response['message'].toString());
      }
    } catch (e) {
      print("Exception on the api$e");
      CommonController.to.buttonLoader = false;
    }
  }

  Future<void> calculateTimeDifference(String startTime, String endTime) async {
    if (startTime.isNotEmpty && endTime.isNotEmpty) {
      // Parse the time with AM/PM indicator
      DateFormat format = DateFormat(
        "hh:mm",
      );
      DateTime startDateTime;
      DateTime endDateTime;
      try {
        startDateTime = format.parse(startTime);
        endDateTime = format.parse(endTime);
      } catch (e) {
        print("Error parsing time: $e");
        return;
      }
      // Calculate the difference in minutes
      int differenceInMinutes = endDateTime.difference(startDateTime).inMinutes;
      if (differenceInMinutes < 0) {
        // Show an error message if end time is before start time
        LeaveAddPermissionController.to.permissionEndTime.clear();
        UtilService().showToast("error",
            message: "End time cannot be before the start time");
        return;
      }
      // Convert the difference to hours and minutes
      int differenceInHours = differenceInMinutes ~/ 60;
      int remainingMinutes = differenceInMinutes % 60;
      String formattedHours = differenceInHours.toString().padLeft(2, '0');
      String formattedMinutes = remainingMinutes.toString().padLeft(2, '0');
      LeaveAddPermissionController.to.permissionHours.text =
          "$formattedHours:$formattedMinutes";
      print("Hours: ${differenceInHours.toString()}");
    }
  }

  void updateDifferenceInDays(String startDateText, String endDateText) {
    print("start date ${startDateText} end date $endDateText");
    if (startDateText.isNotEmpty && endDateText.isNotEmpty) {
      DateTime startDate = DateTime.parse(startDateText);
      DateTime endDate = DateTime.parse(endDateText);
      if (endDate.isBefore(startDate)) {
        // Show a toast message indicating invalid date range
        LeaveAddPermissionController.to.endDate.clear();
        UtilService().showToast("error",
            message: "End date cannot be before the start date");
        return; // Exit the function without further calculation
      }
      // Calculate the absolute difference in days
      int differenceInDays = endDate.difference(startDate).inDays + 1;
      LeaveAddPermissionController.to.noOfDays.text =
          differenceInDays.toString();
      isSameDate = (endDate.difference(startDate).inDays == 0);
    }
  }

  addLeaveAttachment() async {
    List<String> file = [
      LeaveAddPermissionController.to.imageName.value.text,
    ];
    List<String> fileName = ["attachment"];
    List<String> fieldsName = ["leave_id"];
    List<String> fields = [LeaveAddPermissionController.to.leaveId.text];
    print(
        "${file.toString()}  ${fieldsName.toString()} ${fields.toString()} ${fileName.toString()}");
    var response = await _http.commonImagePostMultiPart(
        url: "${Api.leaveAttachment}",
        auth: true,
        filePaths: file,
        fileName: fileName,
        fieldsName: fieldsName,
        fields: fields);
    if (response['code'] == "200") {
      print("Response $response");
      if(response['message'] != null){
        Get.to(()=> Leave());
        await LeaveController.to.getLeaveHistory();
        CommonController.to.buttonLoader = false;
      }
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
  }

  leaveAction(String id, String status, String type, [String? reason]) async {
    Map<String, dynamic> updatedBody = {};
    if (status == "Approve") {
      updatedBody = {"leave_id": id, "type": type, "status": "1"};
    } else {
      updatedBody = {
        "leave_id": id,
        "type": type,
        "status": "2",
        "reason": LeaveAddPermissionController.to.rejectingReason.text,
      };
    }
    ;
    var body = updatedBody;
    debugPrint(body.toString());
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
            url: "${Api.leaveAction}",
            encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
            auth: true)
        : await _http.post(Api.leaveAction, body,
            auth: true, contentHeader: false);
    if (response['code'] == "200") {
      type == "Leave"
          ? LeaveController.to.getLeaveHistory()
          : PermissionController.to.getPermissionHistory();
      Future.delayed(
        Duration(seconds: 1),
        () {
          rejectingReason.text = "";
          UtilService()
              .showToast("success", message: response['message'].toString());
        },
      );
    } else {
      Future.delayed(
        Duration(seconds: 1),
        () {
          UtilService()
              .showToast("error", message: response['message'].toString());
        },
      );
    }
  }

  @override
  void onClose() {
    leaveType.clear();
    leaveTypeId.clear();
    startDate.clear();
    endDate.clear();
    totalHours.clear();
    noOfDays.clear();
    leaveReason.clear();
    imageFormat.clear();
    imageName.clear();
    permissionStartTime.clear();
    permissionEndTime.clear();
    permissionHours.clear();
    permissionReason.clear();
    permissionDate.clear();
    rejectingReason.text = "";
    Get.delete<LeaveAddPermissionController>();
    super.onClose();
  }
}
