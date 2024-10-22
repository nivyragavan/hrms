import 'package:dreamhrms/controller/policy_controller.dart';
import 'package:dreamhrms/widgets/back_to_screen.dart';
import 'package:dreamhrms/widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

import '../../constants/colors.dart';
import '../../controller/announcement_controller.dart';
import '../../controller/common_controller.dart';
import '../../controller/theme_controller.dart';
import '../../widgets/Custom_rich_text.dart';
import '../../widgets/Custom_text.dart';
import '../../widgets/common.dart';
import '../../widgets/common_textformfield.dart';
import '../../widgets/custom_dotted_border.dart';
import '../schedule/multi_select_dropdown.dart';

class AddPoliciesScreen extends StatelessWidget {
  const AddPoliciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      AnnouncementController.to.showDepartmentList = true;
      await AnnouncementController.to.getDepartmentList();
      AnnouncementController.to.showDepartmentList = false;
    });
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
                PolicyController.to.isEdit = "";
                Get.back();
              },
              child: Icon(Icons.arrow_back_ios_new_outlined,
                  color: ThemeController.to.checkThemeCondition() == true
                      ? AppColors.white
                      : AppColors.black),
            ),
            SizedBox(width: 8),
            CustomText(
              text: PolicyController.to.isEdit == ""
                  ? "add_policy"
                  : "edit_policy",
              color: AppColors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
      body: buildAddPolicy(),
    );
  }

  buildAddPolicy() {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomRichText(
                textAlign: TextAlign.left,
                text: 'policy_name',
                color: AppColors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                textSpan: '*',
                textSpanColor: AppColors.red),
            SizedBox(height: 10),
            CommonTextFormField(
              controller: PolicyController.to.policyName,
              isBlackColors: true,
              // hintText: "enter_policy_name".i18n(),
              keyboardType: TextInputType.name,
              validator: (String? data) {
                if (data == "" || data == null) {
                  return "policy_name_validation";
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            CustomRichText(
                textAlign: TextAlign.left,
                text: 'description',
                color: AppColors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                textSpan: '*',
                textSpanColor: AppColors.red),
            SizedBox(height: 10),
            CommonTextFormField(
              controller: PolicyController.to.description,
              isBlackColors: true,
              // hintText: "enter_description".i18n(),
              maxlines: 5,
              keyboardType: TextInputType.name,
              validator: (String? data) {
                if (data == "" || data == null) {
                  return "required_description";
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            CustomRichText(
                textAlign: TextAlign.left,
                text: 'department',
                color: AppColors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                textSpan: '*',
                textSpanColor: AppColors.red),
            SizedBox(height: 10),
            AnnouncementController.to.showDepartmentList
                ? Skeleton(
                    width: double.infinity,
                    height: 30,
                  )
                : MultiSelectDropDown(
                    title: "select_department".i18n(),
                    items: AnnouncementController.to.departmentModel?.data
                            ?.map((type) => "${type.departmentName}")
                            .toList() ??
                        [],
                    onChanged: (value) {},
                    selectedItems: PolicyController.to.selectedDepartments),
            SizedBox(
              height: 20,
            ),
            CustomRichText(
              textAlign: TextAlign.left,
              text: "policies_document",
              color: AppColors.black,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              textSpan: "*",
              textSpanColor: AppColors.red,
            ),
            SizedBox(height: 10),
            CustomDottedBorder(onPressed: () {
              pickFiles(
                  loader: PolicyController.to.loader,
                  controller: PolicyController.to.departmentName,
                  binary: PolicyController.to.department,
                  key: "department");
            }),
            SizedBox(
              height: 10,
            ),
            if (PolicyController.to.departmentName.text != null &&
                (CommonController.to.officeImageSize <= 50))
              CustomText(
                  text: PolicyController.to.departmentName.text,
                  color: AppColors.green,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            if (PolicyController.to.departmentName.text != null &&
                (CommonController.to.officeImageSize > 50))
              CustomText(
                  text: "image_size_exceed_50mb",
                  color: AppColors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: CommonButton(
                      text: 'create',
                      textColor: AppColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      onPressed: () {
                        PolicyController.to.isEdit = "";
                      }),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            BackToScreen(
                text: 'cancel',
                arrowIcon: false,
                onPressed: () {
                  PolicyController.to.isEdit = "";
                  Get.back();
                })
          ],
        ),
      );
    });
  }
}
