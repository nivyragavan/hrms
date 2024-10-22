import 'dart:io';

import 'package:dreamhrms/widgets/no_record.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:localization/localization.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

import '../../../constants/colors.dart';
import '../../../controller/common_controller.dart';
import '../../../controller/department/add_department_controller.dart';
import '../../../controller/department/deparrtment_controller.dart';
import '../../../controller/edit_employee_profile_controller.dart';
import '../../../controller/employee/dependancy_controller.dart';
import '../../../controller/employee/employee_controller.dart';
import '../../../controller/employee/personal_controller.dart';
import '../../../controller/employee_details_controller/profile_controller.dart';
import '../../../controller/shift_controller.dart';
import '../../../controller/signup_controller.dart';
import '../../../model/add_employee/dependent_model.dart';
import '../../../widgets/Custom_rich_text.dart';
import '../../../widgets/Custom_text.dart';
import '../../../widgets/back_to_screen.dart';
import '../../../widgets/common.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/common_datePicker.dart';
import '../../../widgets/common_searchable_dropdown/MainCommonSearchableDropDown.dart';
import '../../../widgets/common_textformfield.dart';
import '../../../widgets/common_timePicker.dart';
import '../employee_details/profile.dart';

class EditDependency extends StatefulWidget {
  EditDependency({Key? key}) : super(key: key);

  @override
  State<EditDependency> createState() => _EditDependencyState();
}

