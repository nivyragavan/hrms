import 'dart:convert';
import 'dart:io';
import 'package:dreamhrms/screen/employee/employee_details/profile.dart';
import 'package:dreamhrms/widgets/no_record.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:localization/localization.dart';
import 'package:skeleton_animation/skeleton_animation.dart';
import '../../../constants/colors.dart';
import '../../../controller/common_controller.dart';
import '../../../controller/department/add_department_controller.dart';
import '../../../controller/edit_employee_profile_controller.dart';
import '../../../controller/employee/dependancy_controller.dart';
import '../../../controller/employee/employee_controller.dart';
import '../../../controller/employee/personal_controller.dart';
import '../../../controller/employee_details_controller/profile_controller.dart';
import '../../../controller/leave_controller.dart';
import '../../../controller/signup_controller.dart';
import '../../../controller/theme_controller.dart';
import '../../../model/add_employee/emergency_model.dart';
import '../../../services/provision_check.dart';
import '../../../widgets/Custom_rich_text.dart';
import '../../../widgets/Custom_text.dart';
import '../../../widgets/back_to_screen.dart';
import '../../../widgets/common.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/common_datePicker.dart';
import '../../../widgets/common_searchable_dropdown/MainCommonSearchableDropDown.dart';
import '../../../widgets/common_textformfield.dart';
import '../add_employee_screen.dart';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({super.key});

  @override
  State<PersonalScreen> createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen>  {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    PersonalController.to.personalLoader = true;
    Future.delayed(Duration(milliseconds: 1)).then((value) async {
      await PersonalController.to.clearValues();
      debugPrint("IsEmployee ${EmployeeController.to.isEmployee} ");
      GetStorage().remove("user_id");
      GetStorage().remove("emp_id");
      PersonalController.to.contactModel?.emergency = [];
      PersonalController.to.contactModel = EmergencyContactModel(emergency: []);
      PersonalController.to.contactModel?.emergency.clear();
      await PersonalController.to.getMasterList();
      await SignupController.to.getCountryList();
      PersonalController.to.emergencyLoader = true;
      PersonalController.to.emeregencyContactCount = 0;

      await EmployeeController.to.isEmployee == "Edit"
          ? await PersonalController.to.setControllerPersonalInformation(
              ProfileController.to.profileModel?.data?.data)
          : PersonalController.to.contactModel?.emergency.insert(
              PersonalController.to.emeregencyContactCount,
              EmergencyContact(
                relationEmailAddress: "",
                relationFirstName: "",
                relationLastName: "",
                phoneNumber: "",
                relationship: "",
              ));
      if (EmployeeController.to.isEmployee == "Edit")
        await EditEmployeeProfileController.to.setEmergencyInformation(
            ProfileController.to.profileModel?.data?.data);
      PersonalController.to.emergencyLoader = false;
      PersonalController.to.personalLoader = false;
    });
    return GestureDetector(
      onTap: commonTapHandler,
      child: Scaffold(
        
        resizeToAvoidBottomInset: true,
        body: ProvisionsWithIgnorePointer(
          provision:'All Employees',type:"create",
          child: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Obx(
                () => SingleChildScrollView(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                            text: 'basic_information',
                            color: AppColors.blue,
                            fontSize: 13,
                            fontWeight: FontWeight.w400),
                        const SizedBox(
                          height: 20,
                        ),

                        CommonController.to.imageLoader ||
                                PersonalController.to.personalLoader
                            ? Skeleton(width: 70, height: 70)
                            : Row(children: [
                                Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.grey.withAlpha(40),
                                      ),
                                      borderRadius: BorderRadius.circular(14),
                                      // image: DecorationImage(
                                      //     fit: BoxFit.cover,
                                      //     image: NetworkImage(
                                      //         '${commonNetworkImageDisplay('${PersonalController.to.imageController.text.toString()}')}',
                                      //       )
                                      // ),
                                    ),
                                    child: AddDepartmentController.to
                                                .isNetworkImage(
                                                    PersonalController
                                                        .to
                                                        .imageController
                                                        .text) &&
                                            PersonalController
                                                    .to.imageController.text !=
                                                ""
                                        ? Image.network(
                                            '${commonNetworkImageDisplay('${PersonalController.to.imageController.text.toString()}')}',
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (BuildContext? context,
                                                    Object? exception,
                                                    StackTrace? stackTrace) {
                                              return Image.asset(
                                                "assets/images/user.jpeg",
                                                fit: BoxFit.contain,
                                              );
                                            },
                                          )
                                        : PersonalController
                                                    .to.imageController.text !=
                                                ""
                                            ? Image.file(File(
                                                '${PersonalController.to.imageController.text.toString()}'))
                                            : Image.asset(
                                                "assets/images/user.jpeg",
                                                fit: BoxFit.contain,
                                              )),
                                SizedBox(
                                  width: 14,
                                ),
                                InkWell(
                                  onTap: () async {
                                    showImagePicker(context,
                                        controller: PersonalController
                                            .to.imageController,
                                        showGallery: true,
                                        showCamera: false);
                                  },
                                  child: Container(
                                    width: Get.width * 0.50,
                                    height: 40,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: AppColors.lightGrey)),
                                    child: CustomText(
                                        text: 'change_profile',
                                        color: AppColors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              ]),
                        SizedBox(height: 30),
                        CustomRichText(
                            textAlign: TextAlign.left,
                            text: 'first_name',
                            color: AppColors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            textSpan: '*',
                            textSpanColor: AppColors.red),
                        SizedBox(height: 10),
                        PersonalController.to.personalLoader
                            ? Skeleton(width: Get.width, height: 35)
                            : CommonTextFormField(
                                controller:
                                    DependencyController.to.firstNameController,
                                isBlackColors: true,
                                keyboardType: TextInputType.name,
                                validator: (String? data) {
                                  if (data == "" || data == null) {
                                    return "first_name_validator";
                                  } else {
                                    return null;
                                  }
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
                        SizedBox(height: 10),
                        PersonalController.to.personalLoader
                            ? Skeleton(width: Get.width, height: 35)
                            : CommonTextFormField(
                                controller:
                                    DependencyController.to.lastNameController,
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
                        SizedBox(height: 15),
                        CustomRichText(
                            textAlign: TextAlign.left,
                            text: 'email',
                            color: AppColors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            textSpan: '*',
                            textSpanColor: AppColors.red),
                        SizedBox(height: 10),
                        PersonalController.to.personalLoader
                            ? Skeleton(width: Get.width, height: 35)
                            : CommonTextFormField(
                                controller:
                                    DependencyController.to.emailController,
                                isBlackColors: true,
                                keyboardType: TextInputType.emailAddress,
                                validator: (String? data) {
                                  if (data == "" || data == null) {
                                    return "required_email";
                                  } else if (!RegExp(
                                          r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                                      .hasMatch(data)) {
                                    return "required_email_format";
                                  } else {
                                    return null;
                                  }
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
                        PersonalController.to.personalLoader
                            ? Skeleton(width: Get.width, height: 35)
                            : PersonalController.to.masterLoader == true
                                ? Skeleton(width: Get.width, height: 30)
                                : MainSearchableDropDown(
                                    title: 'gender',
                                    isRequired: true,
                                    error: "gender",
                                    items: PersonalController
                                        .to.employeeMasterModel?.data?[0].gender
                                        ?.map((status) {
                                      return {"gender": status};
                                    }).toList(),
                                    controller: DependencyController
                                        .to.genderController,
                                    onChanged: (data) {}),
                        SizedBox(height: 10),
                        CustomRichText(
                            textAlign: TextAlign.left,
                            text:'marital_status',
                            color: AppColors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            textSpan: '*',
                            textSpanColor: AppColors.red),
                        PersonalController.to.personalLoader
                            ? Skeleton(width: Get.width, height: 35)
                            : PersonalController.to.masterLoader == true
                                ? Skeleton(width: Get.width, height: 30)
                                : MainSearchableDropDown(
                                    title: 'status',
                                    isRequired: true,
                                    error:'marital_status',
                                    items: PersonalController
                                        .to
                                        .employeeMasterModel
                                        ?.data?[0]
                                        .maritalStatus
                                        ?.map((status) {
                                      return {"status": status};
                                    }).toList(),
                                    controller: DependencyController
                                        .to.maritalStatusController,
                                    onChanged: (data) {}),
                        SizedBox(height: 10),
                        CustomRichText(
                            textAlign: TextAlign.left,
                            text: 'dob',
                            color: AppColors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            textSpan: '*',
                            textSpanColor: AppColors.red),
                        SizedBox(height: 10),
                        PersonalController.to.personalLoader
                            ? Skeleton(width: Get.width, height: 35)
                            : DatePicker(
                                controller: DependencyController.to.dob,
                                focusedBorder:
                                    BorderSide(color: Colors.grey, width: 1.7),
                                disabledBorder:
                                    BorderSide(color: Colors.black, width: 1),
                                // hintText: "YYYY-MM-DD",
                                hintText: GetStorage().read('date_format'),
                                dateFormat: GetStorage().read('date_format'),
                                validator: (String? data) {
                                  if (data == "" || data == null) {
                                    return "required_date_of_birth";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                        SizedBox(height: 15),
                        CustomRichText(
                            textAlign: TextAlign.left,
                            text: 'country',
                            color: AppColors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            textSpan: '*',
                            textSpanColor: AppColors.red),
                        PersonalController.to.personalLoader
                            ? Skeleton(width: Get.width, height: 35)
                            : SignupController.to.countryLoader
                                ? Skeleton(width: Get.width, height: 30)
                                : MainSearchableDropDown(
                                    title: 'name',
                                    isRequired: true,
                                    error: 'country',
                                    items: SignupController
                                        .to.countryModel?.data
                                        ?.map((datum) => datum.toJson())
                                        .toList(),
                                    controller: DependencyController
                                        .to.nationalityController,
                                    onChanged: (data) async {
                                      DependencyController
                                          .to
                                          .nationalityControllerId
                                          .text = data['id'].toString();
                                      await PersonalController.to.getStateList(
                                          DependencyController
                                              .to.nationalityControllerId.text);
                                    }),
                        SizedBox(height: 10),
                        CustomRichText(
                            textAlign: TextAlign.left,
                            text: 'state',
                            color: AppColors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            textSpan: '*',
                            textSpanColor: AppColors.red),
                        PersonalController.to.personalLoader
                            ? Skeleton(width: Get.width, height: 35)
                            : PersonalController.to.stateLoader
                                ? Skeleton(width: Get.width, height: 30)
                                : MainSearchableDropDown(
                                    title: 'name',
                                    isRequired: true,
                                    error: 'state',
                                    items: PersonalController
                                        .to.stateModel?.data
                                        ?.map((datum) => datum.toJson())
                                        .toList(),
                                    controller:
                                        DependencyController.to.stateController,
                                    onChanged: (data) async {
                                      DependencyController.to.stateControllerId
                                          .text = data['id'].toString();
                                      print(
                                          "State ${DependencyController.to.nationalityController.text}"
                                          "${DependencyController.to.stateController.text}"
                                          "${DependencyController.to.cityController.text}");
                                      await PersonalController.to.getCityList(
                                          DependencyController
                                              .to.stateControllerId.text);
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
                        PersonalController.to.personalLoader
                            ? Skeleton(width: Get.width, height: 35)
                            : PersonalController.to.cityLoader
                                ? Skeleton(width: Get.width, height: 30)
                                : MainSearchableDropDown(
                                    title: 'name',
                                    isRequired: true,
                                    error: 'city',
                                    items: PersonalController.to.cityModel?.data
                                        ?.map((datum) => datum.toJson())
                                        .toList(),
                                    controller:
                                        DependencyController.to.cityController,
                                    onChanged: (data) {
                                      DependencyController.to.cityControllerId
                                          .text = data['id'].toString();
                                      print(
                                          "city ${DependencyController.to.nationalityController.text}"
                                          "${DependencyController.to.stateController.text}"
                                          "${DependencyController.to.cityController.text}");
                                    }),
                        SizedBox(height: 15),
                        CustomRichText(
                            textAlign: TextAlign.left,
                            text: 'personal_mail',
                            color: AppColors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            textSpan: '*',
                            textSpanColor: AppColors.red),
                        SizedBox(height: 10),
                        PersonalController.to.personalLoader
                            ? Skeleton(width: Get.width, height: 35)
                            : CommonTextFormField(
                                controller: DependencyController
                                    .to.personalEmailController,
                                isBlackColors: true,
                                keyboardType: TextInputType.emailAddress,
                                validator: (String? data) {
                                  if (data == "" || data == null) {
                                    return "required_email";
                                  } else if (!RegExp(
                                          r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                                      .hasMatch(data)) {
                                    return "required_email_format";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                        SizedBox(height: 15),
                        CustomRichText(
                            textAlign: TextAlign.left,
                            text: 'blood',
                            color: AppColors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            textSpan: '*',
                            textSpanColor: AppColors.red),
                        PersonalController.to.personalLoader
                            ? Skeleton(width: Get.width, height: 35)
                            : PersonalController.to.masterLoader == true
                                ? Skeleton(width: Get.width, height: 30)
                                : MainSearchableDropDown(
                                    title: 'blood',
                                    isRequired: true,
                                    error: 'blood',
                                    items: PersonalController
                                        .to
                                        .employeeMasterModel
                                        ?.data?[0]
                                        .bloodGroup
                                        ?.map((status) {
                                      return {"blood": status};
                                    }).toList(),
                                    controller:
                                        DependencyController.to.bloodController,
                                    onChanged: (data) {}),
                        SizedBox(height: 15),
                        CustomRichText(
                            textAlign: TextAlign.left,
                            text: 'personal_phone_number',
                            color: AppColors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            textSpan: '*',
                            textSpanColor: AppColors.red),
                        SizedBox(height: 10),
                        PersonalController.to.personalLoader
                            ? Skeleton(width: Get.width, height: 35)
                            : CommonTextFormField(
                                controller: DependencyController
                                    .to.phoneNumberController,
                                isBlackColors: true,
                                // filled: true,
                                // fillColor: AppColors.white,
                                keyboardType: TextInputType.phone,
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
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                                text: 'emergency_information',
                                color: AppColors.blue,
                                fontSize: 13,
                                fontWeight: FontWeight.w400),
                            InkWell(
                              onTap: () {
                                PersonalController.to.emergencyLoader = true;
                                PersonalController.to.emeregencyContactCount =
                                    PersonalController
                                            .to.emeregencyContactCount +
                                        1;
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
                                PersonalController.to.emergencyLoader = false;
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
                          height: 20,
                        ),
                        commonLoader(
                          length: MediaQuery.of(context).size.height.toInt(),
                          loader: PersonalController.to.emergencyLoader,
                          child: PersonalController
                                      .to.contactModel?.emergency.length ==
                                  0
                              ? NoRecord()
                              : ListView.builder(
                                  itemCount: PersonalController
                                          .to.contactModel?.emergency.length ??
                                      0,
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 10),
                                      width: Get.width,
                                      padding: EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        color: ThemeController.to.checkThemeCondition() == true ? AppColors.black : AppColors.lightGrey,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
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
                                                    PersonalController.to.emergencyLoader=true;
                                                    PersonalController.to
                                                        .contactModel?.emergency
                                                        .removeAt(index);
                                                    PersonalController.to
                                                            .emeregencyContactCount =
                                                        PersonalController.to
                                                                .emeregencyContactCount -
                                                            1;
                                                    PersonalController.to.emergencyLoader=false;
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
                                              text: 'first_name',
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
                                            fillColor: ThemeController.to.checkThemeCondition() == true ? AppColors.black : AppColors.white,
                                            keyboardType: TextInputType.name,
                                            onChanged: (value) {
                                              PersonalController
                                                  .to
                                                  .contactModel
                                                  ?.emergency[index]
                                                  .relationFirstName = value;
                                            },
                                            validator: (String? data) {
                                              if (data == "" || data == null) {
                                              return "first_name_validator";
                                              } else {
                                                return null;
                                              }
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
                                            fillColor: ThemeController.to.checkThemeCondition() == true ? AppColors.black : AppColors.white,
                                            keyboardType: TextInputType.name,
                                            onChanged: (value) {
                                              PersonalController
                                                  .to
                                                  .contactModel
                                                  ?.emergency[index]
                                                  .relationLastName = value;
                                            },
                                            validator: (String? data) {
                                              if (data == "" || data == null) {
                                                return "last_name_validator";
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                          SizedBox(height: 15),
                                          CustomRichText(
                                              textAlign: TextAlign.left,
                                              text: 'relationship',
                                              color: AppColors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              textSpan: '*',
                                              textSpanColor: AppColors.red),
                                          PersonalController.to.masterLoader ==
                                                      true ||
                                                  PersonalController
                                                      .to.emergencyLoader ||
                                                  PersonalController
                                                      .to.personalLoader
                                              ? Skeleton(
                                                  width: Get.width, height: 30)
                                              : MainSearchableDropDown(
                                                  title: 'relationship',
                                                  isRequired: true,
                                                  error: "relationship",
                                                  filled: true,
                                                  fillColor: ThemeController.to.checkThemeCondition() == true ? AppColors.black : AppColors.white,
                                                  items: PersonalController
                                                      .to
                                                      .employeeMasterModel
                                                      ?.data?[0]
                                                      .relationship
                                                      ?.map((status) {
                                                    return {
                                                      "relationship": status
                                                    };
                                                  }).toList(),
                                                  controller:
                                                      TextEditingController(
                                                          text:
                                                              PersonalController
                                                                  .to
                                                                  .contactModel!
                                                                  .emergency[
                                                                      index]
                                                                  .relationship),
                                                  onChanged: (data) {
                                                    print(
                                                        "data emergency $data");
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
                                            fillColor: ThemeController.to.checkThemeCondition() == true ? AppColors.black : AppColors.white,
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
                                          SizedBox(height: 15),
                                          CustomRichText(
                                              textAlign: TextAlign.left,
                                             text: 'email',
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
                                                    .relationEmailAddress),
                                            isBlackColors: true,
                                            filled: true,
                                            fillColor: ThemeController.to.checkThemeCondition() == true ? AppColors.black : AppColors.white,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            onChanged: (value) {
                                              PersonalController
                                                  .to
                                                  .contactModel
                                                  ?.emergency[index]
                                                  .relationEmailAddress = value;
                                            },
                                            validator: (String? data) {
                                              if (data == "" || data == null) {
                                                return "required_email";
                                              } else if (!RegExp(
                                                      r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                                                  .hasMatch(data)) {
                                                return "required_email_format";
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
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
                                    EmployeeController.to.isEmployee != "Edit"
                                        ?await PersonalController.to
                                            .postPersonalDetails()
                                        : await PersonalController.to.editEmployee();
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
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

