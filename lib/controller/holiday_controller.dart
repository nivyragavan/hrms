import 'package:dreamhrms/model/holiday_model.dart';
import 'package:dreamhrms/screen/holidays/holiday_screen.dart';
import 'package:dreamhrms/services/HttpHelper.dart';
import 'package:dreamhrms/services/api_service.dart';
import 'package:dreamhrms/widgets/encrypt_decrypt.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import '../services/utils.dart';
import 'common_controller.dart';

class HolidayController extends GetxController {
  static HolidayController get to => Get.put(HolidayController());
  static final HttpHelper _http = HttpHelper();
  BuildContext? context = Get.context;
  TextEditingController holidayName = TextEditingController();
  TextEditingController holidayDate = TextEditingController();
  TextEditingController imageFormat = TextEditingController();
  TextEditingController holidayId = TextEditingController();
  TextEditingController fromDate = TextEditingController();
  TextEditingController toDate = TextEditingController();
  final _showList = false.obs;
  final holidayDates = [].obs;
  get showList => _showList.value;
  bool isFromCalendar = false;
  HolidayListModel? holidayListModel;
  set showList(value) {
    _showList.value = value;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getHolidayList();
    isFromCalendar == false ? getStartAndEndDate() : null;
  }

  getStartAndEndDate() {
    DateTime currentDate = DateTime.now();
    DateTime firstDayOfMonth = DateTime(currentDate.year, currentDate.month, 1);
    DateTime lastDayOfMonth =
        DateTime(currentDate.year, currentDate.month + 1, 0);
    final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
    fromDate = TextEditingController(text: _dateFormat.format(firstDayOfMonth));
    toDate = TextEditingController(text: _dateFormat.format(lastDayOfMonth));
  }

  addHoliday() async {
    var body = {
      "holiday_name": holidayName.value.text,
      "holiday_date": CommonController.to.formatDate(holidayDate.value.text)
    };
    debugPrint(body.toString());
    try {
      var response = GetStorage().read("RequestEncryption") == true
          ? await _http.multipartPostData(
              url: "${Api.addHoliday}",
              encryptMessage:
                  await LibSodiumAlgorithm().encryptionMessage(body),
              auth: true)
          : await _http.post(Api.addHoliday, body,
              auth: true, contentHeader: false);
      if (response['code'] == "200") {
        await HolidayController.to.getHolidayList();
        Get.to(() => HolidaysScreen());
        UtilService()
            .showToast("success", message: response['message'].toString());
      } else {
        UtilService()
            .showToast("error", message: response['message'].toString());
      }
    } catch (e) {
      print("Exception on the api$e");
      CommonController.to.buttonLoader = false;
    }
  }

  deleteHoliday(String id) async {
    var body = {
     "id":id,
      "type":"3"
    };
    debugPrint(body.toString());
    try {
      var response = GetStorage().read("RequestEncryption") == true
          ? await _http.multipartPostData(
          url: "${Api.deleteHoliday}",
          encryptMessage:
          await LibSodiumAlgorithm().encryptionMessage(body),
          auth: true)
          : await _http.post(Api.deleteHoliday, body,
          auth: true, contentHeader: false);
      if (response['code'] == "200") {
        UtilService()
            .showToast("success", message: response['message'].toString());
        Get.back();
        holidayDates.clear();
        await HolidayController.to.getHolidayList();
      } else {
        UtilService()
            .showToast("error", message: response['message'].toString());
      }
    } catch (e) {
      print("Exception on the api$e");
      CommonController.to.buttonLoader = false;
    }
  }

  getHolidayList() async {
    showList = true;
    var body = {"from_date": fromDate.text, "to_date": toDate.text, "sort_by": "holiday_date",
      "order_by":"asc"};
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
            url: "${Api.holidayList}",
            encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
            auth: true)
        : await _http.post(Api.holidayList, body,
            auth: true, contentHeader: false);
    if (response['code'] == "200") {
      holidayListModel = HolidayListModel.fromJson(response);
      if (holidayListModel!.data!.isNotEmpty) {
        for (var dates in holidayListModel!.data!) {
          DateTime parsedDate = DateTime.parse(dates.holidayDate ?? "");
          String formattedDate = _holidayFormatDate(parsedDate);
          holidayDates.addAll([formattedDate]);
        }
      }
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
    showList = false;
  }

  String _holidayFormatDate(DateTime date) {
    final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
    String formattedDate = _dateFormat.format(date);
    return formattedDate;
  }

  editHoliday() async {
    var body = {
      "id": holidayId.value.text,
      "holiday_name": holidayName.value.text,
      "holiday_date": CommonController.to.formatDate(holidayDate.value.text)
    };
    try {
      var response = GetStorage().read("RequestEncryption") == true
          ? await _http.multipartPostData(
              url: "${Api.addHoliday}",
              encryptMessage:
                  await LibSodiumAlgorithm().encryptionMessage(body),
              auth: true)
          : await _http.post(Api.addHoliday, body,
              auth: true, contentHeader: false);
      if (response['code'] == "200") {
        holidayDates.clear();
        await HolidayController.to.getHolidayList();
        Get.to(() => HolidaysScreen());
        UtilService()
            .showToast("success", message: response['message'].toString());
      } else {
        UtilService()
            .showToast("error", message: response['message'].toString());
      }
    } catch (e) {
      print("Exception on the api$e");
      CommonController.to.buttonLoader = false;
    }
  }

  @override
  void onClose() {
    Get.delete<HolidayController>();
    super.onClose();
  }

  clear() {
    holidayName.text = '';
    holidayDate.text = '';
  }
}
