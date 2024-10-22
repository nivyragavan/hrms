import 'package:dreamhrms/constants/colors.dart';
import 'package:dreamhrms/widgets/Custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:localization/localization.dart';

import '../../controller/theme_controller.dart';

class DashboardEvents extends StatelessWidget {
  const DashboardEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            labelColor: AppColors.blue,
            unselectedLabelColor: AppColors.grey,
            indicatorColor: AppColors.blue,
            tabs: [
              Tab(text: "All"),
              Tab(text: "Birthday"),
              Tab(text: "Anniversary"),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.34,
            width: MediaQuery.of(context).size.width * 0.99,
            child: TabBarView(
              children: [
                buildAllEvents(),
                buildBirthdayEvents(),
                buildAnniversaryEvents(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildAllEvents() {
    return ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: 6,
        itemBuilder: (context, index) {
          var ownerImg =
              "https://media.istockphoto.com/id/1318482009/photo/young-woman-ready-for-job-business-concept.jpg?s=612x612&w=0&k=20&c=Jc1NcoUMoM78AxPTh9EApaPU2kXh2evb499JgW99b0g=";
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                  // color: AppColors.white,
                  border: Border.all(
                    color: AppColors.grey.withOpacity(0.3),
                    // width: 1.0,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipOval(
                            child: Image.network(
                          ownerImg,
                          fit: BoxFit.cover,
                          width: 50.0,
                          height: 50.0,
                        )),
                        Positioned(
                          left: 37,
                          top: 38,
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: AppColors.green,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              border: Border.all(
                                color: AppColors
                                    .white, // Replace with desired border color
                                width: 2, // Replace with desired border width
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: Get.width * 0.30,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "John Walker",
                            color: AppColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(height: 8),
                          CustomText(
                            text: "UI Designer",
                            color: AppColors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: 30,
                      width: 65,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: ThemeController.to.checkThemeCondition() == true ? AppColors.grey.withOpacity(0.3) : AppColors.lightBlue,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6))),
                      child: CustomText(
                        text: "Wish Him",
                        color: AppColors.blue,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  buildBirthdayEvents() {
    return ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: 6,
        itemBuilder: (context, index) {
          var ownerImg =
              "https://media.istockphoto.com/id/1318482009/photo/young-woman-ready-for-job-business-concept.jpg?s=612x612&w=0&k=20&c=Jc1NcoUMoM78AxPTh9EApaPU2kXh2evb499JgW99b0g=";
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                  // color: AppColors.white,
                  border: Border.all(
                    color: AppColors.grey.withOpacity(0.3),
                    // width: 1.0,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipOval(
                            child: Image.network(
                          ownerImg,
                          fit: BoxFit.cover,
                          width: 50.0,
                          height: 50.0,
                        )),
                        Positioned(
                            left: 37,
                            top: 38,
                            child: Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: AppColors.green,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
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
                      width: Get.width * 0.30,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "John Walker",
                            color: AppColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(height: 8),
                          CustomText(
                            text: "UI Designer",
                            color: AppColors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: 30,
                      width: 65,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: ThemeController.to.checkThemeCondition() == true ? AppColors.grey.withOpacity(0.3) : AppColors.lightBlue,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6))),
                      child: CustomText(
                        // text: index/2==0?"Present":"Absent",
                        text: "Birthday",
                        color: AppColors.blue,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  buildAnniversaryEvents() {
    return ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: 6,
        itemBuilder: (context, index) {
          var ownerImg =
              "https://media.istockphoto.com/id/1318482009/photo/young-woman-ready-for-job-business-concept.jpg?s=612x612&w=0&k=20&c=Jc1NcoUMoM78AxPTh9EApaPU2kXh2evb499JgW99b0g=";
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                  // color: AppColors.white,
                  border: Border.all(
                    color: AppColors.grey.withOpacity(0.3),
                    // width: 1.0,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipOval(
                            child: Image.network(
                          ownerImg,
                          fit: BoxFit.cover,
                          width: 50.0,
                          height: 50.0,
                        )),
                        Positioned(
                            left: 37,
                            top: 38,
                            child: Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: AppColors.green,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
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
                      width: Get.width * 0.30,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "John Walker",
                            color: AppColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(height: 8),
                          CustomText(
                            text: "UI Designer",
                            color: AppColors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: 30,
                      width: 65,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: ThemeController.to.checkThemeCondition() == true ? AppColors.grey.withOpacity(0.3) : AppColors.lightBlue,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6))),
                      child: CustomText(
                        // text: index/2==0?"Present":"Absent",
                        text: "Anniversary",
                        color: AppColors.blue,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
