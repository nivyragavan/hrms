import 'package:dreamhrms/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import '../controller/login_controller.dart';
import '../widgets/Custom_rich_text.dart';
import '../widgets/Custom_text.dart';
import '../widgets/back_to_screen.dart';
import '../widgets/common_button.dart';
import '../widgets/common_textformfield.dart';

class SetPassword extends StatelessWidget {
  const SetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Column(
          children: [
            SizedBox(height: 100),
            headerPart(),
            SizedBox(height: 30),
            bodyPart(context),
          ],
        ),
      ),
    );
  }

  Widget bodyPart(BuildContext context) {
    return Align(
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
            controller: LoginController.to.userEmail,
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
            controller: LoginController.to.userEmail,
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
                  text: "reset_password",
                  textColor: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  // textAlign: TextAlign.center,
                  onPressed: () {
                    _showAlert(context);
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          BackToScreen(
            text: "back_to_login",
            arrowIcon: true,
            onPressed: () {
              Get.off(Login());
            },
          )
        ],
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
          SizedBox(height: 30),
          CustomText(
              text: "set_password",
              color: AppColors.black,
              fontSize: 25,
              fontWeight: FontWeight.w700),
          SizedBox(height: 10),
          CustomText(
              text: "set_password_message",
              color: AppColors.grey,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.center),
        ],
      ),
    );
  }

  void _showAlert(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => Dialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              child: _buildPopupDialog(context),
            ));
  }

  Widget _buildPopupDialog(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: const BorderRadius.all(Radius.circular(18))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset("assets/icons/tick.svg"),
          SizedBox(height: 10),
          CustomText(
              text: "reset_password_success_msg",
              color: AppColors.black,
              fontSize: 20,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w700),
          SizedBox(height: 20),
          CustomText(
              text: "reset__msg",
              color: AppColors.grey,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.center),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: CommonButton(
                  text: "continue",
                  textColor: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  // textAlign: TextAlign.center,
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
