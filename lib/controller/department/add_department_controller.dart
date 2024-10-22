import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../model/department_model.dart';
import '../../model/grade_model.dart';
import '../../services/HttpHelper.dart';
import '../../services/api_service.dart';
import '../../services/utils.dart';
import '../../widgets/encrypt_decrypt.dart';
import '../common_controller.dart';
import 'deparrtment_controller.dart';

class AddDepartmentController extends GetxController {
  static AddDepartmentController get to => Get.put(AddDepartmentController());
  final formKey = GlobalKey<FormState>();
  static final HttpHelper _http = HttpHelper();
  TextEditingController deptNameController = TextEditingController();
  TextEditingController deptIdController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController positionIdController = TextEditingController();
  TextEditingController gradeController = TextEditingController();
  TextEditingController gradeIdController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController departmentImage = TextEditingController();

  TextEditingController popupNameController = TextEditingController();

  BuildContext? context = Get.context;

  final _imageFormat = "".obs;

  get imageFormat => _imageFormat.value;

  set imageFormat(value) {
    _imageFormat.value = value;
  }

  final _loader = false.obs;

  get loader => _loader.value;

  set loader(value) {
    _loader.value = value;
  }

  final _addDepartment = false.obs;

  get addDepartment => _addDepartment.value;

  set addDepartment(value) {
    _addDepartment.value = value;
  }

  final _descRequired = false.obs;

  get descRequired => _descRequired.value;

  set descRequired(value) {
    _descRequired.value = value;
  }

  final _department = "".obs;

  get department => _department.value;

  set department(value) {
    _department.value = value;
  }

  final _position = "".obs;

  get position => _position.value;

  set position(value) {
    _position.value = value;
  }

  GradeModel? gradeModel;

  @override
  void onClose() {
    super.onClose();
    positionLoader = false;
    descRequired = false;
    addDepartment = false;
  }

  clearData() {
    AddDepartmentController.to.departmentImage.text = "";
    deptNameController.text = "";
    deptIdController.text = "";
    positionController.text = "";
    positionIdController.text = "";
    gradeController.text = "";
    gradeIdController.text = "";
    descriptionController.text = "";
    imageFormat = "";
    department = "";
    position = "";
    positionLoader = false;
    descRequired = false;
    addDepartment = false;
    departmentLoader = false;
    positionLoader = false;
    gradeLoader = false;
    loader = false;
  }

  final _positionLoader = false.obs;

  get positionLoader => _positionLoader.value;

  set positionLoader(value) {
    _positionLoader.value = value;
  }

  final _departmentLoader = false.obs;

  get departmentLoader => _departmentLoader.value;

  set departmentLoader(value) {
    _departmentLoader.value = value;
  }

  final _gradeLoader = false.obs;

  get gradeLoader => _gradeLoader.value;

  set gradeLoader(value) {
    _gradeLoader.value = value;
  }


  getGradeName(String id) {
    gradeLoader = true;
    List matchingGrades = gradeModel?.data
            ?.where((element) => element.id.toString() == id.toString())
            .toList() ??
        [];
    print(matchingGrades);
    String gradeName =
        matchingGrades.isNotEmpty ? matchingGrades[0].gradeName : "";

    Future.delayed(Duration(milliseconds: 1)).then((value) {
      AddDepartmentController.to.gradeController.text = gradeName;
      gradeLoader = false;
    });
    return gradeName;
  }

  setControllerHeaderEdit(dynamic data) {
    loader = true;
    departmentImage.text = '${data.departmentIcon}';
    deptNameController.text = '${data.departmentName!}';
    deptIdController.text = '${data.departmentId!}';
    descriptionController.text = '${data.description!}';
    addDepartment = false;
    loader = false;
  }

