import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SickLeaveController extends GetxController{
  static SickLeaveController get to=>Get.put(SickLeaveController());

  TextEditingController sickDays = TextEditingController();

  final _sickLeaveSwitch=false.obs;

  get sickLeaveSwitch => _sickLeaveSwitch.value;

  set sickLeaveSwitch(value) {
    _sickLeaveSwitch.value = value;
  }
}