class _EditDependencyState extends State<EditDependency> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero).then((value) async {
      DependencyController.to.dependantModel = DependantModel(dependant: []);
      DependencyController.to.dependantLoader = true;
      await PersonalController.to.getMasterList();
      await EditEmployeeProfileController.to.setDependencyInformation(
          ProfileController.to.profileModel?.data?.data);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration.zero).then((value) async {
    //   DependencyController.to.dependantModel = DependantModel(dependant: []);
    //   DependencyController.to.dependantLoader = true;
    //   await PersonalController.to.getMasterList();
    //   await EditEmployeeProfileController.to.setDependencyInformation(
    //       ProfileController.to.profileModel?.data?.data);
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
            Expanded(
              child: CustomText(
                text: "edit_dependency_information",
                color: AppColors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Obx(
                () => SingleChildScrollView(
              child: commonLoader(
                length:  MediaQuery.of(context).size.height.toInt(),
                singleRow: true,
                loader: DependencyController.to.dependantLoader,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                            text: 'Basic Information',
                            color: AppColors.blue,
                            fontSize: 13,
                            fontWeight: FontWeight.w400),
                        InkWell(
                          onTap: () {
                            DependencyController.to.dependantLoader = true;
                            print(
                                "DependencyController.to.dependantModel!.dependant.length${DependencyController.to.dependantModel!.dependant.length}");
                            DependencyController.to.dependantModel?.dependant
                                .insert(
                                DependencyController
                                    .to.dependantModel!.dependant.length,
                                Dependant(
                                    firstName: "",
                                    lastName: "",
                                    relationship: "",
                                    phoneNumber: "",
                                    gender: "",
                                    emailAddress: ""));
                            print(DependencyController
                                .to.dependantModel?.dependant.length);
                            DependencyController.to.dependantLoader = false;
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
                    DependencyController
                        .to.dependantModel?.dependant.length==0?NoRecord():ListView.builder(
                        itemCount: DependencyController
                            .to.dependantModel?.dependant.length ??
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (index != 0)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          DependencyController
                                              .to.dependantLoader = true;
                                          DependencyController
                                              .to.dependantModel?.dependant
                                              .removeAt(index);
                                          DependencyController
                                              .to.dependantLoader = false;
                                        },
                                        child: Icon(
                                          Icons.delete_outline,
                                          color: AppColors.black,
                                        ),
                                      ),
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
                                      text: DependencyController
                                          .to
                                          .dependantModel
                                          ?.dependant[index]
                                          .firstName),
                                  isBlackColors: true,
                                  filled: true,
                                  fillColor: AppColors.white,
                                  keyboardType: TextInputType.name,
                                  validator: (String? data) {
                                    if (data == "" || data == null) {
                                      print("Empty data");
                                    return "first_name_validator";
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: (value) {
                                    DependencyController.to.dependantModel
                                        ?.dependant[index].firstName = value;
                                    print(
                                        "valuesss ${DependencyController.to.dependantModel?.dependant[index].firstName}");
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
                                      text: DependencyController
                                          .to
                                          .dependantModel
                                          ?.dependant[index]
                                          .lastName),
                                  isBlackColors: true,
                                  filled: true,
                                  fillColor: AppColors.white,
                                  keyboardType: TextInputType.name,
                                  validator: (String? data) {
                                    if (data == "" || data == null) {
                                      print("Empty data");
                                      return "last_name_validator";
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: (value) {
                                    DependencyController.to.dependantModel
                                        ?.dependant[index].lastName = value;
                                  },
                                ),
                                SizedBox(height: 20),
                                CustomRichText(
                                    textAlign: TextAlign.left,
                                    text: 'Gender',
                                    color: AppColors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    textSpan: '*',
                                    textSpanColor: AppColors.red),
                                // PersonalController.to.masterLoader == true
                                //     ? Skeleton(height: 30)
                                //     :
                                MainSearchableDropDown(
                                    title: 'gender',
                                    hint: "Select Gender",
                                    filled: true,
                                    fillColor: AppColors.white,
                                    isRequired: true,
                                    error: 'Gender',
                                    items: PersonalController.to
                                        .employeeMasterModel?.data?[0].gender
                                        ?.map((status) {
                                      return {"gender": status};
                                    }).toList(),
                                    controller: TextEditingController(
                                        text: DependencyController
                                            .to
                                            .dependantModel
                                            ?.dependant[index]
                                            .gender),
                                    onChanged: (data) {
                                      DependencyController
                                          .to
                                          .dependantModel
                                          ?.dependant[index]
                                          .gender = data['gender'];
                                    }),
                                SizedBox(height: 10),
                                CustomRichText(
                                    textAlign: TextAlign.left,
                                    text: 'relationship',
                                    color: AppColors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    textSpan: '*',
                                    textSpanColor: AppColors.red),
                                // PersonalController.to.masterLoader == true
                                //     ? Skeleton(height: 30)
                                //     :
                                MainSearchableDropDown(
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
                                        text: DependencyController
                                            .to
                                            .dependantModel
                                            ?.dependant[index]
                                            .relationship),
                                    onChanged: (data) {
                                      DependencyController
                                          .to
                                          .dependantModel
                                          ?.dependant[index]
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
                                      text: DependencyController
                                          .to
                                          .dependantModel
                                          ?.dependant[index]
                                          .phoneNumber),
                                  isBlackColors: true,
                                  filled: true,
                                  fillColor: AppColors.white,
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
                                  onChanged: (value) {
                                    DependencyController
                                        .to
                                        .dependantModel
                                        ?.dependant[index]
                                        .phoneNumber = value;
                                  },
                                ),
                                SizedBox(height: 20),
                                CustomRichText(
                                    textAlign: TextAlign.left,
                                   text: 'email',
                                    color: AppColors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    textSpan: '',
                                    textSpanColor: AppColors.red),
                                SizedBox(height: 10),
                                CommonTextFormField(
                                  controller: TextEditingController(
                                      text: DependencyController
                                          .to
                                          .dependantModel
                                          ?.dependant[index]
                                          .emailAddress),
                                  isBlackColors: true,
                                  filled: true,
                                  fillColor: AppColors.white,
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: (value) {
                                    DependencyController
                                        .to
                                        .dependantModel
                                        ?.dependant[index]
                                        .emailAddress = value;
                                  },
                                ),
                              ],
                            ),
                          );
                        }),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          child: CommonButton(
                            text: "save_changes",
                            textColor: AppColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            buttonLoader: CommonController.to.buttonLoader,
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                CommonController.to.buttonLoader = true;
                                await EditEmployeeProfileController.to
                                    .postDependencyInformation();
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
                    SizedBox(height: 20),
                    BackToScreen(
                      text: "Skip",
                      filled: true,
                      arrowIcon: false,
                      onPressed: () {
                        Get.back();
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
