import 'package:dreamhrms/model/schedule_list_model.dart';
import 'package:dreamhrms/screen/schedule/schedule.dart';
import 'package:dreamhrms/services/api_service.dart';
import 'package:dreamhrms/services/utils.dart';
import 'package:dreamhrms/widgets/encrypt_decrypt.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import '../model/schedue_datewise_model.dart';
import '../services/HttpHelper.dart';
import 'common_controller.dart';

enum ScheduleType { Employee, Department }

class ScheduleController extends GetxController {
  static ScheduleController get to => Get.put(ScheduleController());



  static final HttpHelper _http = HttpHelper();
  BuildContext? context = Get.context;
  final type = ScheduleType.Employee.obs;
  final isEmployeeRadioEnabled = true.obs;
  ScheduleListModel? scheduleListModel;
  TextEditingController templateCtrl = TextEditingController();
  TextEditingController templateIdCtrl = TextEditingController();
  TextEditingController assignTypeCTrl = TextEditingController();
  TextEditingController assignIdCTrl = TextEditingController();
  final isDepRadioEnabled = false.obs;
  final isExpand = false.obs;
  List<String> selectedEmployeeItems = <String>[].obs;
  List<String> selectedDepartmentItems = <String>[].obs;
  DateTime today = DateTime.now();
  final dateList = <String>[].obs;
  final dateApiFormat = <String>[].obs;
  final _isShiftItems = false.obs;
  final passedDate = "".obs;

  get isShiftItems => _isShiftItems.value;
  List<ShiftList> filteredShifts = <ShiftList>[].obs;

  set isShiftItems(value) {
    _isShiftItems.value = value;
  }

  final _scheduleLoader = false.obs;

  get scheduleLoader => _scheduleLoader.value;

  set scheduleLoader(value) {
    _scheduleLoader.value = value;
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }
  getDataList() {
    dateList.clear();
    dateApiFormat.clear();
    final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
    final DateFormat _format = DateFormat('dd-MM-yy');
    DateTime today = DateTime.now();
    dateList.add(_dateFormat.format(today));
    dateApiFormat.add(_format.format(today));
    for (int i = 1; i <= 4; i++) {
      DateTime nextDate = today.add(Duration(days: i));
      String formattedNextDate = _dateFormat.format(nextDate);
      String formattedNext = _format.format(nextDate);
      dateList.add(formattedNextDate);
      dateApiFormat.add(formattedNext);
    }
  }

  assignSchedule({required List<int?> id, required String type}) async {
    DateTime today = DateTime.now();
    String formattedDate = DateFormat("yyyy-MM-dd").format(today);
    Map<String, dynamic> body = {
      "shift_id": templateIdCtrl.value.text,
      "date": formattedDate,
      "type": type,
    };
    if (type == "user") {
      body["user_id"] = id;
    } else if (type == "department") {
      body["department_id"] = id;
    }
    debugPrint(body.toString());
    try{
      var response = GetStorage().read("RequestEncryption") == true
          ? await _http.multipartPostData(
          url: "${Api.updateSchedule}",
          encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
          auth: true)
          : await _http.post(Api.updateSchedule, body,
          auth: true, contentHeader: false);
      if (response['code'] == "200") {
        Get.to(() => Schedule());
        UtilService()
            .showToast("success", message: "Schedule Assigned Successfully".toString());
      } else {
        UtilService()
            .showToast("error", message: response['message'].toString());
      }
    }catch (e) {
      print("Exception on the api$e");
      CommonController.to.buttonLoader = false;
    }
  }

  Future<void> getScheduleList() async {
    var body = {
      "from_date": dateList.isNotEmpty ? '${dateList.first}' : "",
      "to_date": dateList.isNotEmpty ? '${dateList.last}' : ""
      // "count_per_page": 10,
      // "page": 1
    };
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
        url: "${Api.scheduleList}",
        encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
        auth: true)
        : await _http.post(Api.scheduleList, body,
        auth: true, contentHeader: false);
    if (response['code'] == "200") {
      scheduleListModel = ScheduleListModel.fromJson(response);

    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
  }

