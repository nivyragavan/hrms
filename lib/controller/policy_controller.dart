import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../model/policies_model.dart';
import '../services/HttpHelper.dart';
import '../services/api_service.dart';
import '../services/utils.dart';
import '../widgets/encrypt_decrypt.dart';
import 'common_controller.dart';


class PolicyController extends GetxController{
  static PolicyController get to => Get.put(PolicyController());
  PoliciesListModel? policiesListModel;

  TextEditingController policyName = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController departmentName = TextEditingController();
  TextEditingController department = TextEditingController();
  List<String> selectedDepartments = <String>[].obs;


  final _isEdit = "".obs;

  get isEdit => _isEdit.value;

  set isEdit(value) {
    _isEdit.value = value;
  }

  final _loader = false.obs;

  get loader => _loader.value;

  set loader(value) {
    _loader.value = value;
  }

  getPoliciesList() async {
    loader = true;
    var body = {'': ''};
    var response = GetStorage().read("RequestEncryption") == true
        ? await HttpHelper().multipartPostData(
        url: "${Api.policiesList}",
        encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
        auth: true)
        : await HttpHelper().post(Api.policiesList, body,
        auth: true, contentHeader: false);
    if (response['code'] == "200") {
      policiesListModel=PoliciesListModel.fromJson(response);
     } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
    loader = false;
  }

  saveSystemSettings({required String option}) async {
    print("option $option");
    var body = option == 'add'
        ? {
      "name":"Custm policy1",
      "description":"test",
      // department:[
      //   {
      //
      //   }
      // ]
    }
        : {
      "id":"",
      "name":"Custm policy1",
      "description":"test",
      // department:[
      //   {
      //
      //   }
      // ]
    };
    try {
      var response = GetStorage().read("RequestEncryption") == true
          ? await HttpHelper().multipartPostData(
          url: "${Api.policiesSave}",
          encryptMessage:
          await LibSodiumAlgorithm().encryptionMessage(body),
          auth: true)
          : await HttpHelper().post(Api.policiesSave, body,
          auth: true, contentHeader: false);
      if (response['code'] == "200") {
        UtilService()
            .showToast("success", message: response['message'].toString());
        Get.back();
        await getPoliciesList();
      } else {
        UtilService()
            .showToast("error", message: response['message'].toString());
      }
    } catch (e) {
      print("Exception on the api$e");
      CommonController.to.buttonLoader = false;
    }
  }

}