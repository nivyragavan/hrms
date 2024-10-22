import 'package:dreamhrms/controller/common_controller.dart';
import 'package:dreamhrms/screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import '../controller/change_password_controller.dart';
import '../widgets/Custom_rich_text.dart';
import '../widgets/Custom_text.dart';
import '../widgets/back_to_screen.dart';
import '../widgets/common.dart';
import '../widgets/common_button.dart';
import '../widgets/common_textformfield.dart';

class ChangePassword extends StatelessWidget {
   ChangePassword({super.key});
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
             navBackButton(),
            SizedBox(width: 8),
            CustomText(
              text: "change_password",
              color: AppColors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              buildWidget(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildWidget(BuildContext context) {
    return Form(
      key: formKey,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: CustomRichText(
                  textAlign: TextAlign.center,
                  text: "new_password",
                  color: AppColors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  textSpan: ' *',
                  textSpanColor: AppColors.red),
            ),
            SizedBox(height: 10),
            CommonTextFormField(
              controller: ChangePasswordController.to.newPassword,
              // hintText: "mail_hint",
              isBlackColors: true,
              password: true,
              keyboardType: TextInputType.emailAddress,
              validator: (String? data) {
                if (data == "" || data == null) {
                  return "validate_new_password";
                } else {
                  return null;
                }
              },
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: CustomRichText(
                  textAlign: TextAlign.center,
                  text: "confirm_password",
                  color: AppColors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  textSpan: ' *',
                  textSpanColor: AppColors.red),
            ),
            SizedBox(height: 10),
            CommonTextFormField(
              controller: ChangePasswordController.to.confirmPassword,
              // hintText: "mail_hint",
              password: true,
              isBlackColors: true,
              keyboardType: TextInputType.emailAddress,
              validator: (String? data) {
                if (data == "" || data == null) {
                  return "validate_confirm_password";
                } else {
                  return null;
                }
              },
            ),
            SizedBox(height: 25),
            Row(
              children: [
                Expanded(
                  child: CommonButton(
                    text: "change_password",
                    textColor: AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    buttonLoader: CommonController.to.buttonLoader,
                    // textAlign: TextAlign.center,
                    onPressed: () {
                     //change password api
                      if(formKey.currentState!.validate()){
                       CommonController.to.buttonLoader=true;
                       // if its true
                       // LoginController.to.clearLocalStorage();
                       // Get.offAll(() => Splash());
                       CommonController.to.buttonLoader=false;
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            BackToScreen(
              text: "cancel",
              arrowIcon: false,
              onPressed: () {
                Get.to(()=>MainScreen());
              },
            )
          ],
        ),
      ),
    );
  }

}
