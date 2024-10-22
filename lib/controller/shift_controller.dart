import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/shift_list_model.dart';
import '../services/HttpHelper.dart';
import '../services/api_service.dart';
import '../services/utils.dart';

class ShiftController extends GetxController {
  static ShiftController get to => Get.put(ShiftController());
  static final HttpHelper _http = HttpHelper();
  BuildContext? context = Get.context;
  final List<Color> ColorCodeList = <Color>[].obs;
  final _showShift = false.obs;
  get showShift => _showShift.value;
  ShiftListModel? shiftListModel;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
   getShiftList();
  }

  set showShift(value) {
    _showShift.value = value;
  }

  getShiftList() async {
    showShift = true;
    var response = await _http.post(Api.shiftList, "", auth: true, contentHeader: false);
    if (response['code'] == "200") {
      shiftListModel = ShiftListModel.fromJson(response);
      ColorCodeList.clear();
      if (shiftListModel!.data?.list != null) {
        for (var item in shiftListModel!.data!.list!) {
          Color? color = getColorFromHex(item.color.toString());
          ColorCodeList.add(color);
        }
      }
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
    showShift = false;
  }

  Color getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    int colorValue = int.parse(hexColor, radix: 16);
    return Color(0xFF000000 + colorValue);
  }

  String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0')}';
  }
}
