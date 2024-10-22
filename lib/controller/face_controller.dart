import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dreamhrms/constants/colors.dart';
import 'package:dreamhrms/controller/common_controller.dart';
import 'package:dreamhrms/controller/employee/personal_controller.dart';
import 'package:dreamhrms/model/face_model.dart';
import 'package:dreamhrms/screen/face_reco/add_face.dart';
import 'package:dreamhrms/screen/face_reco/verify_face.dart';
import 'package:dreamhrms/screen/main_screen.dart';
import 'package:dreamhrms/services/HttpHelper.dart';
import 'package:dreamhrms/services/utils.dart';
import 'package:dreamhrms/widgets/Custom_text.dart';
import 'package:dreamhrms/widgets/back_to_screen.dart';
import 'package:dreamhrms/widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../services/api_service.dart';

class FaceController extends GetxController {
  static FaceController get to => Get.put(FaceController());
  final _loading = false.obs;
  int lastPage = 0;
  final countPerPage = 10;
  get loading => _loading.value;
  set loading(value) {
    _loading.value = value;
  }

  RxList<FaceDetails> _faceList = RxList<FaceDetails>.empty();
  List get faceList => _faceList;

  set faceList(value) {
    _faceList.value = value;
  }

  Future getFaceList({required int page, int? status}) async {
    if (page == 1) {
      faceList = RxList<FaceDetails>.empty();
    }
    loading = true;
    var body = {
      "page": page.toString(),
      "count_per_page": countPerPage.toString(),
      "list_type": "paginate"
    };

    if (status != null) {
      body['search'] = status.toString();
    }

    // add try catch
    try {
      var response = await HttpHelper().post(Api.faceList, body, auth: true);
      if (response['code'] == "200") {
        print('face list response $response');
        lastPage = response['data']['last_page'];
        if (page == 1) {
          faceList = faceListFromJson(jsonEncode(response['data']['data']));
        } else {
          faceList
              .addAll(faceListFromJson(jsonEncode(response['data']['data'])));
        }
        loading = false;
      } else {
        loading = false;
        print('face list error ${response['message']}');
      }
    } catch (e) {
      loading = false;
      print('face list error $e');
      UtilService().showToast("error", message: e.toString());
    }
  }

  Future<bool> changeFaceStatus({required int id, required int status}) async {
    var body = {"user_id": "$id", "punch_in_status": "$status"};
    var response =
        await HttpHelper().post(Api.changeFaceStatus, body, auth: true);
    if (response['code'] == "200") {
      print('change face status response $response');
      UtilService()
          .showToast("success", message: response['message'].toString());
      return true;
    } else {
      print('change face status error ${response['message']}');
      UtilService().showToast("error", message: response['message'].toString());
      return false;
    }
  }

  // add Face
  Future addFace({required String filePath}) async {
    File rotatedImage = await FlutterExifRotation.rotateImage(path: filePath);

    var response = await HttpHelper().commonImagePostMultiPart(
        url: Api.addFace,
        fieldsName: [],
        fileName: ['image'],
        auth: true,
        fields: [],
        filePaths: [rotatedImage.path]);
    if (response['code'] == "200") {
      print('add face response $response');
      UtilService()
          .showToast("success", message: response['message'].toString());
    } else {
      UtilService().showToast("error", message: response['message'].toString());
      print('add face error ${response['message']}');
    }
  }

  // verify face
  Future<bool> verifyFace(
      {required String filePath, required String fileUrl}) async {
    File rotatedImage = await FlutterExifRotation.rotateImage(path: filePath);

    try {
      var request = http.MultipartRequest('POST', Uri.parse(Api.verifyFace));
      request.fields['image_url'] = fileUrl;
      request.files
          .add(await http.MultipartFile.fromPath('image', rotatedImage.path));
      var res = await request.send();
      var result = await res.stream.bytesToString();
      var response = json.decode(result); // Parse response into JSON
      inspect(response);
      inspect(res);
      if (res.statusCode == 200) {
        print('verify face response $response');
        UtilService()
            .showToast("success", message: response['message'].toString());
        return true;
      } else {
        UtilService()
            .showToast("error", message: response['message'].toString());
        print('verify face error ${response['message']}');
        return false;
      }
    } catch (e) {
      print('verify face error $e');
      inspect(e);
      UtilService().showToast("error", message: e.toString());
      return false;
    }
  }

  // get face status
  Future<FaceDetails?> getFaceStatus({required String userId}) async {
    var response = await HttpHelper()
        .post(Api.getFaceStatus, {"user_id": userId}, auth: true);
    if (response['code'] == "200") {
      print('get face status response $response');
      return FaceDetails.fromJson(response['data']);
    } else {
      print('get face status error ${response['message']}');
      return null;
    }
  }

  // can able to do face reco
  Future doFaceReco({ bool verificationOnly=false}) async {
    FaceDetails? face =
        await getFaceStatus(userId: PersonalController.to.userId);
    print("face response $face");
   if(verificationOnly==false){
     if (face != null) {
       if (face.punchInStatus == 1) {
         bool isVerified =
         await Get.to(() => VerifyFace(image_url: face.punchInImage));
         return isVerified;
       } else {
         Get.back();
         CommonController.to.buttonLoader = false;
         await showAlertMessage(status: face.punchInStatus);
         return false;
       }
     }
     else {
       Get.back();
       CommonController.to.buttonLoader = false;
       await showAlertMessage();
       return false;
     }
   }else{
     if (face != null) {
       if (face.punchInStatus == 1) {
         bool isVerified =
         await Get.to(() => VerifyFace(image_url: face.punchInImage));
         return isVerified;
       } else {
         Get.back();
         CommonController.to.buttonLoader = false;
         await showAlertMessage(status: face.punchInStatus);
         return false;
       }
     }
     else {
       await showAlertMessage(verificationOnly:verificationOnly);
       return false;
     }
   }
  }

  showAlertMessage({int? status, bool? verificationOnly=false}) async {
    return Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Material(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // SvgPicture.asset('assets/icons/tick.svg'),
                      CircleAvatar(
                        backgroundColor: AppColors.lightRed,
                        radius: 15,
                        child: Icon(
                          status == 2 ? Icons.close : Icons.warning,
                          color: AppColors.red,
                          size: 18,
                        ),
                      ),
                      SizedBox(height: 15),
                      CustomText(
                          text: status == 2
                              ? 'Your face is rejected by approver. Please add new face.'
                              : status == 0
                                  ? 'Your face is not approved by approver. Please wait until get approved.'
                                  : 'Your face is not added. Please add new face.',
                          color: AppColors.black,
                          fontSize: 18,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w400,
                          maxLines: 10),
                      SizedBox(height: 20),
                      Obx(
                        () => Row(
                          children: [
                            Expanded(
                              child: CommonButton(
                                text: status == 0 ? "OK" : "Add Face",
                                textColor: AppColors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                buttonLoader: CommonController.to.buttonLoader,
                                onPressed: () async {
                                  // CommonController.to.buttonLoader=true;
                                  print("status $status");
                                  if (status != 0) {
                                    if(verificationOnly==true){
                                      await Get.to(() => AddFace());
                                      Get.back();
                                    }else{
                                      await Get.to(() => AddFace());
                                      Get.to(()=>MainScreen());
                                    }
                                  }else{
                                    Get.back();
                                  }
                                  // Get.back();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      BackToScreen(
                        text: "close",
                        arrowIcon: false,
                        onPressed: () {
                          print("close button on click");
                          // Get.to(()=>MainScreen());
                          Get.back();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
