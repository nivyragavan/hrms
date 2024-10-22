import 'package:dreamhrms/controller/login_controller.dart';
import 'package:dreamhrms/screen/sign_up.dart';
import 'package:dreamhrms/widgets/common_button.dart';
import 'package:dreamhrms/widgets/common_typeheadtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';

import '../constants/colors.dart';
import '../controller/common_controller.dart';
import '../services/firebase_notification.dart';
import '../widgets/Custom_rich_text.dart';
import '../widgets/Custom_text.dart';
import '../widgets/common.dart';
import '../widgets/common_textformfield.dart';
import 'forgot_password.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  bottomWidget() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CustomRichText(
        text: "no_account",
        color: AppColors.grey,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        textAlign: TextAlign.center,
        textSpan: "sign_up",
        textSpanColor: AppColors.blue,
        textSpanFontSize: 14,
        textSpanFontWeight: FontWeight.w600,
        textSpanTextAlign: TextAlign.center,
        onPressed: () {
          Get.to(() => Signup());
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((value) async {
      LoginController.to.loginInit();
      FirebaseApi().initNotifications();
      LoginController.to.credentialsList = await LoginController.to.getCredentialsList();
      LoginController.to.switchRememberButton = false;
    });
    return GestureDetector(
      onTap: commonTapHandler,
      child: Scaffold(
        bottomNavigationBar: bottomWidget(),
        
        body: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: AutofillGroup(
                  child: Column(
                    children: [
                      SizedBox(height: 70),
                      loginHeader(),
                      SizedBox(height: 30),
                      loginBody(),
                      SizedBox(height: 30),
                      loginBottom(),
                    ],
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 30),
              //   child: Align(
              //     alignment: Alignment.bottomCenter,
              //     child: CustomRichText(
              //       text: "no_account",
              //       color: AppColors.grey,
              //       fontSize: 14,
              //       fontWeight: FontWeight.w400,
              //       textAlign: TextAlign.center,
              //       textSpan: "sign_up",
              //       textSpanColor: AppColors.blue,
              //       textSpanFontSize: 14,
              //       textSpanFontWeight: FontWeight.w600,
              //       textSpanTextAlign: TextAlign.center,
              //       onPressed: () {
              //         Get.to(() => Signup());
              //       },
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget loginHeader() {
    return Center(
      child: Column(
        children: [
          Image.asset(
            "assets/images/logo_hr.png",
            fit: BoxFit.contain,
          ),
          SizedBox(height: 15),
          CustomText(
              text: "welcome",
              color: AppColors.black,
              fontSize: 25,
              fontWeight: FontWeight.w700),
          SizedBox(height: 10),
          CustomText(
              text: "login_message",
              color: AppColors.grey,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget loginBody() {
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
                  text: "email",
                  color: AppColors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  textSpan: ' *',
                  textSpanColor: AppColors.red),
            ),
            SizedBox(height: 10),
            CommonTypeTextFormField(
              controller: LoginController.to.userEmail,
              autofillHints: [AutofillHints.username],
              // hintText: "mail_hint",
              isBlackColors: true,
              type: "username",
              keyboardType: TextInputType.emailAddress,
              validator: (String? data) {
                if (data == "" || data == null) {
                  return "required_email";
                } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                    .hasMatch(data)) {
                  return "required_email_format";
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
                  text: "password",
                  color: AppColors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  textSpan: ' *',
                  textSpanColor: AppColors.red),
            ),
            SizedBox(height: 10),
            CommonTextFormField(
              // autofillHints: [AutofillHints.password],
              controller: LoginController.to.password,
              isBlackColors: true,
              password: true,
              // type: 'password',
              keyboardType: TextInputType.emailAddress,
              validator: (String? data) {
                if (data == "" || data == null) {
                  return "required_password";
                } else {
                  return null;
                }
              },
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    rememberToggle(),
                    SizedBox(width: 5),
                    CustomText(
                        text: "remember_me",
                        color: AppColors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Rubik"),
                  ],
                ),
                CustomText(
                    text: "forgot_password?",
                    color: AppColors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Rubik",
                    onPressed: () {
                      Get.to(() => ForgotPassword());
                    }),
              ],
            ),
            SizedBox(height: 25),
            Obx(()=>
               Row(
                children: [
                  Expanded(
                    child: CommonButton(
                      text: "login",
                      textColor: AppColors.white,
                      fontSize: 16,
                      buttonLoader: CommonController.to.buttonLoader,
                      fontWeight: FontWeight.w500,
                      // textAlign: TextAlign.center,
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          CommonController.to.buttonLoader=true;
                          await CommonController.to.checkInternetConnectivity();
                          await LoginController.to.login(option:"login");
                          CommonController.to.buttonLoader=false;
                        }
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget rememberToggle() {
    return Obx(
      () => FlutterSwitch(
        height: 25,
        width: 50,
        // toggleSize: 26,
        // showOnOff: true,
        valueFontSize: 11,
        activeColor: AppColors.blue,
        activeTextColor: AppColors.grey,
        inactiveColor: AppColors.lightGrey,
        inactiveTextColor: AppColors.grey,
        value: LoginController.to.switchRememberButton,
        onToggle: (val) {
          LoginController.to.switchRememberButton =
              !LoginController.to.switchRememberButton;
        },
      ),
    );
  }

  Widget loginBottom() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Divider(color: AppColors.grey.withOpacity(0.5))),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CustomText(
                  text: "continue_other_login",
                  color: AppColors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.center),
            ),
            Expanded(child: Divider(color: AppColors.grey.withOpacity(0.5))),
          ],
        ),
        SizedBox(height: 20),
        otherLogin(image: "assets/images/google.png", text: "google",onPressed:(){
        }),
        otherLogin(image: "assets/images/octa.png", text: "octa"),
        otherLogin(
            image: "assets/images/microsoft.png", text: "microsoft"),
      ],
    );
  }

  otherLogin({required String image, required String text,  Null Function()? onPressed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.grey.withOpacity(0.5),
              // width: 1.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  image,
                  fit: BoxFit.contain,
                ),
                SizedBox(width: 10),
                CustomText(
                  text: text,
                  color: AppColors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
