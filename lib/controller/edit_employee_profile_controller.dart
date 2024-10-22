import 'package:dreamhrms/controller/department/add_department_controller.dart';
import 'package:dreamhrms/controller/department/deparrtment_controller.dart';
import 'package:dreamhrms/controller/employee/personal_controller.dart';
import 'package:dreamhrms/controller/employee_details_controller/profile_controller.dart';
import 'package:dreamhrms/controller/shift_controller.dart';
import 'package:dreamhrms/model/profile_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../model/add_employee/dependent_model.dart';
import '../model/add_employee/education_model.dart';
import '../model/add_employee/emergency_model.dart';
import '../screen/employee/add_employee_screen.dart';
import '../services/HttpHelper.dart';
import '../services/api_service.dart';
import '../services/utils.dart';
import '../widgets/encrypt_decrypt.dart';
import 'common_controller.dart';
import 'employee/dependancy_controller.dart';
import 'employee/education_controller.dart';
import 'employee/employee_controller.dart';

class EditEmployeeProfileController extends GetxController {
  static EditEmployeeProfileController get to =>
      Get.put(EditEmployeeProfileController());
  static final HttpHelper _http = HttpHelper();

  TextEditingController statusController = TextEditingController();
  TextEditingController statusIdController = TextEditingController();
  TextEditingController departmentIdController = TextEditingController();
  TextEditingController joinDateController = TextEditingController();

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

  // @override
  // void onClose() {
  //   super.onClose();
  //   setDependencyInformation(null);
  // }

  setControllerPersonalInformation(DataData? data) {
    print("setControllerPersonalInformation");
    personalLoader = true;
    var ProfileModelInformation = data;
    PersonalController.to.userId = '${ProfileModelInformation?.id}';
    departmentIdController.text =
        '${ProfileModelInformation?.departmentId ?? ""}';
    EmployeeController.to.gradeController.text =
        '${ProfileModelInformation?.jobPosition?.position?.grade?.gradeName ?? ""}';
    EmployeeController.to.shiftController.text =
        '${ProfileModelInformation?.shedules?.shiftName}';
    EmployeeController.to.shiftIdController.text =
        '${ProfileModelInformation?.shiftId}';
    // getShiftName(EmployeeController.to.shiftIdController.text) ?? "";
    EmployeeController.to.shiftTimeController.text =
        '${CommonController.to.timeConversion(ProfileModelInformation?.personalInfo?.shiftTime ?? "", GetStorage().read("global_time").toString())}';
    EmployeeController.to.employeeTypeController.text =
        '${ProfileModelInformation?.employeeType?.type ?? ""}';
    EmployeeController.to.employeeTypeIdController.text =
        '${ProfileModelInformation?.employeeType?.id}';
    DependencyController.to.genderController.text =
        '${ProfileModelInformation?.gender ?? ""}';
    DependencyController.to.bloodController.text =
        '${ProfileModelInformation?.bloodGroup ?? ""}';
    DependencyController.to.maritalStatusController.text =
        '${ProfileModelInformation?.maritalStatus ?? ""}';
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
    DependencyController.to.phoneNumberController.text =
        '${ProfileModelInformation?.mobileNumber ?? ""}';
    EditEmployeeProfileController.to.statusController.text =
        '${ProfileModelInformation?.status}' == "1" ? "Active" : "InActive";
    EditEmployeeProfileController.to.statusIdController.text =
        '${ProfileModelInformation?.status ?? ""}';
    personalLoader = false;
  }

  setControllerEmployeeInformation(DataData? data) {
    personalLoader = true;
    var ProfileModelInformation = data;
    PersonalController.to.userId = '${ProfileModelInformation?.id}';
    EmployeeController.to.employeeIdController.text =
        '${ProfileModelInformation?.userUniqueId}';
    PersonalController.to.imageController.text =
        '${ProfileModelInformation?.profileImage ?? ""}';
    DependencyController.to.firstNameController.text =
        '${ProfileModelInformation?.firstName ?? ""}';
    DependencyController.to.lastNameController.text =
        '${ProfileModelInformation?.lastName ?? ""}';
    EmployeeController.to.departmentController.text =
        '${ProfileModelInformation?.department?.departmentName ?? ""}';
    EmployeeController.to.departmentIDController.text =
        '${ProfileModelInformation?.departmentId}';
    PersonalController.to.phoneNumberController.text =
        '${ProfileModelInformation?.mobileNumber}';
    PersonalController.to.emailAddressController.text =
        '${ProfileModelInformation?.emailId}';
    EmployeeController.to.positionTypeController.text =
        '${ProfileModelInformation?.jobPosition?.position?.positionName}';
    EmployeeController.to.positionIdController.text =
        '${ProfileModelInformation?.jobPosition?.position?.id}';
    EmployeeController.to.lineManagerController.text =
        '${ProfileModelInformation?.jobPosition?.lineManager}';
    EmployeeController.to.lineManagerIdController.text =
        getLineManagerId(EmployeeController.to.lineManagerController.text) ??
            "";
    DependencyController.to.dob.text =
    '${CommonController.to.dateConversion(ProfileModelInformation?.dateOfBirth ?? "", GetStorage().read("date_format"))}';
    EditEmployeeProfileController.to.joinDateController.text =
        '${ProfileModelInformation?.personalInfo?.effectiveDate}';
    PersonalController.to.imageController.text =
        '${ProfileModelInformation?.profileImage}';
    personalLoader = false;
  }

