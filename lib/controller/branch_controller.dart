import 'package:dreamhrms/model/branch_model/branch_list_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import '../model/branch_model/branch_radius_list_model.dart';
import '../screen/branch/branch_screen.dart';
import '../services/HttpHelper.dart';
import '../services/api_service.dart';
import '../services/utils.dart';
import '../widgets/encrypt_decrypt.dart';
import 'common_controller.dart';

class BranchController extends GetxController {

  static BranchController get to => Get.put(BranchController());
  static final HttpHelper _http = HttpHelper();

  TextEditingController officeName = TextEditingController();
  TextEditingController officeFullAddress = TextEditingController();
  TextEditingController officeImage = TextEditingController();
  TextEditingController officeAddress = TextEditingController();
  TextEditingController radiusController = TextEditingController();
  TextEditingController radiusId = TextEditingController();

  BranchListModel? branchListModel;
  BranchRadiusList? branchRadiusList;

  onInit(){
    if(isEdit == ""){
         final value = GetStorage().read("CurrentAddress").toString();
         officeAddress.text = value;
         debugPrint("Address controller ${officeAddress.text}");
    }
    super.onInit();

  }
  final _loader = false.obs;

  get loader => _loader.value;

  set loader(value) {
    _loader.value = value;
  }

  final _mapLoader = false.obs;

  get mapLoader => _mapLoader.value;

  set mapLoader(value) {
    _mapLoader.value = value;
  }

  final _enableGroFencingStatus = false.obs;

  get enableGeoFencingStatus => _enableGroFencingStatus.value;

  set enableGeoFencingStatus(value) {
    _enableGroFencingStatus.value = value;
  }

  final _allowArea = false.obs;

  get allowArea => _allowArea.value;

  set allowArea(value) {
    _allowArea.value = value;
  }

  final _imageFormat = "".obs;

  get imageFormat => _imageFormat.value;

  set imageFormat(value) {
    _imageFormat.value = value;
  }

  final _showList = false.obs;
  get showList => _showList.value;

  set showList(value) {
    _showList.value = value;
  }

  final _branchRadiusList = false.obs;
  get branchRadiusListLoader => _branchRadiusList.value;

  set branchRadiusListLoader(value) {
    _branchRadiusList.value = value;
  }

  double _latitude = 0.0;

  double get latitude => _latitude;

  set latitude(double value) {
    _latitude = value;
  }

  final  _branchId = 1.obs;

  int get branchId => _branchId.value;

  set branchId(int value) {
    _branchId.value = value;
  }

  double _radius = 0.0;

  double get radius => _radius;

  set radius(double value) {
    _radius = value;
  }

  double _longitude = 0.0;

  double get longitude => _longitude;

  set longitude(double value) {
    _longitude = value;
  }

  LatLng? _destLocation = const LatLng(11.05022464095414, 77.01854346852336);

  LatLng? get destLocation => _destLocation;

  set destLocation(LatLng? value) {
    _destLocation = value;
  }

  bool isNetworkImage(String imageUrl) {
    return imageUrl.startsWith('http://') || imageUrl.startsWith('https://');
  }

  final _isEdit = "".obs;

  get isEdit => _isEdit.value;

  set isEdit(value) {
    _isEdit.value = value;
  }

  clearValues() {
    officeName.text = "";
    officeFullAddress.text = "";
    officeImage.text = "";
    radiusId.text = "";
   // officeAddress.text = "";
    radiusId.text = "";
    allowArea = false;
    isEdit = "";
    enableGeoFencingStatus = false;
    destLocation = LatLng(0.0, 0.0);
    latitude = 11.3660125;
    longitude = 77.7522656;
  }

  Future<Location> locationFromAddress(String address) async {
    final locations =
        await GeocodingPlatform.instance.locationFromAddress(address);
    if (locations.isNotEmpty) {
      final location = locations.first;
      return location;
    }
    return Location(latitude: 0, longitude: 0, timestamp: DateTime.now());
  }

  Future<LatLng> getLatLngFromAddress() async {
    mapLoader = true;
    String address = GetStorage().read("CurrentAddress");
    print("Address $address");
    try {
      Location location = await locationFromAddress(address);
      if (location != null) {
        BranchController.to.latitude = location.latitude;
        BranchController.to.longitude = location.longitude;
        debugPrint('Lat ${BranchController.to.latitude.toString()}');
        debugPrint("Long ${BranchController.to.longitude.toString()}");
        BranchController.to.destLocation =
            LatLng(BranchController.to.latitude, BranchController.to.longitude);
        debugPrint("Dest location ${BranchController.to.destLocation}");

        return LatLng(location.latitude, location.longitude);
      } else {
        throw Exception("No location found for the provided address.");
      }
    } catch (e) {
      throw Exception("Error fetching LatLng: $e");
    } finally {
      mapLoader =
          false;
    }
  }

  branchList() async {
    print('branch list');
    showList = true;
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
            url: "${Api.branchList}",
            encryptMessage: await LibSodiumAlgorithm().encryptionMessage({}),
            auth: true)
        : await _http.post(Api.branchList, {},
            auth: true, contentHeader: false);
    if (response['code'] == "200") {
      branchListModel = BranchListModel.fromJson(response);
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
    showList = false;
  }

