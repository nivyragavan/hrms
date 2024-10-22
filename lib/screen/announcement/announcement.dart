import 'package:dreamhrms/controller/common_controller.dart';
import 'package:dreamhrms/controller/theme_controller.dart';
import 'package:dreamhrms/screen/announcement/announcement_draft.dart';
import 'package:dreamhrms/screen/announcement/announcement_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import '../../constants/colors.dart';
import '../../controller/announcement_controller.dart';
import '../../widgets/Custom_text.dart';
import '../main_screen.dart';
import 'create_announcement.dart';

class AnnouncementScreen extends StatefulWidget {
  final int? index;
  const AnnouncementScreen({
    Key? key, this.index,
  }) : super(key: key);

  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen>
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
      length: 2,
      initialIndex: widget.index ?? 0,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: ThemeController.to.checkThemeCondition() == true ? Colors.grey.shade900 : AppColors.white,
          title: Row(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(() => MainScreen());
                    },
                    child: Icon(Icons.arrow_back_ios_new_outlined,
                        color: ThemeController.to.checkThemeCondition() == true
                            ? AppColors.white
                            : AppColors.black),
                  ),
                  SizedBox(width: 8),
                  CustomText(
                    text: "announcement",
                    color: AppColors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: InkWell(
                  onTap: () {
                   AnnouncementController.to.clearValues();
                    Get.to(() => CreateAnnouncement());
                  },
                  child: Container(
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(
                      color: AppColors.blue,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    child: Icon(Icons.add, color: AppColors.white),
                  ),
                ),
              )
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
                      text: "published",
                    ),
                    Tab(
                      text: "draft",
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
            AnnouncementListScreen(),
            AnnouncementDraft(),
          ],
        ),
      ),
    );
  }
}
