import 'package:dreamhrms/controller/edit_employee_profile_controller.dart';
import 'package:dreamhrms/controller/employee/personal_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../model/employee_list_model.dart' hide DataData;
import '../../model/line_manager_model.dart';
import '../../model/profile_model.dart';
import '../../model/role_model.dart';
import '../../screen/employee/add_employee_screen.dart';
import '../../services/HttpHelper.dart';
import '../../services/api_service.dart';
import '../../services/utils.dart';
import '../../widgets/encrypt_decrypt.dart';
import '../common_controller.dart';

class EmployeeController extends GetxController {
  static EmployeeController get to => Get.put(EmployeeController());

  final formKey = GlobalKey<FormState>();
  static final HttpHelper _http = HttpHelper();

  TextEditingController employeeIdController = TextEditingController();
  TextEditingController effectiveDateController = TextEditingController();
  TextEditingController employeeTypeController = TextEditingController();
  TextEditingController employeeTypeIdController = TextEditingController();
  TextEditingController shiftController = TextEditingController();
  TextEditingController shiftIdController = TextEditingController();
  TextEditingController shiftTimeController = TextEditingController();
  TextEditingController probationPeriodController = TextEditingController();
  TextEditingController probationStartDateController = TextEditingController();
  TextEditingController probationEndDateController = TextEditingController();

  TextEditingController departmentController = TextEditingController();
  TextEditingController departmentIDController = TextEditingController();
  TextEditingController positionTypeController = TextEditingController();
  TextEditingController positionIdController = TextEditingController();
  TextEditingController lineManagerController = TextEditingController();
  TextEditingController lineManagerIdController = TextEditingController();
  TextEditingController gradeController = TextEditingController();
  TextEditingController gradeIdController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController roleIdController = TextEditingController();
  TextEditingController statusController = TextEditingController();

  LineManagerModel? lineManagerModel;
  EmployeeListModel? employeeListModel;
  EmployeeModel? employeeModel;
  RoleModel? roleModel;
  BuildContext? context = Get.context;
  String activeCount = "";
  String inActiveCount = "";

  final _shiftTimeLoader = false.obs;

  get shiftTimeLoader => _shiftTimeLoader.value;

  set shiftTimeLoader(value) {
    _shiftTimeLoader.value = value;
  }

  final _selectedUserId = "".obs;

  get selectedUserId => _selectedUserId.value;

  set selectedUserId(value) {
    _selectedUserId.value = value;
  }

  final _isEmployee = "".obs;

  get isEmployee => _isEmployee.value;

  set isEmployee(value) {
    _isEmployee.value = value;
  }

  final _isLoading = false.obs;

  get isLoading => _isLoading.value;

  set isLoading(value) {
    _isLoading.value = value;
  }

  final _isActive = false.obs;

  get isActive => _isActive.value;

  set isActive(value) {
    _isActive.value = value;
  }

  clearValues() {
    EmployeeController.to.effectiveDateController.text = "";
    EmployeeController.to.statusController.text = "";
    EmployeeController.to.employeeTypeController.text = "";
    EmployeeController.to.employeeTypeIdController.text = "";
    EmployeeController.to.shiftController.text = "";
    EmployeeController.to.shiftIdController.text = "";
    EmployeeController.to.shiftTimeController.text = "";
    EmployeeController.to.probationPeriodController.text = "";
    EmployeeController.to.probationStartDateController.text = "";
    EmployeeController.to.probationEndDateController.text = "";
    EmployeeController.to.departmentController.text = "";
    EmployeeController.to.departmentIDController.text = "";
    EmployeeController.to.positionTypeController.text = "";
    EmployeeController.to.positionIdController.text = "";
    EmployeeController.to.lineManagerController.text = "";
    EmployeeController.to.lineManagerIdController.text = "";
    EmployeeController.to.gradeController.text = "";
    EmployeeController.to.gradeIdController.text = "";
    EmployeeController.to.roleController.text = "";
    EmployeeController.to.roleIdController.text = "";
  }

