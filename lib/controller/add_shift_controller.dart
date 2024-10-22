import 'package:dreamhrms/model/add_shift_model.dart';
import 'package:dreamhrms/screen/shift/shift.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';
import '../services/HttpHelper.dart';
import '../services/api_service.dart';
import '../services/utils.dart';
import '../widgets/encrypt_decrypt.dart';
import 'common_controller.dart';

enum ShiftType { Duration, Clock }

class AddShiftController extends GetxController {
  static AddShiftController get to => Get.put(AddShiftController());
  static final HttpHelper _http = HttpHelper();
  BuildContext? context = Get.context;
  final List<int> durationSwitches = <int>[].obs;
  final List<int> clockSwitches = <int>[].obs;
  TextEditingController shiftName = TextEditingController();
  TextEditingController totalWorkHrs = TextEditingController();
  TextEditingController durationWorkHr = TextEditingController();
  TextEditingController startTime = TextEditingController();
  TextEditingController endTime = TextEditingController();
  TextEditingController breakTime = TextEditingController();
  final durationType = ShiftType.Duration.obs;
  Rx<Color> currentColor = Rx<Color>(Colors.blue);
  DateTime selectedTime = DateTime.now();
  List<String> daysOfWeek = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];
  final List<DurationData> durationBasedList = [];
  final List<DurationData> updatedDurationBasedList = [];
  DurationDataModel? durationDataModel;
  ClockDataModel? clockDataModel;
  final List<ClockData> clockBasedList = [];
  final List<ClockData> updatedClockBasedList = [];

  final _isColorChoosed = 0.obs;
  final _isShiftId = 0.obs;
  int get shiftId => _isShiftId.value;
  set shiftId(value) {
    _isShiftId.value = value;
  }

  get colorChoosed => _isColorChoosed.value;

  final _isEdit = "".obs;

  String get isEdit => _isEdit.value;

  set isEdit(value) {
    _isEdit.value = value;
  }

  final _isEditingType = "".obs;

  String get isEditingType => _isEditingType.value;

  set isEditingType(value) {
    _isEditingType.value = value;
  }

  set colorChoosed(value) {
    _isColorChoosed.value = value;
  }
  final _durationLoader = false.obs;
  bool get durationLoader => _durationLoader.value;
  set durationLoader(bool value) {
    _durationLoader.value = value;
  }
  final _clockLoader = false.obs;
  bool get clockLoader => _clockLoader.value;
  set clockLoader(bool value) {
    _clockLoader.value = value;
  }
  void setDurationData() {
    durationLoader = true;
    for (int i = 0; i < daysOfWeek.length; i++) {
      DurationData durationData = DurationData(
        days: daysOfWeek[i],
        duration: TextEditingController(),
      );
      durationBasedList.add(durationData);
    }
    durationDataModel = DurationDataModel(
      shiftHours: totalWorkHrs.text,
      shiftName: shiftName.text,
      durationData: durationBasedList,
    );
    durationLoader = false;
  }

  void setClockData() {
    clockLoader = true;
    for (int i = 0; i < daysOfWeek.length; i++) {
      ClockData clockData = ClockData(
        days: daysOfWeek[i],
        endTime: TextEditingController(),
        startTime: TextEditingController(),
        breakTime: TextEditingController(),
      );
      clockBasedList.add(clockData);
    }
    clockDataModel = ClockDataModel(
        clockDataModel: clockBasedList,
        shiftHours: totalWorkHrs.text,
      shiftName: shiftName.text);
    clockLoader = false;
  }

  @override
  void onInit() {
    super.onInit();
    totalWorkHrs.addListener(() {
      durationLoader = true;
      AddShiftController.to.durationBasedList.clear();
      List<DurationData> durationList = List.generate(
        7,
            (index) => DurationData(
          days: daysOfWeek[index].i18n(),
          duration: TextEditingController(text: totalWorkHrs.text),
          active: index == 0,
        ),
      );

      AddShiftController.to.durationBasedList.addAll(durationList);
      durationLoader = false;
    });
  }


  Color getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    int colorValue = int.parse(hexColor, radix: 16);
    return Color(0xFF000000 + colorValue);
  }

  String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0')}';
  }

  editShift() async {
    final List<Map<String, dynamic>> workingTimeData =
        durationType.value.name == 'Duration'
            ? AddShiftController.to.durationBasedList
                .map((workingTime) => {
                      "days": workingTime.days,
                      "duration":
                      CommonController.to.timeConversion(workingTime.duration.text,GetStorage().read("global_time").toString()),
                      "active": workingTime.active
                    })
                .toList()
            : AddShiftController.to.clockBasedList
                .map((workingTime) => {
                      "days": workingTime.days,
                      "start_time":  CommonController.to.timeConversion(workingTime.startTime.text,GetStorage().read("global_time").toString()),
                      "end_time":  CommonController.to.timeConversion(workingTime.endTime.text,GetStorage().read("global_time").toString()),
                      "break_time":
                      CommonController.to.timeConversion(workingTime.breakTime.text,GetStorage().read("global_time").toString()),
                      "active": workingTime.active
                    })
                .toList();

    var body = {
      "shift_name": shiftName.value.text,
      "color": colorToHex(currentColor.value),
      "type": "edit",
      "shift_id": AddShiftController.to.shiftId.toString(),
      "shift_type": AddShiftController.to.durationType.value
              .toString()
              .split('.')
              .last
              .toLowerCase() +
          "_based",
      "shift_hours":  CommonController.to.timeConversion(totalWorkHrs.text,"HH:mm:ss"),
      "working_time": workingTimeData
    };

    try {
      var response = GetStorage().read("RequestEncryption") == true
          ? await _http.multipartPostData(
              url: "${Api.addShift}",
              encryptMessage:
                  await LibSodiumAlgorithm().encryptionMessage(body),
              auth: true)
          : await _http.post(Api.addShift, body,
              auth: true, contentHeader: false);
      if (response['code'] == "200") {
        Get.to(() => Shift());
        Future.delayed(
          Duration(seconds: 1),
          () {
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
    } catch (e) {
      print("Exception on the api$e");
      CommonController.to.buttonLoader = false;
    }
  }

  addShift() async {
    final List<Map<String, dynamic>> workingTimeData =
    durationType.value.name == 'Duration'
        ? AddShiftController.to.updatedDurationBasedList
        .map((workingTime) => {
      "days": workingTime.days,
      "duration":
      CommonController.to.timeConversion(workingTime.duration.text,GetStorage().read("global_time").toString()),
      "active": workingTime.active
    })
        .toList()
        : AddShiftController.to.updatedClockBasedList
        .map((workingTime) => {
      "days": workingTime.days,
      "start_time":  CommonController.to.timeConversion(workingTime.startTime.text,GetStorage().read("global_time").toString()),
      "end_time":  CommonController.to.timeConversion(workingTime.endTime.text,GetStorage().read("global_time").toString()),
      "break_time":
      CommonController.to.timeConversion(workingTime.breakTime.text,GetStorage().read("global_time").toString()),
      "active": workingTime.active
    })
        .toList();
    var body = {
      "shift_name": shiftName.value.text,
      "color": colorToHex(currentColor.value),
      "type": "add",
      "shift_id": AddShiftController.to.shiftId.toString(),
      "shift_type": AddShiftController.to.durationType.value
          .toString()
          .split('.')
          .last
          .toLowerCase() +
          "_based",
      "shift_hours":  CommonController.to.timeConversion(totalWorkHrs.text,"HH:mm:ss"),
      "working_time": workingTimeData
    };
    debugPrint(body.toString());
    try {
      var response = GetStorage().read("RequestEncryption") == true
          ? await _http.multipartPostData(
              url: "${Api.addShift}",
              encryptMessage:
                  await LibSodiumAlgorithm().encryptionMessage(body),
              auth: true)
          : await _http.post(Api.addShift, body,
              auth: true, contentHeader: false);
      if (response['code'] == "200") {
        Get.to(() => Shift());
        Future.delayed(
          Duration(seconds: 1),
          () {
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
    } catch (e) {
      print("Exception on the api$e");
      CommonController.to.buttonLoader = false;
    }
  }

  void updateDurationList(int index, DurationData data) {
    final durationData = DurationData(
      days: data.days,
      duration: TextEditingController(
          text: AddShiftController.to.durationWorkHr.value.text),
    );
    updatedDurationBasedList.add(durationData);
    if (index >= 0 && index < durationBasedList.length) {
      // Update durationBasedList
      updatedDurationBasedList[index] = durationData;
    }
  }

  void updateClockList(int index, ClockData data) {
    final clockData = ClockData(
      days: data.days,
      startTime: TextEditingController(
        text: AddShiftController.to.startTime.value.text,
      ),
      endTime:
          TextEditingController(text: AddShiftController.to.endTime.value.text),
      breakTime: TextEditingController(
          text: AddShiftController.to.breakTime.value.text),
    );
    if (index >= 0 && index < updatedClockBasedList.length) {
      updatedClockBasedList[index] = clockData;
    } else {
      updatedClockBasedList.add(clockData);
    }
    if (index >= 0 && index < clockBasedList.length) {
      clockBasedList[index] = clockData;
    } else {
      clockBasedList.add(clockData);
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    shiftName.clear();
    totalWorkHrs.clear();
    durationWorkHr.clear();
    startTime.clear();
    endTime.clear();
    breakTime.clear();
    durationBasedList.clear();
    clockBasedList.clear();
    updatedDurationBasedList.clear();
    updatedClockBasedList.clear();
    Get.delete<AddShiftController>();
    super.onClose();
  }
}