  Future<void> getFilteredList(ScheduleListModel? scheduleListModel,
      ScheduleDateWiseModel scheduleDateWiseModel) async {
    final scheduleList = scheduleListModel?.data?.data;
    for (int i = 0; i < scheduleList!.length; i++) {

      for (int j = 0; j < scheduleList[i].shiftList!.length; j++) {

        await getDateList(scheduleList[i].shiftList?[j].date,
            scheduleList[i].shiftList![j], scheduleDateWiseModel,scheduleList[i].profileImage?? "");
      }
    }
  }

  Future<void> getDateList(String? date, ShiftList shiftList,
      ScheduleDateWiseModel scheduleDateWiseModel,String imgSrc) async {
    if (dateApiFormat.length == 5) {
      if (dateApiFormat[0] == shiftList.date.toString()) {
        int length = scheduleDateWiseModel.firstData?.length ?? 0;
        scheduleDateWiseModel.firstData?.insert(
            length,
            FirstData(
                day: '${shiftList.day}',
                imageSrc: '$imgSrc',
                date: "${shiftList.date}",
                id: "${shiftList.id}",
                shiftId: "${shiftList.shiftId}",
                shiftName: "${shiftList.shiftName}",
                shiftColor: "${shiftList.shiftColor}",
                shiftHours: "${shiftList.shiftHours}",
                shiftType: "${shiftList.shiftType}",
                shiftStartTime: shiftList.shiftStartTime ?? "",
                shiftEndTime: shiftList.shiftEndTime ?? "",
                shiftBreakTime: shiftList.shiftBreakTime ?? "",
                duration: shiftList.duration ?? ""));
      } else if (dateApiFormat[1] == shiftList.date.toString()) {
        int length = scheduleDateWiseModel.secondData?.length ?? 0;
        scheduleDateWiseModel.secondData?.insert(
            length,
            FirstData(
                day: '${shiftList.day}',
                date: "${shiftList.date}",
                imageSrc: '$imgSrc',
                id: "${shiftList.id}",
                shiftId: "${shiftList.shiftId}",
                shiftName: "${shiftList.shiftName}",
                shiftColor: "${shiftList.shiftColor}",
                shiftHours: "${shiftList.shiftHours}",
                shiftType: "${shiftList.shiftType}",
                shiftStartTime: shiftList.shiftStartTime ?? "",
                shiftEndTime: shiftList.shiftEndTime ?? "",
                shiftBreakTime: shiftList.shiftBreakTime ?? "",
                duration: shiftList.duration ?? ""));
      } else if (dateApiFormat[2] == shiftList.date.toString()) {
        int length = scheduleDateWiseModel.thirdData?.length ?? 0;
        scheduleDateWiseModel.thirdData?.insert(
            length,
            FirstData(
                day: '${shiftList.day}',
                date: "${shiftList.date}",
                id: "${shiftList.id}",
                imageSrc: '$imgSrc',
                shiftId: "${shiftList.shiftId}",
                shiftName: "${shiftList.shiftName}",
                shiftColor: "${shiftList.shiftColor}",
                shiftHours: "${shiftList.shiftHours}",
                shiftType: "${shiftList.shiftType}",
                shiftStartTime: shiftList.shiftStartTime ?? "",
                shiftEndTime: shiftList.shiftEndTime ?? "",
                shiftBreakTime: shiftList.shiftBreakTime ?? "",
                duration: shiftList.duration ?? ""));
      } else if (dateApiFormat[3] == shiftList.date.toString()) {
        int length = scheduleDateWiseModel.fourData?.length ?? 0;
        scheduleDateWiseModel.fourData?.insert(
            length,
            FirstData(
                day: '${shiftList.day}',
                date: "${shiftList.date}",
                id: "${shiftList.id}",
                imageSrc: '$imgSrc',
                shiftId: "${shiftList.shiftId}",
                shiftName: "${shiftList.shiftName}",
                shiftColor: "${shiftList.shiftColor}",
                shiftHours: "${shiftList.shiftHours}",
                shiftType: "${shiftList.shiftType}",
                shiftStartTime: shiftList.shiftStartTime ?? "",
                shiftEndTime: shiftList.shiftEndTime ?? "",
                shiftBreakTime: shiftList.shiftBreakTime ?? "",
                duration: shiftList.duration ?? ""));
      }
    }
  }

  @override
  void onClose() {
    templateIdCtrl.text = "";
    assignIdCTrl.text = "";
    assignTypeCTrl.text = "";
    templateCtrl.text = "";
    super.onClose();
  }
}
