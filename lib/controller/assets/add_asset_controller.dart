import 'package:dreamhrms/model/asset/asset_status_model.dart';
import 'package:dreamhrms/model/asset/get_code_model.dart';
import 'package:dreamhrms/services/HttpHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../screen/admin_assets/admin_assets_list.dart';
import '../../services/api_service.dart';
import '../../services/utils.dart';
import '../../widgets/encrypt_decrypt.dart';
import '../common_controller.dart';
import 'admin_asset_controller.dart';

class AddAssetController extends GetxController {
  static AddAssetController get to => Get.put(AddAssetController());
  static final HttpHelper _http = HttpHelper();
  BuildContext? context = Get.context;

  TextEditingController assetName = TextEditingController();
  TextEditingController assetID = TextEditingController();
  TextEditingController deviceCategories = TextEditingController();
  TextEditingController brand = TextEditingController();
  TextEditingController model = TextEditingController();
  TextEditingController warrantyExpirationDate = TextEditingController();
  TextEditingController assetStatus = TextEditingController();
  TextEditingController assetStatusId = TextEditingController();
  TextEditingController serialNumber = TextEditingController();
  TextEditingController supplier = TextEditingController();
  TextEditingController purchaseDate = TextEditingController();
  TextEditingController purchaseAmount = TextEditingController();
  TextEditingController assetImage = TextEditingController();
  TextEditingController imageFormat = TextEditingController();
  TextEditingController imageName = TextEditingController();
  TextEditingController attachmentId = TextEditingController();
  TextEditingController masterId = TextEditingController();
  AssetStatusModel? assetStatusModel;
  AssetGetCodeModel? assetGetCodeModel;
  final _showAssetStatus = false.obs;

  get showAssetStatus => _showAssetStatus.value;

  set showAssetStatus(value) {
    _showAssetStatus.value = value;
  }

  final _assetIdLoader = false.obs;

  get generatedAssetId => _assetIdLoader.value;

  set generatedAssetId(value) {
    _assetIdLoader.value = value;
  }

  final _isEdit = false.obs;

  get isEdit => _isEdit.value;

  set isEdit(value) {
    _isEdit.value = value;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAssetStatusList();
  }

  bool isNetworkImage(String imageUrl) {
    return imageUrl.startsWith('http://') || imageUrl.startsWith('https://');
  }

  getCode() async {
    generatedAssetId = true;
    var response = await _http.post(Api.assetGetCode, "",
        auth: true, contentHeader: false);
    if (response['code'] == "200") {
      assetGetCodeModel = AssetGetCodeModel.fromJson(response);
      assetID.text = response['data']['data'];
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
    generatedAssetId = false;
  }

  getAssetStatusList() async {
    showAssetStatus = true;
    var response =
        await _http.post(Api.assetStatus, "", auth: true, contentHeader: false);
    if (response['code'] == "200") {
      assetStatusModel = AssetStatusModel.fromJson(response);
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
    showAssetStatus = false;
  }

  postAsset(isEdit) async {
    var body = {
      "name": assetName.text,
      if(isEdit == true)
        "id": masterId.text,
      "asset_id": assetID.text,
      "category": deviceCategories.text,
      "brand": brand.text,
      "model": model.text,
      "warranty_expiry_date": CommonController.to.dateConversion(warrantyExpirationDate.text, "dd-mm-yy"),
      "status": assetStatusId.text,
      "serial_number": serialNumber.text,
      "supplier": supplier.text,
      "purchase_date": purchaseDate.text,
      // "currency": "",
      "cost": purchaseAmount.text,
      // "notes": ""
    };
    debugPrint(body.toString());
    try {
      var response = GetStorage().read("RequestEncryption") == true
          ? await _http.multipartPostData(
              url:  isEdit == true ? "${Api.editAsset}": "${Api.addAsset}",
              encryptMessage:
                  await LibSodiumAlgorithm().encryptionMessage(body),
              auth: true)
          : await _http.post( isEdit == true ? Api.editAsset : Api.addAsset, body,
              auth: true, contentHeader: false);
      if (response['code'] == "200") {
        if(AddAssetController.to.imageName.text != "" &&
            isNetworkImage(AddAssetController.to.imageName.text) == false){
            isEdit == true ?  AddAssetController.to.attachmentUpload(
                AddAssetController.to.masterId.text,
              attachmentId: AddAssetController.to.attachmentId.text) :
           AddAssetController.to.attachmentUpload(response['data']['data']['id'].toString());
        }
        else {
          Get.to(()=> AdminAssets());
          AdminAssetController.to.getAdminAssetList();
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

  attachmentUpload(assetId, {attachmentId}) async {
    List<String> file = [AddAssetController.to.imageName.value.text];
    List<String> fileName = ["attachment"];
    List<String> fieldsName = ["asset_id"];
    List<String> fields = [assetId];
    if (attachmentId != null) {
      fieldsName.add("attachment_id");
      fields.add(attachmentId);
    }
    debugPrint(
        "File Name $fileName  fieldsName $fieldsName file $file fields $fields");
    var response = await _http.commonImagePostMultiPart(
        url: "${Api.addAssetAttachment}",
        auth: true,
        filePaths: file,
        fileName: fileName,
        fieldsName: fieldsName,
        fields: fields);
    print("response $response");
    if (response['code'] == "200") {
      if(response['message']!= ""){
        print("success");
        Get.to(()=> AdminAssets());
        AdminAssetController.to.getAdminAssetList();
        CommonController.to.buttonLoader = false;
      }
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
  }
  deleteAsset(String assetId) async {
    var body = {
      "id": assetId,
    };
    debugPrint(body.toString());
    try {
      var response = GetStorage().read("RequestEncryption") == true
          ? await _http.multipartPostData(
          url: "${Api.deleteAsset}",
          encryptMessage:
          await LibSodiumAlgorithm().encryptionMessage(body),
          auth: true)
          : await _http.post(Api.deleteAsset, body,
          auth: true, contentHeader: false);
      if (response['code'] == "200") {

        UtilService()
            .showToast("success", message: response['message'].toString());
        Get.back();
        AdminAssetController.to.getAdminAssetList();
      } else {
        UtilService()
            .showToast("error", message: response['message'].toString());
      }
    } catch (e) {
      print("Exception on the api$e");
      CommonController.to.buttonLoader = false;
    }
  }

  clear() {
    assetName.clear();
    assetID.clear();
    deviceCategories.clear();
    brand.clear();
    model.clear();
    warrantyExpirationDate.clear();
    assetStatus.clear();
    assetStatusId.clear();
    serialNumber.clear();
    supplier.clear();
    purchaseDate.clear();
    purchaseAmount.clear();
    assetImage.clear();
    imageFormat.clear();
    isEdit = false;
    Get.delete<AddAssetController>();
  }
}
