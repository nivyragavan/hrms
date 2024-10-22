import 'package:dreamhrms/controller/common_controller.dart';
import 'package:dreamhrms/model/announcement/announcement_position.dart';
import 'package:dreamhrms/screen/announcement/announcement.dart';
import 'package:dreamhrms/screen/announcement/announcement_list.dart';
import 'package:dreamhrms/screen/employee/employee_details/profile.dart';
import 'package:dreamhrms/widgets/no_record.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

import '../../../constants/colors.dart';
import '../../../controller/announcement_controller.dart';
import '../../../controller/department/deparrtment_controller.dart';
import '../../../widgets/Custom_text.dart';
import '../../../widgets/back_to_screen.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/common_textformfield.dart';

class PositionTabScreen extends StatelessWidget {
  const PositionTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((value) async {
      AnnouncementController.to.jobPositionList = true;
      await AnnouncementController.to.getJobPosition();
      AnnouncementController.to.filterPosition("");
      if (AnnouncementController.to.isEdit == "Edit") {
        for (final user in AnnouncementController.to.filteredPositions) {
          final isSelected =
              AnnouncementController.to.selectedPositionIds.contains(user?.id);
          final index =
              AnnouncementController.to.filteredPositions.indexOf(user);
          while (index >=
              AnnouncementController.to.positionCheckboxStatus.length) {
            AnnouncementController.to.positionCheckboxStatus.add(false);
          }
          if (index >= 0 &&
              index < AnnouncementController.to.positionCheckboxStatus.length) {
            AnnouncementController.to.positionCheckboxStatus[index] =
                isSelected;
          }
        }
      } else {
        AnnouncementController.to.positionCheckboxStatus = List.generate(
          AnnouncementController
                  .to.announcementJobPositionModel?.data?.length ??
              0,
          (index) => false,
        );
      }
      AnnouncementController.to.jobPositionList = false;
    });
    return Scaffold(
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CommonTextFormField(
                  isBlackColors: true,
                  hintText: "Search",
                  prefixIcon: Icons.search,
                  keyboardType: TextInputType.name,
                  onChanged: (searchText) {
                    AnnouncementController.to.filterPosition(searchText);
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Transform.translate(
                      offset: Offset(-10, 0),
                      child: Checkbox(
                          value: AnnouncementController.to.selectAllPositions,
                          onChanged: (value) {
                            AnnouncementController.to.selectAllPositions =
                                value!;
                            AnnouncementController.to.positionCheckboxStatus =
                                List.filled(
                              AnnouncementController
                                      .to
                                      .announcementJobPositionModel
                                      ?.data
                                      ?.length ??
                                  0,
                              value,
                            );
                            if (AnnouncementController.to.selectAllPositions) {
                              AnnouncementController.to.selectedPositionIds
                                  .addAll(AnnouncementController
                                      .to.filteredPositions
                                      .map((element) => int.parse(
                                          element?.positionName ?? "")));

                              AnnouncementController
                                      .to.selectedPositionIdsString =
                                  AnnouncementController.to.selectedPositionIds
                                      .join(",");
                            } else {
                              AnnouncementController.to.selectedPositionIds =
                                  [];
                            }
                            print(
                                'Position id ${AnnouncementController.to.selectedPositionIdsString.toString()}');
                          }),
                    ),
                    Transform.translate(
                      offset: Offset(-10, 0),
                      child: CustomText(
                          text: "Select all positions",
                          color: AppColors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                Container(
                  height: Get.height * 0.40,
                  child: commonLoader(
                    length:
                    6,
                    width: double.infinity,
                    loader: AnnouncementController.to.jobPositionList,
                    singleRow: true,
                    child: AnnouncementController.to.filteredPositions.length == 0
                        ? NoRecord()
                        : ListView.separated(
                      shrinkWrap: true,
                      itemCount: AnnouncementController
                          .to
                          .filteredPositions
                          .length ??
                          0,
                      itemBuilder: (context, index) {
                        var positionList = AnnouncementController.to
                            .filteredPositions?[index];
                        return Row(
                          children: [
                            AnnouncementController.to.jobPositionList ==
                                true
                                ? Skeleton()
                                : Transform.translate(
                              offset: Offset(-10, 0),
                              child: Checkbox(
                                value: AnnouncementController.to
                                    .positionCheckboxStatus[index],
                                onChanged: (value) {
                                  AnnouncementController
                                      .to.jobPositionList = true;
                                  AnnouncementController.to
                                      .positionCheckboxStatus[
                                  index] = value ?? false;
                                  if (value == true &&
                                      !AnnouncementController
                                          .to.selectedPositionIds
                                          .contains(
                                          positionList?.id)) {
                                    AnnouncementController
                                        .to.selectedPositionIds
                                        .add(int.parse(positionList!
                                        .id
                                        .toString() ??
                                        ""));
                                  } else if (value == false &&
                                      AnnouncementController
                                          .to.selectedPositionIds
                                          .contains(
                                          positionList?.id)) {
                                    AnnouncementController
                                        .to.selectedPositionIds
                                        .remove(int.parse(
                                        positionList?.id
                                            .toString() ??
                                            ""));
                                  }
                                  AnnouncementController.to
                                      .selectedPositionIdsString =
                                      AnnouncementController
                                          .to.selectedPositionIds
                                          .join(",");
                                  print(
                                      'separate department id ${AnnouncementController.to.selectedPositionIdsString}');
                                  AnnouncementController
                                      .to.jobPositionList = false;
                                },
                              ),
                            ),
                            Transform.translate(
                              offset: Offset(-10, 0),
                              child: CustomText(
                                  text: positionList?.positionName ?? "",
                                  color: AppColors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 10,
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 120,
                      child: CommonButton(
                          iconText: true,
                          text: 'publish',
                          icons: Icons.check,
                          buttonLoader: CommonController.to.buttonLoader,
                          iconSize: 18,
                          textColor: AppColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          onPressed: () async {
                            CommonController.to.buttonLoader = true;
                            await AnnouncementController.to
                                .positionAssign();
                            CommonController.to.buttonLoader = false;
                          }),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: 120,
                      child: BackToScreen(
                          text: "cancel",
                          filled: true,
                          icon: "assets/icons/cancel.svg",
                          iconColor: AppColors.grey,
                          arrowIcon: true,
                          onPressed: () async {
                           Get.to(()=> AnnouncementScreen());
                          }),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
