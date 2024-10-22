import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../model/settings/system/currency_list_model.dart';
import '../../../model/settings/system/date_time_format_model.dart';
import '../../../model/settings/system/language_model.dart';
import '../../../model/settings/system/system_setting_model.dart';
import '../../../model/settings/system/time_zone_model.dart';
import '../../../services/HttpHelper.dart';
import '../../../services/api_service.dart';
import '../../../services/utils.dart';
import '../../../widgets/encrypt_decrypt.dart';
import '../../common_controller.dart';
import '../settings.dart';

class SystemSettingsController extends GetxController {
  static SystemSettingsController get to => Get.put(SystemSettingsController());
  static final HttpHelper _http = HttpHelper();
  TimeZoneListModel? timeZoneListModel;
  DateTimeFormatListModel? dateTimeFormatListModel;
  LanguageListModel? languageListModel;
  CurrencyListModel? currencyListModel;
  SystemSettingsListModel? systemSettingsListModel;

  TextEditingController timeZoneController = TextEditingController();
  TextEditingController timeZoneIdController = TextEditingController();
  TextEditingController dateFormatController = TextEditingController();
  TextEditingController dateFormatIdController = TextEditingController();
  TextEditingController weekController = TextEditingController();
  TextEditingController timeFormatController = TextEditingController();
  TextEditingController timeFormatIdController = TextEditingController();
  TextEditingController languageController = TextEditingController();
  TextEditingController languageIdController = TextEditingController();
  TextEditingController currencyController = TextEditingController();
  TextEditingController currencyIdController = TextEditingController();

  final _systemSettingsLoader = false.obs;

  get systemSettingsLoader => _systemSettingsLoader.value;

  set systemSettingsLoader(value) {
    _systemSettingsLoader.value = value;
  }

  systemList() async {
    systemSettingsLoader = true;
    print("branch id ${SettingsController.to.branchId.text}");
    var body = {"branch_id": SettingsController.to.branchId.text};
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
            url: "${Api.systemList}",
            encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
            auth: true)
        : await _http.post(Api.systemList, body,
            auth: true, contentHeader: false);
    if (response['code'] == "200") {
      systemSettingsListModel = SystemSettingsListModel.fromJson(response);
      await SystemSettingsController.to.clearValues();
      GetStorage().write("first_day",systemSettingsListModel?.data?[0].firstDayOfWeek);
      GetStorage().write("global_time",systemSettingsListModel?.data?[0].timezoneTimeFormat?.format);
      print("language code ${systemSettingsListModel?.data?[0].languages?.code}");
      if(systemSettingsListModel?.data?[0].languages?.code!=GetStorage().read("language_code")){
        GetStorage().write("language_code",systemSettingsListModel?.data?[0].languages?.code);
        await CommonController.to.getLanguageTranslator(GetStorage().read("language_code"));
      }
      print("FirstDay ${GetStorage().read("first_day")}");
      print("TimeFormat ${GetStorage().read("global_time")}");
      print(
          "System settings data ${SystemSettingsController.to.systemSettingsListModel?.data?.length}");
      await systemSettingsListModel?.data?.length != 0 &&
              SystemSettingsController.to.systemSettingsListModel?.data != null
          ? await SystemSettingsController.to.setControllerInformation()
          : "";
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
    systemSettingsLoader = false;
  }

