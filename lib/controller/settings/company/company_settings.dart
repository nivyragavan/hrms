import 'dart:convert';

import 'package:dreamhrms/controller/department/add_department_controller.dart';
import 'package:dreamhrms/screen/settings/company_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../model/settings/company/company_settings_list_model.dart';
import '../../../model/settings/company/company_working_days_model.dart';
import '../../../services/HttpHelper.dart';
import '../../../services/api_service.dart';
import '../../../services/utils.dart';
import '../../../widgets/encrypt_decrypt.dart';
import '../../common_controller.dart';
import '../settings.dart';

class CompanySettingsController extends GetxController {
  static CompanySettingsController get to =>
      Get.put(CompanySettingsController(), permanent: true);
  static final HttpHelper _http = HttpHelper();
  TextEditingController companyName = TextEditingController();
  TextEditingController legalName = TextEditingController();
  TextEditingController companyWebsite = TextEditingController();
  TextEditingController companyRegistration = TextEditingController();
  TextEditingController companyLogo = TextEditingController();

  TextEditingController companyAddress = TextEditingController();
  TextEditingController companyCountry = TextEditingController();
  TextEditingController companyCountryId = TextEditingController();
  TextEditingController companyState = TextEditingController();
  TextEditingController companyStateId = TextEditingController();
  TextEditingController companyCity = TextEditingController();
  TextEditingController companyCityId = TextEditingController();
  TextEditingController companyPhoneNumber = TextEditingController();
  TextEditingController companyMobileNumber = TextEditingController();
  TextEditingController companyFax = TextEditingController();
  TextEditingController companyPostalCode = TextEditingController();

  TextEditingController hoursController = TextEditingController();

  CompanySettingsListModel? companySettingsListModel;
  CompanyWorkingDaysModel? companyWorkingDaysModel;

  final _companyLoader = false.obs;

  get companyLoader => _companyLoader.value;

  set companyLoader(value) {
    _companyLoader.value = value;
  }

  final _totalHrsLoader=false.obs;

  get totalHrsLoader => _totalHrsLoader.value;

  set totalHrsLoader(value) {
    _totalHrsLoader.value = value;
  }

