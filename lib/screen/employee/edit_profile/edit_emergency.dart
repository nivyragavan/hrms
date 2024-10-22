import 'package:dreamhrms/widgets/no_record.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

import '../../../constants/colors.dart';
import '../../../controller/common_controller.dart';
import '../../../controller/edit_employee_profile_controller.dart';
import '../../../controller/employee/personal_controller.dart';
import '../../../controller/employee_details_controller/profile_controller.dart';
import '../../../model/add_employee/emergency_model.dart';
import '../../../widgets/Custom_rich_text.dart';
import '../../../widgets/Custom_text.dart';
import '../../../widgets/back_to_screen.dart';
import '../../../widgets/common.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/common_searchable_dropdown/MainCommonSearchableDropDown.dart';
import '../../../widgets/common_textformfield.dart';
import '../employee_details/profile.dart';

class EditEmergency extends StatefulWidget {
  EditEmergency({Key? key}) : super(key: key);

  @override
  State<EditEmergency> createState() => _EditEmergencyState();
}

class _EditEmergencyState extends State<EditEmergency> {
  final formKey = GlobalKey<FormState>();
  List<TextEditingController> textControllers = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero).then((value) async {
      EditEmployeeProfileController.to.personalLoader = true;
      PersonalController.to.contactModel = EmergencyContactModel(emergency: []);
      await PersonalController.to.getMasterList();
      await EditEmployeeProfileController.to.setEmergencyInformation(
          ProfileController.to.profileModel?.data?.data);
      textControllers = List.generate(
        PersonalController.to.contactModel?.emergency.length ?? 0,
        (_) => TextEditingController(),
      );
      EditEmployeeProfileController.to.personalLoader = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration.zero).then((value) async {
    //   EditEmployeeProfileController.to.personalLoader = true;
    //   PersonalController.to.contactModel = EmergencyContactModel(emergency: []);
    //   await PersonalController.to.getMasterList();
    //   await EditEmployeeProfileController.to.setEmergencyInformation(
    //       ProfileController.to.profileModel?.data?.data);
    //   // EditEmployeeProfileController.to.personalLoader = false;
    // });
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
              text: "edit_emergency_information",
              color: AppColors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.all(20),
          child:SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                            text: 'Emergency Information',
                            color: AppColors.blue,
                            fontSize: 13,
                            fontWeight: FontWeight.w400),
                        InkWell(
                          onTap: () {
                            EditEmployeeProfileController.to.personalLoader =
                                true;
                            print(
                                "PersonalController.to.contactModel!.emergency.length ${PersonalController.to.contactModel!.emergency.length}");
                            PersonalController.to.contactModel?.emergency
                                .insert(
                                    PersonalController
                                        .to.contactModel!.emergency.length,
                                    EmergencyContact(
                                      relationEmailAddress: "",
                                      relationFirstName: "",
                                      relationLastName: "",
                                      phoneNumber: "",
                                      relationship: "",
                                    ));
                            print(
                                "PersonalController length ${PersonalController.to.contactModel!.emergency.length}");
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
                    SizedBox(height: 20),
                    commonLoader(
                      length: MediaQuery.of(context).size.height.toInt(),
                      singleRow: true,
                      loader: EditEmployeeProfileController.to.personalLoader,
                      child: PersonalController
                                  .to.contactModel?.emergency.length ==
                              0
                          ? NoRecord()
                          : ListView.builder(
                              itemCount: PersonalController
                                      .to.contactModel?.emergency.length ??
                                  0,
                            // itemCount: 1,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  width: Get.width,
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      // color: AppColors.lightGrey,
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
                                                  PersonalController.to
                                                      .contactModel?.emergency
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
                                          text: 'First Name',
                                          color: AppColors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          textSpan: '*',
                                          textSpanColor: AppColors.red),
                                      SizedBox(height: 10),
                                      CommonTextFormField(
                                        controller: TextEditingController(
                                            text: PersonalController
                                                .to
                                                .contactModel
                                                ?.emergency[index]
                                                .relationFirstName),
                                        isBlackColors: true,
                                        filled: true,
                                        fillColor: AppColors.white,
                                        keyboardType: TextInputType.text,
                                        onChanged: (value) {
                                          PersonalController
                                              .to
                                              .contactModel
                                              ?.emergency[index]
                                              .relationFirstName = value;
                                        },
                                        validator: (String? data) {
                                          if (data == "" || data == null) {
                                            print("Empty data");
                                          return "first_name_validator";
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      SizedBox(height: 20),
                                      CustomRichText(
                                          textAlign: TextAlign.left,
                                          text: 'last_name',
                                          color: AppColors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          textSpan: '*',
                                          textSpanColor: AppColors.red),
                                      SizedBox(height: 10),
                                      CommonTextFormField(
                                        controller: TextEditingController(
                                            text: PersonalController
                                                .to
                                                .contactModel
                                                ?.emergency[index]
                                                .relationLastName),
                                        isBlackColors: true,
                                        filled: true,
                                        fillColor: AppColors.white,
                                        keyboardType: TextInputType.text,
                                        onChanged: (value) {
                                          PersonalController
                                              .to
                                              .contactModel
                                              ?.emergency[index]
                                              .relationLastName = value;
                                        },
                                        validator: (String? data) {
                                          if (data == "" || data == null) {
                                            print("Empty data");
                                            return "last_name_validator";
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      SizedBox(height: 20),
                                      CustomRichText(
                                          textAlign: TextAlign.left,
                                          text: 'relationship',
                                          color: AppColors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          textSpan: '*',
                                          textSpanColor: AppColors.red),
                                      PersonalController.to.masterLoader == true
                                          ? Skeleton(
                                              width: Get.width, height: 30)
                                          : MainSearchableDropDown(
                                              title: 'relationship',
                                              hint: "Select Relationship",
                                              filled: true,
                                              fillColor: AppColors.white,
                                              isRequired: true,
                                              error: "Relationship",
                                              items: PersonalController
                                                  .to
                                                  .employeeMasterModel
                                                  ?.data?[0]
                                                  .relationship
                                                  ?.map((status) {
                                                return {"relationship": status};
                                              }).toList(),
                                              controller: TextEditingController(
                                                  text: PersonalController
                                                      .to
                                                      .contactModel
                                                      ?.emergency[index]
                                                      .relationship),
                                              onChanged: (data) {
                                                print("data emergency $data");
                                                PersonalController
                                                        .to
                                                        .contactModel
                                                        ?.emergency[index]
                                                        .relationship =
                                                    data['relationship'];
                                              }),
                                      SizedBox(height: 10),
                                      CustomRichText(
                                          textAlign: TextAlign.left,
                                         text: 'phone_number',
                                          color: AppColors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          textSpan: '*',
                                          textSpanColor: AppColors.red),
                                      SizedBox(height: 10),
                                      CommonTextFormField(
                                        controller: TextEditingController(
                                            text: PersonalController
                                                .to
                                                .contactModel
                                                ?.emergency[index]
                                                .phoneNumber),
                                        isBlackColors: true,
                                        filled: true,
                                        fillColor: AppColors.white,
                                        keyboardType: TextInputType.phone,
                                        onChanged: (value) {
                                          PersonalController
                                              .to
                                              .contactModel
                                              ?.emergency[index]
                                              .phoneNumber = value;
                                        },
                                        validator: (String? data) {
                                          if (data == "" || data == null) {
                                            return "phone_number_validator"
                                                ;
                                          } else if (data.length != 10) {
                                             return "phone_no_validation";
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      SizedBox(height: 20),
                                      CustomRichText(
                                          textAlign: TextAlign.left,
                                         text: 'email',
                                          color: AppColors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          textSpan: ' *',
                                          textSpanColor: AppColors.red),
                                      SizedBox(height: 10),
                                      CommonTextFormField(
                                        controller: TextEditingController(
                                            text: PersonalController
                                                .to
                                                .contactModel
                                                ?.emergency[index]
                                                .relationEmailAddress),
                                        isBlackColors: true,
                                        filled: true,
                                        fillColor: AppColors.white,
                                        keyboardType: TextInputType.text,
                                        onChanged: (value) {
                                          PersonalController
                                              .to
                                              .contactModel
                                              ?.emergency[index]
                                              .relationEmailAddress = value;
                                        },
                                        validator: (String? data) {
                                          if (data == "" || data == null) {
                                            print("Empty data");
                                            return "Enter valid email address";
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              }),
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          child: CommonButton(
                            text: "save_changes",
                            textColor: AppColors.white,
                            fontSize: 16,
                            buttonLoader: CommonController.to.buttonLoader,
                            fontWeight: FontWeight.w500,
                            // textAlign: TextAlign.center,
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                CommonController.to.buttonLoader = true;
                                await EditEmployeeProfileController.to
                                    .postEmergencyInformation();
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
              )
        ),
      ),
    );
  }
}
