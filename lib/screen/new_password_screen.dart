import 'package:dreamhrms/controller/signup_controller.dart';
import 'package:dreamhrms/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import '../controller/common_controller.dart';
import '../controller/login_controller.dart';
import '../widgets/Custom_rich_text.dart';
import '../widgets/Custom_text.dart';
import '../widgets/back_to_screen.dart';
import '../widgets/common_button.dart';
import '../widgets/common_textformfield.dart';
import '../widgets/password_validator.dart';

class NewPasswordScreen extends StatelessWidget {
  NewPasswordScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 30, right: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 100),
              headerPart(),
              SizedBox(height: 40),
              bodyPart(),
            ],
          ),
        ),
      ),
    );
  }

  Widget headerPart() {
    return Center(
      child: Column(
        children: [
          Image.asset(
            "assets/images/logo_hr.png",
            fit: BoxFit.contain,
          ),
          SizedBox(height: 25),
          CustomText(
              text: "account_create",
              color: AppColors.black,
              fontSize: 25,
              fontWeight: FontWeight.w700),
          SizedBox(height: 10),
          CustomText(
              text: "account_fields",
              color: AppColors.grey,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget bodyPart() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(height: 10),
            // CustomText(
            //   text: "domain_name",
            //   color: AppColors.black,
            //   fontSize: 12,
            //   fontWeight: FontWeight.w500,
            // ),
            // SizedBox(height: 10),
            // CustomText(
            //   text: SignupController.to.domainName.text ?? '-',
            //   color: AppColors.grey,
            //   fontSize: 14,
            //   fontWeight: FontWeight.w600,
            // ),
            // SizedBox(height: 20),

            Align(
              alignment: Alignment.centerLeft,
              child: CustomRichText(
                  textAlign: TextAlign.center,
                  text: "password",
                  color: AppColors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  textSpan: ' *',
                  textSpanColor: AppColors.red),
            ),
            SizedBox(height: 10),
            CommonTextFormField(
              controller: LoginController.to.password,
              // hintText: "mail_hint",
              isBlackColors: true,
              password: true,
              keyboardType: TextInputType.emailAddress,
              validator: (String? data) {
                if (data == "" || data == null) {
                  return "required_password";
                }
                PasswordValidationError validationResult = validatePassword(data);

                switch (validationResult) {
                  case PasswordValidationError.MissingLowercase:
                    return 'Password should contain at least one lowercase letter';
                  case PasswordValidationError.MissingUppercase:
                    return 'Password should contain at least one uppercase letter';
                  case PasswordValidationError.MissingDigit:
                    return 'Password should contain at least one digit';
                  case PasswordValidationError.MissingSpecialCharacter:
                    return 'Password should contain at least one special character';
                  case PasswordValidationError.TooShort:
                    return 'Password should be at least 8 characters long';
                  case PasswordValidationError.None:
                    return null; // Password is valid
                }
              },
            ),
            SizedBox(height: 30),
            Obx(()=> Row(
                children: [
                  Expanded(
                    child: CommonButton(
                      text: "get_started",
                      textColor: AppColors.white,
                      fontSize: 16,
                      buttonLoader: CommonController.to.buttonLoader,
                      fontWeight: FontWeight.w500,
                      // textAlign: TextAlign.center,
                      onPressed: ()async {
                        if (formKey.currentState!.validate()) {
                          CommonController.to.buttonLoader=true;
                          await SignupController.to.signUp();
                          CommonController.to.buttonLoader=false;
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            BackToScreen(
              text: "back",
              arrowIcon: true,
              onPressed: () {
                Get.back();
              },
            ),
            SizedBox(height: 20),
            BackToScreen(
              text: "cancel",
              arrowIcon: false,
              onPressed: () {
                SignupController.to.disposeValue();
                Get.to(() => Login());
              },
            ),
          ],
        ),
      ),
    );
  }

}

