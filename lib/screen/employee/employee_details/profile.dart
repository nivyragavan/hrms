import 'package:dreamhrms/controller/common_controller.dart';
import 'package:dreamhrms/widgets/Custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:localization/localization.dart';
import 'package:skeleton_animation/skeleton_animation.dart';
import '../../../constants/colors.dart';
import '../../../controller/employee_details_controller/profile_controller.dart';
import '../../../controller/theme_controller.dart';
import '../../../services/provision_check.dart';
import '../../../widgets/common.dart';
import '../../../widgets/no_record.dart';
import '../edit_profile/edit_emergency.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero)
        .then((value) async => await ProfileController.to.getProfileList());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "profile",
                  color: AppColors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 20),
                employeeInformation(),
                SizedBox(height: 20),
                personalInformation(),
                SizedBox(height: 20),
               if (GetStorage().read('role') == "admin") emergencyContact(),
                if (GetStorage().read('role') == "admin") SizedBox(height: 20),
                if (GetStorage().read('role') == "admin")
                  dependenceInformation(),
                if (GetStorage().read('role') == "admin") SizedBox(height: 20),
                if (GetStorage().read('role') == "admin")
                  educationInformation(),
                if (GetStorage().read('role') == "admin") SizedBox(height: 20),
                if (GetStorage().read('role') == "admin") workInformation(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

employeeInformation() {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: "emp_information",
            color: AppColors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          ProfileController.to.showProfileList
              ? Skeleton(height: 20, width: 10)
              : ProfileController.to.profileModel?.data?.data != null
                  ? ProvisionsWithIgnorePointer(
                      provision: 'All Employees',
                      type: "create",
                      child: InkWell(
                          onTap: () {
                            print("Employee Information");
                            Get.toNamed('/EditEmployee',
                                arguments: "Edit_Employee_Information");
                          },
                          child: SvgPicture.asset(
                            "assets/icons/edit.svg",
                            color:
                                ThemeController.to.checkThemeCondition() == true
                                    ? AppColors.white
                                    : AppColors.black,
                          )),
                    )
                  : Container(),
        ],
      ),
      SizedBox(height: 20),
      Container(
        decoration: BoxDecoration(
            // color: ThemeController.to.checkThemeCondition() == true ? AppColors.black : AppColors.white,
            border: Border.all(
              color: AppColors.grey.withOpacity(0.3),
              // width: 1.0,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(14))),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: commonLoader(
            loader: ProfileController.to.showProfileList,
            length: 3,
            child: Column(
              children: [
                commonDataDisplay(
                    title1: "emp_id",
                    text1:
                        '${ProfileController.to.profileModel?.data?.data?.userUniqueId ?? "-"}',
                    title2: "department",
                    text2:
                        '${ProfileController.to.profileModel?.data?.data?.department?.departmentName ?? "-"}'),
                commonDataDisplay(
                    title1: "dob",
                    text1:
                        '${ProfileController.to.profileModel?.data?.data?.dateOfBirth ?? "-"}',
                    title2: "line_manager",
                    text2:
                        '${ProfileController.to.profileModel?.data?.data?.jobPosition?.lineManager ?? "-"}'),
                commonDataDisplay(
                    title1: "mail",
                    text1:
                        '${ProfileController.to.profileModel?.data?.data?.emailId ?? "-"}',
                    title2: "phone_number",
                    text2:
                        '${ProfileController.to.profileModel?.data?.data?.mobileNumber ?? "-"}'),
                commonSingleDataDisplay(
                    title1: "marital_status",
                    text1:
                        '${ProfileController.to.profileModel?.data?.data?.maritalStatus ?? "-"}',
                    titleFontSize: 11,
                    textFontSize: 13),
              ],
            ),
          ),
        ),
      )
    ],
  );
}

