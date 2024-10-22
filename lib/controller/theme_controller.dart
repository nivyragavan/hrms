import'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ThemeController extends GetxController{
  static ThemeController get to => Get.put(ThemeController());

  final _loader=false.obs;

  get loader => _loader.value;

  set loader(value) {
    _loader.value = value;
  }

  final _isDarkTheme = false.obs;

  get isDarkTheme => _isDarkTheme.value;

  set isDarkTheme(value) {
    _isDarkTheme.value = value;
  }

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  saveThemeStatus() async {
    SharedPreferences pref = await _prefs;
    pref.setBool('theme', isDarkTheme);
  }

  getThemeStatus() async {
    var isDark = _prefs.then((SharedPreferences prefs) {
      return prefs.getBool('theme') != null ? prefs.getBool('theme') : false;
    }).obs;
    isDarkTheme = (await isDark.value)!;
    Get.changeThemeMode(isDarkTheme ? ThemeMode.dark : ThemeMode.light);
  }

  checkThemeCondition(){
    return isDarkTheme;
  }
}