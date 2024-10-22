import 'dart:ui' as ui;

import 'package:dreamhrms/controller/common_controller.dart';
import 'package:dreamhrms/controller/theme_controller.dart';
import 'package:dreamhrms/screen/employee/employee_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:localization/localization.dart';
import '../constants/colors.dart';
import '../controller/employee/employee_controller.dart';
import '../widgets/Custom_text.dart';
import '../widgets/common.dart';
import '../widgets/common_drawerappbar.dart';

class HomeMainDrawer extends StatefulWidget {
  const HomeMainDrawer({Key? key}) : super(key: key);

  @override
  State<HomeMainDrawer> createState() => _HomeMainDrawerState();
}

class _HomeMainDrawerState extends State<HomeMainDrawer>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    EmployeeController.to.selectedUserId = GetStorage().read('login_userid');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: AppColors.primaryColor1,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: AppBar(
                  centerTitle: false,
                  elevation: 0,
                  leadingWidth: 20.0,
                  backgroundColor: Colors.transparent,
                  leading: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: SvgPicture.asset("assets/icons/cancel.svg")),
                  title: Padding(
                    padding: const EdgeInsets.only(right: 40),
                    child: Image.asset('assets/images/logo_white.png'),
                  ),
                  actions: [AppBarDrawer()]
                  ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          BackdropFilter(
            filter: ui.ImageFilter.blur(
              sigmaX: 2.0,
              sigmaY: 2.0,
            ),
            child: Container(
              color: ThemeController.to.checkThemeCondition() == true ? AppColors.black : AppColors.white,
              width: Get.width * 0.85,
              height: Get.height,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.grey.withOpacity(0.3)),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Column(
                          children: [
                            GetStorage().read("role")!="employee"?
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 15),
                                  width: 38.0,
                                  height: 38.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            GetStorage().read("CompanyLogo"))),
                                  ),
                                ),
                                SizedBox(width: 5),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                        text: GetStorage().read("user_name") ?? "",
                                        color: AppColors.black ,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,),
                                    SizedBox(height: 5),
                                    SizedBox(
                                      width: Get.width*0.35,
                                      child: CustomText(
                                          text:  GetStorage().read("user_job_title") ?? "",
                                          color: AppColors.grey,
                                          fontSize: 12,
                                          fontWeight:
                                          FontWeight.w500,),
                                    ),
                                  ],
                                ),
                                // commonSingleDataDisplay(
                                //   title1: GetStorage().read("user_name") ?? "",
                                //   text1:
                                //       GetStorage().read("user_job_title") ?? "",
                                //   titleFontSize: 14,
                                //   titleFontColor: AppColors.black,
                                //   titleFontWeight: FontWeight.w600,
                                //   textFontSize: 12,
                                //   textFontColor: AppColors.grey,
                                //   textFontWeight: FontWeight.w500,
                                // ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Icon(Icons.arrow_forward_ios_outlined,
                                      color: AppColors.grey),
                                )
                              ],
                            ):
                            InkWell(
                              onTap:(){
                                Get.to(()=>EmployeeDetails());
                              },
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 15),
                                    width: 38.0,
                                    height: 38.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              GetStorage().read("UserImage"))),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: GetStorage().read("emp_name") ?? "",
                                        color: AppColors.black ,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,),
                                      SizedBox(height: 5),
                                      SizedBox(
                                        width: Get.width*0.35,
                                        child: CustomText(
                                          text:  GetStorage().read("user_mail_id") ?? "",
                                          color: AppColors.grey,
                                          fontSize: 12,
                                          fontWeight:
                                          FontWeight.w500,),
                                      ),
                                    ],
                                  ),
                                  // commonSingleDataDisplay(
                                  //   title1: GetStorage().read("user_name") ?? "",
                                  //   text1:
                                  //       GetStorage().read("user_job_title") ?? "",
                                  //   titleFontSize: 14,
                                  //   titleFontColor: AppColors.black,
                                  //   titleFontWeight: FontWeight.w600,
                                  //   textFontSize: 12,
                                  //   textFontColor: AppColors.grey,
                                  //   textFontWeight: FontWeight.w500,
                                  // ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Icon(Icons.arrow_forward_ios_outlined,
                                        color: AppColors.grey),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      GetStorage().read("role")=="employee"?
                      getMenuList(CommonController.to.employeeMenuList)
                          :getMenuList(CommonController.to.adminMenuList)
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  getMenuList(List<MenuItem> menuItems){
    return ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              commonMenuDisplay(
                image: menuItems[index].icon,
                imageColor: AppColors.grey,
                text: menuItems[index].title,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.grey,
                onPressed: () {
                  menuItems[index].onPressed();
                },
              ),
            ],
          );
        });
  }
}

class MenuItem {
  String title;
  String icon;
  Function onPressed; // Callback function

  MenuItem({
    required this.title,
    required this.icon,
    required this.onPressed,
  });
}