Widget educationInformation() {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: "education_information",
            color: AppColors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          // ProfileController.to.showProfileList
          //     ? Skeleton(height: 20, width: 10)
          //     : EditProvision(
          //   provision: 'All Employees',
          //   type: "create",
          //       child: InkWell(
          //           onTap: () {
          //             Get.to(() => EditEducation());
          //           },
          //           child: SvgPicture.asset("assets/icons/edit.svg")
          // ),
          //     )
        ],
      ),
      SizedBox(height: 20),
      Container(
        decoration: BoxDecoration(
            // color: AppColors.white,
            border: Border.all(
              color: AppColors.grey.withOpacity(0.3),
              // width: 1.0,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(14))),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: ProfileController.to.showProfileList == true
              ? skeleton(1)
              : ProfileController.to.profileModel?.data?.data
                          ?.educationalDetails?.length ==
                      0
                  ? NoRecord()
                  : ListView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: ProfileController.to.profileModel?.data?.data
                              ?.educationalDetails?.length ??
                          0,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                  textAlign: TextAlign.start,
                                  text:
                                      "${"education_information"} ${index + 1}",
                                  color: AppColors.blue,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                              SizedBox(height: 10),
                              CustomText(
                                  text:
                                      '${ProfileController.to.profileModel?.data?.data?.educationalDetails?[index].degree}',
                                  color: AppColors.secondaryColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400),
                              SizedBox(height: 5),
                              CustomText(
                                  text:
                                      '${ProfileController.to.profileModel?.data?.data?.educationalDetails?[index].collegeName}',
                                  color: AppColors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  SvgPicture.asset("assets/icons/book.svg"),
                                  SizedBox(width: 5),
                                  CustomText(
                                      text:
                                          '${ProfileController.to.profileModel?.data?.data?.educationalDetails?[index].gpa}',
                                      color: AppColors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                  SizedBox(width: 15),
                                  SvgPicture.asset("assets/icons/calendar.svg"),
                                  SizedBox(width: 5),
                                  CustomText(
                                      text:
                                          '${ProfileController.to.profileModel?.data?.data?.educationalDetails?[index].startYear?.year} - ${ProfileController.to.profileModel?.data?.data?.educationalDetails?[index].endYear?.year}',
                                      color: AppColors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ],
                              )
                            ],
                          ),
                        );
                      }),
        ),
      ),
    ],
  );
}

Widget workInformation() {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: "work_history",
            color: AppColors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          // SvgPicture.asset("assets/icons/edit.svg"),
        ],
      ),
      SizedBox(height: 20),
      Container(
        decoration: BoxDecoration(
            // color: AppColors.white,
            border: Border.all(
              color: AppColors.grey.withOpacity(0.3),
              // width: 1.0,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(14))),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: commonLoader(
            length: 1,
            loader: ProfileController.to.showProfileList,
            child: ProfileController
                        .to.profileModel?.data?.data?.positionLogs?.length ==
                    0
                ? NoRecord()
                : ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: ProfileController.to.profileModel?.data?.data
                            ?.positionLogs?.length ??
                        0,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                                text:
                                    "${ProfileController.to.profileModel?.data?.data?.positionLogs?[index].position?.positionName}",
                                color: AppColors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                            SizedBox(height: 5),
                            CustomText(
                                text:
                                    "${ProfileController.to.profileModel?.data?.data?.company?.firstName} ${ProfileController.to.profileModel?.data?.data?.company?.lastName}",
                                color: AppColors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                SvgPicture.asset("assets/icons/calendar.svg"),
                                SizedBox(width: 5),
                                CustomText(
                                    text:
                                        "${ProfileController.to.profileModel?.data?.data?.positionLogs?[index].position?.createdAt?.day}/"
                                        "${ProfileController.to.profileModel?.data?.data?.positionLogs?[index].position?.createdAt?.month}/"
                                        "${ProfileController.to.profileModel?.data?.data?.positionLogs?[index].position?.createdAt?.year}",
                                    color: AppColors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                                SizedBox(width: 15),
                                SvgPicture.asset("assets/icons/location.svg"),
                                SizedBox(width: 5),
                                CustomText(
                                    text:
                                        '${ProfileController.to.profileModel?.data?.data?.company?.address}',
                                    color: AppColors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ],
                            )
                          ],
                        ),
                      );
                    }),
          ),
        ),
      )
    ],
  );
}

