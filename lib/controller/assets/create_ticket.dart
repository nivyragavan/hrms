import 'package:dreamhrms/model/asset/asset_status_model.dart';
import 'package:dreamhrms/services/HttpHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../services/api_service.dart';
import '../../services/utils.dart';
import '../../widgets/encrypt_decrypt.dart';
import '../common_controller.dart';

class CreateTicketAssetController extends GetxController {
  static CreateTicketAssetController get to => Get.put(CreateTicketAssetController());
  static final HttpHelper _http = HttpHelper();
  BuildContext? context = Get.context;

  TextEditingController depName = TextEditingController();
  TextEditingController depId = TextEditingController();
  TextEditingController ticketCode = TextEditingController();
  TextEditingController subject = TextEditingController();
  TextEditingController priorityId = TextEditingController();
  TextEditingController priorityName = TextEditingController();
  TextEditingController ticketMessage = TextEditingController();
  TextEditingController imageName = TextEditingController();
  TextEditingController imageFormat = TextEditingController();


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }

}
