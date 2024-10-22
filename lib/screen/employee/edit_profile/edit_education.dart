import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';

import '../../../constants/colors.dart';
import '../../../controller/common_controller.dart';
import '../../../controller/edit_employee_profile_controller.dart';
import '../../../controller/employee/education_controller.dart';
import '../../../controller/employee_details_controller/profile_controller.dart';
import '../../../model/add_employee/education_model.dart';
import '../../../widgets/Custom_rich_text.dart';
import '../../../widgets/Custom_text.dart';
import '../../../widgets/back_to_screen.dart';
import '../../../widgets/common.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/common_datePicker.dart';
import '../../../widgets/common_textformfield.dart';
import '../../../widgets/no_record.dart';
import '../employee_details/profile.dart';

class EditEducation extends StatefulWidget {
  EditEducation({Key? key}) : super(key: key);

  @override
  State<EditEducation> createState() => _EditEducationState();
}

class _EditEducationState extends State<EditEducation> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero).then((value) async {
      EditEmployeeProfileController.to.personalLoader = true;
      EducationController.to.educationModel = EducationModel(education: []);
      await EditEmployeeProfileController.to.setEducationInformation(
          ProfileController.to.profileModel?.data?.data);
      EditEmployeeProfileController.to.personalLoader = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        // leading: Icon(Icons.arrow_back_ios_new_outlined,color: AppColors.black),
        title: Row(
          children: [
            navBackButton(),
            SizedBox(width: 8),
            CustomText(
              text: "edit_education_information",
              color: AppColors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Obx(() => commonLoader(
              length: MediaQuery.of(context).size.height.toInt(),
              singleRow: true,
              loader: EditEmployeeProfileController.to.personalLoader,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                          text: 'Education Information',
                          color: AppColors.blue,
                          fontSize: 13,
                          fontWeight: FontWeight.w400),
                      InkWell(
                        onTap: () {
                          print(
                              "PersonalController length ${EducationController.to.educationModel?.education.length}");

                          EditEmployeeProfileController.to.personalLoader =
                          true;
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
                          print(
                              "PersonalController length ${EducationController.to.educationModel?.education.length}");
                          EditEmployeeProfileController.to.personalLoader =
                          false;
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              color: AppColors.blue,
                              borderRadius: BorderRadius.circular(6)),
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
                  EducationController.to.educationModel?.education.length ==
                      0
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
                              color: AppColors.lightGrey,
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              if (index != 0)
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          EditEmployeeProfileController
                                              .to.personalLoader = true;
                                          EducationController.to
                                              .educationModel?.education
                                              .removeAt(index);
                                          EditEmployeeProfileController
                                              .to
                                              .personalLoader = false;
                                        },
                                        child: Icon(
                                          Icons.delete_outline,
                                          color: AppColors.black,
                                        )),
                                  ],
                                ),
                              CustomRichText(
                                  textAlign: TextAlign.left,
                                  text: 'Degree Name',
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
                                fillColor: AppColors.white,
                                keyboardType: TextInputType.name,
                                validator: (String? data) {
                                  if (data == "" || data == null) {
                                    return "Required Degree Name";
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
                                  text: 'Specialization',
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
                                    return "Required Specialization";
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
                                  text: 'University Name',
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
                                    return "Required University Name";
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
                                  text: 'GPA',
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
                                    return "Required GPA";
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
                                  text: 'Start Date',
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
                                filled: true,
                                hintText: "YYYY-MM-DD",
                                fillColor: AppColors.white,
                                dateFormat: 'yyyy-MM-dd',
                                validator: (String? data) {
                                  if (data == "" || data == null) {
                                    return "Required Start Date";
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
                                  text: 'End Date',
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
                                fillColor: AppColors.white,
                                hintText: "YYYY-MM-DD",
                                dateFormat: 'yyyy-MM-dd',
                                validator: (String? data) {
                                  if (data == "" || data == null) {
                                    return "Required End Date";
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  EducationController
                                      .to
                                      .educationModel
                                      ?.education[index]
                                      .end_year = value;
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
                          text: "save_changes",
                          textColor: AppColors.white,
                          fontSize: 16,
                          buttonLoader: CommonController.to.buttonLoader,
                          fontWeight: FontWeight.w500,
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              CommonController.to.buttonLoader = true;
                              await EditEmployeeProfileController.to
                                  .postEducationInformation();
                              CommonController.to.buttonLoader = false;
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
                ],
              ),
            )),
          ),
        ),
      ),
    );
  }
}

