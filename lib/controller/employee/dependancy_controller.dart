import 'package:dreamhrms/controller/employee/personal_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../model/add_employee/dependent_model.dart';
import '../../model/profile_model.dart';
import '../../screen/employee/add_employee_screen.dart';
import '../../services/HttpHelper.dart';
import '../../services/api_service.dart';
import '../../services/utils.dart';
import '../../widgets/encrypt_decrypt.dart';
import '../common_controller.dart';

class DependencyController extends GetxController {
  static DependencyController get to => Get.put(DependencyController());

  final formKey = GlobalKey<FormState>();

  BuildContext? context = Get.context;
  static final HttpHelper _http = HttpHelper();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController relationshipController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController maritalStatusController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController nationalityControllerId = TextEditingController();
  TextEditingController stateControllerId = TextEditingController();
  TextEditingController cityControllerId = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController personalEmailController = TextEditingController();
  TextEditingController bloodController = TextEditingController();
  TextEditingController dob = TextEditingController();

  final _dependantLoader = false.obs;

  get dependantLoader => _dependantLoader.value;

  set dependantLoader(value) {
    _dependantLoader.value = value;
  }

  final _personalLoader = false.obs;

  get personalLoader => _personalLoader.value;

  set personalLoader(value) {
    _personalLoader.value = value;
  }

  final _isVisible = false.obs;

  get isVisible => _isVisible.value;

  set isVisible(value) {
    _isVisible.value = value;
  }

  DependantModel? dependantModel;

  postDependency() async {
    var body = {
      "dependant": dependantModel?.dependant,
      "user_id": GetStorage().read("user_id"),
      "type": "add"
    };
    print("Body post data $body");
    try {
      var response = GetStorage().read("RequestEncryption") == true
          ? await _http.multipartPostData(
              url: "${Api.dependencyupload}",
              encryptMessage:
                  await LibSodiumAlgorithm().encryptionMessage(body),
              auth: true)
          : await _http.post(Api.dependencyupload, body,
              auth: true, contentHeader: false);
      if (response['code'] == "200") {
        print("Employee details Response $response");
        UtilService()
            .showToast("success", message: response['message'].toString());
        Get.back();
        Get.to(() => AddEmployeeScreen(selectedIndex: 3));
      } else {
        UtilService()
            .showToast("error", message: response['message'].toString());
      }
    } catch (e) {
      print("Exception on the api$e");
      CommonController.to.buttonLoader = false;
    }
  }

  editDependency() async {
    var body = {
      "dependant": dependantModel?.dependant,
      // "user_id": PersonalController.to.userId,
      "user_id": PersonalController.to.userId,
      "type": "edit"
    };
    print("Body edit data $body");
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
            url: "${Api.dependencyupload}",
            encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
            auth: true)
        : await _http.post(Api.dependencyupload, body,
            auth: true, contentHeader: false);
    if (response['code'] == "200") {
      print("Employee details Response $response");
      UtilService().showToast("error", message: response['message'].toString());
      Get.back();
      Get.to(() => AddEmployeeScreen(selectedIndex: 3));
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
  }
}
