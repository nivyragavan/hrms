import 'package:dreamhrms/controller/employee/personal_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../model/docu_model.dart';
import '../../services/HttpHelper.dart';
import '../../services/api_service.dart';
import '../../services/utils.dart';
import '../../widgets/encrypt_decrypt.dart';
import '../employee/employee_controller.dart';

class DocumentsController extends GetxController {
  static DocumentsController get to => Get.put(DocumentsController());
  DocumentModel? documentModel;
  static final HttpHelper _http = HttpHelper();
  BuildContext? context = Get.context;
  final _showDocuList = false.obs;

  get showDocuList => _showDocuList.value;

  set showDocuList(value) {
    _showDocuList.value = value;
  }

  final _documentIndex=0.obs;

  get documentIndex => _documentIndex.value;

  set documentIndex(value) {
    _documentIndex.value = value;
  }

  getDocuList({ String? type}) async {
    showDocuList = true;
    var body = {"user_id": type=="Edit"?PersonalController.to.userId:EmployeeController.to.selectedUserId.toString()};
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
        url: "${Api.documentList}",
        encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
        auth: true)
        : await _http.post(Api.documentList, body,
        auth: true, contentHeader: false);
    // var response = await _http.post(Api.documentList, body, auth: true);
    if (response['code'] == "200") {
      documentModel = DocumentModel.fromJson(response);
    } else {
      UtilService()
          .showToast("error", message: response['message'].toString());
    }
    showDocuList = false;
  }
}