  getCompanySettingsList() async {
    companyLoader = true;
    var body = {"branch_id": SettingsController.to.branchId.text};
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
            url: "${Api.companySettingsList}",
            encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
            auth: true)
        : await _http.post(Api.companySettingsList, body,
            auth: true, contentHeader: false);
    if (response['code'] == "200") {
      companySettingsListModel = CompanySettingsListModel.fromJson(response);
      await setCompanyControllerValue();
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
    companyLoader = false;
  }
  List<String> daysOfWeek = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
  ];
  setWorkingDays() {
    companyLoader = true;
    companyWorkingDaysModel = CompanyWorkingDaysModel(workingDays: []);
    for (int i = 0; i < 7; i++) {
      String dayOfWeek = daysOfWeek[i];
      final data = companySettingsListModel?.data?.schedule
          ?.where(
            (entry) => entry.days.toString() == dayOfWeek.toString(),
          )
          .toList();
      final matchingSchedule = data?.length == 0 ? null : data?.first;
      print("matchingSchedule$matchingSchedule");
      // If there's matching data, use it; otherwise, store empty data
      if (matchingSchedule != null) {
        print("matched${companyWorkingDaysModel?.workingDays.length}");
        companyWorkingDaysModel?.workingDays.insert(
          i,
          WorkingDay(
            //daysEnable: null,
            daysEnable: true,
            days: '${matchingSchedule.days ?? ""}',
            customHours: '${CommonController.to.timeConversion(matchingSchedule.customHours.toString(), GetStorage().read("global_time")) ?? ""}',
            startTime: '${CommonController.to.timeConversion(matchingSchedule.startTime.toString(), GetStorage().read("global_time")) ?? ""}',
            endTime: '${CommonController.to.timeConversion(matchingSchedule.endTime.toString(), GetStorage().read("global_time")) ?? ""}',
            workingHours: '${CommonController.to.timeConversion(matchingSchedule.workingHrs.toString(), GetStorage().read("global_time")) ?? ""}',
          ),
        );
      } else {
        print("not matcheed ${companyWorkingDaysModel?.workingDays.length}");
        companyWorkingDaysModel?.workingDays.insert(
          i,
          WorkingDay(
            daysEnable: false,
            days: dayOfWeek,
            customHours: '',
            startTime: '',
            endTime: '',
            workingHours: '',
          ),
        );
      }
    }
    companyLoader = false;
  }

  clearValues(){
    companyName.text="";
    legalName.text="";
    companyWebsite.text="";
    companyRegistration.text="";
    companyLogo.text="";
    companyAddress.text="";
    companyCountry.text="";
    companyCountryId.text="";
    companyCountry.text="";
    companyStateId.text="";
    companyState.text="";
    companyCityId.text="";
    companyCity.text="";
    companyPhoneNumber.text="";
    companyMobileNumber.text="";
    companyFax.text="";
  }

  getInitialize() async {
    await CompanySettingsController.to.clearValues();
    await CompanySettingsController.to.getCompanySettingsList();
  }

  setCompanyControllerValue() {
    companyName.text = '${companySettingsListModel?.data?.companyName ?? ""}';
    legalName.text = '${companySettingsListModel?.data?.legalName ?? ""}';
    companyWebsite.text = '${companySettingsListModel?.data?.website ?? ""}';
    companyRegistration.text =
        '${companySettingsListModel?.data?.registration ?? ""}';

    CommonController.to.imageLoader=true;
    companyLogo.text = '${companySettingsListModel?.data?.companyLogo ?? ""}';
    CommonController.to.imageLoader=false;
    print("companyLogo ${companyLogo.text}");
    companyAddress.text = '${companySettingsListModel?.data?.address ?? ""}';
    companyCountryId.text =
        '${companySettingsListModel?.data?.country?.id ?? ""}';
    companyCountry.text =
        '${companySettingsListModel?.data?.country?.name ?? ""}';
    companyStateId.text = '${companySettingsListModel?.data?.state?.id ?? ""}';
    companyState.text = '${companySettingsListModel?.data?.state?.name ?? ""}';
    companyCityId.text = '${companySettingsListModel?.data?.city?.id ?? ""}';
    companyCity.text = '${companySettingsListModel?.data?.city?.name ?? ""}';
    companyPostalCode.text = '${companySettingsListModel?.data?.postalCode ?? ""}';
    companyPhoneNumber.text =
        '${companySettingsListModel?.data?.phoneNumber ?? ""}';
    companyMobileNumber.text =
        '${companySettingsListModel?.data?.mobileNumber ?? ""}';
    companyFax.text = '${companySettingsListModel?.data?.fax ?? ""}';
  }

  Map<String, dynamic> workingDayToJson(WorkingDay workingDay) {
    return {
      "days": workingDay.days,
      "custom_hours":
          workingDay.customHours != "" ? workingDay.customHours : "00:00:00",
      "start_time":
          workingDay.startTime != "" ? CommonController.to.timeConversion(workingDay.startTime, "HH:mm:ss") : "00:00:00",
      "end_time": workingDay.endTime != "" ?  CommonController.to.timeConversion(workingDay.endTime,"HH:mm:ss") : "00:00:00",
      "working_hrs":
          workingDay.workingHours != "" ? workingDay.workingHours : "00:00:00"
    };
  }

  postCompanySettings() async {
    var workingDaysJson = companyWorkingDaysModel?.workingDays
        .where((day) => day.daysEnable == true) // Filter only enabled days
        .map((day) => workingDayToJson(day)) // Convert to JSON
        .toList();
    var body = {
      "company_id": companySettingsListModel?.data?.id,
      "company_name": companyName.text,
      "legal_name": legalName.text,
      "phone_number": companyPhoneNumber.text,
      "mobile_number": companyMobileNumber.text,
      "website": companyWebsite.text,
      "company_registration": companyRegistration.text,
      "address": companyAddress.text,
      "country": companyCountryId.text,
      "state": companyStateId.text,
      "city": companyCityId.text,
      "postal_code": companyPostalCode.text,
      "fax": companyFax.text,
      "branch_id": '${SettingsController.to.branchId.text}',
      "working_days": workingDaysJson
    };
    print("filteredList body ${body}");
    print("filteredList body ${jsonEncode(body)}");

    try {
      var response = GetStorage().read("RequestEncryption") == true
          ? await _http.multipartPostData(
              url: "${Api.companySave}",
              encryptMessage:
                  await LibSodiumAlgorithm().encryptionMessage(body),
              auth: true)
          : await _http.post(Api.companySave, body,
              auth: true, contentHeader: false);
      if (response['code'] == "200") {
        print("api response of the company save $response");
        UtilService()
            .showToast("success", message: response['message'].toString());
        if(AddDepartmentController.to.isNetworkImage(companyLogo.text)==false)await uploadCompanyLogo(companySettingsListModel?.data?.id.toString());
        Get.back();
        Get.to(() => CompanySettings(selectedIndex: 3));
        await getCompanySettingsList();
      } else {
        UtilService()
            .showToast("error", message: response['message'].toString());
      }
    } catch (e) {
      print("Exception on the api$e");
      CommonController.to.buttonLoader = false;
    }
  }

  Future<bool> uploadCompanyLogo(String? companyID) async {
    List<String> fieldsName = ["company_id"];
    List<String> fields = ["1"];
    List<String> filePaths = [companyLogo.text];
    List<String> fileName = [
      "company_image",
    ];
    var response = await _http.commonImagePostMultiPart(
        url: "${Api.companyLogoUpload}",
        auth: true,
        fieldsName: fieldsName,
        fields: fields,
        fileName: fileName,
        filePaths: filePaths);
    if (response['code'] == "200") {
      return true;
    } else {
      return false;
    }

  }
}
