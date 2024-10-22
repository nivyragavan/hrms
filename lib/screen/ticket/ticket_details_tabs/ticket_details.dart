import 'package:dreamhrms/controller/common_controller.dart';
import 'package:dreamhrms/controller/theme_controller.dart';
import 'package:dreamhrms/screen/announcement/announcement_draft.dart';
import 'package:dreamhrms/screen/announcement/announcement_list.dart';
import 'package:dreamhrms/screen/ticket/ticket_details_tabs/ticket_activity.dart';
import 'package:dreamhrms/screen/ticket/ticket_details_tabs/ticket_assign_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';

import '../../../constants/colors.dart';
import '../../../widgets/Custom_text.dart';
import '../../../widgets/common.dart';
import '../../main_screen.dart';

class TicketDetailsTabs extends StatefulWidget {
  final int? index;
  const TicketDetailsTabs({
    Key? key,
    this.index,
  }) : super(key: key);

  @override
  State<TicketDetailsTabs> createState() => _TicketDetailsTabsState();
}

class _TicketDetailsTabsState extends State<TicketDetailsTabs>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: widget.index ?? 0,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: ThemeController.to.checkThemeCondition() == true
              ? Colors.grey.shade900
              : AppColors.white,
          title: Row(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back_ios_new_outlined,
                        color: ThemeController.to.checkThemeCondition() == true
                            ? AppColors.white
                            : AppColors.black),
                  ),
                  SizedBox(width: 8),
                  CustomText(
                    text: "ticket_details".i18n(),
                    color: AppColors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(40),
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: TabBar(
                  indicatorColor: AppColors.blue,
                  isScrollable: true,
                  controller: tabController,
                  onTap: (value) {
                    // setState(() {
                    //   tabController!.index = widget.index ?? 0;
                    // });
                  },
                  unselectedLabelColor: AppColors.grey,
                  labelColor: AppColors.blue,
                  tabs: [
                    Tab(
                      text: "ticket_details".i18n(),
                    ),
                    Tab(
                      text: "assignee_details".i18n(),
                    ),
                    Tab(
                      text: "activity".i18n(),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        backgroundColor: AppColors.white,
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: tabController,
          children: [
            TicketDetail(),
            TicketAssignDetails(),
            TicketActivity(),
          ],
        ),
      ),
    );
  }
}

class TicketDetail extends StatelessWidget {
  const TicketDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: [
            SizedBox(height: 16),
            Row(
              children: [
                commonDataDisplay(
                    title1: "ticket_name",
                    text1: "0298",
                    title2: "name".i18n(),
                    text2: "John Smith",
                    titleFontSize1: 13,
                    titleFontSize2: 13,
                    textFontSize1: 14,
                    textFontSize2: 14),
              ],
            ),
            Row(
              children: [
                commonDataDisplay(
                    title1: "created_on".i18n(),
                    text1: "02 June 2023",
                    title2: "subject".i18n(),
                    text2: "Laptop Change",
                    titleFontSize1: 13,
                    titleFontSize2: 13,
                    textFontSize1: 14,
                    textFontSize2: 14),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