  setDependencyInformation(DataData? data) {
    DependencyController.to.dependantLoader = true;
    var ProfileModelInformation = data?.dependents;
    PersonalController.to.userId = '${data?.id}';
    for (int i = 0; i < ProfileModelInformation!.length; i++) {
      DependencyController.to.dependantModel?.dependant.insert(
          0,
          Dependant(
            firstName: '${ProfileModelInformation[i].firstName ?? ""}',
            lastName: '${ProfileModelInformation[i].lastName ?? ""}',
            relationship: '${ProfileModelInformation[i].relationship ?? ""}',
            phoneNumber: '${ProfileModelInformation[i].phoneNumber ?? ""}',
            emailAddress: '${ProfileModelInformation[i].emailAddress ?? ""}',
            gender: '${ProfileModelInformation[i].gender ?? ""}',
          ));
    }
    DependencyController.to.dependantLoader = false;
  }

  setEducationInformation(DataData? data) {
    personalLoader = true;
    EducationController.to.educationLoader = true;
    var ProfileModelInformation = data?.educationalDetails;
    PersonalController.to.userId = '${data?.id}';
    if (ProfileModelInformation != null) {
      for (int i = 0; i < ProfileModelInformation.length; i++) {
        EducationController.to.educationModel?.education.insert(
            i,
            Education(
                degree: "${ProfileModelInformation[i].degree ?? ""}",
                specialization:
                    "${ProfileModelInformation[i].specialization ?? ""}",
                university_name:
                    "${ProfileModelInformation[i].collegeName ?? ""}",
                gpa: "${ProfileModelInformation[i].gpa ?? ""}",
                start_year:
                    "${ProfileModelInformation[i].startYear?.year.toString().padLeft(4, '0')}-${ProfileModelInformation[i].startYear?.month.toString().padLeft(2, '0')}-${ProfileModelInformation[i].startYear?.day.toString().padLeft(2, '0')}",
                end_year:
                    "${ProfileModelInformation[i].endYear?.year.toString().padLeft(4, '0')}-${ProfileModelInformation[i].endYear?.month.toString().padLeft(2, '0')}-${ProfileModelInformation[i].endYear?.day.toString().padLeft(2, '0')}"));
      }
    }
     personalLoader = false;
    EducationController.to.educationLoader = false;
  }

  setEmergencyInformation(DataData? data) {
    personalLoader = true;
    DependencyController.to.dependantLoader = true;
    var ProfileModelInformation = data?.emergencyContactDetails;
    PersonalController.to.userId = '${data?.id}';
    for (int i = 0; i < ProfileModelInformation!.length; i++) {
      PersonalController.to.contactModel?.emergency.insert(
          i,
          EmergencyContact(
            relationEmailAddress:
                "${ProfileModelInformation[i].emailAddress ?? ""}",
            relationFirstName: "${ProfileModelInformation[i].firstName ?? ""}",
            relationLastName: "${ProfileModelInformation[i].lastName ?? ""}",
            phoneNumber: "${ProfileModelInformation[i].phoneNumber ?? ""}",
            relationship: "${ProfileModelInformation[i].relationship ?? ""}",
          ));
    }
    personalLoader = false;
    DependencyController.to.dependantLoader = false;
  }

  getShiftName(String shiftId) {
    final value = ShiftController.to.shiftListModel?.data?.list
        ?.where((data) => data.id == shiftId)
        .toList();

    if (value != null && value.isNotEmpty) {
      final firstItem = value[0];
      return firstItem.shiftName;
    }

    return null;
  }

