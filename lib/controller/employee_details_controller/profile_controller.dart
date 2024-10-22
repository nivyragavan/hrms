import 'package:dreamhrms/controller/employee/employee_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../model/profile_model.dart';
import '../../services/HttpHelper.dart';
import '../../services/api_service.dart';
import '../../services/utils.dart';
import '../../widgets/encrypt_decrypt.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.put(ProfileController());

  static final HttpHelper _http = HttpHelper();
  final _showProfileList = false.obs;
  get showProfileList => _showProfileList.value;

  set showProfileList(value) {
    _showProfileList.value = value;
  }

  BuildContext? context = Get.context;
  ProfileModel? profileModel;

  @override
  void onClose() {
    profileModel = null;
    super.onClose();
  }

  getProfileList() async {
    showProfileList = true;
    profileModel = null;
    print('userId ${EmployeeController.to.selectedUserId}');
    var body = {"user_id": EmployeeController.to.selectedUserId.toString()};
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
            url: "${Api.profileList}",
            encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
            auth: true)
        : await _http.post(Api.profileList, body,
            auth: true, contentHeader: false);
    if (response['code'] == "200") {
      profileModel = ProfileModel.fromJson(response);
      GetStorage().write('UserImage', profileModel?.data?.data?.profileImage??"");
      GetStorage().write('emp_name', '${profileModel?.data?.data?.firstName??"-"} ${profileModel?.data?.data?.lastName}');
      GetStorage().write('user_mail_id', profileModel?.data?.data?.emailId??"");
    } else {
      UtilService()
          .showToast("error", message: response['message'].toString());
    }
    showProfileList = false;
  }
}
