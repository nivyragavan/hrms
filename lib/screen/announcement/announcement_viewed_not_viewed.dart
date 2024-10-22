import 'package:dreamhrms/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:localization/localization.dart';

import '../../constants/colors.dart';
import '../../controller/announcement_controller.dart';
import '../../widgets/Custom_text.dart';
import '../../widgets/common.dart';
import '../../widgets/common_textformfield.dart';
import '../../widgets/no_record.dart';
import '../employee/employee_details/profile.dart';

class AnnouncementViewedNotViewedScreen extends StatelessWidget {
  final int? id;
  const AnnouncementViewedNotViewedScreen({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((value) async {
      await AnnouncementController.to.getAnnouncementView(announcementId: id ?? -1);
      AnnouncementController.to.filterViewedAnnouncement("");
      AnnouncementController.to.filterNotViewedAnnouncement("");
    });
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            Row(
              children: [
                navBackButton(),
                SizedBox(width: 8),
                CustomText(
                  text: "${"announcement_seen_by"} ${AnnouncementController.to.viewedCount}  / "
                "${AnnouncementController.to.notViewedCount + AnnouncementController.to.viewedCount} member",
                  color: AppColors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ],
        ),
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        buildViewedList(context);
                        AnnouncementController.to.isViewed = true;
                        AnnouncementController.to.isNotViewed = false;
                        AnnouncementController.to.filterViewedAnnouncement("");
                      },
                      child: Container(
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                          color: AnnouncementController.to.isViewed && ThemeController.to.checkThemeCondition() == true
                              ? AppColors.blue
                              : ThemeController.to.checkThemeCondition() == true?  AppColors.grey : AnnouncementController.to.isViewed ? AppColors.blue: AppColors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            bottomLeft: Radius.circular(8.0),
                          ),
                          border: Border.all(
                            color: AnnouncementController.to.isViewed
                                ? AppColors.blue
                                : AppColors.grey.withOpacity(0.7),
                          ),
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/icons/eye_open.svg",
                                color: AppColors.white,
                                width: 18,
                                height: 16,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              CustomText(
                                text:
                                    "Viewed (${AnnouncementController.to.viewedCount})"
                                        ,
                                color: AnnouncementController.to.isViewed
                                    ? AppColors.white
                                    : AppColors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ]),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        buildNotViewedList(context);
                        AnnouncementController.to.isNotViewed = true;
                        AnnouncementController.to.isViewed = false;
                        AnnouncementController.to.filterNotViewedAnnouncement("");
                      },
                      child: Container(
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                          color: AnnouncementController.to.isNotViewed && ThemeController.to.checkThemeCondition() == true
                              ? AppColors.blue
                              : ThemeController.to.checkThemeCondition() == true ?  AppColors.grey : AnnouncementController.to.isNotViewed ? AppColors.blue : AppColors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8.0),
                            bottomRight: Radius.circular(8.0),
                          ),
                          border: Border.all(
                            color: AnnouncementController.to.isNotViewed
                                ? AppColors.blue
                                : AppColors.grey.withOpacity(0.7),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/icons/eye_close.svg",
                              color:AppColors.white,
                              width: 18,
                              height: 16,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            CustomText(
                              text:
                                  "Not Viewed (${AnnouncementController.to.notViewedCount})"
                                      ,
                              color: AnnouncementController.to.isNotViewed
                                  ? AppColors.white
                                  : AppColors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                AnnouncementController.to.isViewed == true ?
                  buildViewedList(context) :buildNotViewedList(context),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

buildViewedList(BuildContext context) {
  return Obx(
    () => Column(
      children: [
        CommonTextFormField(
          isBlackColors: true,
          hintText: "search",
          prefixIcon: Icons.search,
          keyboardType: TextInputType.name,
          onChanged: (searchText) {
            AnnouncementController.to.filterViewedAnnouncement(searchText);
          },
        ),
        commonLoader(
          length: MediaQuery.of(context).size.height.toInt(),
          width: double.infinity,
          loader: AnnouncementController.to.viewedListLoader,
          singleRow: true,
          child: AnnouncementController.to.filteredViewedList.length == 0
              ? NoRecord()
              : ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount:
                      AnnouncementController.to.filteredViewedList.length ?? 0,
                  itemBuilder: (context, index) {
                    var viewedData =
                        AnnouncementController.to.filteredViewedList[index];
                    return ListTile(
                      leading: ClipOval(
                        child: Image.network(
                          commonNetworkImageDisplay(
                              "${viewedData?.userId?.profileImage}"),
                          fit: BoxFit.cover,
                          width: 38.0,
                          height: 38.0,
                        ),
                      ),
                      title: CustomText(
                        text:
                            "${viewedData?.userId?.firstName} ${viewedData?.userId?.lastName}",
                        color: AppColors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      subtitle: CustomText(
                        text: "${viewedData?.userId?.userUniqueId?? ""}",
                        color: AppColors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 10,
                    );
                  },
                ),
        ),
      ],
    ),
  );
}

buildNotViewedList(BuildContext context) {
  return Obx(
    () => Column(
      children: [
        CommonTextFormField(
          isBlackColors: true,
          hintText: "search",
          prefixIcon: Icons.search,
          keyboardType: TextInputType.name,
          onChanged: (searchText) {
            AnnouncementController.to.filterNotViewedAnnouncement(searchText);
          },
        ),
        commonLoader(
          length: MediaQuery.of(context).size.height.toInt(),
          width: double.infinity,
          loader: AnnouncementController.to.viewedListLoader,
          singleRow: true,
          child: AnnouncementController.to.filteredNotViewedList.length == 0
              ? NoRecord()
              : ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: AnnouncementController
                          .to
                          .filteredNotViewedList
                          .length ??
                      0,
                  itemBuilder: (context, index) {
                    var notViewedData = AnnouncementController
                        .to
                        .filteredNotViewedList[index];
                    return ListTile(
                      leading: ClipOval(
                        child: Image.network(
                          commonNetworkImageDisplay(
                              "${notViewedData?.userId?.profileImage}"),
                          fit: BoxFit.cover,
                          width: 38.0,
                          height: 38.0,
                        ),
                      ),
                      title: CustomText(
                        text:
                            "${notViewedData?.userId?.firstName} ${notViewedData?.userId?.lastName}",
                        color: AppColors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      subtitle: CustomText(
                        text: "${notViewedData?.userId?.userUniqueId ??""}",
                        color: AppColors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 10,
                    );
                  },
                ),
        ),
      ],
    ),
  );
}
