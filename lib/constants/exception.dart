
import 'dart:ui';

import 'package:dreamhrms/screen/login.dart';
import 'package:dreamhrms/screen/splash.dart';
import 'package:dreamhrms/services/utils.dart';
import 'package:get/get.dart';

import '../controller/login_controller.dart';
import '../widgets/no_record.dart';

class AppException implements Exception{
  final dynamic _message;
  final dynamic _prefix;

  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  int code;
  String message;

  FetchDataException(this.message, this.code)
      : super(message, "") {
    print("500 entry $code}");
    UtilService()
        .showToast("error", message: "Something went wrong. Try again later".toString());
    //   if(code==500 || code==502) {
    //     ///if 500 occur toast and image
    //     UtilService()
    //         .showToast("error", message: "Something went wrong. Try again later".toString());
    //     // Get.to(()=>ServerError());
    //     // CommonToast.show(msg: "Sorry for the inconvenience... Please wait.....");
    //     // Get.to(()=>Error500());
    // }

    // Get.defaultDialog(
    //
    //      onConfirm: () {
    //        Get.offNamed('/');
    //      },
    //      onCancel: () {
    //        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    //      },
    //      textCancel: 'Close App',
    //      textConfirm: 'Home',
    //      middleText: message
    //  );

  }
}

class BadRequestException extends AppException {
  int code;
  String message;

  BadRequestException(this.message, this.code)
      : super(message, "Invalid Request: ") {
    // navigator!.pushNamed('/' + code.toString());
    // String scode = code != null ? code.toString() : '404';
   ///404 display image
    // Get.to(()=>Error404());
  }
}

class UnauthorisedException extends AppException {
  int code;
  String message;
  String next;
  var res;

  UnauthorisedException(this.res, this.message, this.code, {this.next = ""})
      : super(message, "Unauthorized Token") {
    if(message=="Unauthorized Token"){
      LoginController.to.clearLocalStorage();
      Get.offAll(Splash());
    }else{
      // UtilService()
      //     .showToast("success", message: "response['message']".toString());
      // Image.asset(
      //   "assets/images/assets.png",
      //   fit: BoxFit.fill,
      //   width: Get.width,
      // ),
    }
  }
}

