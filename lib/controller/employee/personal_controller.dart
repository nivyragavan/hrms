import 'package:dreamhrms/controller/employee/dependancy_controller.dart';
import 'package:dreamhrms/controller/employee_details_controller/profile_controller.dart';
import 'package:dreamhrms/model/profile_model.dart';
import 'package:dreamhrms/screen/employee/add_employee_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../model/add_employee/emergency_model.dart';
import '../../model/add_employee/employee_master_model.dart';
import '../../model/city_model.dart';
import '../../model/state_model.dart';
import '../../services/HttpHelper.dart';
import '../../services/api_service.dart';
import '../../services/utils.dart';
import '../../widgets/encrypt_decrypt.dart';
import '../common_controller.dart';
import '../department/add_department_controller.dart';
import '../edit_employee_profile_controller.dart';
import '../signup_controller.dart';
import 'employee_controller.dart';

class PersonalController extends GetxController {
  static PersonalController get to => Get.put(PersonalController());
  final formKey = GlobalKey<FormState>();
  static final HttpHelper _http = HttpHelper();
  StateModel? stateModel;
  CityModel? cityModel;

  BuildContext? context = Get.context;

  EmployeeMasterModel? employeeMasterModel;
  TextEditingController relationController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  final _userId = "".obs;

  get userId => _userId.value;

  set userId(value) {
    _userId.value = value;
  }

  final _masterLoader = false.obs;

  get masterLoader => _masterLoader.value;

  set masterLoader(value) {
    _masterLoader.value = value;
  }

  final _stateLoader = false.obs;

  get stateLoader => _stateLoader.value;

  set stateLoader(value) {
    _stateLoader.value = value;
  }

  final _emeregencyContactCount = 0.obs;

  get emeregencyContactCount => _emeregencyContactCount.value;

  set emeregencyContactCount(value) {
    _emeregencyContactCount.value = value;
  }

  final _cityLoader = false.obs;

  get cityLoader => _cityLoader.value;

  set cityLoader(value) {
    _cityLoader.value = value;
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

  clearValues() {
    print("clear.....");
    CommonController.to.imageBase64 = "";
    PersonalController.to.imageController.text = "";
    DependencyController.to.firstNameController.text = "";
    DependencyController.to.lastNameController.text = "";
    DependencyController.to.emailController.text = "";
    DependencyController.to.genderController.text = "";
    DependencyController.to.maritalStatusController.text = "";
    DependencyController.to.dob.text = "";
    DependencyController.to.nationalityController.text = "";
    DependencyController.to.stateController.text = "";
    DependencyController.to.personalEmailController.text = "";
    DependencyController.to.cityController.text = "";
    DependencyController.to.bloodController.text = "";
    DependencyController.to.phoneNumberController.text = "";
    PersonalController.to.imageController.text = "";
    contactModel?.emergency.clear();
  }

  initialDataLoad() async {
    GetStorage().remove("user_id");
    GetStorage().remove("emp_id");
    await PersonalController.to.clearValues();
    debugPrint("IsEmployee ${EmployeeController.to.isEmployee}");
    PersonalController.to.contactModel = EmergencyContactModel(emergency: []);
    await PersonalController.to.getMasterList();
    await SignupController.to.getCountryList();
    PersonalController.to.emergencyLoader = true;
    PersonalController.to.emeregencyContactCount = 0;
    EmployeeController.to.isEmployee == "Edit"
        ? await PersonalController.to.setControllerPersonalInformation(
            ProfileController.to.profileModel?.data?.data)
        : PersonalController.to.contactModel?.emergency.insert(
            PersonalController.to.emeregencyContactCount,
            EmergencyContact(
              relationEmailAddress: "",
              relationFirstName: "",
              relationLastName: "",
              phoneNumber: "",
              relationship: "",
            ));
    if (EmployeeController.to.isEmployee == "Edit")
      await EditEmployeeProfileController.to.setEmergencyInformation(
          ProfileController.to.profileModel?.data?.data);
    PersonalController.to.emergencyLoader = false;
  }

  getMasterList() async {
    masterLoader = true;
    var response = await _http.get(Api.Master, auth: true);
    if (response['code'] == "200") {
      employeeMasterModel = EmployeeMasterModel.fromJson(response);
    }
    masterLoader = false;
  }

  Future<void> getStateList(String stateId) async {
    stateLoader = true;
    var body = {
      "country_id": stateId,
    };
    print("body $body");
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
            url: "${Api.stateList}",
            encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
            auth: true)
        : await _http.post(Api.stateList, body,
            auth: true, contentHeader: false);
    if (response['code'] == "200" || response['code'] == "204") {
      stateModel = StateModel.fromJson(response);
      print("stateModel $response");
    }
    stateLoader = false;
  }

