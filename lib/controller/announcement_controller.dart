import 'package:dreamhrms/model/announcement/announcement_list_model.dart'
    hide Data, Datum;
import 'package:dreamhrms/model/department_model.dart';
import 'package:dreamhrms/screen/announcement/announcement_list.dart';
import 'package:dreamhrms/services/HttpHelper.dart';
import 'package:dreamhrms/services/api_service.dart';
import 'package:dreamhrms/services/utils.dart';
import 'package:dreamhrms/widgets/encrypt_decrypt.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart' hide Data;

import '../model/announcement/announcement_position.dart';
import '../model/announcement/announcement_viewd_list_model.dart';
import '../model/employee_list_model.dart';
import '../screen/announcement/announcement.dart';

class AnnouncementController extends GetxController {
  static AnnouncementController get to => Get.put(AnnouncementController());
  static final HttpHelper _http = HttpHelper();

  TextEditingController subject = TextEditingController();
  TextEditingController message = TextEditingController();
  TextEditingController attachment = TextEditingController();
  TextEditingController positionSearch = TextEditingController();

  List<bool> departmentCheckboxStatus = [];
  List<int> selectedDepartmentIds = [];
  String selectedDepartmentIdsString = '';

  List<bool> userCheckboxStatus = [];
  List<int> selectedUserIds = [];
  String selectedUserIdsString = '';

  List<String> profileImages = [];

  final _remainingCount = 0.obs;

  get remainingCount => _remainingCount.value;

  set remainingCount(value) {
    _remainingCount.value = value;
  }

  AnnouncementJobPositionModel? announcementJobPositionModel;
  List<bool> positionCheckboxStatus = [];
  List<int> selectedPositionIds = [];
  String selectedPositionIdsString = '';
  final RxList<PositionData?> filteredPositions = <PositionData?>[].obs;
  final RxList<AnnouncementViewedData?> filteredViewedList =
      <AnnouncementViewedData?>[].obs;
  final RxList<AnnouncementViewedData?> filteredNotViewedList =
      <AnnouncementViewedData?>[].obs;
  final _selectAllPositions = false.obs;

  get selectAllPositions => _selectAllPositions.value;

  set selectAllPositions(value) {
    _selectAllPositions.value = value;
  }

  AnnouncementListModel? announcementListModel;
  AnnouncementListModel? announcementDraftModel;
  DepartmentModel? departmentModel;
  EmployeeListModel? employeeListModel;

  final _showList = false.obs;
  get showList => _showList.value;

  set showList(value) {
    _showList.value = value;
  }

  final _showDepartmentList = false.obs;
  get showDepartmentList => _showDepartmentList.value;

  set showDepartmentList(value) {
    _showDepartmentList.value = value;
  }

  final _showUserList = false.obs;
  get showUserList => _showUserList.value;

  set showUserList(value) {
    _showUserList.value = value;
  }

  final _currentStep = 0.obs;

  get currentStep => _currentStep.value;

  set currentStep(value) {
    _currentStep.value = value;
  }

  final _imageFormat = "".obs;

  get imageFormat => _imageFormat.value;

  set imageFormat(value) {
    _imageFormat.value = value;
  }

  final _isEdit = "".obs;

  get isEdit => _isEdit.value;

  set isEdit(value) {
    _isEdit.value = value;
  }

  int? _announcementId;

   get announcementId => _announcementId!;

  set announcementId( value) {
    _announcementId = value;
  }

  final _selectAllDepartments = false.obs;

  get selectAllDepartments => _selectAllDepartments.value;

  set selectAllDepartments(value) {
    _selectAllDepartments.value = value;
  }

  final _selectAllUsers = false.obs;

  get selectAllUsers => _selectAllUsers.value;

  set selectAllUsers(value) {
    _selectAllUsers.value = value;
  }



  int? _viewedCount;

  int get viewedCount => _viewedCount ?? 0;

  set viewedCount(int value) {
    _viewedCount = value;
  }

  int? _notViewedCount;

  int get notViewedCount => _notViewedCount ?? 0;

