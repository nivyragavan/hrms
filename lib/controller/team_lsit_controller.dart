import 'package:dreamhrms/controller/login_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../services/HttpHelper.dart';
import '../services/api_service.dart';
import '../services/utils.dart';
import '../widgets/encrypt_decrypt.dart';

class TeamListController extends GetxController {
  static TeamListController get to => Get.put(TeamListController());

  static final HttpHelper _http = HttpHelper();

  final _loader = false.obs;

  get loader => _loader.value;

  set loader(value) {
    _loader.value = value;
  }

  getTeam() async {
    loader = true;
    var body = {
      "user_id": GetStorage().read("login_userid")
    };
    print("teams body data $body");
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
        url: "${Api.assets}",
        encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
        auth: true)
        : await _http.post(Api.assets, body,
        auth: true, contentHeader: false);
    if (response['code'] == "200") {
    } else {
      UtilService().showToast("error",
          message: response['message'].toString());
    }
    loader = false;
    // update();
  }
}
