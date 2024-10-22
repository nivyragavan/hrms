import 'package:dreamhrms/constants/colors.dart';
import 'package:dreamhrms/controller/employee/employee_controller.dart';
import 'package:dreamhrms/controller/theme_controller.dart';
import 'package:dreamhrms/widgets/Custom_text.dart';
import 'package:dreamhrms/widgets/no_record.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

import '../../controller/common_controller.dart';
import '../../controller/face_controller.dart';
import '../../services/provision_check.dart';
import '../../widgets/common.dart';
import '../../widgets/common_textformfield.dart';

class FaceRegisterEmployeeList extends StatelessWidget {
  FaceRegisterEmployeeList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      EmployeeController.to.isLoading = true;
      EmployeeController.to.isActive = false;
      await EmployeeController.to.getEmployeeList(search: true);
    });
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            navBackButton(),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: CustomText(
                  text: "employees",
                  color: AppColors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.start),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: CommonTextFormField(
                controller: CommonController.to.search,
                isBlackColors: true,
                prefixIcon: Icons.search,
                showPrefixIcon: true,
                suffixIcon: Icon(Icons.clear),
                suffixIcononClear: true,
                keyboardType: TextInputType.name,
                onChanged: (data) async {
                  await EmployeeController.to.getEmployeeList(search: true);
                },
              ),
            ),
            ViewProvisionedWidget(
              provision: "All Employees",
              type: "view",
              child: Obx(
                () => EmployeeController.to.isLoading == true
                    ? skeleton(context)
                    : EmployeeController.to.employeeListModel?.code
                                .toString() ==
                            "500"
                        ? ServerError()
                        : EmployeeController.to.employeeListModel?.data?.data
                                    ?.data?.length ==
                                0
                            ? NoRecord()
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemCount: EmployeeController
                                    .to
                                    .employeeListModel
                                    ?.data
                                    ?.data
                                    ?.data
                                    ?.length,
                                itemBuilder: (context, index) {
                                  final employeeListData = EmployeeController
                                      .to.employeeListModel?.data?.data?.data;
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    child: InkWell(
                                      onTap: () async {
                                        bool isVerified = await FaceController
                                            .to
                                            .doFaceReco(verificationOnly: true);
                                        print('isVerified$isVerified');
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            // color: AppColors.white,
                                            border: Border.all(
                                              color: AppColors.grey
                                                  .withOpacity(0.3),
                                              // width: 1.0,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10))),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Stack(
                                                            children: [
                                                              ClipOval(
                                                                  child:
                                                                      SizedBox(
                                                                width: 50.0,
                                                                height: 50.0,
                                                                child: Image
                                                                    .network(
                                                                  commonNetworkImageDisplay(
                                                                      '${employeeListData?[index].profileImage}'),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  errorBuilder: (BuildContext?
                                                                          context,
                                                                      Object?
                                                                          exception,
                                                                      StackTrace?
                                                                          stackTrace) {
                                                                    return Image
                                                                        .asset(
                                                                      "assets/images/user.jpeg",
                                                                      fit: BoxFit
                                                                          .contain,
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
                                                                        color: EmployeeController.to.employeeListModel?.data?.data?.data?[index].status ==
                                                                                1
                                                                            ? AppColors.green
                                                                            : AppColors.red,
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(30)),
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              AppColors.white, // Replace with desired border color
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
                                                            width: Get.width *
                                                                0.45,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                CustomText(
                                                                  text:
                                                                      '${employeeListData?[index].userUniqueId}',
                                                                  color: AppColors
                                                                      .secondaryColor,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                                SizedBox(
                                                                    height: 8),
                                                                CustomText(
                                                                  text:
                                                                      '${employeeListData?[index].firstName} ${employeeListData?[index].lastName}',
                                                                  color:
                                                                      AppColors
                                                                          .black,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                                SizedBox(
                                                                    height: 8),
                                                                CustomText(
                                                                  text:
                                                                      '${employeeListData?[index].jobPosition?.position?.positionName ?? "-"}',
                                                                  color:
                                                                      AppColors
                                                                          .grey,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  Spacer(),
                                                ],
                                              ),
                                              SizedBox(height: 5),
                                              Divider(
                                                color: AppColors.grey
                                                    .withOpacity(0.10),
                                                thickness: 2,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    "assets/icons/mail.svg",
                                                    color: ThemeController.to
                                                                .checkThemeCondition() ==
                                                            true
                                                        ? AppColors.white
                                                        : AppColors.black,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: CustomText(
                                                        text:
                                                            '${employeeListData?[index].emailId ?? "-"}',
                                                        color: AppColors.grey,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    "assets/icons/call.svg",
                                                    color: ThemeController.to
                                                                .checkThemeCondition() ==
                                                            true
                                                        ? AppColors.white
                                                        : AppColors.black,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  CustomText(
                                                      text:
                                                          '${employeeListData?[index].mobileNumber ?? "-"}',
                                                      color: ThemeController.to
                                                                  .checkThemeCondition() ==
                                                              true
                                                          ? AppColors.white
                                                          : AppColors.black,
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w400)
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
              ),
            ),
          ],
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
                                        Skeleton(width: Get.width, height: 20),
                                        SizedBox(height: 8),
                                        Skeleton(width: Get.width, height: 20),
                                        SizedBox(height: 8),
                                        Skeleton(width: Get.width, height: 20),
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
