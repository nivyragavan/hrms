import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../model/on_boarding_model/checklist_assign_list.dart';
import '../../model/on_boarding_model/checklist_model.dart';
import '../../model/on_boarding_model/task_details_model.dart';
import '../../services/HttpHelper.dart';
import '../../services/api_service.dart';
import '../../services/utils.dart';
import '../../widgets/encrypt_decrypt.dart';

class OffBoardingChecklistController extends GetxController{
  static OffBoardingChecklistController get to => Get.put(OffBoardingChecklistController());
  static final HttpHelper _http = HttpHelper();

  TextEditingController template = TextEditingController();
  TextEditingController templateId = TextEditingController();
  TextEditingController hrInCharge = TextEditingController();
  TextEditingController hrInChargeId = TextEditingController();


  ChecklistModel? checklistModel;
  ChecklistAssignListModel? checklistAssignListModel;

  final _showList = false.obs;
  get showList => _showList.value;

  set showList(value) {
    _showList.value = value;
  }

  final _showCheckList = false.obs;
  get showCheckList => _showCheckList.value;

  set showCheckList(value) {
    _showCheckList.value = value;
  }

  clearValues() {
    template.text = "";
    hrInCharge.text = "";
  }

  ///checklist api services
  getChecklist() async {
    showList = true;
    var body = {"type": "2"};
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
        url: "${Api.checklist}",
        encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
        auth: true)
        : await _http.post(Api.checklist, body,
        auth: true, contentHeader: false);
    if (response['code'] == "200") {
      print('checklist response $response');
      checklistModel = ChecklistModel.fromJson(response);
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
    showList = false;
  }

  checklistAssign(int index) async {
    var body = {
      "user_id": checklistModel?.data?.data?[index].id,
      "template_id": templateId.text,
      "hr_id": hrInChargeId.text,
      "type": "2",
    };
    print("assign checklist body $body");
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
        url: "${Api.checklistAssign}",
        encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
        auth: true)
        : await _http.post(Api.checklistAssign, body, auth: true, contentHeader: false);
    if (response['code'] == "200") {
      UtilService()
          .showToast("success", message: response['message'].toString());
      Get.back();
      clearValues();
      getChecklist();
      getChecklistAssignList();
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
  }

  getChecklistAssignList() async{
    showCheckList = true;
    var body = {"type": "2"};
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
        url: "${Api.checklistAssignList}",
        encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
        auth: true)
        : await _http.post(Api.checklistAssignList, body,
        auth: true, contentHeader: false);
    if (response['code'] == "200") {
      print('checklist response $response');
      checklistAssignListModel = ChecklistAssignListModel.fromJson(response);
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
    showCheckList = false;
  }

  deleteTask(Task taskIndex) async {
    var body = {"id": taskIndex.id};
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
        url: "${Api.taskDelete}",
        encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
        auth: true)
        : await _http.post(Api.taskDelete, body,
        auth: true, contentHeader: false);
    if (response['code'] == "200") {
      UtilService()
          .showToast("success", message: response['message'].toString());
      Get.back();
      getChecklistAssignList();
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
  }

  userTaskAnswer({List<TaskDetails>? taskDetails,required int userId,required int taskId, String? taskType}) async {
    var body = {
      "type":"2",
      "user_id": userId.toString(),
      "task_id": taskId.toString(),
      "task_field_type": taskDetails,
      "task_type":taskType
    };
    print('body ${jsonEncode(body)}');
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
        url: "${Api.userTaskAnswer}",
        encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
        auth: true)
        : await _http.post(Api.userTaskAnswer, body,
        auth: true, contentHeader: false);
    if (response['code'] == "200") {
      UtilService()
          .showToast("success", message: response['message'].toString());
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
  }

  userTaskAnswerFile({List<
      TaskDetails>? taskDetails, required int userId, required int taskId, String? taskType}) async {
    List<String> fieldsName = ["type","user_id", "task_id", "task_type"];
    List<String> fields = [
      "2",
      userId.toString(),
      taskId.toString(),
      taskType.toString()
    ];
    List<String> filePaths = [
      // AddDepartmentController.to.departmentImage.text
    ];
    List<String> fileName = [

    ];
    var response = await _http.onBoardingFileUpload(
        url: "${Api.userTaskAnswer}",
        auth: true,
        fieldsName: fieldsName,
        fields: fields,
        fileName: fileName,
        filePaths: filePaths,
        taskDetails:taskDetails
    );
    if (response['code'] == "200") {
      return true;
    } else {
      return false;
    }
  }
}