  getEmployeeList({bool search = false}) async {
    isLoading = true;
    employeeListModel = null;
    var body = search == false
        ? {"status": isActive ? "2" : "1"}
        : {
            "status": isActive ? "2" : "1",
            "search": '${CommonController.to.search.text ?? ""}'
          };
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
            url: "${Api.employeeList}",
            encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
            auth: true)
        : await _http.post(Api.employeeList, body,
            auth: true, contentHeader: true);
    if (response['code'] == "200") {
      employeeListModel = EmployeeListModel.fromJson(response);
      employeeListModel = EmployeeListModel.fromJson(response);
      activeCount =
          "${EmployeeController.to.employeeListModel?.data?.data?.activeCount}";
      inActiveCount =
          "${EmployeeController.to.employeeListModel?.data?.data?.inactiveCount}";
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
    isLoading = false;
  }

  final _lineMangerLoader = false.obs;

  get lineMangerLoader => _lineMangerLoader.value;

  set lineMangerLoader(value) {
    _lineMangerLoader.value = value;
  }

  final _roleLoader = false.obs;

  get roleLoader => _roleLoader.value;

  set roleLoader(value) {
    _roleLoader.value = value;
  }

  final _shiftLoader = false.obs;

  get shiftLoader => _shiftLoader.value;

  set shiftLoader(value) {
    _shiftLoader.value = value;
  }

  final _personalLoader = false.obs;

  get personalLoader => _personalLoader.value;

  set personalLoader(value) {
    _personalLoader.value = value;
  }

  getLineManagerList() async {
    lineMangerLoader = true;
    var response = await _http.get(Api.lineManagerList, auth: true);
    if (response['code'] == "200") {
      lineManagerModel = LineManagerModel.fromJson(response);
      print("Line Manager $response");
    }
    lineMangerLoader = false;
  }

  getRoleList() async {
    roleLoader = true;
    var response = await _http.get(Api.role, auth: true);
    if (response['code'] == "200") {
      roleModel = RoleModel.fromJson(response);
      print(response);
    }
    roleLoader = false;
  }

  postEmployeeDetails() async {
    var body = {
      "reporting_to": lineManagerIdController.text,
      "role": roleIdController.text,
      "department_id": departmentIDController.text,
      "grade": gradeIdController.text,
      "position_name": positionIdController.text,
      "probation_end_date":
          CommonController.to.formatDate(probationEndDateController.text),
      "probation_start_date":
          CommonController.to.formatDate(probationStartDateController.text),
      "probation_period": probationPeriodController.text == "1 Month"
          ? "1"
          : probationPeriodController.text == "2 Month"
              ? "2"
              : "3",
      "shift_time":  CommonController.to.timeConversion( shiftTimeController.text, GetStorage().read("global_time").toString()),
      "shift_id": shiftIdController.text,
      "employement_type": employeeTypeIdController.text,
      "effective_date":
          CommonController.to.formatDate(effectiveDateController.text),
      "employee_id": employeeIdController.text,
      "user_id": GetStorage().read("user_id"),
      "type": "add"
    };
    print("Body post data $body");
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
            url: "${Api.uploadEmployeeDetails}",
            encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
            auth: true)
        : await _http.post(Api.uploadEmployeeDetails, body,
            auth: true, contentHeader: false);
    if (response['code'] == "200") {
      print("Employee details Response $response");
      UtilService()
          .showToast("success", message: response['message'].toString());
      Get.back();
      Get.to(() => AddEmployeeScreen(selectedIndex: 2));
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
  }

  employeeStatusChange(int index) async {
    var body = {
      "user_id": employeeListModel?.data?.data?.data?[index].id,
      "status":
          employeeListModel?.data?.data?.data?[index].status == 1 ? "0" : "1"
    };
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
            url: "${Api.employeeStatus}",
            encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
            auth: true)
        : await _http.post(Api.employeeStatus, body,
            auth: true, contentHeader: false);
    print("body $body");
    if (response['code'] == "200") {
      getEmployeeList();
      UtilService()
          .showToast("success", message: response['message'].toString());
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
  }