  timeZoneList() async {
    systemSettingsLoader = true;
    var response = await _http.get(Api.timeZoneList, auth: true);
    if (response['code'] == "200") {
      timeZoneListModel = TimeZoneListModel.fromJson(response);
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
    systemSettingsLoader = false;
  }

  saveSystemSettings({required String option}) async {
    print("option $option");
    var body = option == 'add'
        ? {
            "branch_id": SettingsController.to.branchId.text,
            "timezone_id": timeZoneIdController.text,
            "timezone_date_format": dateFormatIdController.text,
            "timezone_time_format": timeZoneIdController.text,
            "first_day_of_week": weekController.text,
            "language": languageIdController.text,
            "currency": currencyIdController.text
          }
        : {
            "id": '${systemSettingsListModel?.data?[0].id ?? ""}',
            "branch_id": SettingsController.to.branchId.text,
            "timezone_id": timeZoneIdController.text,
            "timezone_date_format": dateFormatIdController.text,
            "timezone_time_format": timeZoneIdController.text,
            "first_day_of_week": weekController.text,
            "language": languageIdController.text,
            "currency": currencyIdController.text
          };
    print("body content ${jsonEncode(body)}");
    print(dateFormatController.text);
    print(timeFormatController.text);
    try {
      var response = GetStorage().read("RequestEncryption") == true
          ? await _http.multipartPostData(
              url: "${Api.systemSave}",
              encryptMessage:
                  await LibSodiumAlgorithm().encryptionMessage(body),
              auth: true)
          : await _http.post(Api.systemSave, body,
              auth: true, contentHeader: false);
      if (response['code'] == "200") {
        systemSettingsListModel = SystemSettingsListModel.fromJson(response);
      } else {
        UtilService()
            .showToast("error", message: response['message'].toString());
      }
    } catch (e) {
      print("Exception on the api$e");
      CommonController.to.buttonLoader = false;
    }
  }

  dateTimeFormatList() async {
    systemSettingsLoader = true;
    var response = await _http.get(Api.dateTimeFormatList, auth: true);
    if (response['code'] == "200") {
      dateTimeFormatListModel = DateTimeFormatListModel.fromJson(response);
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
    systemSettingsLoader = false;
  }

  languageList() async {
    systemSettingsLoader = true;
    var response = await _http.get(Api.languageList, auth: true);
    if (response['code'] == "200") {
      languageListModel = LanguageListModel.fromJson(response);
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
    systemSettingsLoader = false;
  }

  currencyList() async {
    systemSettingsLoader = true;
    var response = await _http.get(Api.currencyList, auth: true);
    if (response['code'] == "200") {
      currencyListModel = CurrencyListModel.fromJson(response);
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
    systemSettingsLoader = false;
  }

  clearValues() {
    timeZoneController.text = "";
    timeZoneIdController.text = "";
    dateFormatController.text = "";
    dateFormatIdController.text = "";
    weekController.text = "";
    timeZoneController.text = "";
    timeZoneIdController.text = "";
    languageController.text = "";
    languageIdController.text = "";
    currencyController.text = "";
    currencyIdController.text = "";
  }

  setControllerInformation() {
    systemSettingsLoader = true;
    final systemSettings = systemSettingsListModel?.data?[0];
    print("systemSettings on set $systemSettings");
    timeZoneIdController.text = '${systemSettings?.timezoneId ?? ""}';
    timeZoneController.text =
    '${(timeZoneListModel?.data?.indexWhere((timezone) => timezone.id.toString() == systemSettings?.timezoneId.toString()) != -1) ?
    timeZoneListModel?.data?.firstWhere((timezone) => timezone.id.toString() == systemSettings?.timezoneId.toString()).timezoneName.toString() ?? "" : ""} '
        '${(timeZoneListModel?.data?.indexWhere((timezone) => timezone.id.toString() == systemSettings?.timezoneId.toString()) != -1) ?
    timeZoneListModel?.data?.firstWhere((timezone) => timezone.id.toString() == systemSettings?.timezoneId.toString())?.aliasName.toString() ?? "" : ""}';
   dateFormatController.text =
        '${systemSettings?.timezoneDateFormat?.format ?? ""}';
    GetStorage().write("date_format",'${dateFormatController.text==null || dateFormatController.text==""?"YYYY-MM-DD":dateFormatController.text}');
    dateFormatIdController.text =
        '${systemSettings?.timezoneDateFormat?.id ?? ""}';
    weekController.text = '${systemSettings?.firstDayOfWeek ?? ""}';

    timeFormatController.text =
        '${systemSettings?.timezoneTimeFormat?.format ?? ""}';
    timeFormatIdController.text =
        '${systemSettings?.timezoneTimeFormat?.id ?? ""}';
    languageController.text = '${systemSettings?.languages?.name ?? ""}';
    languageIdController.text = '${systemSettings?.languages?.id ?? ""}';
    currencyController.text = '${systemSettings?.currency?.name ?? ""}';
    currencyIdController.text = '${systemSettings?.currency?.id ?? ""}';
    print("timeZoneController${timeZoneController.text}");
    print("dateFormatController${dateFormatController.text}");
    print("weekController${weekController.text}");
    print("timeFormatController${timeFormatController.text}");
    print("languageController${languageController.text}");
    print("currencyController${currencyController.text}");
    systemSettingsLoader = false;
  }
}
