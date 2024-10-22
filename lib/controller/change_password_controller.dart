import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../services/HttpHelper.dart';

class ChangePasswordController extends GetxController{
  static ChangePasswordController get to => Get.put(ChangePasswordController());

  BuildContext? context = Get.context;
  static final HttpHelper _http = HttpHelper();


  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
}