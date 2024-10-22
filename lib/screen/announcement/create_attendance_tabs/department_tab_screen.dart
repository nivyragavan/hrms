import 'package:dreamhrms/controller/announcement_controller.dart';
import 'package:dreamhrms/controller/common_controller.dart';
import 'package:dreamhrms/screen/employee/employee_details/profile.dart';
import 'package:dreamhrms/widgets/no_record.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

import '../../../constants/colors.dart';
import '../../../widgets/Custom_text.dart';
import '../../../widgets/back_to_screen.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/common_textformfield.dart';
import '../announcement.dart';

class DepartmentTabScreen extends StatelessWidget {
  const DepartmentTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      AnnouncementController.to.showDepartmentList = true;
      await AnnouncementController.to.getDepartmentList();
      AnnouncementController.to.filterDepartments("");
      AnnouncementController.to.selectedDepartmentIdsString = "";
      if (AnnouncementController.to.isEdit == "Edit") {
        for (final user in AnnouncementController.to.filteredDepartments) {
          final isSelected = AnnouncementController.to.selectedDepartmentIds
              .contains(user?.departmentId);
          final index =
              AnnouncementController.to.filteredDepartments.indexOf(user);
          while (index >=
              AnnouncementController.to.departmentCheckboxStatus.length) {
            AnnouncementController.to.departmentCheckboxStatus.add(false);
          }
          if (index >= 0 &&
              index <
                  AnnouncementController.to.departmentCheckboxStatus.length) {
            AnnouncementController.to.departmentCheckboxStatus[index] =
                isSelected;
          }
        }
      } else {
        AnnouncementController.to.departmentCheckboxStatus = List.generate(
          AnnouncementController.to.departmentModel?.data?.length ?? 0,
          (index) => false,
        );
      }
      AnnouncementController.to.showDepartmentList = false;
    });
    return Scaffold(
        
        body: Obx(() => Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Column(
                children: [
                  CommonTextFormField(
                    isBlackColors: true,
                    hintText: "Search",
                    prefixIcon: Icons.search,
                    keyboardType: TextInputType.name,
                    onChanged: (searchText) {
                      AnnouncementController.to.filterDepartments(searchText);
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
                            value:
                                AnnouncementController.to.selectAllDepartments,
                            onChanged: (value) {
                              AnnouncementController.to.selectAllDepartments =
                                  value!;
                              AnnouncementController
                                  .to.departmentCheckboxStatus = List.filled(
                                AnnouncementController
                                        .to.departmentModel?.data?.length ??
                                    0,
                                value,
                              );
                              if (AnnouncementController
                                  .to.selectAllDepartments) {
                                AnnouncementController.to.selectedDepartmentIds
                                    .addAll(AnnouncementController
                                        .to.filteredDepartments
                                        .map((element) => int.parse(
                                            element?.departmentId ?? "")));
                                AnnouncementController
                                        .to.selectedDepartmentIdsString =
                                    AnnouncementController
                                        .to.selectedDepartmentIds
                                        .join(",");
                              } else {
                                AnnouncementController
                                    .to.selectedDepartmentIds = [];
                                AnnouncementController
                                        .to.selectedDepartmentIdsString =
                                    AnnouncementController
                                        .to.selectedDepartmentIds
                                        .join(",");
                              }
                              print(
                                  'department id ${AnnouncementController.to.selectedDepartmentIdsString.toString()}');
                            }),
                      ),
                      Transform.translate(
                        offset: Offset(-10, 0),
                        child: CustomText(
                            text: "Select all departments",
                            color: AppColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  Container(
                    height: Get.height * 0.40,
                    child: commonLoader(
                      length: 5,
                      loader: AnnouncementController.to.showDepartmentList,
                      singleRow: true,
                      child: AnnouncementController
                                  .to.filteredDepartments.length ==
                              0
                          ? NoRecord()
                          : ListView.separated(
                              shrinkWrap: true,
                              itemCount: AnnouncementController
                                  .to.filteredDepartments.length,
                              itemBuilder: (context, index) {
                                var departmentList = AnnouncementController
                                    .to.filteredDepartments[index];
                                return Row(
                                  children: [
                                    AnnouncementController
                                                .to.showDepartmentList ==
                                            true
                                        ? Skeleton()
                                        : Transform.translate(
                                            offset: Offset(-10, 0),
                                            child: Checkbox(
                                              value: AnnouncementController.to
                                                      .departmentCheckboxStatus[
                                                  index],
                                              onChanged: (value) {
                                                AnnouncementController.to
                                                    .showDepartmentList = true;
                                                AnnouncementController.to
                                                        .departmentCheckboxStatus[
                                                    index] = value ?? false;
                                                if (value == true &&
                                                    !AnnouncementController.to
                                                        .selectedDepartmentIds
                                                        .contains(departmentList
                                                            ?.departmentId)) {
                                                  AnnouncementController
                                                      .to.selectedDepartmentIds
                                                      .add(int.parse(
                                                          departmentList
                                                                  ?.departmentId
                                                                  .toString() ??
                                                              ""));
                                                } else if (value == false &&
                                                    AnnouncementController.to
                                                        .selectedDepartmentIds
                                                        .contains(departmentList
                                                            ?.departmentId)) {
                                                  AnnouncementController
                                                      .to.selectedDepartmentIds
                                                      .remove(int.parse(
                                                          departmentList
                                                                  ?.departmentId
                                                                  .toString() ??
                                                              ""));
                                                }
                                                AnnouncementController.to
                                                        .selectedDepartmentIdsString =
                                                    AnnouncementController.to
                                                        .selectedDepartmentIds
                                                        .join(",");
                                                print(
                                                    'separate department id ${AnnouncementController.to.selectedDepartmentIdsString}');
                                                AnnouncementController.to
                                                    .showDepartmentList = false;
                                              },
                                            ),
                                          ),
                                    Transform.translate(
                                      offset: Offset(-10, 0),
                                      child: CustomText(
                                          text:
                                              departmentList?.departmentName ??
                                                  "-",
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
                            iconSize: 18,
                            textColor: AppColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            buttonLoader: CommonController.to.buttonLoader,
                            onPressed: () async {
                              CommonController.to.buttonLoader = true;
                              await AnnouncementController.to
                                  .departmentAssign();
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
                            onPressed: () {
                              Get.to(()=> AnnouncementScreen());
                            }),
                      ),
                    ],
                  )
                ],
              ),
            )
        )
    );
  }
}
