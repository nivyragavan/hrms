import 'package:dreamhrms/controller/edit_employee_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';

import '../../../constants/colors.dart';
import '../../../controller/common_controller.dart';
import '../../../controller/employee/education_controller.dart';
import '../../../controller/employee/employee_controller.dart';
import '../../../controller/employee_details_controller/profile_controller.dart';
import '../../../controller/theme_controller.dart';
import '../../../model/add_employee/education_model.dart';
import '../../../widgets/Custom_rich_text.dart';
import '../../../widgets/Custom_text.dart';
import '../../../widgets/back_to_screen.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/common_datePicker.dart';
import '../../../widgets/common_textformfield.dart';
import '../../../widgets/no_record.dart';
import '../add_employee_screen.dart';
import '../employee_details/profile.dart';

class EducationalScreen extends StatelessWidget {
  EducationalScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    EducationController.to.educationLoader = true;
    Future.delayed(Duration(seconds: 5)).then((value) async {
      EducationController.to.educationLoader = true;
      EducationController.to.personalLoader = true;
      EducationController.to.educationModel = EducationModel(education: []);
      await EmployeeController.to.isEmployee == "Edit"
          ? await EditEmployeeProfileController.to.setEducationInformation(
              ProfileController.to.profileModel?.data?.data)
          : EducationController.to.educationModel?.education.insert(
              0,
              Education(
                  degree: "",
                  specialization: "",
                  university_name: "",
                  gpa: "",
                  start_year: "",
                  end_year: ""));
       EducationController.to.educationLoader = false;
      EducationController.to.personalLoader = false;
    });
    return Scaffold(
      body: Obx(()=>
         Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: commonLoader(
                length: MediaQuery.of(context).size.height.toInt(),
                singleRow: true,
                loader: EducationController.to.educationLoader || EducationController.to.personalLoader,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                            text: 'education_information',
                            color: AppColors.blue,
                            fontSize: 13,
                            fontWeight: FontWeight.w400),
                        InkWell(
                          onTap: () {
                            EducationController.to.educationLoader = true;
                            EducationController.to.educationModel?.education
                                .insert(
                                EducationController
                                    .to.educationModel!.education.length,
                                Education(
                                    degree: "",
                                    specialization: "",
                                    university_name: "",
                                    gpa: "",
                                    start_year: "",
                                    end_year: ""));
                            EducationController.to.educationLoader = false;
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: AppColors.blue,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Icon(
                              Icons.add,
                              color: AppColors.white,
                              size: 20,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 5),
                    EducationController.to.educationModel?.education.length == 0
                        ? NoRecord()
                        : ListView.builder(
                        itemCount: EducationController
                            .to.educationModel?.education.length ??
                            0,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            width: Get.width,
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: ThemeController.to.checkThemeCondition() == true ? AppColors.black : AppColors.lightGrey,
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (index != 0)
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            EducationController
                                                .to.educationLoader = true;
                                            EducationController.to
                                                .educationModel?.education
                                                .removeAt(index);
                                            EducationController
                                                .to.educationLoader = false;
                                          },
                                          child: Icon(
                                            Icons.delete_outline,
                                            color: AppColors.black,
                                          )),
                                    ],
                                  ),
                                CustomRichText(
                                    textAlign: TextAlign.left,
                                    text: 'degree_name',
                                    color: AppColors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    textSpan: '*',
                                    textSpanColor: AppColors.red),
                                SizedBox(height: 10),
                                CommonTextFormField(
                                  controller: TextEditingController(
                                      text: EducationController
                                          .to
                                          .educationModel
                                          ?.education[index]
                                          .degree),
                                  isBlackColors: true,
                                  filled: true,
                                  fillColor: ThemeController.to.checkThemeCondition() == true ? AppColors.black : AppColors.white,
                                  keyboardType: TextInputType.name,
                                  validator: (String? data) {
                                    if (data == "" || data == null) {
                                      return "degree_name_validation";
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: (value) {
                                    EducationController.to.educationModel
                                        ?.education[index].degree = value;
                                  },
                                ),
                                SizedBox(height: 15),
                                CustomRichText(
                                    textAlign: TextAlign.left,
                                    text: 'specialization',
                                    color: AppColors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    textSpan: '*',
                                    textSpanColor: AppColors.red),
                                SizedBox(height: 10),
                                CommonTextFormField(
                                  controller: TextEditingController(
                                      text: EducationController
                                          .to
                                          .educationModel
                                          ?.education[index]
                                          .specialization),
                                  isBlackColors: true,
                                  filled: true,
                                  fillColor: AppColors.white,
                                  keyboardType: TextInputType.name,
                                  validator: (String? data) {
                                    if (data == "" || data == null) {
                                      return "specialization_validation";
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: (value) {
                                    EducationController
                                        .to
                                        .educationModel
                                        ?.education[index]
                                        .specialization = value;
                                  },
                                ),
                                SizedBox(height: 15),
                                CustomRichText(
                                    textAlign: TextAlign.left,
                                    text: 'university_name',
                                    color: AppColors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    textSpan: '*',
                                    textSpanColor: AppColors.red),
                                SizedBox(height: 10),
                                CommonTextFormField(
                                  controller: TextEditingController(
                                      text: EducationController
                                          .to
                                          .educationModel
                                          ?.education[index]
                                          .university_name),
                                  isBlackColors: true,
                                  filled: true,
                                  fillColor: AppColors.white,
                                  keyboardType: TextInputType.name,
                                  validator: (String? data) {
                                    if (data == "" || data == null) {
                                      return "university_name_validation";
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: (value) {
                                    EducationController
                                        .to
                                        .educationModel
                                        ?.education[index]
                                        .university_name = value;
                                  },
                                ),
                                SizedBox(height: 15),
                                CustomRichText(
                                    textAlign: TextAlign.left,
                                    text: 'gpa',
                                    color: AppColors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    textSpan: '*',
                                    textSpanColor: AppColors.red),
                                SizedBox(height: 10),
                                CommonTextFormField(
                                  controller: TextEditingController(
                                      text: EducationController
                                          .to
                                          .educationModel
                                          ?.education[index]
                                          .gpa),
                                  isBlackColors: true,
                                  filled: true,
                                  fillColor: AppColors.white,
                                  keyboardType: TextInputType.number,
                                  validator: (String? data) {
                                    if (data == "" || data == null) {
                                      return "gpa_validation";
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: (value) {
                                    EducationController.to.educationModel
                                        ?.education[index].gpa = value;
                                  },
                                ),
                                SizedBox(height: 15),
                                CustomRichText(
                                    textAlign: TextAlign.left,
                                    text: 'start_date',
                                    color: AppColors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    textSpan: '*',
                                    textSpanColor: AppColors.red),
                                SizedBox(height: 10),
                                DatePicker(
                                  controller: TextEditingController(
                                      text: EducationController
                                          .to
                                          .educationModel
                                          ?.education[index]
                                          .start_year
                                          .toString()),
                                  hintText: "YYYY-MM-DD",
                                  filled: true,
                                  fillColor: ThemeController.to.checkThemeCondition() == true ? AppColors.black : AppColors.white,
                                  dateFormat: 'yyyy-MM-dd',
                                  validator: (String? data) {
                                    if (data == "" || data == null) {
                                      return "start_date_validation";
                                    } else {
                                      return null;
                                    }
                                  },
                                  onSaved: (value) {
                                    EducationController
                                        .to
                                        .educationModel
                                        ?.education[index]
                                        .start_year = value;
                                  },
                                ),
                                SizedBox(height: 15),
                                CustomRichText(
                                    textAlign: TextAlign.left,
                                    text: 'end_date',
                                    color: AppColors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    textSpan: '*',
                                    textSpanColor: AppColors.red),
                                SizedBox(height: 10),
                                DatePicker(
                                  controller: TextEditingController(
                                      text: EducationController
                                          .to
                                          .educationModel
                                          ?.education[index]
                                          .end_year),
                                  filled: true,
                                  fillColor: ThemeController.to.checkThemeCondition() == true ? AppColors.black : AppColors.white,
                                  hintText: "YYYY-MM-DD",
                                  dateFormat: 'yyyy-MM-dd',
                                  validator: (String? data) {
                                    if (data == "" || data == null) {
                                      return "end_date_validation";
                                    } else {
                                      return null;
                                    }
                                  },
                                  onSaved: (value) {
                                    EducationController.to.educationModel
                                        ?.education[index].end_year = value;
                                  },
                                ),
                                SizedBox(height: 20)
                              ],
                            ),
                          );
                        }),
                    Row(
                      children: [
                        Expanded(
                          child: CommonButton(
                            text: "save_next",
                            textColor: AppColors.white,
                            fontSize: 16,
                            buttonLoader: CommonController.to.buttonLoader,
                            fontWeight: FontWeight.w500,
                            // textAlign: TextAlign.center,
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                CommonController.to.buttonLoader = true;
                                EmployeeController.to.isEmployee == "Edit"
                                    ? await EditEmployeeProfileController.to
                                    .postEducationInformation(
                                    type: "EmployeeEdit")
                                    :await  EducationController.to
                                    .postEducationData();
                                CommonController.to.buttonLoader = false;
                              }
                              ;
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
                      text: "Skip",
                      filled: true,
                      arrowIcon: false,
                      onPressed: () {
                        Get.back();
                        Get.to(() => AddEmployeeScreen(
                          selectedIndex: 4,
                        ));
                      },
                    ),
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