  Future<void> getCityList(String stateId) async {
    cityLoader = true;
    var body = {
      "state_id": stateId,
    };
    print("state body data $body");
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
            url: "${Api.cityList}",
            encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
            auth: true)
        : await _http.post(Api.cityList, body,
            auth: true, contentHeader: false);
    if (response['code'] == "200" || response['code'] == "204") {
      cityModel = CityModel.fromJson(response);
      print("city $response");
    }
    cityLoader = false;
  }

  final _emergencyLoader = false.obs;

  get emergencyLoader => _emergencyLoader.value;

  set emergencyLoader(value) {
    _emergencyLoader.value = value;
  }

  ProfileModel? profileModel;
  EmergencyContactModel? contactModel;
  postPersonalDetails() async {
    userId = "";
    var body = {
      "emergency": contactModel?.emergency,
      "personal_email": DependencyController.to.personalEmailController.text,
      "email": DependencyController.to.emailController.text,
      "personal_phone_number":
          DependencyController.to.phoneNumberController.text,
      "city": DependencyController.to.cityControllerId.text,
      "state": DependencyController.to.stateControllerId.text,
      "country": DependencyController.to.nationalityControllerId.text,
      "blood_group": DependencyController.to.bloodController.text,
      "marital_status": DependencyController.to.maritalStatusController.text,
      "gender": DependencyController.to.genderController.text,
      "dob": CommonController.to.formatDate(DependencyController.to.dob.text),
      "last_name": DependencyController.to.lastNameController.text,
      "first_name": DependencyController.to.firstNameController.text,
    };
    print("Body post data $body");
    try {
      var response = GetStorage().read("RequestEncryption") == true
          ? await _http.multipartPostData(
              url: "${Api.addEmployee}",
              encryptMessage:
                  await LibSodiumAlgorithm().encryptionMessage(body),
              auth: true)
          : await _http.post(Api.addEmployee, body,
              auth: true, contentHeader: false);
      if (response['code'] == "200") {
        EmployeeController.to.employeeIdController.text =
            response['data']['emp_id'];
        GetStorage().write("user_id", response['data']['user_id']);
        GetStorage().write("emp_id", response['data']['emp_id']);
        userId = response['data']['user_id'];
        if (PersonalController.to.imageController.text != "" &&
            AddDepartmentController.to.isNetworkImage(
                    PersonalController.to.imageController.text) ==
                false) {
          if (await PersonalController.to
              .employeeImageUpload(GetStorage().read("user_id"))) {}
        }
        UtilService()
            .showToast("success", message: response['message'].toString());
        Get.back();
        Get.to(() => AddEmployeeScreen(selectedIndex: 1));
      } else {
        UtilService()
            .showToast("error", message: response['message'].toString());
      }
    } catch (e) {
      print("Exception on the api$e");
      CommonController.to.buttonLoader = false;
    }
  }

  employeeImageUpload(userID) async {
    // logDev.log(CommonController.to.imageBase64, name: 'Base64 Value');
    var body = {
      "user_id": userID,
      "image": "data:image/png;base64,${CommonController.to.imageBase64}"
    };
    var response = await _http.post("${Api.addProfileImage}", body);
    if (response['code'] == "200") {
      return true;
    } else {
      UtilService().showToast("error", message: response['message'].toString());
      return false;
    }
  }

  setControllerPersonalInformation(DataData? data) {
    personalLoader = true;
    var ProfileModelInformation = data;
    PersonalController.to.userId = '${ProfileModelInformation?.id}';
    imageController.text = '${ProfileModelInformation?.profileImage ?? ""}';
    DependencyController.to.firstNameController.text =
        '${ProfileModelInformation?.firstName ?? ""}';
    DependencyController.to.lastNameController.text =
        '${ProfileModelInformation?.lastName ?? ""}';
    DependencyController.to.emailController.text =
        '${ProfileModelInformation?.emailId ?? ""}';
    DependencyController.to.genderController.text =
        '${ProfileModelInformation?.gender ?? ""}';
    DependencyController.to.maritalStatusController.text =
        '${ProfileModelInformation?.maritalStatus ?? ""}';
    DependencyController.to.dob.text =
        '${CommonController.to.dateConversion(ProfileModelInformation?.dateOfBirth ?? "", GetStorage().read("date_format"))}';
    DependencyController.to.nationalityController.text =
        '${ProfileModelInformation?.country?.name ?? ""}';
    DependencyController.to.nationalityControllerId.text =
        '${ProfileModelInformation?.country?.id}';
    DependencyController.to.stateController.text =
        '${ProfileModelInformation?.state?.name ?? ""}';
    DependencyController.to.stateControllerId.text =
        '${ProfileModelInformation?.state?.id}';
    DependencyController.to.cityControllerId.text =
        '${ProfileModelInformation?.city?.id}';
    DependencyController.to.cityController.text =
        '${ProfileModelInformation?.city?.name ?? ""}';
    DependencyController.to.personalEmailController.text =
        '${ProfileModelInformation?.personalEmail ?? ""}';
    DependencyController.to.bloodController.text =
        '${ProfileModelInformation?.bloodGroup ?? ""}';
    DependencyController.to.phoneNumberController.text =
        '${ProfileModelInformation?.mobileNumber ?? ""}';
    personalLoader = false;
  }

  editEmployee() async {
    print("DependencyController.to.dob.text${DependencyController.to.dob.text}");
    var body = {
      "emergency": contactModel?.emergency,
      "personal_email": DependencyController.to.personalEmailController.text,
      "email": DependencyController.to.emailController.text,
      "personal_phone_number":
          DependencyController.to.phoneNumberController.text,
      "city": DependencyController.to.cityControllerId.text,
      "state": DependencyController.to.stateControllerId.text,
      "country": DependencyController.to.nationalityControllerId.text,
      "blood_group": DependencyController.to.bloodController.text,
      "marital_status": DependencyController.to.maritalStatusController.text,
      "gender": DependencyController.to.genderController.text,
      "dob": await CommonController.to.formatDate(DependencyController.to.dob.text.toString()),
      "last_name": DependencyController.to.lastNameController.text,
      "first_name": DependencyController.to.firstNameController.text,
      "email_id": ProfileController.to.profileModel?.data?.data?.emailId,
      "date_of_birth": ProfileController.to.profileModel?.data?.data?.dateOfBirth,
      "mobile_number":
          ProfileController.to.profileModel?.data?.data?.mobileNumber,
      "status": ProfileController.to.profileModel?.data?.data?.status,
      "user_unique_id":
          ProfileController.to.profileModel?.data?.data?.userUniqueId,
      "user_id": PersonalController.to.userId,
      "type": "edit",
    };
    print("Body post data $body");
    try {
      var response = GetStorage().read("RequestEncryption") == true
          ? await _http.multipartPostData(
              url: "${Api.addEmployee}",
              encryptMessage:
                  await LibSodiumAlgorithm().encryptionMessage(body),
              auth: true)
          : await _http.post(Api.addEmployee, body,
              auth: true, contentHeader: false);
      if (response['code'] == "200") {
        if (PersonalController.to.imageController.text != "" &&
            AddDepartmentController.to.isNetworkImage(
                    PersonalController.to.imageController.text) ==
                false) {
          if (await PersonalController.to
              .employeeImageUpload(PersonalController.to.userId)) {}
        }
        UtilService()
            .showToast("success", message: response['message'].toString());
        Get.back();
        Get.to(() => AddEmployeeScreen(selectedIndex: 1));
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