  setControllerEmployeeInformation(DataData? data) {
    personalLoader = true;
    var ProfileModelInformation = data;
    employeeIdController.text = '${ProfileModelInformation?.userUniqueId}';
    effectiveDateController.text =
        '${CommonController.to.dateConversion(ProfileModelInformation?.personalInfo?.effectiveDate ?? "", GetStorage().read("date_format"))}';
    employeeTypeController.text =
        '${ProfileModelInformation?.employeeType?.type ?? ""}';
    employeeTypeIdController.text =
        '${ProfileModelInformation?.employeeType?.id ?? ""}';
    shiftController.text =
        '${ProfileModelInformation?.shedules?.shiftName ?? ""}';
    shiftIdController.text = '${ProfileModelInformation?.shiftId}';
    ;
    EmployeeController.to.shiftTimeController.text =
        '${CommonController.to.timeConversion(ProfileModelInformation?.personalInfo?.shiftTime ?? "", GetStorage().read("global_time").toString())}';
    probationPeriodController.text =
        '${ProfileModelInformation?.personalInfo?.probationPeriod ?? ""}';
    probationStartDateController.text =
        '${CommonController.to.dateConversion(ProfileModelInformation?.personalInfo?.probationStartDate ?? "", GetStorage().read("date_format"))}';
    probationEndDateController.text =
        '${CommonController.to.dateConversion(ProfileModelInformation?.personalInfo?.probationEndDate ?? "", GetStorage().read("date_format"))}';
    departmentController.text =
        '${ProfileModelInformation?.department?.departmentName ?? ""}';
    departmentIDController.text =
        '${ProfileModelInformation?.departmentId ?? ""}';
    positionTypeController.text =
        '${ProfileModelInformation?.jobPosition?.position?.positionName}';
    positionIdController.text =
        '${ProfileModelInformation?.jobPosition?.position?.id}';
    lineManagerController.text =
        '${ProfileModelInformation?.jobPosition?.lineManager}';
    EmployeeController.to.lineManagerIdController.text =
        EditEmployeeProfileController.to.getLineManagerId(
                EmployeeController.to.lineManagerController.text) ??
            "";
    gradeController.text =
        '${ProfileModelInformation?.jobPosition?.position?.grade?.gradeName ?? ""}';
    roleIdController.text = '${ProfileModelInformation?.role.toString()}';
    print(
        '${roleModel?.data?.data?.where((element) => element.id.toString() == ProfileModelInformation?.role.toString()).toList()}');
    print("roleid ${roleIdController.text}");
    roleController.text =
        '${roleModel?.data?.data?.where((role) => role.id.toString() == ProfileModelInformation?.role.toString()).map((role) => role.name ?? '').join(', ')}';
    gradeIdController.text =
        '${ProfileModelInformation?.jobPosition?.position?.grade?.id}';
    statusController.text = '${ProfileModelInformation?.status}';
    personalLoader = false;
  }

  editEmployeeInfo() async {
    var body = {
      "reporting_to": lineManagerIdController.text,
      "role": roleIdController.text,
      "department_id": departmentIDController.text,
      "grade": gradeIdController.text,
      "position_name": positionIdController.text,
      "probation_end_date":
          CommonController.to.formatDate(probationEndDateController.text),
      "probation_start_date":
          CommonController.to.formatDate(probationStartDateController.text),
      "probation_period": probationPeriodController.text == "1 Month"
          ? "1"
          : probationPeriodController.text == "2 Month"
              ? "2"
              : "3",
      "shift_time":  CommonController.to.timeConversion( shiftTimeController.text, GetStorage().read("global_time").toString()),
      "shift_id": shiftIdController.text,
      "employement_type": 2,
      "effective_date":
          CommonController.to.formatDate(effectiveDateController.text),
      "employee_id": employeeIdController.text,
      "user_id": PersonalController.to.userId,
      "type": "edit",
      "status": statusController.text
    };
    print("Body post data $body");
    try {
      var response = GetStorage().read("RequestEncryption") == true
          ? await _http.multipartPostData(
              url: "${Api.uploadEmployeeDetails}",
              encryptMessage:
                  await LibSodiumAlgorithm().encryptionMessage(body),
              auth: true)
          : await _http.post(Api.uploadEmployeeDetails, body,
              auth: true, contentHeader: false);
      if (response['code'] == "200") {
        print("Employee details Response $response");
        UtilService()
            .showToast("success", message: response['message'].toString());
        Get.back();
        Get.to(() => AddEmployeeScreen(selectedIndex: 2));
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
