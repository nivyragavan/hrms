import 'package:dreamhrms/controller/emp_announcement_controller.dart';
import 'package:dreamhrms/widgets/common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../constants/colors.dart';
import '../../controller/theme_controller.dart';
import '../../widgets/Custom_text.dart';
import '../../widgets/no_record.dart';
import '../employee/employee_details/profile.dart';
import 'package:localization/localization.dart';

import '../main_screen.dart';

class EmployeeAnnouncement extends StatelessWidget {
  const EmployeeAnnouncement({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      await EmpAnnouncementController.to.getAnnouncementList();
    });
    return Scaffold(
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
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Obx(
          () => commonLoader(
            length: MediaQuery.of(context).size.height.toInt(),
            singleRow: true,
            loader: EmpAnnouncementController.to.showList,
            child: EmpAnnouncementController
                        .to.announcementListModel?.data?.length ==
                    0
                ? NoRecord()
                : ListView.separated(
                    itemCount: EmpAnnouncementController
                            .to.announcementListModel?.data?.length ??
                        0,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      var announcementList = EmpAnnouncementController
                          .to.announcementListModel?.data?[index];
                      return InkWell(
                        onTap: () async {
                          EmpAnnouncementController.to.getAnnouncementView(
                              announcementId: announcementList.announcement?.id ?? 0);
                          showAnnouncementView(
                              context, index, announcementList.id ?? 0);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: ThemeController.to.checkThemeCondition() ==
                                      true
                                  ? AppColors.black
                                  : AppColors.white,
                              border: Border.all(
                                  color: AppColors.grey.withOpacity(0.5)),
                              borderRadius: BorderRadius.circular(8)),
                          child: Container(
                            margin: EdgeInsets.all(10),
                            color:
                                ThemeController.to.checkThemeCondition() == true
                                    ? AppColors.black
                                    : AppColors.white,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: Get.width * 0.60,
                                      child: CustomText(
                                        text: announcementList?.announcement?.subject ?? "-",
                                        color: AppColors.blue,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.60,
                                      child: CustomText(
                                        text: announcementList?.announcement?.message ?? "-",
                                        color: AppColors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: DateFormat('dd-MM-yyyy')
                                          .format(DateTime.parse(
                                          announcementList
                                          !.createdAt.toString())),
                                      color: AppColors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    CustomText(
                                      text: DateFormat.EEEE().format(
                                        DateTime.parse(
                                            announcementList
                                            !.createdAt.toString())),
                                      color: AppColors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    CustomText(
                                      text: announcementList.announcement?.publish == 1
                                          ? "published".i18n() : "",
                                      color: AppColors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 15,
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }

  showAnnouncementView(BuildContext context, int index, int id) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50.0),
              topRight: Radius.circular(50.0),
            ),
            color: ThemeController.to.checkThemeCondition() == true
                ? AppColors.black
                : AppColors.white,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Obx(
              () => commonLoader(
                length: 5,
                singleRow: true,
                loader: EmpAnnouncementController.to.viewedListLoader,
                child: EmpAnnouncementController.to.announcementViewModel
                            ?.data?.data?.announcement?.viewedData?.length ==
                        0
                    ? NoRecord()
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            CustomText(
                              text: EmpAnnouncementController
                                      .to
                                      .announcementViewModel
                                      ?.data?.data?.announcement
                                      ?.subject ??
                                  "".i18n(),
                              color: AppColors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            CustomText(
                              text: "send_to".i18n(),
                              color: AppColors.darkBlue,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            // ListTile(
                            //   leading: Image.network(EmpAnnouncementController
                            //       .to
                            //       .announcementViewModel
                            //       ?.data?.data?.user?.profileImage.toString() ??
                            //       ""),
                            //   title: CustomText(
                            //     text:
                            //     "${EmpAnnouncementController.to.announcementViewModel?.data?.data?.user?.firstName ?? ""}",
                            //     color: AppColors.black,
                            //     fontSize: 14,
                            //     fontWeight: FontWeight.w500,
                            //   ),
                            //   subtitle: CustomText(
                            //     text:
                            //     "${EmpAnnouncementController.to.announcementViewModel?.data?.data?.user?.emailId ?? ""}",
                            //     color: AppColors.black,
                            //     fontSize: 12,
                            //     fontWeight: FontWeight.w400,
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 18,
                            // ),
                            CustomText(
                              text: "message".i18n(),
                              color: AppColors.darkBlue,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            CustomText(
                              text:
                                  "Hi${EmpAnnouncementController.to.announcementViewModel?.data?.data?.user?.firstName ?? ""}",
                              color: AppColors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            CustomText(
                              text: EmpAnnouncementController
                                      .to
                                      .announcementViewModel
                                      ?.data?.data?.announcement
                                      ?.message ??
                                  "".i18n(),
                              color: AppColors.grey,
                              maxLines: 7,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.25,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                                image: DecorationImage(
                                  image: NetworkImage(commonNetworkImageDisplay(
                                      EmpAnnouncementController
                                          .to
                                          .announcementViewModel
                                          ?.data?.data?.announcement
                                          ?.attachment ??
                                          ""
                                  )),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ),
        );
      },
    );
  }

}
