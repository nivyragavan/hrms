import 'package:dreamhrms/screen/login.dart';
import 'package:dreamhrms/screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controller/common_controller.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Future.delayed(Duration.zero).then((value) async => await CommonController.to.checkInternetConnectivity()
      );
      checkNavigation();
    });
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            SizedBox(height: 50),
            centerLogoIcon(),
            bottomImage(),
          ],
        ),
      ),
    );
  }

  centerLogoIcon() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 300),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              "assets/images/logo.png",
              fit: BoxFit.contain,
              // width: 150,
              // height: 150,
            ),
          ),
        ],
      ),
    );
  }

  bottomImage() {
    return Positioned(
      bottom: 5,
      left: 0,
      right: 0,
      child: Image.asset(
        "assets/images/splash_background.png",
        fit: BoxFit.cover, // Adjust the fit as needed
      ),
    );
  }

  checkNavigation() {
    if (GetStorage().read("Token") != null) {
      Get.to(() => MainScreen());
    } else {
      Get.to(() => Login());
    }
  }
}
