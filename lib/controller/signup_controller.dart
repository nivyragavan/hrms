import 'package:dreamhrms/model/country_model.dart';
import 'package:dreamhrms/screen/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../services/HttpHelper.dart';
import '../services/api_service.dart';
import '../services/utils.dart';
import '../widgets/encrypt_decrypt.dart';
import 'common_controller.dart';

class SignupController extends GetxController {
  static SignupController get to => Get.put(SignupController());
  static final HttpHelper _http = HttpHelper();
  BuildContext? context = Get.context;
  final formKey = GlobalKey<FormState>();

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController emailAddress = TextEditingController();
  TextEditingController jobTitle = TextEditingController();
  TextEditingController jobName = TextEditingController();
  TextEditingController companyName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController employeeCount = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController countryId = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void onClose() {
    // disposeValue();
    super.onClose();
  }


  disposeValue(){
    firstName.text="";
    lastName.text="";
    emailAddress.text="";
    jobTitle.text="";
    jobName.text="";
    companyName.text="";
    phoneNumber.text="";
    employeeCount.text="";
    country.text="";
    countryId.text="";
    password.text="";
  }

  CountryModel? countryModel;

  final _countryLoader=false.obs;

  get countryLoader => _countryLoader.value;

  set countryLoader(value) {
    _countryLoader.value = value;
  }

  getCountryList() async {
    countryLoader=true;
    var response = await _http.post(Api.countryList, "",
        auth: true, contentHeader: true);
    if (response['code'] == "200") {
      countryModel = CountryModel.fromJson(response);
      print("Country List ${countryModel?.data}");
    }
    countryLoader=false;
  }

  signUp() async {
    // firstName.text="Vaishnavi";
    // lastName.text="Vaishu";
    // emailAddress.text="vaishnavi.gopal@dreamguystech.com";
    // phoneNumber.text="1234567890";
    // jobTitle.text="Developer";
    // employeeCount.text="1";
    // companyName.text="DGT";
    // country.text="3";
    // password.text="VaishuHRMS";
    // domainName.text="Android";
    var body = {
      "first_name": firstName.text,
      "last_name": lastName.text,
      "email": emailAddress.text,
      "phone_number": phoneNumber.text,
      "job_title": jobTitle.text,
      "employee_count": employeeCount.text,
      "country_id": countryId.text,
      "password": password.text,
      "domain_name": companyName.text,
    };
    print("Body response data $body");
    try{
      var response = await _http.multipartPostData(
          url: "${Api.register}",
          encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
          auth: false);
      print("sign up ${response}");
      if (response['code'] == "200") {
        UtilService().showToast("success",
            message: response['message'].toString());
        Get.to(()=> Login());
      } else {
        UtilService()
            .showToast("error", message: response['message'].toString());
        // Future.delayed(Duration(seconds: 2));
        // UtilService()
        //     .showToast("error", message: "Something went wrong. Try again later");
      }
    }catch (e) {
      print("Exception on the api$e");
      CommonController.to.buttonLoader = false;
    }

  }

  forgotPassword() async {
    // firstName.text="Vaishnavi";
    // lastName.text="Vaishu";
    // emailAddress.text = "saranya@dreamguys.com";
    // phoneNumber.text="1234567890";
    // jobTitle.text="Developer";
    // employeeCount.text="1";
    // companyName.text="DGT";
    // country.text="3";
    // password.text="VaishuHRMS";
    // domainName.text="Android";
    var body = {"email": emailAddress.text};
    print("Body response data $body");
    var response = await _http.multipartPostData(
        url: "${Api.forgotPassword}",
        encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
        auth: false);
    print("sign up ${response}");
    if (response['code'] == "200") {
      UtilService().showToast("success",
          message: response['message'].toString());
      Get.to(()=> Login());
    } else {
      UtilService()
          .showToast("error", message: response['message'].toString());
    }
    // Get.to(()=> Login());
  }
}
