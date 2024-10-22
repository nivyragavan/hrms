import 'package:dreamhrms/controller/theme_controller.dart';
import 'package:dreamhrms/model/announcement/announcement_list_model.dart';
import 'package:dreamhrms/screen/announcement/create_announcement.dart';
import 'package:dreamhrms/screen/employee/employee_details/profile.dart';
import 'package:dreamhrms/widgets/no_record.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

import '../../constants/colors.dart';

import '../../controller/announcement_controller.dart';
import '../../controller/common_controller.dart';
import '../../model/announcement/announcement_list_model.dart';
import '../../services/provision_check.dart';
import '../../widgets/Custom_text.dart';
import '../../widgets/common.dart';
import '../../widgets/common_alert_dialog.dart';
import '../../widgets/stacket_image_widget.dart';
import 'announcement_viewed_not_viewed.dart';

class AnnouncementListScreen extends StatelessWidget {
  const AnnouncementListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      AnnouncementController.to.clearValues();
      AnnouncementController.to.announcementListModel;
      await AnnouncementController.to.getAnnouncementList();
    });
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(20),
          child:  ViewProvisionedWidget(
            provision: "Announcement",
            type:"view",
            child: Obx(
              () => commonLoader(
                length: MediaQuery.of(context).size.height.toInt(),
                singleRow: true,
                loader: AnnouncementController.to.showList,
                child: AnnouncementController
                            .to.announcementListModel?.data?.length ==
                        0
                    ? NoRecord()
                    : ListView.separated(
                        itemCount: AnnouncementController
                                .to.announcementListModel?.data?.length ??
                            0,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          var announcementList = AnnouncementController
                              .to.announcementListModel?.data?[index];
                          AnnouncementController.to.profileImages =
                              extractProfileImages(
                                  announcementList?.id ?? -1,
                                  AnnouncementController
                                          .to.announcementListModel?.data ??
                                      []);
                          return InkWell(
                            onTap: ()  async {
                              showAnnouncementView(
                                  context, index, announcementList?.id ?? 0);
                               AnnouncementController.to.getAnnouncementView(
                                  announcementId: announcementList?.id ?? 0);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: ThemeController.to.checkThemeCondition() == true ? AppColors.black : AppColors.white,
                                  border: Border.all(
                                      color: AppColors.grey.withOpacity(0.5)),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Slidable(
                                closeOnScroll: true,
                                endActionPane: ActionPane(
                                  extentRatio: 0.3,
                                  motion: const BehindMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) {
                                        editAnnouncement(announcementList, index);
                                      },
                                      backgroundColor: AppColors.blue,
                                      foregroundColor: Colors.white,
                                      icon: Icons.edit_outlined,
                                    ),
                                    SlidableAction(
                                      onPressed: (context) {
                                        commonAlertDialog(
                                          icon: Icons.delete_outline,
                                          context: context,
                                          title: "delete_announcement",
                                          provision: 'announcement',
                                          provisionType: 'delete',
                                          description:
                                              'all_details_in_this_announcement_will_be_deleted.',
                                          actionButtonText: "delete",
                                          onPressed: () async {
                                            CommonController.to.buttonLoader = true;
                                            await AnnouncementController.to
                                                .deleteAnnouncement(
                                                    announcementId:
                                                        announcementList?.id ??
                                                            0);
                                            CommonController.to.buttonLoader = false;
                                          },
                                        );
                                      },
                                      backgroundColor: AppColors.red,
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete_outline,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(8),
                                          bottomRight: Radius.circular(8)),
                                    ),
                                  ],
                                ),
                                child: Container(
                                    margin: EdgeInsets.all(10),
                                    color: ThemeController.to.checkThemeCondition() == true ? AppColors.black : AppColors.white,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: Get.width * 0.60,
                                              child: CustomText(
                                                text: announcementList?.subject ??
                                                    "-",
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
                                                text: announcementList?.message ??
                                                    "-",
                                                color: AppColors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            buildExpandedBox(
                                              color: ThemeController.to.checkThemeCondition() == true ? AppColors.black : AppColors.white,
                                              children: [
                                                SizedBox(
                                                  width: Get.width * 0.60,
                                                  child: SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: buildStackedImages(
                                                        images:
                                                            AnnouncementController
                                                                .to.profileImages,
                                                        imgsize: 30,
                                                        showCount: false),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CustomText(
                                              text: DateFormat('dd-MM-yyyy')
                                                  .format(announcementList
                                                          ?.createdAt ??
                                                      DateTime.now()),
                                              color: AppColors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            CustomText(
                                              text: DateFormat.EEEE().format(
                                                  announcementList?.createdAt ??
                                                      DateTime.now()),
                                              color: AppColors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            CustomText(
                                              text: announcementList?.publish == 1
                                                  ? "published"
                                                  : "draft",
                                              color: AppColors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ],
                                        )
                                      ],
                                    )),
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
          )),
    );
  }

  showAnnouncementView(BuildContext context, int index, int id) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        print(
            "Data ${AnnouncementController.to.announcementViewListModel?.data?.subject ?? ""}");
        AnnouncementController.to.profileImages = extractProfileImages(id ?? -1,
            AnnouncementController.to.announcementListModel?.data ?? []);
        return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50.0),
                          topRight: Radius.circular(50.0),
                        ),
                        color: ThemeController.to.checkThemeCondition() == true ? AppColors.black : AppColors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical:15,horizontal: 15),
                        child: Obx(() => commonLoader(
                          length: 5,
                          singleRow: true,
                          loader: AnnouncementController.to.viewedListLoader,
                          child: AnnouncementController.to.announcementViewListModel?.data!
                              .viewedData?.length ==
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
                                text: AnnouncementController
                                        .to
                                        .announcementViewListModel
                                        ?.data
                                        ?.subject ??
                                    "",
                                color: AppColors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                              SizedBox(
                                height: 18,
                              ),
                              CustomText(
                                text: "send_to",
                                color: AppColors.darkBlue,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              buildExpandedBox(
                                color: ThemeController.to.checkThemeCondition() == true ? AppColors.black : AppColors.white,
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: buildStackedImages(
                                          images: AnnouncementController
                                              .to.profileImages,
                                          imgsize: 30,
                                          showCount: false),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 18,
                              ),
                              CustomText(
                                text: "message",
                                color: AppColors.darkBlue,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              CustomText(
                                text: AnnouncementController
                                            .to.profileImages.length >
                                        2
                                    ? "hi_everyone"
                                    : "${AnnouncementController.to.announcementViewListModel?.data?.viewedData?[index].userId?.firstName ?? ""}",
                                color: AppColors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              CustomText(
                                text: AnnouncementController
                                        .to
                                        .announcementViewListModel
                                        ?.data
                                        ?.message ??
                                    "",
                                color: AppColors.grey,
                                maxLines: 7,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  image: DecorationImage(
                                    image: NetworkImage(AnnouncementController
                                            .to
                                            .announcementViewListModel
                                            ?.data
                                            ?.attachment ??
                                        ""),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.back();
                                  Get.to(
                                    () => AnnouncementViewedNotViewedScreen(
                                      id: id,
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/eye_open.svg",
                                      color: AppColors.grey,
                                      width: 18,
                                      height: 16,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    CustomText(
                                      text: "${AnnouncementController.to.viewedCount} ${"member"} / "
                                              "${AnnouncementController.to.notViewedCount + AnnouncementController.to.viewedCount} "
                                          ,
                                      color: AppColors.blue,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
            ));
      },
    );
  }

  editAnnouncement(Data? announcementList, int index) {
    AnnouncementController.to.isEdit = "Edit";
    AnnouncementController.to.subject.text = announcementList?.subject ?? "";
    AnnouncementController.to.message.text = announcementList?.message ?? "";
    AnnouncementController.to.announcementId = announcementList?.id ?? 0;
    AnnouncementController.to.attachment.text =
        announcementList?.attachment ?? "";
    for (final item in  announcementList?.users ?? []) {
      final departmentId = item.depId;
      final positionId = item.positionId;
      final userId = item.userId;
      if (departmentId == null && positionId == null) {
        AnnouncementController.to.selectedUserIds.add(userId ?? -1);
        print("${AnnouncementController.to.selectedUserIds.length}");
        AnnouncementController
            .to.selectedUserIdsString =
            AnnouncementController
                .to.selectedUserIds
                .join(",");
      }
      else  if (userId == null && positionId == null) {
        AnnouncementController.to.selectedDepartmentIds.add(departmentId ?? -1);
        AnnouncementController
            .to.selectedUserIdsString =
            AnnouncementController
                .to.selectedDepartmentIds
                .join(",");
      }
      else {
        AnnouncementController.to.selectedPositionIds.add(positionId ?? -1);
        AnnouncementController
            .to.selectedPositionIdsString =
            AnnouncementController
                .to.selectedPositionIds
                .join(",");
      }
    }
    Get.to(() => CreateAnnouncement());
  }

  List<String> extractProfileImages(int announcementId, List<Data> data) {
    List<String> profileImages = [];

    for (var datum in data) {
      if (datum.id == announcementId) {
        for (var user in datum.users ?? []) {
          if (user.announcementId == announcementId && user.user != null) {
            profileImages.add(user.user!.profileImage ?? "");
          }
        }
      }
    }

    return profileImages;
  }
}