  getBranchRadiusList() async {
    branchRadiusListLoader = true;
    var response = await _http.post(Api.branchRadiusList, "", auth: true);
    if (response['code'] == "200") {
      branchRadiusList = BranchRadiusList.fromJson(response);
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
    branchRadiusListLoader = false;
  }

  postBranch(isEdit) async {
    var body = {
      if(isEdit == true)
        'id': branchId ?? 0,
      "office_name":" officeName.text",
      "office_fulladdress": officeFullAddress.text,
      "geofencing_status": enableGeoFencingStatus == true ? "1" : "0",
      "office_address": officeAddress.text,
      "clock_limit_radius": radiusId.text,
      "allow_area": allowArea == true ? "1" : "0",
      "latitude": BranchController.to.latitude,
      "longitude":BranchController.to.longitude,
    };
    debugPrint(body.toString());
    try {
      var response = GetStorage().read("RequestEncryption") == true
          ? await _http.multipartPostData(
              url: "${Api.addBranch}",
              encryptMessage:
                  await LibSodiumAlgorithm().encryptionMessage(body),
              auth: true)
          : await _http.post(Api.addBranch, body,
              auth: true, contentHeader: false);
        if (response['code'] == "200") {
        branchId = response['data']['data']['id'];
        if(BranchController.to.officeImage.text != "" &&
            isNetworkImage(BranchController.to.officeImage.text) == false){
          BranchController.to.addBranchAttachment(branchId);
        }
        else{
          Get.to(() => BranchScreen());
          BranchController.to.branchList();
          CommonController.to.buttonLoader = false;
        }
        UtilService()
            .showToast("success", message: response['message'].toString());
      } else {
        UtilService()
            .showToast("error", message: response['message'].toString());
      }
    } catch (e) {
      print("Exception on the api$e");
      CommonController.to.buttonLoader = false;
    }
  }


  addBranchAttachment(branchId) async {
    List<String> filePath = [
      BranchController.to.officeImage.value.text,
    ];
    List<String> fileName = ["office_image"];
    List<String> fieldsName = ["branch_id"];
    List<String> fields = [branchId.toString()];
    //  List<String> fields = ["30"];
    debugPrint(
        "File Name $fileName  fieldsName $fieldsName file $filePath fields $fields");
    var response = await _http.commonImagePostMultiPart(
        url: "${Api.addBranchAttachment}",
        auth: true,
        filePaths: filePath,
        fileName: fileName,
        fieldsName: fieldsName,
        fields: fields);
    print("response $response");
    if (response['code'] == "200") {
    if(response['message']!= ""){
      print("Success");
      Get.to(() => BranchScreen());
      BranchController.to.branchList();
      CommonController.to.buttonLoader = false;
    }
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
  }

  geoFencingStatusChange(int index) async {
    var body = {
      "id": branchListModel?.data?[index].id,
      "status": branchListModel?.data?[index].geofencingStatus == 1 ? "0" : "1"
    };
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
            url: "${Api.geoFencingStatusChange}",
            encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
            auth: true)
        : await _http.post(Api.geoFencingStatusChange, body,
            auth: true, contentHeader: false);
    print("body $body");
    if (response['code'] == "200") {
      branchList();
      UtilService()
          .showToast("success", message: response['message'].toString());
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
  }

  statusChange(int index) async {
    var body = {
      "id": branchListModel?.data?[index].id,
      "type": branchListModel?.data?[index].deletedAt == null ? "0" : "1"
    };
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
            url: "${Api.statusChange}",
            encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
            auth: true)
        : await _http.post(Api.statusChange, body,
            auth: true, contentHeader: false);
    print("body $body");
    if (response['code'] == "200") {
      branchList();
      UtilService()
          .showToast("success", message: response['message'].toString());
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
  }

  setAsHQ(int index) async {
    var body = {
      "id": branchListModel?.data?[index].id,
      "set_hq": branchListModel?.data?[index].setHq == 1 ? "0" : "1"
    };
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
            url: "${Api.setAsHQ}",
            encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
            auth: true)
        : await _http.post(Api.setAsHQ, body, auth: true, contentHeader: false);
    print("body $body");
    if (response['code'] == "200") {
      Get.back();
      Get.back();
      branchList();
      UtilService()
          .showToast("success", message: response['message'].toString());
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
  }

  deleteTask(Datum branchIndex) async {
    var body = {"id": branchIndex.id, "type": 3};
    var response = GetStorage().read("RequestEncryption") == true
        ? await _http.multipartPostData(
            url: "${Api.deleteBranch}",
            encryptMessage: await LibSodiumAlgorithm().encryptionMessage(body),
            auth: true)
        : await _http.post(Api.deleteBranch, body,
            auth: true, contentHeader: false);
    if (response['code'] == "200") {
      UtilService()
          .showToast("success", message: response['message'].toString());

      Get.back();
      Get.back();
      branchList();
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
  }
}
