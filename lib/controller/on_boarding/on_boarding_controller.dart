import 'package:dreamhrms/model/on_boarding_model/custom_field_model.dart';
import 'package:dreamhrms/model/on_boarding_model/task_role_model.dart';
import 'package:dreamhrms/model/on_boarding_model/template_list_model.dart';
import 'package:dreamhrms/screen/on_boarding/on_boarding_template/on_boarding_template.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../model/on_boarding_model/task_type_model.dart';
import '../../services/HttpHelper.dart';
import '../../services/api_service.dart';
import '../../services/utils.dart';
import '../../widgets/encrypt_decrypt.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get to => Get.put(OnBoardingController());
  static final HttpHelper _http = HttpHelper();

  List<TextEditingController> documentName = [];
  List<TextEditingController> document = [];
  List<TextEditingController> customField = [];

  ///add template controllers
  TextEditingController templateName = TextEditingController();
  TextEditingController description = TextEditingController();

  ///add task controllers
  TextEditingController taskName = TextEditingController();
  TextEditingController taskType = TextEditingController();
  TextEditingController taskTypeId = TextEditingController();
  TextEditingController assignRole = TextEditingController();
  TextEditingController day = TextEditingController();
  TextEditingController joinDate = TextEditingController();
  TextEditingController taskDescription = TextEditingController();
  TextEditingController maximumFileNumber = TextEditingController();
  List<String> selectedCustomFieldItems = <String>[].obs;

  TemplateListModel? templateListModel;
  TaskTypeModel? taskTypeModel;
  TaskRoleModel? taskRoleModel;
  CustomFieldModel? customFieldModel;

  final _loader = false.obs;

  get loader => _loader.value;

  set loader(value) {
    _loader.value = value;
  }

  final _showList = false.obs;
  get showList => _showList.value;

  set showList(value) {
    _showList.value = value;
  }

  final _showType = false.obs;
  get showType => _showType.value;

  set showType(value) {
    _showType.value = value;
  }

  int initialValue = 0;

  clearValues() {
    documentName = [];
    document = [];
    templateName.text = "";
    description.text = "";
    taskName.text = "";
    taskType.text = "";
    taskTypeId.text = "";
    assignRole.text = "";
    day.text = "";
    joinDate.text = "";
    taskDescription.text = "";
    maximumFileNumber.text = "";
    selectedCustomFieldItems = [];
  }

  ///on boarding template api services

  addTemplate() async {
    var body = {
      "template_name": templateName.text,
      "description": description.text,
      "type": "1"
    };
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
            url: "${Api.templateAdd}",
            encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
            auth: true)
        : await _http.post(Api.templateAdd, body,
            auth: true, contentHeader: false);
    if (response['code'] == "200") {
      UtilService()
          .showToast("success", message: response['message'].toString());
      clearValues();
      Get.back();
      getTemplateList();
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
  }

  editTemplate(int templateIndex) async {
    var body = {
      "template_name": templateName.text,
      "description": description.text,
      "type": "1",
      "id": templateListModel?.data?.data?[templateIndex].id
    };
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
            url: "${Api.templateEdit}",
            encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
            auth: true)
        : await _http.post(Api.templateEdit, body,
            auth: true, contentHeader: false);
    if (response['code'] == "200") {
      UtilService()
          .showToast("success", message: response['message'].toString());
      clearValues();
      Get.back();
      getTemplateList();
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
  }

  getTemplateList() async {
    showList = true;
    var body = {"type": "1"};
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
            url: "${Api.templateList}",
            encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
            auth: true)
        : await _http.post(Api.templateList, body,
            auth: true, contentHeader: false);
    if (response['code'] == "200") {
      templateListModel = TemplateListModel.fromJson(response);
      print("template list $templateListModel");
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
    showList = false;
  }

  deleteTemplate(int templateIndex) async {
    var body = {"id": templateListModel?.data?.data?[templateIndex].id};
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
            url: "${Api.templateDelete}",
            encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
            auth: true)
        : await _http.post(Api.templateDelete, body,
            auth: true, contentHeader: false);
    if (response['code'] == "200") {
      UtilService()
          .showToast("success", message: response['message'].toString());
      Get.back();
      getTemplateList();
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
  }

  ///task api services

  getTaskType() async {
    showType = true;
    var response = await _http.get(Api.taskType, auth: true);
    if (response['code'] == "200") {
      taskTypeModel = TaskTypeModel.fromJson(response);
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
    showType = false;
  }

  getTaskRole() async {
    showType = true;
    var response = await _http.get(Api.taskRole, auth: true);
    if (response['code'] == "200") {
      taskRoleModel = TaskRoleModel.fromJson(response);
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
    showType = false;
  }

  getCustomField() async {
    showType = true;
    var response = await _http.get(Api.customField, auth: true);
    if (response['code'] == "200") {
      customFieldModel = CustomFieldModel.fromJson(response);
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
    showType = false;
  }

  addTask({String? customFields, required int templateIndex}) async {
    var body = {
      "template_id": templateIndex.toString(),
      "task_name": taskName.text,
      "description": taskDescription.text,
      "task_type": taskType.text,
      "assign_role": assignRole.text,
      "due_date": joinDate.text,
      "no_of_days": day.text,
      "custom_field": customFields,
      "no_of_files": maximumFileNumber.text
    };
    print("add task body $body");
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
            url: "${Api.taskAdd}",
            encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
            auth: true)
        : await _http.post(Api.taskAdd, body, auth: true, contentHeader: false);
    if (response['code'] == "200") {
      UtilService()
          .showToast("success", message: response['message'].toString());
      Get.to(() => OnBoardingTemplateScreen());
      getTemplateList();
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
  }

  editTask({
    String? customFields,
    required int templateIndex,
    required int taskIndex,
  }) async {
    var body = {
      "template_id": templateIndex.toString(),
      "id": taskIndex.toString(),
      "task_name": taskName.text,
      "description": taskDescription.text,
      "task_type": taskType.text,
      "assign_role": assignRole.text,
      "due_date": joinDate.text,
      "no_of_days": day.text,
      "custom_field": customFields,
      "no_of_files": maximumFileNumber.text
    };
    print("edit task body $body");
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
            url: "${Api.taskEdit}",
            encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
            auth: true)
        : await _http.post(Api.taskEdit, body,
            auth: true, contentHeader: false);
    if (response['code'] == "200") {
      UtilService()
          .showToast("success", message: response['message'].toString());
      Get.to(() => OnBoardingTemplateScreen());
      getTemplateList();
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
  }

  setEditTaskInfo(Task? data) {
    loader = true;
    var EditTaskInfo = data;
    taskName.text = '${EditTaskInfo?.taskName ?? ""}';
    taskType.text = '${EditTaskInfo?.taskType ?? ""}';
    taskTypeId.text = '${EditTaskInfo?.id ?? ""}';
    assignRole.text = '${EditTaskInfo?.assignRole ?? ""}';
    day.text = '${EditTaskInfo?.noOfDays ?? ""}';
    joinDate.text = '${EditTaskInfo?.dueDate ?? ""}';
    taskDescription.text = '${EditTaskInfo?.description ?? ""}';
    selectedCustomFieldItems = EditTaskInfo?.taskType == "custom_field"
        ? EditTaskInfo!.taskForm!.map((e) => e.fieldName!).toList()
        : [];
    maximumFileNumber.text = EditTaskInfo?.taskType == "file"
        ? EditTaskInfo!.taskForm!.map((e) => e.options).join()
        : '';
    loader = false;
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
    print(body.toString());
    if (response['code'] == "200") {
      UtilService()
          .showToast("success", message: response['message'].toString());
      Get.to(() => OnBoardingTemplateScreen());
      getTemplateList();
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
  }
}
