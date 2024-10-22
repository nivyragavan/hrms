import 'dart:io';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:dreamhrms/constants/theme.dart';
import 'package:dreamhrms/controller/theme_controller.dart';
import 'package:dreamhrms/routes/routes.dart';
import 'package:dreamhrms/services/firebase_notification.dart';
import 'package:face_camera/face_camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_sodium/flutter_sodium.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:localization/localization.dart';
import 'package:permission_handler/permission_handler.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xff2fb97d))); //AppColors.green
  await GetStorage.init();
  await Firebase.initializeApp();
  await FirebaseApi().initNotifications();
  await FirebaseApi().localNotification();
  await FaceCamera.initialize();
  ThemeController.to.getThemeStatus();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  HttpOverrides.global = new MyHttpOverrides();
  Sodium.init();
  // data: MediaQueryData.fromView(ui.window),
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    getPages: AppRoutes.routes,
    themeMode: ThemeMode.system,
    theme: MyThemes.lightTheme,
    darkTheme: MyThemes.darkTheme,
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      LocalJsonLocalization.delegate,
    ],
    locale: const Locale('en'),
  ));
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