  set notViewedCount(int value) {
    _notViewedCount = value;
  }

  final RxList<Data?> filteredDepartments = <Data?>[].obs;
  final RxList<Datum?> filteredUsers = <Datum?>[].obs;

  clearValues() {
    subject.text = "";
    message.text = "";
    attachment.text = "";
    currentStep = 0;
    imageFormat = "";
    selectAllDepartments = false;
    selectAllUsers = false;
    selectAllPositions = false;
    selectedPositionIds = [];
    selectedDepartmentIds = [];
    selectedUserIds = [];
    selectedPositionIdsString = "";
    selectedUserIdsString = "";
    selectedDepartmentIdsString = "";
    remainingCount = 0;
    isEdit = "";
  }

  bool isNetworkImage(String imageUrl) {
    return imageUrl.startsWith('http://') || imageUrl.startsWith('https://');
  }

  final _isViewed = true.obs;
  get isViewed => _isViewed.value;

  set isViewed(value) {
    _isViewed.value = value;
  }

  final _isNotViewed = false.obs;
  get isNotViewed => _isNotViewed.value;

  set isNotViewed(value) {
    _isNotViewed.value = value;
  }

  final _showAnnouncementViewedList = false.obs;
  get showAnnouncementViewedList => _showAnnouncementViewedList.value;

  set showAnnouncementViewedList(value) {
    _showAnnouncementViewedList.value = value;
  }

  final _jobPositionList = false.obs;
  get jobPositionList => _jobPositionList.value;

  set jobPositionList(value) {
    _jobPositionList.value = value;
  }

  final _viewedListLoader = false.obs;
  get viewedListLoader => _viewedListLoader.value;

  set viewedListLoader(value) {
    _viewedListLoader.value = value;
  }
  final _isAdded = false.obs;
  get isAdded => _isAdded.value;

  set isAdded(value) {
    _isAdded.value = value;
  }
  AnnouncementViewListModel? announcementViewedListModel;
  AnnouncementViewListModel? announcementNotViewedListModel;
  AnnouncementViewListModel? announcementViewListModel;

  getAnnouncementView({required int announcementId}) async {
    viewedListLoader = true;
    var body = {
      "id": announcementId,
    };
    debugPrint(body.toString());
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
            url: "${Api.announcementView}",
            encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
            auth: true)
        : await _http.post(Api.announcementView, body,
            auth: true, contentHeader: false);
    if (response['code'] == "200") {
      announcementViewListModel = AnnouncementViewListModel.fromJson(response);
      List<AnnouncementViewedData>? filteredViewedData =
          announcementViewListModel?.data?.viewedData
              ?.where((element) =>
                  element.seen == 1)
              .toList();
      AnnouncementData filteredAnnouncementData =
          AnnouncementData(viewedData: filteredViewedData);
      announcementViewedListModel = AnnouncementViewListModel(
        code: announcementViewedListModel?.code,
        message: announcementViewedListModel?.message,
        data: filteredAnnouncementData,
      );
      viewedCount = announcementViewedListModel?.data?.viewedData?.length ?? -1;
      List<AnnouncementViewedData>? filteredNotViewedData =
          announcementViewListModel?.data?.viewedData
              ?.where((element) => element.seen == 2)
              .toList();
      AnnouncementData filteredNotViewedAnnouncementData =
          AnnouncementData(viewedData: filteredNotViewedData);
      announcementNotViewedListModel = AnnouncementViewListModel(
        code: announcementNotViewedListModel?.code,
        message: announcementNotViewedListModel?.message,
        data: filteredNotViewedAnnouncementData,
      );
      notViewedCount = announcementNotViewedListModel?.data?.viewedData?.length ?? 0;
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
    viewedListLoader = false;
  }

  getAnnouncementList() async {
    showList = true;
    var body = {'': ''};
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
            url: "${Api.announcementList}",
            encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
            auth: true)
        : await _http.post(Api.announcementList, body,
            auth: true, contentHeader: false);
    if (response['code'] == "200") {
      announcementListModel = AnnouncementListModel.fromJson(response);
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
    showList = false;
  }
  