  setControllerValue(Positions? expansionList, int mainIndex) {
    loader = true;
    departmentImage.text =
        '${DepartmentController.to.departmentModel?.data![mainIndex].departmentIcon}';
    deptNameController.text =
        '${DepartmentController.to.departmentModel?.data![mainIndex].departmentName!}';
    deptIdController.text =
        '${DepartmentController.to.departmentModel?.data![mainIndex].departmentId!}';
    positionController.text = expansionList!.positionName!;
    positionIdController.text = '${expansionList.id}';
    gradeIdController.text = expansionList.grade!;
    gradeController.text = getGradeName(gradeIdController.text);
    descriptionController.text =
        '${DepartmentController.to.departmentModel?.data![mainIndex].description!}';
    addDepartment = true;
    loader = false;
  }

  getGradeList() async {
    var response = await _http.get(Api.gradeList, auth: true);
    if (response['code'] == "200") {
      gradeModel = GradeModel.fromJson(response);
    }
  }

  postAddDepartment({required String value}) async {
    try{
      var body = await getBodyData(value);
      print("body request data $body");
      var response =
      GetStorage().read("RequestEncryption") == true
          ? await _http.multipartPostData(
          url: "${Api.departmentDataUpload}",
          encryptMessage:
          await LibSodiumAlgorithm().encryptionMessage(body),
          auth: true)
          : await _http.post(Api.departmentDataUpload, body,
          auth: true, contentHeader: false);
      if (response['code'] == "200") {
        if (departmentImage.text != "" &&
            departmentImage.text != null &&
            isNetworkImage(AddDepartmentController.to.departmentImage.text) ==
                false) {
          if (await imageUpload(response['data']['department_id'])) {
            UtilService()
                .showToast("success", message: response['message'].toString());
            DepartmentController.to.getDepartmentList();
            Get.back();
          } else {
            UtilService().showToast("error",
                message: "Something Went Wrong. Try Again Later!");
          }
        } else {
          UtilService()
              .showToast("success", message: response['message'].toString());
          DepartmentController.to.getDepartmentList();
          Get.back();
        }
      } else {
        UtilService().showToast("error", message: response['message'].toString());
      }
    }catch (e) {
      print("Exception on the api$e");
      CommonController.to.buttonLoader = false;
    }
  }

  bool isNetworkImage(String imageUrl) {
    return imageUrl.startsWith('http://') || imageUrl.startsWith('https://');
  }

  imageUpload(departmentId) async {
    List<String> fieldsName = ["department_id"];
    List<String> fields = [departmentId];
    List<String> filePaths = [AddDepartmentController.to.departmentImage.text];
    List<String> fileName = [
      "department_icon",
    ];
    var response = await _http.commonImagePostMultiPart(
        url: "${Api.departmentIconUpload}",
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

  getBodyData(String value) {
    print(
        "getBody data $value addDepartment $addDepartment department$department position$position");
    if (value == "SubEdit") {
      var body = {
        "position_type": "edit",
        "position_name": positionController.text,
        "position_id": positionIdController.text,
        "grade": gradeIdController.text
      };
      return body;
    }
    if (addDepartment == false && department == "add") {
      var body = {
        "department_name": deptNameController.text,
        "description": descriptionController.text,
        "department_type": "add",
      };
      return body;
    } else {
      if (addDepartment == false && department == "edit") {
        var body = {
          "department_name": deptNameController.text,
          "description": descriptionController.text,
          "department_id": '${deptIdController.text}',
          "department_type": "edit",
        };
        return body;
      }
      if (addDepartment == true && department == "edit" && position == "edit") {
        Map<String, dynamic> body = {
          "department_id": '${deptIdController.text}',
          "department_name": deptNameController.text,
          "position_name": positionController.text,
          "position_id": '${positionIdController.text}',
          "grade": '${gradeIdController.text}',
          "position_type": position,
          "department_type": department,
          "description": descriptionController.text,
        };
        return body;
      } else {
        if (addDepartment == true &&
            department == "edit" &&
            position == "add") {
          Map<String, dynamic> body = {
            "department_id": '${deptIdController.text}',
            "department_name": deptNameController.text,
            "position_name": positionController.text,
            "grade": '${gradeIdController.text}',
            "position_type": position,
            "department_type": department,
            "description": descriptionController.text
          };
          return body;
        }
      }
    }
  }
}
