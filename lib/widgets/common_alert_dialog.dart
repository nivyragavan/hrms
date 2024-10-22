import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import '../constants/colors.dart';
import '../controller/common_controller.dart';
import '../services/provision_check.dart';
import 'Custom_text.dart';
import 'back_to_screen.dart';
import 'common_button.dart';

commonAlertDialog(
    {required IconData icon,
    required String title,
    required String description,
    required String actionButtonText,
    required VoidCallback onPressed,
    int? index, required BuildContext context,  String? provision,  String? provisionType}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
          content: Padding(
            // width: Get.width,
            // height: Get.height * 0.30,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: AppColors.blue,
                ),
                SizedBox(
                  height: 18,
                ),
                CustomText(
                    text: title,
                    color: AppColors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
                SizedBox(
                  height: 18,
                ),
                CustomText(
                    text: description,
                    color: AppColors.grey,
                    fontSize: 14,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w400),
                SizedBox(
                  height: 18,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Obx(()=>
                          ProvisionsWithIgnorePointer(
                            provision: provision ?? "",
                            type: provisionType ?? "",
                           child: CommonButton(
                              text: actionButtonText,
                              buttonLoader: CommonController.to.buttonLoader,
                              textColor: AppColors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              onPressed: onPressed
                        ),
                         ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                BackToScreen(
                  text: "cancel",
                  arrowIcon: false,
                  onPressed: () {
                    Get.back();
                  },
                ),
              ],
            ),
          )
      );
    }
      );
}