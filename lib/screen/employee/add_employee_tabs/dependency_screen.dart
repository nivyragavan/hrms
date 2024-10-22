import 'package:dreamhrms/controller/common_controller.dart';
import 'package:dreamhrms/screen/employee/employee_details/profile.dart';
import 'package:dreamhrms/widgets/no_record.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';

import '../../../constants/colors.dart';
import '../../../controller/edit_employee_profile_controller.dart';
import '../../../controller/employee/dependancy_controller.dart';
import '../../../controller/employee/employee_controller.dart';
import '../../../controller/employee/personal_controller.dart';
import '../../../controller/employee_details_controller/profile_controller.dart';
import '../../../controller/theme_controller.dart';
import '../../../model/add_employee/dependent_model.dart';
import '../../../widgets/Custom_rich_text.dart';
import '../../../widgets/Custom_text.dart';
import '../../../widgets/back_to_screen.dart';
import '../../../widgets/common.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/common_searchable_dropdown/MainCommonSearchableDropDown.dart';
import '../../../widgets/common_textformfield.dart';
import '../add_employee_screen.dart';

class DependencyScreen extends StatefulWidget {
  DependencyScreen({super.key});

  @override
  State<DependencyScreen> createState() => _DependencyScreenState();
}

class _DependencyScreenState extends State<DependencyScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    DependencyController.to.dependantLoader = true;
    Future.delayed(Duration(seconds: 2)).then((value) async {
      DependencyController.to.personalLoader =
          EmployeeController.to.isEmployee == "" ? false : true;
      await PersonalController.to.getMasterList();
      DependencyController.to.dependantModel = DependantModel(dependant: []);
      EmployeeController.to.isEmployee == "Edit"
          ? await EditEmployeeProfileController.to.setDependencyInformation(
              ProfileController.to.profileModel?.data?.data)
          : DependencyController.to.dependantModel?.dependant.insert(
              0,
              Dependant(
                  firstName: "",
                  lastName: "",
                  relationship: "",
                  phoneNumber: "",
                  emailAddress: "",
                  gender: ""));
      DependencyController.to.dependantLoader = false;
      DependencyController.to.personalLoader = false;
    });
    return Scaffold(
        
        body: GestureDetector(
          // onTap: common
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Obx(
                () => Padding(
                  padding: const EdgeInsets.all(20),
                  child: commonLoader(
                    length: MediaQuery.of(context).size.height.toInt(),
                    singleRow: true,
                    loader: DependencyController.to.dependantLoader,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                                text: 'depend_information',
                                color: AppColors.blue,
                                fontSize: 13,
                                fontWeight: FontWeight.w400),
                            InkWell(
                              onTap: () {
                                DependencyController.to.dependantLoader = true;
                                DependencyController
                                    .to.dependantModel?.dependant
                                    .insert(
                                        DependencyController.to.dependantModel!
                                            .dependant.length,
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
                        const SizedBox(
                          height: 15,
                        ),
                        DependencyController
                                    .to.dependantModel?.dependant.length ==
                                0
                            ? NoRecord()
                            : ListView.builder(
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
                                        color: ThemeController.to.checkThemeCondition() == true ? AppColors.black : AppColors.lightGrey,
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
                                                    DependencyController.to
                                                        .dependantLoader = true;
                                                    DependencyController
                                                        .to
                                                        .dependantModel
                                                        ?.dependant
                                                        .removeAt(index);
                                                    DependencyController.to
                                                            .dependantLoader =
                                                        false;
                                                  },
                                                  child: Icon(
                                                    Icons.delete_outline,
                                                    color: AppColors.black,
                                                  )),
                                            ],
                                          ),
                                        CustomRichText(
                                            textAlign: TextAlign.left,
                                            text: 'first_name',
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
                                          fillColor: ThemeController.to.checkThemeCondition() == true ? AppColors.black : AppColors.white,
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
                                            DependencyController
                                                .to
                                                .dependantModel
                                                ?.dependant[index]
                                                .firstName = value;
                                          },
                                        ),
                                        SizedBox(height: 15),
                                        CustomRichText(
                                            textAlign: TextAlign.left,
                                            text: 'last_name',
                                            color: AppColors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            textSpan: '*',
                                            textSpanColor: AppColors.red),
                                        SizedBox(height: 15),
                                        CommonTextFormField(
                                          controller: TextEditingController(
                                              text: DependencyController
                                                  .to
                                                  .dependantModel
                                                  ?.dependant[index]
                                                  .lastName),
                                          isBlackColors: true,
                                          filled: true,
                                          fillColor: ThemeController.to.checkThemeCondition() == true ? AppColors.black : AppColors.white,
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
                                            DependencyController
                                                .to
                                                .dependantModel
                                                ?.dependant[index]
                                                .lastName = value;
                                          },
                                        ),
                                        SizedBox(height: 15),
                                        CustomRichText(
                                            textAlign: TextAlign.left,
                                            text: 'gender',
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
                                            filled: true,
                                            fillColor: ThemeController.to.checkThemeCondition() == true ? AppColors.black : AppColors.white,
                                            isRequired: true,
                                            error: 'gender',
                                            items: PersonalController
                                                .to
                                                .employeeMasterModel
                                                ?.data?[0]
                                                .gender
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
                                        SizedBox(height: 15),
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
                                            filled: true,
                                            fillColor: ThemeController.to.checkThemeCondition() == true ? AppColors.black : AppColors.white,
                                            isRequired: true,
                                            error: 'relationship',
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
                                        SizedBox(height: 15),
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
                                          fillColor: ThemeController.to.checkThemeCondition() == true ? AppColors.black : AppColors.white,
                                          keyboardType: TextInputType.phone,
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
                                          onChanged: (value) {
                                            DependencyController
                                                .to
                                                .dependantModel
                                                ?.dependant[index]
                                                .phoneNumber = value;
                                          },
                                        ),
                                        SizedBox(height: 15),
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
                                          fillColor: ThemeController.to.checkThemeCondition() == true ? AppColors.black : AppColors.white,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          // validator: (String? data) {
                                          //   if (data == "" || data == null) {
                                          //     return "required_email";
                                          //   } else if(!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(data)){
                                          //     return "required_email_format";
                                          //   }else {
                                          //     return null;
                                          //   }
                                          // },
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
                        SizedBox(height: 20),
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
                                onPressed: () async{
                                  if (formKey.currentState!.validate()) {
                                    CommonController.to.buttonLoader = true;
                                    EmployeeController.to.isEmployee == "Edit"
                                        ? await EditEmployeeProfileController.to
                                            .postDependencyInformation(
                                                type: "EmployeeEdit")
                                        : await DependencyController.to
                                            .postDependency();
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
                            Get.to(() => AddEmployeeScreen(selectedIndex: 3));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