  getAnnouncementDraftList() async {
    showList = true;
    var body = {'option_type': 'draft'};
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
            url: "${Api.announcementList}",
            encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
            auth: true)
        : await _http.post(Api.announcementList, body,
            auth: true, contentHeader: false);
    if (response['code'] == "200") {
      announcementDraftModel = AnnouncementListModel.fromJson(response);
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
    showList = false;
  }

  postAnnouncement(bool isEdit,bool isDraft, {int? announcementId}) async {
    var body = {
      if(isEdit == true)
        "id": announcementId,
      "subject": subject.text,
      "message": message.text,
    };
    print(body);
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
            url: isEdit == true ? "${Api.announcementEdit}":"${Api.announcementAdd}",
            encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
            auth: true)
        : await _http.post(isEdit == true ? Api.announcementEdit : Api.announcementAdd, body,
            auth: true, contentHeader: false);
    if (response['code'] == "200") {
    isDraft == true || isEdit == true ? null :  UtilService()
          .showToast("success", message: response['message'].toString());
    isEdit == true? null:   AnnouncementController.to.announcementId = response['data']['id'];
    isAdded = true;
    // Get.to(()=>AnnouncementScreen());
    // await AnnouncementController.to.getAnnouncementList();
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
  }

  announcementImage({required int announcementId}) async {
    List<String> file = [
      attachment.text,
    ];
    List<String> fileName = ["attachment"];
    List<String> fieldsName = ["id"];
    List<String> fields = [announcementId.toString()];
    debugPrint(
        "File Name $fileName  fieldsName $fieldsName file $file fields $fields");
    var response = await _http.commonImagePostMultiPart(
        url: "${Api.imageUpload}",
        auth: true,
        filePaths: file,
        fileName: fileName,
        fieldsName: fieldsName,
        fields: fields);
    if (response['code'] == "200") {
      // UtilService()
      //     .showToast("success", message: response['message'].toString());
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
  }

  deleteAnnouncement({required int announcementId}) async {
    var body = {
      "id": announcementId,
    };
    print(body);
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
            url: "${Api.announcementDelete}",
            encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
            auth: true)
        : await _http.post(Api.announcementDelete, body,
            auth: true, contentHeader: false);
    if (response['code'] == "200") {
      UtilService()
          .showToast("success", message: response['message'].toString());
      Get.back();
      getAnnouncementList();
      getAnnouncementDraftList();
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
  }

  getDepartmentList() async {
    showDepartmentList = true;
    var response = await _http.get(Api.departmentList, auth: true);
    if (response['code'] == "200") {
      departmentModel = DepartmentModel.fromJson(response);
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
    showDepartmentList = false;
  }

  filterDepartments(String searchText) {
    if (searchText.isEmpty) {
      filteredDepartments.assignAll(departmentModel?.data ?? []);
    } else {
      final filtered = (departmentModel?.data)?.where((department) =>
          department.departmentName
              ?.toLowerCase()
              .contains(searchText.toLowerCase()) ??
          false);
      filteredDepartments.assignAll(filtered?.toList() ?? []);
    }
  }

  getEmployeeList() async {
    showUserList = true;
    var body = {"status": "1"};
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
            url: "${Api.employeeList}",
            encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
            auth: true)
        : await _http.post(Api.employeeList, body,
            auth: true, contentHeader: true);
    if (response['code'] == "200") {
      employeeListModel = EmployeeListModel.fromJson(response);
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
    showUserList = false;
  }

  filterUsers(String searchText) {
    if (searchText.isEmpty) {
      filteredUsers.assignAll(employeeListModel?.data?.data?.data ?? []);
    } else {
      final filtered = (employeeListModel?.data?.data?.data)?.where((employee) {
        final firstName = employee.firstName?.toLowerCase() ?? '';
        final lastName = employee.lastName?.toLowerCase() ?? '';
        final userUniqueId = employee.userUniqueId?.toLowerCase() ?? '';
        final lowerSearchText = searchText.toLowerCase();

        return firstName.contains(lowerSearchText) ||
            lastName.contains(lowerSearchText) ||
            userUniqueId.contains(lowerSearchText);
      });
      filteredUsers.assignAll(filtered?.toList() ?? []);
    }
  }

  userAssign() async {
    var body = {
      "announcement_id": announcementId.toString(),
      "user_id": selectedUserIdsString,
    };
    print('body $body');
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
            url: "${Api.userAssign}",
            encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
            auth: true)
        : await _http.post(Api.userAssign, body,
            auth: true, contentHeader: false);
    if (response['code'] == "200") {
      UtilService()
          .showToast("success", message: response['message'].toString());
      Get.back();
      getAnnouncementList();
      Get.to(() => AnnouncementScreen(index: 0,));
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
  }

  departmentAssign() async {
    var body = {
      "announcement_id": announcementId.toString(),
      "department_id": selectedDepartmentIdsString,
    };
    print('body $body');
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
            url: "${Api.departmentAssign}",
            encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
            auth: true)
        : await _http.post(Api.departmentAssign, body,
            auth: true, contentHeader: false);
    if (response['code'] == "200") {
      UtilService()
          .showToast("success", message: response['message'].toString());
      Get.back();

      getAnnouncementList();
      Get.to(() => AnnouncementScreen(index: 0,));
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
  }

  positionAssign() async {
    var body = {
      "announcement_id": announcementId.toString(),
      "position_id": selectedPositionIdsString,
    };
    print('body $body');
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
            url: "${Api.positionAssign}",
            encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
            auth: true)
        : await _http.post(Api.positionAssign, body,
            auth: true, contentHeader: false);
    if (response['code'] == "200") {
      UtilService()
          .showToast("success", message: response['message'].toString());
      Get.back();
      getAnnouncementList();
      Get.to(() => AnnouncementScreen(index: 0,));
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
  }

  getJobPosition() async {
    jobPositionList = true;
    var body = {'': ''};
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
            url: "${Api.jobPosition}",
            encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
            auth: true)
        : await _http.post(Api.jobPosition, body,
            auth: true, contentHeader: false);
    if (response['code'] == "200") {
      announcementJobPositionModel =
          AnnouncementJobPositionModel.fromJson(response);
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }

    jobPositionList = false;
  }

  filterPosition(String searchText) {
    if (searchText.isEmpty) {
      AnnouncementController.to.filteredPositions
          .assignAll(announcementJobPositionModel?.data ?? []);
    } else {
      final filtered = (announcementJobPositionModel?.data)?.where((position) =>
          position.positionName
              ?.toLowerCase()
              .contains(searchText.toLowerCase()) ??
          false);
      AnnouncementController.to.filteredPositions
          .assignAll(filtered?.toList() ?? []);
    }
  }

  filterViewedAnnouncement(String searchText) {
    if (searchText.isEmpty) {
      AnnouncementController.to.filteredViewedList
          .assignAll(announcementViewedListModel?.data?.viewedData ?? []);
    } else {
      final filtered = (announcementViewedListModel?.data?.viewedData)?.where(
          (data) =>
              data.userId?.firstName
                  ?.toLowerCase()
                  .contains(searchText.toLowerCase()) ??
              false);
      AnnouncementController.to.filteredViewedList
          .assignAll(filtered?.toList() ?? []);
    }
  }

  filterNotViewedAnnouncement(String searchText) {
    if (searchText.isEmpty) {
      AnnouncementController.to.filteredNotViewedList
          .assignAll(announcementNotViewedListModel?.data?.viewedData ?? []);
    } else {
      final filtered = (announcementNotViewedListModel?.data?.viewedData)
          ?.where((data) =>
              data.userId?.firstName
                  ?.toLowerCase()
                  .contains(searchText.toLowerCase()) ??
              false);
      AnnouncementController.to.filteredNotViewedList
          .assignAll(filtered?.toList() ?? []);
    }
  }
}
