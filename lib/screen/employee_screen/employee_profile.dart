import 'package:dreamhrms/screen/splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localization/localization.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

import '../../constants/colors.dart';
import '../../controller/common_controller.dart';
import '../../controller/department/add_department_controller.dart';
import '../../controller/employee/employee_controller.dart';
import '../../controller/employee/personal_controller.dart';
import '../../controller/employee_details_controller/profile_controller.dart';
import '../../controller/login_controller.dart';
import '../../controller/theme_controller.dart';
import '../../widgets/Custom_text.dart';
import '../../widgets/common.dart';
import '../../widgets/image_picker.dart';

class EmployeeProfile extends StatelessWidget {
  const EmployeeProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((value) async {
      CommonController.to.imageBase64 = "";
      EmployeeController.to.selectedUserId = GetStorage().read('login_userid');
      await ProfileController.to.getProfileList();
    });
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        // leading: Icon(Icons.arrow_back_ios_new_outlined,color: AppColors.black),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // navBackButton(),
            // SizedBox(width: 8),
            CustomText(
              text: "profile_details",
              color: AppColors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                children: [
                  // ObxValue(
                  //       (data) => FlutterSwitch(
                  //           height: 25,
                  //           width: 50,
                  //           padding: 2,
                  //           valueFontSize: 11,
                  //           activeColor: AppColors.blue,
                  //           activeTextColor: AppColors.grey,
                  //           inactiveColor: AppColors.lightGrey,
                  //           inactiveTextColor: AppColors.grey,
                  //           value: ThemeController.to.isDarkTheme,
                  //           onToggle: (val) {
                  //             ThemeController.to.isDarkTheme = val;
                  //             Get.changeThemeMode(
                  //               ThemeController.to.isDarkTheme
                  //                   ? ThemeMode.dark
                  //                   : ThemeMode.light,
                  //             );
                  //             ThemeController.to.saveThemeStatus();
                  //           }),
                  //   false.obs,
                  // ),
                  SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () async {
                      LoginController.to.clearLocalStorage();
                      Get.to(() => Splash());
                    },
                    child: Container(
                      height: 36,
                      width: 36,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          color: AppColors.bgbrown,
                          border: Border.all(
                              color: AppColors.bgbrown.withOpacity(0.20)),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: SvgPicture.asset(
                        "assets/icons/menu/offboarding.svg",
                        color: AppColors.red,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      body: Stack(
        children: [
          Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Stack(
                  children: [
                    Center(
                      child: ProfileController.to.showProfileList ||
                              CommonController.to.imageLoader == true
                          ? Container(
                              height: 92,
                              width: 92,
                              child: Skeleton(),
                            )
                          : InkWell(
                              onTap: () async {
                                print("on Pressed image Picker");
                                await _onImageSelectedFromGallery(
                                  PersonalController.to.imageController,
                                );
                                if (PersonalController
                                            .to.imageController.text !=
                                        "" &&
                                    AddDepartmentController.to.isNetworkImage(
                                            PersonalController
                                                .to.imageController.text) ==
                                        false) {
                                  await PersonalController.to
                                      .employeeImageUpload(
                                          GetStorage().read('login_userid'));
                                  await ProfileController.to.getProfileList();
                                  await EmployeeController.to.getEmployeeList();
                                }
                              },
                              child: Container(
                                width: 100,
                                height: 100,
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 92,
                                      width: 92,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: Image.network(
                                              commonNetworkImageDisplay(
                                                  '${ProfileController.to.profileModel?.data?.data?.profileImage}'),
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
                                            ).image,
                                          ),
                                          color: AppColors.white,
                                          border: Border.all(
                                            color: AppColors.grey,
                                          ),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(14))),
                                    ),
                                    Positioned(
                                        left: 70,
                                        top: 70,
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            gradient: AppColors.primaryColor1,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30)),
                                          ),
                                          child: Icon(
                                            Icons.camera_alt_outlined,
                                            color: AppColors.white,
                                            size: 16,
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
                CustomText(
                  text:
                      '${ProfileController.to.profileModel?.data?.data?.firstName ?? '-'} ${ProfileController.to.profileModel?.data?.data?.lastName ?? '-'}',
                  color: AppColors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 5),
                CustomText(
                  text:
                      '${ProfileController.to.profileModel?.data?.data?.jobPosition?.position?.positionName ?? "-"}',
                  color: AppColors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: CommonController.to.employeeMenuList.length,
                    // TimeOffController.to.employeeTimeOffModel?.data?.data?.commonLeaveDetails?.length ?? 0,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 2 / 0.7),
                    itemBuilder: (BuildContext context, int index) {
                      final employeeMenuList =
                          CommonController.to.employeeMenuList[index];
                      return InkWell(
                        onTap: () {
                          employeeMenuList.onPressed();
                        },
                        child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.lightGrey),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(9)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors
                                      .transparent, // Shadow color (transparent for no shadow)
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: Offset(0,
                                      4), // Offset controls shadow position (horizontal, vertical)
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                      radius: 40,
                                      backgroundColor:
                                          AppColors.blue.withOpacity(0.2),
                                      child: SizedBox(
                                          width: 18,
                                          height: 18,
                                          child: SvgPicture.asset(
                                              employeeMenuList.icon,
                                              color: AppColors.blue))),
                                  Expanded(
                                    child: CustomText(
                                      text: '${employeeMenuList.title}',
                                      color: AppColors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _onImageSelectedFromGallery(controller) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      CommonController.to.imageLoader = true;
      controller.text = pickedFile.path ?? "";
      print("pickedFile.path${pickedFile.path}");
      CommonController.to.imageBase64 = await convertImageToBase64(pickedFile);
      CommonController.to.imageLoader = false;
    }
  }
}
