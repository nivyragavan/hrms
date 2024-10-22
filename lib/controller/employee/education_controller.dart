import 'package:dreamhrms/controller/employee/employee_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../model/add_employee/education_model.dart';
import '../../model/profile_model.dart';
import '../../screen/employee/add_employee_screen.dart';
import '../../services/HttpHelper.dart';
import '../../services/api_service.dart';
import '../../services/utils.dart';
import '../../widgets/encrypt_decrypt.dart';
import '../common_controller.dart';
import 'personal_controller.dart';

class EducationController extends GetxController {
  static EducationController get to => Get.put(EducationController());
  TextEditingController degreeNameController = TextEditingController();
  TextEditingController specializationController = TextEditingController();
  TextEditingController universityNameController = TextEditingController();
  TextEditingController gpaController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  @override
  void onClose() {
    super.onClose();
  }

  final _educationLoader = false.obs;

  get educationLoader => _educationLoader.value;

  set educationLoader(value) {
    _educationLoader.value = value;
  }

  final _isVisible = false.obs;

  get isVisible => _isVisible.value;

  set isVisible(value) {
    _isVisible.value = value;
  }

  final _personalLoader = false.obs;

  get personalLoader => _personalLoader.value;

  set personalLoader(value) {
    _personalLoader.value = value;
  }

  EducationModel? educationModel;
  BuildContext? context = Get.context;
  static final HttpHelper _http = HttpHelper();
  postEducationData() async {
    var body = {
      "education_data": educationModel?.education,
      "user_id": GetStorage().read("user_id"), //PersonalController.to.userId,
      "type": "add"
    };
    print("Body post data $body");
    try {
      var response = GetStorage().read("RequestEncryption") == true
          ? await _http.multipartPostData(
              url: "${Api.educationUpload}",
              encryptMessage:
                  await LibSodiumAlgorithm().encryptionMessage(body),
              auth: true)
          : await _http.post(Api.educationUpload, body,
              auth: true, contentHeader: false);
      if (response['code'] == "200") {
        print("Education details Response $response");
        UtilService()
            .showToast("success", message: response['message'].toString());
        Get.back();
        Get.to(() => AddEmployeeScreen(
              selectedIndex: 4,
            ));
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