  getLineManagerId(String label) {
    final value = EmployeeController.to.lineManagerModel?.data
        ?.where(
            (data) => "${data.firstName} ${data.lastName}" == label.toString())
        .toList();
    if (value != null && value.isNotEmpty) {
      final firstItem = value[0];
      return firstItem.id.toString();
    }

    return "";
  }

  getDepartmentName(String departmentId) {
    final value = DepartmentController.to.departmentModel?.data
        ?.where((data) => data.departmentId == departmentId)
        .toList();

    if (value != null && value.isNotEmpty) {
      final firstItem = value[0];
      return firstItem.departmentName;
    }

    return "";
  }

  postPersonalInformation() async {
    var body = {
      "grade": EmployeeController.to.gradeController.text,
      "shift_id": EmployeeController.to.shiftIdController.text,
      "shift_time": CommonController.to.timeConversion(EmployeeController.to.shiftTimeController.text, "HH:mm:ss"),
      "employement_type": EmployeeController.to.employeeTypeIdController.text,
      "gender": DependencyController.to.genderController.text,
      "blood_group": DependencyController.to.bloodController.text,
      "marital_status": DependencyController.to.maritalStatusController.text,
      "country": DependencyController.to.nationalityControllerId.text,
      "state": DependencyController.to.stateControllerId.text,
      "city": DependencyController.to.cityControllerId.text,
      "personal_email": DependencyController.to.personalEmailController.text,
      "personal_phone_number":
          DependencyController.to.phoneNumberController.text,
      "status": EditEmployeeProfileController.to.statusIdController.text,
      "edit_type": "edit_personal_info",
      "type": "edit",
      "user_id": PersonalController.to.userId,
      "department_id": departmentIdController.text
    };
    var body1 = {
      "grade": EmployeeController.to.gradeController.text,
      "shift_id": EmployeeController.to.shiftIdController.text,
      "shift_time": EmployeeController.to.shiftTimeController.text,
      "employement_type": EmployeeController.to.employeeTypeIdController.text,
      "gender": DependencyController.to.genderController.text,
      "blood_group": DependencyController.to.bloodController.text,
      "marital_status": DependencyController.to.maritalStatusController.text,
      "country": DependencyController.to.nationalityControllerId.text,
      "state": DependencyController.to.stateControllerId.text,
      "city": DependencyController.to.cityControllerId.text,
      "personal_email": DependencyController.to.personalEmailController.text,
      "personal_phone_number":
          DependencyController.to.phoneNumberController.text,
      "status": EditEmployeeProfileController.to.statusIdController.text,
      "edit_type": "",
      "type": "edit",
      "user_id": PersonalController.to.userId,
      "department_id": departmentIdController.text
    };
    print("Body post data $body");
   try{
     var response = GetStorage().read("RequestEncryption") == true
         ? await _http.multipartPostData(
         url: "${Api.addEmployee}",
         encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
         auth: true)
         : await _http.post(Api.addEmployee, body,
         auth: true, contentHeader: false);
     var response1 = GetStorage().read("RequestEncryption") == true
         ? await _http.multipartPostData(
         url: "${Api.uploadEmployeeDetails}",
         encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body1),
         auth: true)
         : await _http.post(Api.uploadEmployeeDetails, body1,
         auth: true, contentHeader: false);
     if (response['code'] == "200") {
       ProfileController.to.getProfileList();
       EmployeeController.to.getEmployeeList();
       UtilService()
           .showToast("success", message: response['message'].toString());
       Get.back();
     } else {
       UtilService().showToast("error", message: response['message'].toString());
     }
   }catch (e) {
     print("Exception on the api$e");
     CommonController.to.buttonLoader = false;
   }
  }

  postEmployeeInformation() async {
    try {
      var body = {
        "joining_date": CommonController.to.dateConversion(joinDateController.text, "YYYY-MM-DD"),
        "lineManager": {
          "label": EmployeeController.to.lineManagerController.text,
          "value": EmployeeController.to.lineManagerIdController.text
        },
        "department": {
          "label": EmployeeController.to.departmentController.text,
          "value": EmployeeController.to.departmentIDController.text
        },
        "email": PersonalController.to.emailAddressController.text,
        "phone_number": PersonalController.to.phoneNumberController.text,
        "position_name": EmployeeController.to.positionIdController.text,
        "dob": CommonController.to.dateConversion(DependencyController.to.dob.text, "YYYY-MM-DD"),
        "last_name": DependencyController.to.lastNameController.text,
        "first_name": DependencyController.to.firstNameController.text,
        "employee_id": EmployeeController.to.employeeIdController.text,
        "user_id": PersonalController.to.userId,
        "type": "edit",
        "edit_type": "edit_emp_info",
        "personal_phone_number":
            PersonalController.to.phoneNumberController.text,
        "effective_date": CommonController.to.dateConversion(joinDateController.text, "YYYY-MM-DD"),
        "department_id": EmployeeController.to.departmentIDController.text,
        "reporting_to": EmployeeController.to.lineManagerIdController.text
      };
      print("Body post data $body");
      var response = GetStorage().read("RequestEncryption") == true
          ? await _http.multipartPostData(
              url: "${Api.uploadEmployeeDetails}",
              encryptMessage:
                  await LibSodiumAlgorithm().encryptionMessage(body),
              auth: true)
          : await _http.post(Api.uploadEmployeeDetails, body,
              auth: true, contentHeader: false);
      var response1 = GetStorage().read("RequestEncryption") == true
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
              .employeeImageUpload(PersonalController.to.userId)) {
            UtilService()
                .showToast("success", message: response['message'].toString());
          }
          // else {
          //   UtilService().showToast("error",
          //       message: "Something Went Wrong. Try Again Later!");
          // }
        }

        ProfileController.to.getProfileList();
        EmployeeController.to.getEmployeeList();
        UtilService()
            .showToast("success", message: response['message'].toString());
        Get.back();
      } else {
        UtilService()
            .showToast("error", message: response['message'].toString());
      }
    } catch (e) {
      print("Exception on the api$e");
      CommonController.to.buttonLoader = false;
    }
  }

  postDependencyInformation({String? type}) async {
    var body = {
      "dependant": DependencyController.to.dependantModel?.dependant,
      "user_id": PersonalController.to.userId,
      "type": "edit"
    };
    print("Body post data $body");
    try{
      var response = GetStorage().read("RequestEncryption") == true
          ? await _http.multipartPostData(
          url: "${Api.dependencyupload}",
          encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
          auth: true)
          : await _http.post(Api.dependencyupload, body,
          auth: true, contentHeader: false);
      if (response['code'] == "200") {
        ProfileController.to.getProfileList();
        EmployeeController.to.getEmployeeList();
        UtilService()
            .showToast("success", message: response['message'].toString());
        if (type == "EmployeeEdit") {
          Get.back();
          Get.to(() => AddEmployeeScreen(selectedIndex: 3));
        } else {
          Get.back();
        }
      } else {
        UtilService().showToast("error", message: response['message'].toString());
      }
    }catch (e) {
      print("Exception on the api$e");
      CommonController.to.buttonLoader = false;
    }
  }

  postEducationInformation({String? type}) async {
    var body = {
      "education_data": EducationController.to.educationModel?.education,
      "user_id": PersonalController.to.userId
    };
    print("Body post data $body");
   try{
     var response = GetStorage().read("RequestEncryption") == true
         ? await _http.multipartPostData(
         url: "${Api.educationUpload}",
         encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
         auth: true)
         : await _http.post(Api.educationUpload, body,
         auth: true, contentHeader: false);
     if (response['code'] == "200") {
       ProfileController.to.getProfileList();
       EmployeeController.to.getEmployeeList();
       UtilService()
           .showToast("success", message: response['message'].toString());
       if (type == "EmployeeEdit") {
         Get.back();
         Get.to(() => AddEmployeeScreen(selectedIndex: 4));
       } else {
         Get.back();
       }
     } else {
       UtilService().showToast("error", message: response['message'].toString());
     }
   }catch (e) {
     print("Exception on the api$e");
     CommonController.to.buttonLoader = false;
   }
  }

  postEmergencyInformation() async {
    var body = {
      "emergency": PersonalController.to.contactModel?.emergency,
      "user_id": PersonalController.to.userId,
      "edit_type": "emergency"
    };
    print("Body data $body");
   try{
     var response = GetStorage().read("RequestEncryption") == true
         ? await _http.multipartPostData(
         url: "${Api.addEmployee}",
         encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
         auth: true)
         : await _http.post(Api.addEmployee, body,
         auth: true, contentHeader: false);
     if (response['code'] == "200") {
       ProfileController.to.getProfileList();
       EmployeeController.to.getEmployeeList();
       UtilService()
           .showToast("success", message: response['message'].toString());
       Get.back();
     } else {
       UtilService().showToast("error", message: response['message'].toString());
     }
   }catch (e) {
     print("Exception on the api$e");
     CommonController.to.buttonLoader = false;
   }
  }
}