Widget dependenceInformation() {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: "depend_information",
            color: AppColors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          // ProfileController.to.showProfileList
          //     ? Skeleton(height: 20, width: 10)
          //     : EditProvision(
          //   provision: 'All Employees',
          //   type: "create",
          //       child: InkWell(
          //           onTap: () {
          //             PersonalController.to.userId =
          //                 '${ProfileController.to.profileModel?.data?.data?.id ?? ""}';
          //             Get.to(() => EditDependency());
          //           },
          //           child: SvgPicture.asset("assets/icons/edit.svg")
          // ),
          //     )
        ],
      ),
      SizedBox(height: 20),
      Container(
        decoration: BoxDecoration(
            // color: AppColors.white,
            border: Border.all(
              color: AppColors.grey.withOpacity(0.3),
              // width: 1.0,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(14))),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: ProfileController.to.showProfileList == true
              ? skeleton(2)
              : ProfileController
                          .to.profileModel?.data?.data?.dependents!.length ==
                      0
                  ? NoRecord()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: ProfileController.to.profileModel?.data
                                  ?.data?.dependents?.length ??
                              0,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                      textAlign: TextAlign.start,
                                      text: "${"depend_1"} ${index + 1}",
                                      color: AppColors.blue,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                  SizedBox(height: 10),
                                  commonDataDisplay(
                                      title1: "name",
                                      text1:
                                          '${ProfileController.to.profileModel?.data?.data?.dependents?[index].firstName}',
                                      title2: "relationship",
                                      text2:
                                          '${ProfileController.to.profileModel?.data?.data?.dependents?[index].relationship}'),
                                  commonDataDisplay(
                                      title1: "mail",
                                      text1:
                                          '${ProfileController.to.profileModel?.data?.data?.dependents?[index].emailAddress}',
                                      title2: "phone_number",
                                      text2:
                                          '${ProfileController.to.profileModel?.data?.data?.dependents?[index].phoneNumber}'),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
        ),
      ),
    ],
  );
}

emergencyContact() async {
  var emergency =
      await CommonController.to.getTranslateKeyword("emergency_contact");
  print("emergency $emergency");
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: "emergency_contact",
            color: AppColors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          // ProfileController.to.showProfileList
          //     ? Skeleton(height: 20, width: 10)
          //     : ProfileController.to.profileModel?.data?.data
          //                 ?.emergencyContactDetails !=
          //             null
          //         ? ProvisionsWithIgnorePointer(
          //             provision: 'All Employees',
          //             type: "create",
          //             child: InkWell(
          //                 onTap: () {
          //                   Get.to(() => EditEmergency());
          //                 },
          //                 child: SvgPicture.asset("assets/icons/edit.svg")),
          //           )
          //         : Container(),
        ],
      ),
      SizedBox(height: 20),
      Container(
        decoration: BoxDecoration(
            // color: AppColors.white,
            border: Border.all(
              color: AppColors.grey.withOpacity(0.3),
              // width: 1.0,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(14))),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: commonLoader(
            length: 2,
            loader: ProfileController.to.showProfileList,
            child: ProfileController.to.profileModel?.data?.data
                        ?.emergencyContactDetails?.length ==
                    0
                ? NoRecord()
                : ListView.builder(
                    itemCount: ProfileController.to.profileModel?.data?.data
                            ?.emergencyContactDetails?.length ??
                        0,
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                                text: "${"emergency_contact"} ${index + 1}",
                                color: AppColors.blue,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                            SizedBox(height: 10),
                            commonDataDisplay(
                                title1: "name",
                                text1:
                                    '${ProfileController.to.profileModel?.data?.data?.emergencyContactDetails?[index].firstName}',
                                title2: "relationship",
                                text2:
                                    '${ProfileController.to.profileModel?.data?.data?.emergencyContactDetails?[index].relationship}'),
                            commonDataDisplay(
                                title1: "mail",
                                text1:
                                    '${ProfileController.to.profileModel?.data?.data?.emergencyContactDetails?[index].emailAddress}',
                                title2: "phone_number",
                                text2:
                                    '${ProfileController.to.profileModel?.data?.data?.emergencyContactDetails?[index].phoneNumber}'),
                          ],
                        ),
                      );
                    }),
          ),
        ),
      ),
    ],
  );
}

