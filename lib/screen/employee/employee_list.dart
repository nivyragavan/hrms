import 'package:dreamhrms/constants/colors.dart';
import 'package:dreamhrms/controller/employee/employee_controller.dart';
import 'package:dreamhrms/controller/theme_controller.dart';
import 'package:dreamhrms/screen/employee/add_employee_screen.dart';
import 'package:dreamhrms/screen/employee/employee_offboarding.dart';
import 'package:dreamhrms/widgets/Custom_rich_text.dart';
import 'package:dreamhrms/widgets/Custom_text.dart';
import 'package:dreamhrms/widgets/no_record.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:localization/localization.dart';
import 'package:skeleton_animation/skeleton_animation.dart';
import '../../controller/employee/personal_controller.dart';
import '../../controller/employee_details_controller/profile_controller.dart';
import '../../services/provision_check.dart';
import '../../widgets/common.dart';
import 'employee_details.dart';

class EmployeeList extends StatelessWidget {
  const EmployeeList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      EmployeeController.to.isLoading = true;
      EmployeeController.to.isActive = false;
      await EmployeeController.to.getEmployeeList();
    });
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: CustomText(
              text: "employees",
              color: AppColors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.start),
        ),
        actions: [
          Obx(() {
            return EmployeeController.to.isLoading == true
                ? SizedBox()
                : TextButton(
                    onPressed: () {
                      EmployeeController.to.isActive =
                          !EmployeeController.to.isActive;
                      EmployeeController.to.getEmployeeList();
                    },
                    child: CustomRichText(
                      text: EmployeeController.to.isActive
                          ? "active"
                          : "archived",
                      color: AppColors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.left,
                      textSpan: EmployeeController.to.isActive
                          ? "(${EmployeeController.to.activeCount})"
                          : "(${EmployeeController.to.inActiveCount})",
                      textSpanColor: AppColors.blue,
                      textSpanFontSize: 16,
                      textSpanFontWeight: FontWeight.bold,
                    ));
          })
        ],
      ),
      body: ViewProvisionedWidget(
        provision: "All Employees",
        type: "view",
        child: Obx(
          () => EmployeeController.to.isLoading == true
              ? skeleton(context)
              :
          EmployeeController
              .to.employeeListModel?.code.toString()=="500"?ServerError():
          EmployeeController.to.employeeListModel?.data?.data?.data?.length == 0 ? NoRecord() : ListView.builder(
                    shrinkWrap: true,
                    itemCount: EmployeeController
                        .to.employeeListModel?.data?.data?.data?.length,
                    itemBuilder: (context, index) {
                      var employeeListData =
                          EmployeeController.to.employeeListModel?.data?.data;
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: InkWell(
                          onTap: () {
                            EmployeeController.to.selectedUserId =
                                employeeListData?.data?[index].id.toString();
                            Get.to(() => EmployeeDetails());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                // color: AppColors.white,
                                border: Border.all(
                                  color: AppColors.grey.withOpacity(0.3),
                                  // width: 1.0,
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10))),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Stack(
                                                children: [
                                                  ClipOval(
                                                      child: SizedBox(
                                                    width: 50.0,
                                                    height: 50.0,
                                                    child: Image.network(
                                                      commonNetworkImageDisplay(
                                                          '${employeeListData?.data?[index].profileImage}'),
                                                      fit: BoxFit.cover,
                                                      errorBuilder: (BuildContext?
                                                              context,
                                                          Object? exception,
                                                          StackTrace? stackTrace) {
                                                        return Image.asset(
                                                          "assets/images/user.jpeg",
                                                          fit: BoxFit.contain,
                                                        );
                                                      },
                                                      width: 50.0,
                                                      height: 50.0,
                                                    ),
                                                  )),
                                                  Positioned(
                                                      left: 37,
                                                      top: 38,
                                                      child: Container(
                                                          width: 12,
                                                          height: 12,
                                                          decoration: BoxDecoration(
                                                            color: EmployeeController
                                                                        .to
                                                                        .employeeListModel
                                                                        ?.data
                                                                        ?.data
                                                                        ?.data?[
                                                                            index]
                                                                        .status ==
                                                                    1
                                                                ? AppColors.green
                                                                : AppColors.red,
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        30)),
                                                            border: Border.all(
                                                              color: AppColors
                                                                  .white, // Replace with desired border color
                                                              width:
                                                                  2, // Replace with desired border width
                                                            ),
                                                          )))
                                                ],
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              SizedBox(
                                                width: Get.width * 0.45,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    CustomText(
                                                      text:
                                                          '${employeeListData?.data?[index].userUniqueId}',
                                                      color:
                                                          AppColors.secondaryColor,
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                    SizedBox(height: 8),
                                                    CustomText(
                                                      text:
                                                          '${employeeListData?.data?[index].firstName} ${employeeListData?.data?[index].lastName}',
                                                      color: AppColors.black,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                    SizedBox(height: 8),
                                                    CustomText(
                                                      text:
                                                          '${employeeListData?.data?[index].jobPosition?.position?.positionName??"-"}',
                                                      color: AppColors.grey,
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                     Spacer(),
                                      PopupMenuButton(
                                        icon: Icon(Icons.more_vert,
                                            color: AppColors.grey),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        itemBuilder: (BuildContext context) =>
                                            <PopupMenuEntry<String>>[
                                          PopupMenuItem(
                                            height: 30,
                                            // child:ProvisionsWithIgnorePointer(
                                            //   provision:'all employees',type:"create",
                                              child: InkWell(
                                                onTap: () async {
                                                  EmployeeController.to.selectedUserId =
                                                      employeeListData?.data?[index].id
                                                          .toString();
                                                  PersonalController.to.userId =
                                                      employeeListData?.data?[index].id
                                                          .toString();
                                                  EmployeeController.to.isEmployee =
                                                  "Edit";
                                                  await ProfileController.to
                                                      .getProfileList();
                                                  Get.to(() => AddEmployeeScreen(selectedIndex: 0));
                                                },
                                                child: Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      "assets/icons/edit_out.svg",
                                                      color: ThemeController.to
                                                          .checkThemeCondition() ==
                                                          true
                                                          ? AppColors.white
                                                          : AppColors.black,
                                                      width: 14,
                                                      height: 14,
                                                    ),
                                                    SizedBox(
                                                      width: 12,
                                                    ),
                                                    CustomText(
                                                        text: "edit",
                                                        color: AppColors.black,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w500)
                                                  ],
                                                ),
                                              ),
                                            // ),
                                          ),
                                          PopupMenuItem(
                                            height: 30,
                                            // onTap: () async {
                                            //   EmployeeController.to
                                            //       .employeeStatusChange(index);
                                            //   await EmployeeController.to
                                            //       .getEmployeeList();
                                            // },
                                            child: ProvisionsWithIgnorePointer(
                                              provision:'All Employees',type:"create",
                                              child: GestureDetector(
                                                onTap: () async {
                                                  EmployeeController.to
                                                      .employeeStatusChange(index);
                                                  await EmployeeController.to
                                                      .getEmployeeList();
                                                  Get.back();
                                                },
                                                child: Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      EmployeeController.to.isActive
                                                          ? "assets/icons/eye_open.svg"
                                                          : "assets/icons/eye_close.svg",
                                                      color: ThemeController.to
                                                          .checkThemeCondition() ==
                                                          true
                                                          ? AppColors.white
                                                          : AppColors.black,
                                                      width: 14,
                                                      height: 14,
                                                    ),
                                                    SizedBox(
                                                      width: 12,
                                                    ),
                                                    CustomText(
                                                        text: EmployeeController
                                                                .to.isActive
                                                            ? "active"
                                                            : "in_active",
                                                        color: AppColors.black,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w500)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          PopupMenuItem(
                                              height: 30,
                                              child: ProvisionsWithIgnorePointer(
                                                provision:'Offboarding',type:"create",
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Get.to(
                                                            () => EmployeeOffBoarding(
                                                          userId:
                                                          employeeListData
                                                              ?.data?[index]
                                                              .id
                                                              .toString(),
                                                        ));
                                                    GetStorage().write(
                                                      'emp_name',
                                                      employeeListData
                                                          ?.data?[index].firstName
                                                          .toString(),
                                                    );
                                                  },
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        "assets/icons/menu/logout.svg",
                                                        color: ThemeController.to
                                                            .checkThemeCondition() ==
                                                            true
                                                            ? AppColors.white
                                                            : AppColors.black,
                                                        width: 14,
                                                        height: 14,
                                                      ),
                                                      SizedBox(
                                                        width: 12,
                                                      ),
                                                      CustomText(
                                                          text: "offboarding",
                                                          color: AppColors.black,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w500)
                                                    ],
                                                  ),
                                                ),
                                              ))
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Divider(
                                    color: AppColors.grey.withOpacity(0.10),
                                    thickness: 2,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset("assets/icons/mail.svg",color: ThemeController.to
                                          .checkThemeCondition() ==
                                          true
                                          ? AppColors.white
                                          : AppColors.black,),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: CustomText(
                                            text:
                                                '${employeeListData?.data?[index].emailId??"-"}',
                                            color: AppColors.grey,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset("assets/icons/call.svg",color:ThemeController.to
                                          .checkThemeCondition() ==
                                          true
                                          ? AppColors.white
                                          : AppColors.black,),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      CustomText(
                                          text:
                                              '${employeeListData?.data?[index].mobileNumber??"-"}',
                                          color:ThemeController.to.checkThemeCondition() == true ? AppColors.white : AppColors.black,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),

          // ),
        ),
      ),
    );
  }

  skeleton(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: InkWell(
              child: Container(
                decoration: skeletonBoxDecoration,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Stack(
                                    children: [
                                      ClipOval(
                                          child: Skeleton(
                                        width: 50.0,
                                        height: 50.0,
                                      )),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.55,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Skeleton(width:Get.width,height: 20),
                                        SizedBox(height: 8),
                                        Skeleton(width:Get.width,height: 20),
                                        SizedBox(height: 8),
                                        Skeleton(width:Get.width,height: 20),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Skeleton(width: 20, height: 30),
                          SizedBox(
                            width: 10,
                          ),
                          Skeleton(width: 100, height: 30),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
