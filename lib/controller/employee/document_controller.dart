import 'dart:typed_data';

import 'package:dreamhrms/controller/department/add_department_controller.dart';
import 'package:dreamhrms/controller/employee/employee_controller.dart';
import 'package:dreamhrms/controller/employee/personal_controller.dart';
import 'package:dreamhrms/screen/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../model/docu_model.dart';
import '../../model/profile_model.dart';
import '../../services/HttpHelper.dart';
import '../../services/api_service.dart';
import '../../services/utils.dart';
import '../common_controller.dart';

class DocumentController extends GetxController {
  static DocumentController get to => Get.put(DocumentController());

  BuildContext? context = Get.context;

  static final HttpHelper _http = HttpHelper();

  TextEditingController idProofName = TextEditingController();
  TextEditingController addressName = TextEditingController();
  TextEditingController indentName = TextEditingController();
  TextEditingController experienceName = TextEditingController();
  TextEditingController certificateName = TextEditingController();
  TextEditingController courseName = TextEditingController();
  TextEditingController documentName = TextEditingController();

  TextEditingController idProof = TextEditingController();
  TextEditingController addressBytes = TextEditingController();
  TextEditingController indentBytes = TextEditingController();
  TextEditingController expCertificate = TextEditingController();
  TextEditingController certificateBytes = TextEditingController();
  TextEditingController courseBytes = TextEditingController();
  TextEditingController document = TextEditingController();

  final _loader = false.obs;

  get loader => _loader.value;

  set loader(value) {
    _loader.value = value;
  }

  final _personalLoader = false.obs;

  get personalLoader => _personalLoader.value;

  set personalLoader(value) {
    _personalLoader.value = value;
  }

  DocumentModel? documentModel;

  @override
  void onClose() {
    documentName.text = "";
    document.text = "";
    super.onClose();
  }

  disposeValues() {
    idProof.text = "";
    addressBytes.text = "";
    indentBytes.text = "";
    expCertificate.text = "";
    certificateBytes.text = "";
    courseBytes.text = "";
    idProofName.text = "";
    addressName.text = "";
    indentName.text = "";
    experienceName.text = "";
    certificateName.text = "";
    courseName.text = "";
  }

  editSetValues(Data1? data) {
    var DocumentList = data?.data;
    if (DocumentList != null && DocumentList != "") {
      print("Store document values");
      for (int i = 0; i < DocumentList!.length; i++) {
        print("Valuess description name ${DocumentList[i].docDescription}");
        if (DocumentList[i].docDescription == "id_proof") {
          idProofName.text = DocumentList[i].docName!;
          idProof.text = DocumentList[i].documentUrl!;
        } else if (DocumentList[i].docDescription == "address_proof") {
          addressName.text = DocumentList[i].docName!;
          addressBytes.text = DocumentList[i].documentUrl!;
        } else if (DocumentList[i].docDescription == "ident_proof") {
          indentName.text = DocumentList[i].docName!;
          indentBytes.text = DocumentList[i].documentUrl!;
        } else if (DocumentList[i].docDescription == "exp_certificate") {
          experienceName.text = DocumentList[i].docName!;
          expCertificate.text = DocumentList[i].documentUrl!;
        } else if (DocumentList[i].docDescription ==
            "educational_certificate") {
          certificateName.text = DocumentList[i].docName!;
          certificateBytes.text = DocumentList[i].documentUrl!;
        } else if (DocumentList[i].docDescription ==
            "course_completion_certificate") {
          courseName.text = DocumentList[i].docName!;
          courseBytes.text = DocumentList[i].documentUrl!;
        }
      }
    }
  }

  editDocuments({String? type}) async {
    List<String> file = [];
    List<String> fileName = [];
    if (idProofName.text.isNotEmpty &&
        (AddDepartmentController.to.isNetworkImage(idProof.text) == false)) {
      fileName.add("id_proof");
      file.add(idProof.text);
    }
    if (addressName.text.isNotEmpty &&
        (AddDepartmentController.to.isNetworkImage(addressBytes.text) ==
            false)) {
      fileName.add("address_proof");
      file.add(addressBytes.text);
    }
    if (indentName.text.isNotEmpty &&
        (AddDepartmentController.to.isNetworkImage(indentBytes.text) ==
            false)) {
      fileName.add("indent_proof");
      file.add(indentBytes.text);
    }
    if (experienceName.text.isNotEmpty &&
        (AddDepartmentController.to.isNetworkImage(expCertificate.text) ==
            false)) {
      fileName.add("exp_certificate");
      file.add(expCertificate.text);
    }
    if (certificateName.text.isNotEmpty &&
        (AddDepartmentController.to.isNetworkImage(certificateBytes.text) ==
            false)) {
      fileName.add("educational_certificate");
      file.add(certificateBytes.text);
    }
    if (courseName.text.isNotEmpty &&
        (AddDepartmentController.to.isNetworkImage(courseBytes.text) ==
            false)) {
      fileName.add("course_completion_certificate");
      file.add(courseBytes.text);
    }
    print("fileName${fileName}");
    print("file${file}");
    List<String> fieldsName = ["user_id", "type"];
    List<String> fields = [PersonalController.to.userId, "edit"];
    try {
      var response = await _http.commonImagePostMultiPart(
          url: "${Api.documentsUpload}",
          auth: true,
          filePaths: file,
          fileName: fileName,
          fieldsName: fieldsName,
          fields: fields);
      print("response $response");
      if (response['code'] == "200") {
        print("Education details Response $response");
        UtilService()
            .showToast("success", message: response['message'].toString());
        Get.to(() => MainScreen());
      } else {
        UtilService()
            .showToast("error", message: response['message'].toString());
      }
    } catch (e) {
      print("Exception on the api$e");
      CommonController.to.buttonLoader = false;
    }
  }

  postDocumentData() async {
    List<String> file = [
      idProof.text,
      addressBytes.text,
      indentBytes.text,
      expCertificate.text,
      certificateBytes.text,
      courseBytes.text,
    ];
    List<String> fileName = [
      "id_proof",
      "address_proof",
      "indent_proof",
      "exp_certificate",
      "educational_certificate",
      "course_completion_certificate"
    ];
    List<String> fieldsName = ["user_id", "type"];
    List<String> fields = [GetStorage().read("user_id"), "add"];
    try {
      var response = await _http.commonImagePostMultiPart(
          url: "${Api.documentsUpload}",
          auth: true,
          filePaths: file,
          fileName: fileName,
          fieldsName: fieldsName,
          fields: fields);
      print("response $response");
      if (response['code'] == "200") {
        print("Education details Response $response");
        UtilService()
            .showToast("success", message: response['message'].toString());
        Get.offAll(() => MainScreen());
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
