import 'package:dreamhrms/screen/main_screen.dart';
import 'package:dreamhrms/screen/ticket/ticket_details_tabs/ticket_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import '../../constants/colors.dart';
import '../../controller/theme_controller.dart';
import '../../widgets/Custom_text.dart';

class TicketList extends StatefulWidget {
  const TicketList({super.key});

  @override
  State<TicketList> createState() => _TicketListState();
}

class _TicketListState extends State<TicketList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Get.to(() => MainScreen());
                  },
                  child: Icon(Icons.arrow_back_ios_new_outlined,
                      color: ThemeController.to.checkThemeCondition() == true ? AppColors.white : AppColors.black),
                ),
                SizedBox(width: 8),
                CustomText(
                  text: "tickets".i18n(),
                  color: AppColors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: 5,
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 18.0, vertical: 8.0),
          child: GestureDetector(
            onTap: (){
              Get.to(()=> TicketDetailsTabs());
            },
            child: Container(
                height: Get.height * 0.23,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: AppColors.grey,
                  ),
                ),
                child:  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 12),
                      CustomText(
                          text: "0298",
                          color: AppColors.blue,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                      SizedBox(height: 8),
                      CustomText(
                          text: "LaptopChange - Reg",
                          color: AppColors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                      SizedBox(height: 15),
                      Flex(
                        direction: Axis.horizontal,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                  text: "Date",
                                  color: AppColors.black,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400),
                              CustomText(
                                  text: "01 June 2023",
                                  color: AppColors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            ],
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                  text: "Priority",
                                  color: AppColors.black,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400),
                              CustomText(
                                  text: "Urgent",
                                  color: AppColors.lightOrange,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ],
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                  text: "Status",
                                  color: AppColors.black,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400),
                              CustomText(
                                  text: "Pending",
                                  color: AppColors.red,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Flex(
                        direction: Axis.horizontal,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                backgroundColor: AppColors.transparent,
                                backgroundImage: NetworkImage("https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png"),
                              ),
                              SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                      text: "Assignee",
                                      color: AppColors.grey,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400),
                                  CustomText(
                                      text: "William Dixion",
                                      color: AppColors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ],
                              )
                            ],
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                backgroundColor: AppColors.transparent,
                                backgroundImage: NetworkImage("https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png"),
                              ),
                              SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                      text: "Created By",
                                      color: AppColors.grey,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400),
                                  CustomText(
                                      text: "John Smith",
                                      color: AppColors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                )
            ),
          ),
        );
      },
      ),
    );
  }
}
