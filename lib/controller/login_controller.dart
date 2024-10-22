import 'dart:convert';

import 'package:dreamhrms/controller/common_controller.dart';
import 'package:dreamhrms/model/login_model.dart';
import 'package:dreamhrms/screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:localization/localization.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/colors.dart';
import '../services/HttpHelper.dart';
import 'provision/provision_controller.dart';
import '../services/api_service.dart';
import '../services/firebase_notification.dart';
import '../services/service_method.dart';
import '../services/utils.dart';
import '../widgets/Custom_rich_text.dart';
import '../widgets/Custom_text.dart';
import '../widgets/common_button.dart';
import '../widgets/common_textformfield.dart';
import '../widgets/common_typeheadtextformfield.dart';
import '../widgets/encrypt_decrypt.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.put(LoginController());
  static final HttpHelper _http = HttpHelper();
  LoginModel? loginModel;
  TextEditingController userEmail = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController currentAddress = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loginInit();
    //getCurrentLocation();

  }

  // @override
  // void onClose() {
  //   userEmail.dispose();
  //   password.dispose();
  //   super.onClose();
  // }

  loginInit() {
    userEmail.text = "";
    password.text = "";
  }

  final _switchRememberButton = false.obs;

  get switchRememberButton => _switchRememberButton.value;

  set switchRememberButton(value) {
    _switchRememberButton.value = value;
  }

  BuildContext? context = Get.context;
  final box = GetStorage();
  List<Credentials> credentialsList = [];

  Future<Position?> getCurrentLocation() async {
   bool  service = await Geolocator.isLocationServiceEnabled();
    if(!service){
      print('Service disabled');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
    }
   Position position = await Geolocator.getCurrentPosition(
       desiredAccuracy: LocationAccuracy.high);
   String address =
   await ServiceMethods().searchCoordinateAddress(context, position);
   print("address " + address);
   currentAddress.text = address;
   GetStorage().write("CurrentAddress", currentAddress.text);
   print("Get Storage Address  ${GetStorage().read("CurrentAddress",).toString()}");
   return null;
  }
  login({ String? option}) async {
    String deviceToken = box.read('deviceToken');
      var body = {"email_id": userEmail.text, "password": password.text,"device_token" : deviceToken};
      print('login body $body');
    var response;
    try {
       response = await _http.multipartPostData(
          url: "${Api.login}",
          encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
          auth: false);
      print("response $response");
      if (response['code'] == "200") {
        print("Login response Information+++++++}");
        Logger().d(response);
        loginModel = LoginModel.fromJson(response);
        print("roles values: ${loginModel?.data?.original?.user?.roles}");

        ///Encryption or decryption validation
        checkEncryptionValidation();
        ///stored data in local
        await localStorage();
        if(option=="login" )Get.offAll(() => MainScreen());
        ///remember me
        if (switchRememberButton) {
          Credentials firstCredentials =
              Credentials(userEmail.text, password.text);
          await addCredentialsToList(firstCredentials);
          credentialsList = await getCredentialsList();
        }
      } else {
        UtilService()
            .showToast("error", message: response['message'].toString());
      }
    } catch (e) {
      print("Exception on the api$e");
      print("roles check ${response['data']['original']['user']['roles']}");
      if(response['data']['original']['user']['roles']==[] || response['data']['original']['user']['roles']==null ){
        UtilService().showToast("error", message: "Your login credentials have no roles assigned".toString());
      }
      CommonController.to.buttonLoader = false;
    }
  }

  localStorage() async {
     box.write("login_userid", "${loginModel?.data?.original?.user?.id} ");
    print("login user id ${box.read("login_userid")}");
    box.write("username", userEmail.text);
    box.write("password", password.text);
    box.write(
      "user_name",
      '${LoginController.to.loginModel?.data?.original?.user?.firstName ?? "-"} ${LoginController.to.loginModel?.data?.original?.user?.lastName ?? ""}',
    );
    box.write(
      "emp_name",
      '${LoginController.to.loginModel?.data?.original?.user?.firstName ?? "-"} ${LoginController.to.loginModel?.data?.original?.user?.lastName ?? ""}',
    );
    // box.write("user_job_title", '${LoginController.to.loginModel?.data?.original?.domain?.jobTitle ?? "-"}');
    box.write("user_job_title",
        '${LoginController.to.loginModel?.data?.original?.user?.emailId ?? "-"}');
    box.write("user_mail_id",
        '${LoginController.to.loginModel?.data?.original?.user?.emailId ?? "-"}');
    box.write("comp_name",
        '${LoginController.to.loginModel?.data?.original?.domain?.tenantId ?? "-"}');
    box.write("role",
        '${LoginController.to.loginModel?.data?.original?.user?.roles?[0].name?.toLowerCase() ?? "-"}');
    box.write("company_latitude",'${LoginController.to.loginModel?.data?.original?.branchSettings?.latitude ?? ""}');
    box.write("company_longitude",'${LoginController.to.loginModel?.data?.original?.branchSettings?.longitude ?? ""}');
    box.write("company_radius",'${LoginController.to.loginModel?.data?.original?.branchSettings?.clockLimitRadius?.distance?.split(' ').first?? ""}');
    box.write("company_radius_detection",'${LoginController.to.loginModel?.data?.original?.branchSettings?.geofencingStatus??0}');
    box.write(
        "CompanyLogo",
        loginModel?.data?.original?.companyImage != null
            ? "${loginModel?.data?.original?.user?.profileImage}"
            : "https://media.istockphoto.com/id/1318482009/photo/young-woman-ready-for-job-business-concept.jpg?s=612x612&w=0&k=20&c=Jc1NcoUMoM78AxPTh9EApaPU2kXh2evb499JgW99b0g=");
    box.write(
        "UserImage",
        loginModel?.data?.original?.companyImage != null
            ? "${loginModel?.data?.original?.user?.profileImage}"
            : "https://media.istockphoto.com/id/1318482009/photo/young-woman-ready-for-job-business-concept.jpg?s=612x612&w=0&k=20&c=Jc1NcoUMoM78AxPTh9EApaPU2kXh2evb499JgW99b0g=");
    print(GetStorage().read("CompanyLogo"));
    ///system settings
    GetStorage().write("date_format","${loginModel?.data?.original?.systemSettings?.timezoneDateFormat?.format??"YYYY-MM-DD"}");
    GetStorage().write("first_day",loginModel?.data?.original?.systemSettings?.firstDayOfWeek);
    GetStorage().write("language_code",loginModel?.data?.original?.systemSettings!.languages!.code);
    GetStorage().write("global_time",loginModel?.data?.original?.systemSettings?.timezoneTimeFormat?.format);
    print("Time ${GetStorage().read("global_time").toString()}");
     box.write("Token",
         "${loginModel?.data?.original?.tokenType} ${loginModel?.data?.original?.accessToken}");
    await ProvisionController.to.setProvisions(loginModel?.data?.original?.user?.roles?[0].permissions??[]);
     await CommonController.to.getLanguageTranslator(GetStorage().read("language_code"));
  }

  Future<void> addCredentialsToList(Credentials newCredentials) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? existingCredentialsJson = prefs.getString('credentials');
    List<dynamic> existingCredentialsList = [];

    if (existingCredentialsJson != null) {
      try {
        existingCredentialsList = jsonDecode(existingCredentialsJson);
        if (existingCredentialsList is! List) {
          existingCredentialsList = [];
        }
      } catch (e) {
        existingCredentialsList = [];
      }
    }
    // existingCredentialsList.add(newCredentials.toJson());
    // prefs.setString('credentials', jsonEncode(existingCredentialsList));

    bool isDuplicate = existingCredentialsList.any((credential) {
      final username = credential['username'];
      final password = credential['password'];
      return username.toString() == newCredentials.username.toString() &&
          password.toString() == newCredentials.password.toString();
    });

    bool isUpdate = existingCredentialsList.any((credential) {
      final username = credential['username'];
      final password = credential['password'];
      return username == newCredentials.username &&
          password != newCredentials.password;
    });

    print("isDuplicate$isDuplicate");
    print("isUpdate$isUpdate");

    if (!isDuplicate) {
      existingCredentialsList.add(newCredentials.toJson());
      prefs.setString('credentials', jsonEncode(existingCredentialsList));
    } else {
      if (isUpdate) {
        // Get.dialog(
        //   Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Padding(
        //         padding: const EdgeInsets.symmetric(horizontal: 40),
        //         child: Container(
        //           decoration: const BoxDecoration(
        //             color: Colors.white,
        //             borderRadius: BorderRadius.all(
        //               Radius.circular(20),
        //             ),
        //           ),
        //           child: Padding(
        //             padding: const EdgeInsets.all(10.0),
        //             child: Material(
        //               child: Column(
        //                 children: [
        //                   CustomText(
        //                     text: 'Update Password ?',
        //                     color: AppColors.black,
        //                     fontSize: 15,
        //                     fontWeight: FontWeight.w800,
        //                   ),
        //                   SizedBox(height: 15),
        //                   Row(
        //                     crossAxisAlignment: CrossAxisAlignment.center,
        //                     mainAxisAlignment: MainAxisAlignment.start,
        //                     children: [
        //                       SizedBox(
        //                         width: 65,
        //                         child: CustomRichText(
        //                             textAlign: TextAlign.center,
        //                             text: "mail_hint",
        //                             color: AppColors.black,
        //                             fontSize: 12,
        //                             fontWeight: FontWeight.w400,
        //                             textSpan: '',
        //                             textSpanColor: AppColors.red),
        //                       ),
        //                       SizedBox(width: 10),
        //                       SizedBox(
        //                         width: Get.width * 0.5,
        //                         height: 35,
        //                         child: CommonTypeTextFormField(
        //                           controller: LoginController.to.userEmail,
        //                           readOnly: true,
        //                           // hintText: "mail_hint",
        //                           isBlackColors: true,
        //                           type: "username",
        //                           keyboardType: TextInputType.emailAddress,
        //                           validator: (String? data) {
        //                             if (data == "" || data == null) {
        //                               return "required_email";
        //                             } else if (!RegExp(
        //                                     r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
        //                                 .hasMatch(data)) {
        //                               return "required_email_format";
        //                             } else {
        //                               return null;
        //                             }
        //                           },
        //                         ),
        //                       ),
        //                     ],
        //                   ),
        //                   SizedBox(height: 10),
        //                   Row(
        //                     crossAxisAlignment: CrossAxisAlignment.center,
        //                     mainAxisAlignment: MainAxisAlignment.start,
        //                     children: [
        //                       SizedBox(
        //                         width: 65,
        //                         child: CustomRichText(
        //                             textAlign: TextAlign.center,
        //                             text: "password",
        //                             color: AppColors.black,
        //                             fontSize: 12,
        //                             fontWeight: FontWeight.w400,
        //                             textSpan: '',
        //                             textSpanColor: AppColors.red),
        //                       ),
        //                       SizedBox(width: 10),
        //                       SizedBox(
        //                         width: Get.width * 0.5,
        //                         height: 35,
        //                         child: CommonTextFormField(
        //                           readOnly: true,
        //                           controller: LoginController.to.password,
        //                           isBlackColors: true,
        //                           password: true,
        //                         ),
        //                       ),
        //                     ],
        //                   ),
        //                   SizedBox(height: 20),
        //                   Row(
        //                     mainAxisAlignment: MainAxisAlignment.end,
        //                     children: [
        //                       CommonButton(
        //                         text: "never",
        //                         textColor: AppColors.white,
        //                         fontSize: 16,
        //                         buttonLoader: CommonController.to.buttonLoader,
        //                         fontWeight: FontWeight.w500,
        //                         // textAlign: TextAlign.center,
        //                         onPressed: () async {
        //                           Get.back();
        //                         },
        //                       ),
        //                       SizedBox(width: 5),
        //                       CommonButton(
        //                         text: "save",
        //                         textColor: AppColors.white,
        //                         fontSize: 16,
        //                         buttonLoader: CommonController.to.buttonLoader,
        //                         fontWeight: FontWeight.w500,
        //                         // textAlign: TextAlign.center,
        //                         onPressed: () async {
        //                           CommonController.to.buttonLoader = true;
        //                           existingCredentialsList
        //                               .add(newCredentials.toJson());
        //                           prefs.setString('credentials',
        //                               jsonEncode(existingCredentialsList));
        //                           Get.back();
        //                           CommonController.to.buttonLoader = false;
        //                         },
        //                       ),
        //                     ],
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // );
      }
    }
  }

  Future<List<Credentials>> getCredentialsList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? credentialsJson = prefs.getString('credentials');
    List<dynamic> credentialsList = jsonDecode(credentialsJson ?? '[]');
    List<Credentials> credentialsListObjects = [];
    for (var item in credentialsList) {
      if (item is Map<String, dynamic>) {
        credentialsListObjects.add(Credentials.fromJson(item));
      }
    }

    return credentialsListObjects;
  }

  checkEncryptionValidation() {
    if (loginModel?.data?.original?.libsodiyumSettings?.original!.data?[0]
            .requestEnc ==
        1) {
      GetStorage().write("RequestEncryption", true);
    } else {
      GetStorage().write("RequestEncryption", false);
    }
  }

  clearLocalStorage() async {
    print("Clear Local Storage");
    print("++++++Token ${GetStorage().read('token')}");
    GetStorage().erase();
    clearSharedPreferences();
    print("++++++Token after ${GetStorage().read('token')}");
  }
}

 clearSharedPreferences() async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   prefs.remove('roleSettings');
}

class Credentials {
  final String username;
  final String password;

  Credentials(this.username, this.password);

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }

  factory Credentials.fromJson(Map<String, dynamic> json) {
    return Credentials(json['username'], json['password']);
  }
}
