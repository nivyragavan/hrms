import 'package:dreamhrms/widgets/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';

import '../constants/colors.dart';
import '../controller/theme_controller.dart';
import '../widgets/Custom_text.dart';

class Theme extends StatelessWidget {
  const Theme({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            navBackButton(),
            CustomText(
                text: "theme",
                color: AppColors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.start),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child:Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              CustomText(
                text: "customize_theme",
                color: AppColors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "interface_theme",
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  ObxValue(
                        (data) => Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: FlutterSwitch(
                          height: 25,
                          width: 50,
                          padding: 2,
                          valueFontSize: 11,
                          activeColor: AppColors.blue,
                          activeTextColor: AppColors.grey,
                          inactiveColor: AppColors.lightGrey,
                          inactiveTextColor: AppColors.grey,
                          value: ThemeController.to.isDarkTheme,
                          onToggle: (val) {
                            ThemeController.to.isDarkTheme = val;
                            Get.changeThemeMode(
                              ThemeController.to.isDarkTheme
                                  ? ThemeMode.dark
                                  : ThemeMode.light,
                            );
                            ThemeController.to.saveThemeStatus();
                          }),
                    ),
                    false.obs,
                  )
                ],
              ),
            ],
          ),
        )
      ),
    );
  }
}