personalInformation() {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: "personal_information",
            color: AppColors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          ProfileController.to.showProfileList
              ? Skeleton(height: 20, width: 10)
              : ProfileController.to.profileModel?.data?.data != null
                  ? ProvisionsWithIgnorePointer(
                      provision: 'All Employees',
                      type: "create",
                      child: InkWell(
                          onTap: () async {
                            Get.toNamed('/EditPersonal',
                                arguments: "Edit_Personal_Information");
                          },
                          child: SvgPicture.asset("assets/icons/edit.svg")),
                    )
                  : Container(),
        ],
      ),
      SizedBox(height: 20),
      Container(
        decoration: BoxDecoration(
            // color: AppColors.white,
            border: Border.all(
              color: AppColors.grey.withOpacity(0.3),
              // width: 1.0,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(14))),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: commonLoader(
            length: 4,
            loader: ProfileController.to.showProfileList,
            child: Column(
              children: [
                commonDataDisplay(
                    title1: "grade",
                    text1:
                        '${ProfileController.to.profileModel?.data?.data?.jobPosition?.position?.grade?.gradeName ?? "-"}',
                    title2: "shift",
                    text2:
                        '${ProfileController.to.profileModel?.data?.data?.shedules?.shiftName ?? "-"}'),
                commonDataDisplay(
                    title1: "shift_time",
                    text1:
                        '${ProfileController.to.profileModel?.data?.data?.personalInfo?.shiftTime ?? "-"}',
                    title2: "emp_type",
                    text2:
                        '${ProfileController.to.profileModel?.data?.data?.employeeType?.type ?? "-"}'),
                commonDataDisplay(
                    title1: "status",
                    text1:
                        '${ProfileController.to.profileModel?.data?.data?.status == 1 ? "active" : "in_active"}',
                    title2: "blood",
                    text2:
                        '${ProfileController.to.profileModel?.data?.data?.bloodGroup ?? "-"}'),
                commonDataDisplay(
                    title1: "marital_status",
                    text1:
                        '${ProfileController.to.profileModel?.data?.data?.maritalStatus ?? "-"}',
                    title2: "nationality",
                    text2:
                        '${ProfileController.to.profileModel?.data?.data?.country?.name ?? "-"}'),
                commonSingleDataDisplay(
                  title1: "address",
                  text1:
                      '${ProfileController.to.profileModel?.data?.data?.city?.name ?? "-"}',
                  titleFontSize: 11,
                  textFontSize: 13,
                ),
              ],
            ),
          ),
        ),
      )
    ],
  );
}

commonLoader(
    {dynamic child,
    loader = false,
    required int length,
    bool? singleRow,
    double? width,
    double? height}) {
  return loader == true
      ? skeleton(length, singleRow: singleRow, width: width, height: height)
      : child;
}

skeleton(int length, {bool? singleRow, double? width, double? height = 30}) {
  return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: length,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: singleRow == true
                  ? Skeleton(height: 30, width: Get.width)
                  : Row(
                      children: [
                        Skeleton(width: Get.width * 0.40, height: 35),
                        SizedBox(width: 10),
                        Skeleton(width: Get.width * 0.40, height: 35),
                      ],
                    ),
            )
          ],
        );
      });
}
