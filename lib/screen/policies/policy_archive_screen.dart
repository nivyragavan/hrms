import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';

import '../../constants/colors.dart';
import '../../controller/policy_controller.dart';
import '../../controller/theme_controller.dart';
import '../../widgets/Custom_text.dart';
import '../../widgets/common_alert_dialog.dart';
import 'add_policies_screen.dart';


class PolicyArchiveScreen extends StatelessWidget {
  const PolicyArchiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
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
              text: "archive".i18n(),
              color: AppColors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
      body: buildArchiveList(),
    );
  }

  buildArchiveList() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
                color: ThemeController.to.checkThemeCondition() == true
                    ? AppColors.black
                    : AppColors.white,
                border: Border.all(color: AppColors.grey.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(8)),
            child: Slidable(
              closeOnScroll: true,
              endActionPane: ActionPane(
                extentRatio: 0.3,
                motion: const BehindMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      PolicyController.to.isEdit = "Edit";
                      Get.to(() => AddPoliciesScreen());
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
                        title: "delete_policy ?".i18n(),
                        description:
                        'are_you_sure_you_want_to_delete_this_policy ?'
                            .i18n(),
                        actionButtonText: "delete".i18n(),
                        onPressed: () async {},
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
                margin: EdgeInsets.symmetric(horizontal: 6),
                padding: EdgeInsets.symmetric(vertical: 6),
                color: ThemeController.to.checkThemeCondition() == true
                    ? AppColors.black
                    : AppColors.white,
                child: ListTile(
                    leading: Container(
                        width: 50,
                        height: 50,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: AppColors.lightRed,
                            borderRadius: BorderRadius.circular(4)),
                        child: SvgPicture.asset(
                          'assets/icons/calendar_filled.svg',
                          color: AppColors.red,
                        )),
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: CustomText(
                          text: "Leave Policy 2023",
                          color: AppColors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    subtitle: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: Get.width * 0.25,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                  text: "created_at".i18n(),
                                  color: AppColors.grey,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400),
                              SizedBox(height: 8),
                              CustomText(
                                  text: "03-11-2023",
                                  color: AppColors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500)
                            ],
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.25,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                  text: "expiry_date".i18n(),
                                  color: AppColors.grey,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400),
                              SizedBox(height: 8),
                              CustomText(
                                  text: "05-11-2023",
                                  color: AppColors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500)
                            ],
                          ),
                        ),
                      ],
                    ),
                    trailing: GestureDetector(
                        onTap: () {
                          viewPolicyBottomSheet();
                        },
                        child: Icon(Icons.visibility_outlined))),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 15,
          );
        },
      ),
    );
  }

  viewPolicyBottomSheet() {
    return Get.bottomSheet(
        isDismissible: false,
        enableDrag: false,
        SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: CircleAvatar(
                        backgroundColor:
                        ThemeController.to.checkThemeCondition() == true
                            ? AppColors.black
                            : AppColors.white,
                        child: Icon(
                          Icons.close,
                          color:
                          ThemeController.to.checkThemeCondition() == true
                              ? AppColors.white
                              : AppColors.black,
                        ))),
              ),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: ThemeController.to.checkThemeCondition() == true
                        ? AppColors.black
                        : AppColors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Column(
                  children: [buildDetails()],
                ),
              ),
            ],
          ),
        ));
  }

  buildDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            width: 75,
            height: 4,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: AppColors.grey),
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        CustomText(
            text: "Leave Policy 2023",
            color: AppColors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600),
        const SizedBox(
          height: 25,
        ),
        CustomText(
            text: "description".i18n(),
            color: AppColors.grey,
            fontSize: 11,
            fontWeight: FontWeight.w400),
        const SizedBox(
          height: 10,
        ),
        CustomText(
            text: "At vero eos accusamus et odio",
            color: AppColors.black,
            fontSize: 12,
            fontWeight: FontWeight.w400),
        const SizedBox(
          height: 20,
        ),
        CustomText(
            text: "created_at".i18n(),
            color: AppColors.grey,
            fontSize: 11,
            fontWeight: FontWeight.w400),
        const SizedBox(
          height: 10,
        ),
        CustomText(
            text: "03-11-2023 Friday",
            color: AppColors.black,
            fontSize: 12,
            fontWeight: FontWeight.w400),
        const SizedBox(
          height: 20,
        ),
        CustomText(
            text: "expiry_date".i18n(),
            color: AppColors.grey,
            fontSize: 11,
            fontWeight: FontWeight.w400),
        const SizedBox(
          height: 10,
        ),
        CustomText(
            text: "05-11-2023 Sunday",
            color: AppColors.black,
            fontSize: 12,
            fontWeight: FontWeight.w400),
        const SizedBox(
          height: 20,
        ),
        CustomText(
            text: "department".i18n(),
            color: AppColors.grey,
            fontSize: 11,
            fontWeight: FontWeight.w400),
        const SizedBox(
          height: 10,
        ),
        CustomText(
            text: "All Department",
            color: AppColors.black,
            fontSize: 12,
            fontWeight: FontWeight.w400),
      ],
    );
  }
}
