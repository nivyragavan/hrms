import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

import '../../../constants/colors.dart';
import '../../../controller/common_controller.dart';
import '../../../controller/employee/personal_controller.dart';
import '../../../controller/settings/company/company_settings.dart';
import '../../../controller/signup_controller.dart';
import '../../../widgets/Custom_rich_text.dart';
import '../../../widgets/back_to_screen.dart';
import '../../../widgets/common.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/common_searchable_dropdown/MainCommonSearchableDropDown.dart';
import '../../../widgets/common_textformfield.dart';
import '../company_settings.dart';

class CompanyContactDetails extends StatelessWidget {
  const CompanyContactDetails({Key? key}) : super(key: key);
 static final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((value) async {
      await SignupController.to.getCountryList();
    });
    return GestureDetector(
      onTap: commonTapHandler,
      child: Scaffold(
        
        resizeToAvoidBottomInset: true,
        body: Form(
          key:formKey, child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Obx(()=>
               Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomRichText(
                      textAlign: TextAlign.left,
                      text: "company_address",
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      textSpan: ' *',
                      textSpanColor: AppColors.red),
                  SizedBox(height: 10),
                  CommonTextFormField(
                    controller: CompanySettingsController.to.companyAddress,
                    isBlackColors: true,
                    keyboardType: TextInputType.name,
                    validator: (String? data) {
                      if (data == "" || data == null) {
                        return "company_address_validator";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  CustomRichText(
                      textAlign: TextAlign.left,
                      text: 'country',
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      textSpan: '*',
                      textSpanColor: AppColors.red),
                  SignupController.to.countryLoader
                      ? Skeleton(width: Get.width, height: 30)
                      : MainSearchableDropDown(
                      title: 'name',
                      isRequired: true,
                      error:'country',
                      items: SignupController
                          .to.countryModel?.data
                          ?.map((datum) => datum.toJson())
                          .toList(),
                      controller: CompanySettingsController
                          .to.companyCountry,
                      onChanged: (data) async {
                        CompanySettingsController
                            .to
                            .companyCountryId
                            .text = data['id'].toString();
                        await PersonalController.to.getStateList(
                            CompanySettingsController
                                .to
                                .companyCountryId
                                .text);
                      }),
                  SizedBox(height: 10),
                  CustomRichText(
                      textAlign: TextAlign.left,
                      text: 'state_province',
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      textSpan: '*',
                      textSpanColor: AppColors.red),
                  PersonalController.to. stateLoader?Skeleton(width: Get.width, height: 30):MainSearchableDropDown(
                      title: 'name',
                      isRequired: true,
                      error:  'state_province',
                      items: PersonalController
                          .to.stateModel?.data
                          ?.map((datum) => datum.toJson())
                          .toList(),
                      controller:
                      CompanySettingsController.to.companyState,
                      onChanged: (data) async {
                        CompanySettingsController.to.companyStateId
                            .text = data['id'].toString();
                        await PersonalController.to.getCityList(
                            CompanySettingsController.to.companyStateId
                                .text);
                      }),
                  SizedBox(height: 10),
                  CustomRichText(
                      textAlign: TextAlign.left,
                      text: 'city',
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      textSpan: '*',
                      textSpanColor: AppColors.red),
                  PersonalController.to. cityLoader?Skeleton(width: Get.width, height: 30):MainSearchableDropDown(
                      title: 'name',
                      isRequired: true,
                      error: 'city',
                      items: PersonalController.to.cityModel?.data
                          ?.map((datum) => datum.toJson())
                          .toList(),
                      controller:
                      CompanySettingsController.to.companyCity,
                      onChanged: (data) async {
                        CompanySettingsController.to.companyCityId
                            .text = data['id'].toString();
                      }),
                  SizedBox(height: 10),
                  CustomRichText(
                      textAlign: TextAlign.left,
                      text: "postal_code",
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      textSpan: ' *',
                      textSpanColor: AppColors.red),
                  SizedBox(height: 10),
                  CommonTextFormField(
                    controller: CompanySettingsController.to.companyPostalCode,
                    isBlackColors: true,
                    keyboardType: TextInputType.number,
                    validator: (String? data) {
                      if (data == "" || data == null) {
                        return "postal_code_validation";
                      }
                      else {
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
                    controller: CompanySettingsController.to.companyPhoneNumber,
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
                      text: "mobile_number",
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      textSpan: ' *',
                      textSpanColor: AppColors.red),
                  SizedBox(height: 10),
                  CommonTextFormField(
                    controller: CompanySettingsController.to.companyMobileNumber,
                    isBlackColors: true,
                    keyboardType: TextInputType.number,
                    validator: (String? data) {
                      if (data == "" || data == null) {
                        return "mobile_number_validator";
                      }
                      // else if (data.length != 10) {
                      //    return "phone_no_validation";
                      // }
                      else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  CustomRichText(
                      textAlign: TextAlign.left,
                      text: "fax",
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      textSpan: ' *',
                      textSpanColor: AppColors.red),
                  SizedBox(height: 10),
                  CommonTextFormField(
                    controller: CompanySettingsController.to.companyFax,
                    isBlackColors: true,
                    keyboardType: TextInputType.name,
                    validator: (String? data) {
                      if (data == "" || data == null) {
                        return "fax_validator";
                      }
                      // else if (data.length != 10) {
                      //    return "phone_no_validation";
                      // }
                      else {
                        return null;
                      }
                    },
                  ),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            child: CommonButton(
                              text: "next",
                              textColor: AppColors.white,
                              fontSize: 16,
                              buttonLoader:CommonController.to.buttonLoader,
                              fontWeight: FontWeight.w500,
                              // textAlign: TextAlign.center,
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  Get.back();
                                  Get.to(() => CompanySettings(selectedIndex: 2));
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
                          Get.back();
                        },
                      ),
                  SizedBox(height: 20),
                  BackToScreen(
                    text: "back",
                    arrowIcon: false,
                    onPressed: () {
                      Get.back();
                      Get.to(() => CompanySettings(selectedIndex: 0));
                    },
                  )
                    ],
                  ),
            ),
            ),
          ),
        ),
        ),
      );
  }
}
