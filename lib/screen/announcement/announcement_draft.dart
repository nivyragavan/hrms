import 'package:dreamhrms/model/announcement/announcement_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';

import '../../constants/colors.dart';
import '../../controller/announcement_controller.dart';
import '../../services/provision_check.dart';
import '../../controller/common_controller.dart';
import '../../controller/theme_controller.dart';
import '../../widgets/Custom_text.dart';
import '../../widgets/common_alert_dialog.dart';
import '../../widgets/no_record.dart';
import '../../widgets/stacket_image_widget.dart';
import '../employee/employee_details/profile.dart';
import 'create_announcement.dart';

class AnnouncementDraft extends StatelessWidget {
  const AnnouncementDraft({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      AnnouncementController.to.clearValues();
      AnnouncementController.to.announcementListModel;
      await AnnouncementController.to.getAnnouncementDraftList();
    });
    return Scaffold(
      // backgroundColor: AppColors.white,
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: ViewProvisionedWidget(
            provision: "Announcement",
            type:"view",
            child: Obx(
              () => commonLoader(
                length: MediaQuery.of(context).size.height.toInt(),
                singleRow: true,
                loader: AnnouncementController.to.showList,
                child: AnnouncementController
                            .to.announcementDraftModel?.data?.length ==
                        null
                    ? NoRecord()
                    : ListView.separated(
                        itemCount: AnnouncementController
                                .to.announcementDraftModel?.data?.length ??
                            0,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          var announcementList = AnnouncementController
                              .to.announcementDraftModel?.data?[index];
                          // AnnouncementController.to.profileImages =
                          //     extractProfileImages(
                          //         announcementList?.id ?? -1,
                          //         AnnouncementController
                          //             .to.announcementListModel?.data?.data ??
                          //             []);
                          return InkWell(
                            onTap: () async {
                              await AnnouncementController.to.getAnnouncementView(
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
                                        editAnnouncementDraft(announcementList,index);
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
                                          title: "delete_draft ?",
                                          description:
                                              'all_details_in_this_draft_will_be_deleted.',
                                          actionButtonText: "delete",
                                          onPressed: () async {
                                            CommonController.to.buttonLoader = true;
                                            await AnnouncementController.to
                                                .deleteAnnouncement(
                                                    announcementId:
                                                        announcementList?.id ??
                                                            0);
                                            CommonController.to.buttonLoader = false;
                                          }, provision: 'announcement', provisionType: 'delete',
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

  editAnnouncementDraft(Data? announcementList, int index) {
    AnnouncementController.to.isEdit = "Edit";
    AnnouncementController.to.subject.text = announcementList?.subject ?? "";
    AnnouncementController.to.message.text = announcementList?.message ?? "";
    AnnouncementController.to.announcementId = announcementList?.id ?? 0;
    AnnouncementController.to.attachment.text =
        announcementList?.attachment ?? "";
    Get.to(() => CreateAnnouncement());
  }
}
