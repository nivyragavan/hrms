import 'package:dreamhrms/model/announcement/announcement_list_model.dart'
    hide Data, Datum;
import 'package:dreamhrms/model/announcement/announcement_viewd_list_model.dart';
import 'package:dreamhrms/model/employee_announcement_model/emp_announcement_list.dart';
import 'package:dreamhrms/model/employee_announcement_model/emp_announcement_view_model.dart';
import 'package:dreamhrms/services/HttpHelper.dart';
import 'package:dreamhrms/services/api_service.dart';
import 'package:dreamhrms/services/utils.dart';
import 'package:dreamhrms/widgets/encrypt_decrypt.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart' hide Data;


class EmpAnnouncementController extends GetxController {
  static EmpAnnouncementController get to => Get.put(EmpAnnouncementController());
  static final HttpHelper _http = HttpHelper();

  TextEditingController subject = TextEditingController();
  TextEditingController message = TextEditingController();
  TextEditingController attachment = TextEditingController();

  EmployeeAnnouncementList? announcementListModel;
  EmployeeAnnouncementViewModel? announcementViewModel;

  final _showList = false.obs;
  get showList => _showList.value;
  final _viewedListLoader = false.obs;
  get viewedListLoader => _viewedListLoader.value;
  set viewedListLoader(value) {
    _viewedListLoader.value = value;
  }

  set showList(value) {
    _showList.value = value;
  }

  clearValues() {
    subject.text = "";
    message.text = "";
    attachment.text = "";
  }

  getAnnouncementList() async {
    showList = true;
    var body = {'user_id': GetStorage().read("login_userid").toString()};
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
            url: "${Api.empAnnouncementList}",
            encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
            auth: true)
        : await _http.post(Api.empAnnouncementList, body,
            auth: true, contentHeader: false);
    if (response['code'] == "200") {
      announcementListModel = EmployeeAnnouncementList.fromJson(response);
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
    showList = false;
  }

  getAnnouncementView({required int announcementId}) async {
    viewedListLoader = true;
    var body = {
      "id": announcementId,
    };
    debugPrint(body.toString());
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
        url: "${Api.empAnnouncementView}",
        encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
        auth: true)
        : await _http.post(Api.empAnnouncementView, body,
        auth: true, contentHeader: false);
    if (response['code'] == "200") {
      announcementViewModel = EmployeeAnnouncementViewModel.fromJson(response);
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
    viewedListLoader = false;
  }
}
