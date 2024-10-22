import 'package:dreamhrms/constants/colors.dart';
import 'package:dreamhrms/controller/common_controller.dart';
import 'package:dreamhrms/widgets/Custom_text.dart';
import 'package:dreamhrms/widgets/common_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

import '../../../controller/announcement_controller.dart';
import '../../../widgets/back_to_screen.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/no_record.dart';
import '../../employee/employee_details/profile.dart';
import '../announcement.dart';

class EmployeesTabScreen extends StatelessWidget {
  const EmployeesTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      AnnouncementController.to.showUserList = true;
      await AnnouncementController.to.getEmployeeList();
      await AnnouncementController.to.filterUsers("");
      if (AnnouncementController.to.isEdit == "Edit") {
        for (final user in AnnouncementController.to.filteredUsers) {
          final isSelected = AnnouncementController.to.selectedUserIds.contains(user?.id);
          final index = AnnouncementController.to.filteredUsers.indexOf(user);
          while (index >= AnnouncementController.to.userCheckboxStatus.length) {
            AnnouncementController.to.userCheckboxStatus.add(false);
          }
          if (index >= 0 && index < AnnouncementController.to.userCheckboxStatus.length) {
            AnnouncementController.to.userCheckboxStatus[index] = isSelected;
          }
        }
      } else {
        AnnouncementController.to.userCheckboxStatus = List.generate(
          AnnouncementController
                  .to.employeeListModel?.data?.data?.data?.length ??
              0,
          (index) => false,
        );
      }
      AnnouncementController.to.showUserList = false;
    });
    return Scaffold(
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            children: [
              CommonTextFormField(
                isBlackColors: true,
                hintText: "Search",
                prefixIcon: Icons.search,
                keyboardType: TextInputType.name,
                onChanged: (searchText) {
                  AnnouncementController.to.filterUsers(searchText);
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
                        value: AnnouncementController.to.selectAllUsers,
                        onChanged: (value) {
                          AnnouncementController.to.selectAllUsers = value!;
                          AnnouncementController.to.userCheckboxStatus =
                              List.filled(
                            AnnouncementController.to.employeeListModel?.data
                                    ?.data?.data?.length ??
                                0,
                            value,
                          );
                          if (AnnouncementController.to.selectAllUsers) {
                            AnnouncementController.to.selectedUserIds.addAll(
                                AnnouncementController.to.filteredUsers
                                    .map((element) => element?.id ?? 0));
                            AnnouncementController.to.selectedUserIdsString =
                                AnnouncementController.to.selectedUserIds
                                    .join(",");
                          } else {
                            AnnouncementController.to.selectedUserIds = [];
                            AnnouncementController.to.selectedUserIdsString =
                                AnnouncementController.to.selectedUserIds
                                    .join(",");
                          }
                          print(
                              'user id ${AnnouncementController.to.selectedUserIdsString.toString()}');
                        },
                      )),
                  Transform.translate(
                    offset: Offset(-20, 0),
                    child: CustomText(
                        text: "Select all employees",
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
                  loader: AnnouncementController.to.showUserList,
                  singleRow: true,
                  child: AnnouncementController.to.filteredUsers.length == 0 ||
                          AnnouncementController.to.filteredUsers == []
                      ? NoRecord()
                      : ListView.separated(
                          shrinkWrap: true,
                          itemCount:
                              AnnouncementController.to.filteredUsers.length,
                          itemBuilder: (context, index) {
                            var employeeList =
                                AnnouncementController.to.filteredUsers[index];
                            return ListTile(
                              leading: AnnouncementController.to.showUserList ==
                                      true
                                  ? Skeleton()
                                  : Transform.translate(
                                      offset: Offset(-20, 0),
                                      child: Checkbox(
                                        value: AnnouncementController
                                            .to.userCheckboxStatus[index],
                                        onChanged: (value) {
                                          AnnouncementController
                                              .to.showUserList = true;
                                          AnnouncementController.to
                                                  .userCheckboxStatus[index] =
                                              value ?? false;
                                          if (value == true &&
                                              !AnnouncementController
                                                  .to.selectedUserIds
                                                  .contains(employeeList?.id)) {
                                            AnnouncementController
                                                .to.selectedUserIds
                                                .add(int.parse(employeeList?.id
                                                        .toString() ??
                                                    ""));
                                          } else if (value == false &&
                                              AnnouncementController
                                                  .to.selectedUserIds
                                                  .contains(employeeList?.id)) {
                                            AnnouncementController
                                                .to.selectedUserIds
                                                .remove(int.parse(employeeList
                                                        ?.id
                                                        .toString() ??
                                                    ""));
                                          }
                                          AnnouncementController
                                                  .to.selectedUserIdsString =
                                              AnnouncementController
                                                  .to.selectedUserIds
                                                  .join(",");
                                          print(
                                              'separate user id ${AnnouncementController.to.selectedUserIdsString}');
                                          AnnouncementController
                                              .to.showUserList = false;
                                        },
                                      ),
                                    ),
                              title: Transform.translate(
                                offset: Offset(-30, 0),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: employeeList
                                                      ?.profileImage !=
                                                  null &&
                                              employeeList?.profileImage != ""
                                          ? Image.network(
                                                  employeeList?.profileImage ??
                                                      "")
                                              .image
                                          : AssetImage(
                                              'assets/images/user.jpeg'),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                            text:
                                                "${employeeList?.firstName ?? ""} ${employeeList?.lastName ?? ""}",
                                            color: AppColors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        CustomText(
                                            text:
                                                "${employeeList?.userUniqueId ?? "-"}",
                                            color: AppColors.grey,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w400),
                                      ],
                                    )
                                  ],
                                ),
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
                          await AnnouncementController.to.userAssign();
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
        ),
      ),
    );
  }
}
