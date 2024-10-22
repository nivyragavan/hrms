import 'package:dreamhrms/screen/login.dart';
import 'package:dreamhrms/screen/new_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:localization/localization.dart';
import 'package:skeleton_animation/skeleton_animation.dart';
import '../constants/colors.dart';
import '../controller/signup_controller.dart';
import '../widgets/Custom_rich_text.dart';
import '../widgets/Custom_text.dart';
import '../widgets/common_button.dart';
import '../widgets/common_searchable_dropdown/MainCommonSearchableDropDown.dart';
import '../widgets/common_textformfield.dart';

class Signup extends StatelessWidget {
  Signup({Key? key}) : super(key: key);

  final signupController = Get.put(SignupController());
  final formKey = GlobalKey<FormState>();

  bottomWidget(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CustomRichText(
        text: "already_account",
        color: AppColors.grey,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        textAlign: TextAlign.center,
        textSpan: "login",
        textSpanColor: AppColors.blue,
        textSpanFontSize: 14,
        textSpanFontWeight: FontWeight.w600,
        textSpanTextAlign: TextAlign.center,
        onPressed: () {
          Get.to(() => Login());
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((value) async {
      await SignupController.to.disposeValue();
      await SignupController.to.getCountryList();
    });
    return Scaffold(
      bottomNavigationBar: bottomWidget(),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 100),
                    headerPart(),
                    SizedBox(height: 10),
                    bodyPart(),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
  // Positioned(
  //   bottom: 0,
  //   left: 0,
  //   right: 0,
  //   child: Padding(
  //     padding: const EdgeInsets.only(bottom: 30),
  //     child: Align(
  //       alignment: Alignment.bottomCenter,
  //       child: CustomRichText(
  //         text: "already_account",
  //         color: AppColors.grey,
  //         fontSize: 14,
  //         fontWeight: FontWeight.w400,
  //         textAlign: TextAlign.center,
  //         textSpan: "login",
  //         textSpanColor: AppColors.blue,
  //         textSpanFontSize: 14,
  //         textSpanFontWeight: FontWeight.w600,
  //         textSpanTextAlign: TextAlign.center,
  //         onPressed: () {
  //           Get.to(() => Login());
  //         },
  //       ),
  //     ),
  //   ),
  // ),
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
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Container(
          height: Get.height * 0.65,
          child: Align(
            alignment: Alignment.centerLeft,
            child: ListView(
              shrinkWrap: true,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomRichText(
                    textAlign: TextAlign.left,
                    text: "first_name",
                    color: AppColors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    textSpan: ' *',
                    textSpanColor: AppColors.red),
                SizedBox(height: 10),
                CommonTextFormField(
                  controller: signupController.firstName,
                  isBlackColors: true,
                  keyboardType: TextInputType.name,
                  validator: (String? data) {
                    if (data == "" || data == null) {
                      print("Empty data");
                      return "first_name_validator";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 10),
                CustomRichText(
                    textAlign: TextAlign.left,
                    text: "last_name",
                    color: AppColors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    textSpan: ' *',
                    textSpanColor: AppColors.red),
                SizedBox(height: 10),
                CommonTextFormField(
                  controller: signupController.lastName,
                  isBlackColors: true,
                  keyboardType: TextInputType.name,
                  validator: (String? data) {
                    if (data == "" || data == null) {
                      return "last_name_validator";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 10),
                CustomRichText(
                    textAlign: TextAlign.left,
                    text: "email",
                    color: AppColors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    textSpan: ' *',
                    textSpanColor: AppColors.red),
                SizedBox(height: 10),
                CommonTextFormField(
                  controller: signupController.emailAddress,
                  isBlackColors: true,
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
                SizedBox(height: 10),
                CustomRichText(
                    textAlign: TextAlign.left,
                    text: "job_title",
                    color: AppColors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    textSpan: ' *',
                    textSpanColor: AppColors.red),
                SizedBox(height: 10),
                CommonTextFormField(
                  controller: signupController.jobTitle,
                  isBlackColors: true,
                  keyboardType: TextInputType.text,
                  validator: (String? data) {
                    if (data == "" || data == null) {
                      return "job_title_validator";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 10),
                CustomRichText(
                    textAlign: TextAlign.left,
                    text: "company_name",
                    color: AppColors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    textSpan: ' *',
                    textSpanColor: AppColors.red),
                SizedBox(height: 10),
                CommonTextFormField(
                  controller: signupController.companyName,
                  isBlackColors: true,
                  keyboardType: TextInputType.text,
                  validator: (String? data) {
                    if (data == "" || data == null) {
                      return "company_name_validator";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 10),
                CustomRichText(
                    textAlign: TextAlign.left,
                    text: "phone_number",
                    color: AppColors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    textSpan: ' *',
                    textSpanColor: AppColors.red),
                SizedBox(height: 10),
                CommonTextFormField(
                  controller: signupController.phoneNumber,
                  isBlackColors: true,
                  keyboardType: TextInputType.number,
                  validator: (String? data) {
                    if (data == "" || data == null) {
                      return "phone_number_validator";
                    } else if (data.length != 10) {
                       return "phone_no_validation";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 10),
                CustomRichText(
                    textAlign: TextAlign.left,
                    text: "emp_count",
                    color: AppColors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    textSpan: ' *',
                    textSpanColor: AppColors.red),
                SizedBox(height: 10),
                MainSearchableDropDown(
                    title: 'count',
                    hint: "emp_count_hint",
                    isRequired: true,
                    error: "Employee Count",
                    items: [
                      {"count": "0 - 5"},
                      {"count": "6 - 10"},
                      {"count": "11 - 15"},
                      {"count": "16 - 20"},
                      {"count": "21 - 25"},
                      {"count": "50 - 100"},
                      {"count": "100 +"},
                    ],
                    controller: signupController.employeeCount,
                    onChanged: (data) {
                      print("test data response $data");
                    }),
                CustomRichText(
                    textAlign: TextAlign.left,
                    text: "country",
                    color: AppColors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    textSpan: ' *',
                    textSpanColor: AppColors.red),
                SizedBox(height: 10),
                signupController.countryLoader == true
                    ? Skeleton(height: 35)
                    : MainSearchableDropDown(
                        title: 'name',
                        hint: "country_hint",
                        isRequired: true,
                        error: "Country",
                        items: SignupController.to.countryModel?.data
                            ?.map((datum) => datum.toJson())
                            .toList(),
                        controller: signupController.country,
                        onChanged: (data) {
                          signupController.countryId.text =
                              data['id'].toString();
                          print("Choosen country id ${data['id']}");
                        },
                      ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: CommonButton(
                          text: "next",
                          textColor: AppColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          // textAlign: TextAlign.center,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              Get.to(() => NewPasswordScreen());
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
