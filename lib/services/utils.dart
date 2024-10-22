import 'package:dreamhrms/screen/login.dart';
import 'package:dreamhrms/screen/splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import '../controller/login_controller.dart';


class UtilService {
   showToast(String? toastType,
      {required String message}) {
    print('toast $toastType');
     Fluttertoast.showToast(msg: message,fontSize: 15,textColor:AppColors.white,backgroundColor:
                  toastType == "success" ? AppColors.green : AppColors.red,);
    if(message=="Unauthorized Token"){
      LoginController.to.clearLocalStorage();
      Get.offAll(Splash());
    }
  }
}
