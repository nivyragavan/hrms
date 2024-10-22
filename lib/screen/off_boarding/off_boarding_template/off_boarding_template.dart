import 'package:dreamhrms/controller/theme_controller.dart';
import 'package:dreamhrms/screen/employee/employee_details/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';

import '../../../constants/colors.dart';
import '../../../controller/common_controller.dart';
import '../../../controller/off_boarding/off_boarding_controller.dart';
import '../../../services/provision_check.dart';
import '../../../widgets/Custom_rich_text.dart';
import '../../../widgets/Custom_text.dart';
import '../../../widgets/back_to_screen.dart';
import '../../../widgets/common_alert_dialog.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/common_textformfield.dart';
import '../../../widgets/no_record.dart';
import '../off_boarding_screen.dart';
import 'detailed_off_boarding_template.dart';

class OffBoardingTemplateScreen extends StatelessWidget {
  OffBoardingTemplateScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((value) async {
      OffBoardingController.to.clearValues();
    await OffBoardingController.to.getTemplateList();
    });
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Get.offAll(OffBoardingScreen());
                  },
                  child: Icon(Icons.arrow_back_ios_new_outlined,
                      color: ThemeController.to.checkThemeCondition() == true ? AppColors.white : AppColors.black),
                ),
                SizedBox(width: 8),
                CustomText(
                  text: "offboarding_template",
                  color: AppColors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
            ProvisionsWithIgnorePointer(
              provision: "Offboarding",
              type:"create",
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: InkWell(
                  onTap: () {
                    addTemplateBottomSheet();
                  },
                  child: Container(
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryColor1,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    child: Icon(Icons.add, color: AppColors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      body: Obx(() {
        return Padding(
          padding: EdgeInsets.all(20),
          child: commonLoader(
            length: 6,
            singleRow: true,
            loader: OffBoardingController.to.showList,
            child: ViewProvisionedWidget(
              provision: "Offboarding",
              type: "view",
              child: OffBoardingController
                          .to.templateListModel?.data?.data?.length ==
                      0
                  ? NoRecord()
                  : ListView.separated(
                      shrinkWrap: true,
                      itemCount: OffBoardingController
                              .to.templateListModel?.data?.data?.length ??
                          0,
                      itemBuilder: (context, index) {
                        var templateList = OffBoardingController
                            .to.templateListModel?.data?.data?[index];
                        return InkWell(
                          onTap: () {
                            Get.to(() => DetailedOffBoardingTemplateScreen(
                                  templateListModel: OffBoardingController
                                      .to.templateListModel!.data!.data![index],
                                ));
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
                                      OffBoardingController.to.templateName
                                          .text = templateList!.templateName!;
                                      OffBoardingController.to.description
                                          .text = templateList.description!;
                                      editTemplateBottomSheet(index);
                                    },
                                    backgroundColor: AppColors.blue,
                                    foregroundColor: Colors.white,
                                    icon: Icons.edit_outlined,
                                  ),
                                  SlidableAction(
                                    onPressed: (context) {
                                      commonAlertDialog(
                                        icon: Icons.delete_outline,
                                        context:context,
                                        title: "delete_template ?",
                                        description: 'all_details_in_this_template_will_be_deleted.',
                                        actionButtonText: "delete",
                                        onPressed: () async {
                                          CommonController.to.buttonLoader = true;
                                          await OffBoardingController.to.deleteTemplate(index);
                                          CommonController.to.buttonLoader = false;
                                        }, provision: 'Offboarding', provisionType: 'delete',
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
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                color: ThemeController.to.checkThemeCondition() == true ? AppColors.black : AppColors.white,
                                child: ListTile(
                                  title: Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: CustomText(
                                        text: templateList!.templateName ?? "-",
                                        color: AppColors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  subtitle: CustomText(
                                      text: templateList.description ?? "-",
                                      color: AppColors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                  trailing: Container(
                                    width: 28,
                                    height: 28,
                                    decoration: BoxDecoration(
                                        color: AppColors.lightGrey,
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Icon(
                                      Icons.chevron_right,
                                      color: AppColors.grey,
                                    ),
                                  ),
                                ),
                              ),
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
            ),
          ),
        );
      }),
    );
  }

  addTemplateBottomSheet() {
    return Get.bottomSheet(
        isDismissible: false,
        ProvisionsWithIgnorePointer(
          provision: "Offboarding",
          type:"create",
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: ThemeController.to.checkThemeCondition() == true ? AppColors.black : AppColors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40))),
        child: ListView(
          shrinkWrap: true,
          children: [buildAddTemplateInformation()],
        ),
      ),
    ));
  }

  buildAddTemplateInformation() {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 75,
              height: 4,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.grey),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          CustomText(
              text: 'add_template',
              color: AppColors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600),
          const SizedBox(
            height: 15,
          ),
          CustomRichText(
              textAlign: TextAlign.left,
              text: 'template_name',
              color: AppColors.black,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              textSpan: '*',
              textSpanColor: AppColors.red),
          SizedBox(height: 10),
          CommonTextFormField(
            controller: OffBoardingController.to.templateName,
            isBlackColors: true,
            keyboardType: TextInputType.name,
            validator: (String? data) {
              if (data == "" || data == null) {
                print("Empty data");
                return "required_template_name";
              } else {
                return null;
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          CustomRichText(
              textAlign: TextAlign.left,
              text: 'template_description',
              color: AppColors.black,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              textSpan: '*',
              textSpanColor: AppColors.red),
          SizedBox(height: 10),
          CommonTextFormField(
            controller: OffBoardingController.to.description,
            isBlackColors: true,
            maxlines: 3,
            keyboardType: TextInputType.name,
            validator: (String? data) {
              if (data == "" || data == null) {
                print("Empty data");
                return "required_description";
              } else {
                return null;
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: Obx (() => CommonButton(
                  text: "add_template",
                  textColor: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  buttonLoader: CommonController.to.buttonLoader,
                  onPressed: () async{
                    if (formKey.currentState!.validate()) {
                      CommonController.to.buttonLoader = true;
                      await OffBoardingController.to.addTemplate();
                      CommonController.to.buttonLoader = false;
                    }
                  },
                )),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          BackToScreen(
            text: "cancel",
            arrowIcon: false,
            onPressed: () {
              OffBoardingController.to.clearValues();
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  editTemplateBottomSheet(int templateId) {
    return Get.bottomSheet(
        ProvisionsWithIgnorePointer(
          provision: "Offboarding",
          type:"create",
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: ThemeController.to.checkThemeCondition() == true ? AppColors.black : AppColors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40))),
        child: ListView(
          shrinkWrap: true,
          children: [buildEditTemplateInformation(templateId)],
        ),
      ),
    ));
  }

  buildEditTemplateInformation(int index) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 75,
              height: 4,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.grey),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          CustomText(
              text: 'edit_template',
              color: AppColors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600),
          const SizedBox(
            height: 15,
          ),
          CustomRichText(
              textAlign: TextAlign.left,
              text: 'template_name',
              color: AppColors.black,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              textSpan: '*',
              textSpanColor: AppColors.red),
          SizedBox(height: 10),
          CommonTextFormField(
            controller: OffBoardingController.to.templateName,
            isBlackColors: true,
            keyboardType: TextInputType.name,
            validator: (String? data) {
              if (data == "" || data == null) {
                print("Empty data");
                return "required_template_name";
              } else {
                return null;
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          CustomRichText(
              textAlign: TextAlign.left,
              text: 'template_description',
              color: AppColors.black,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              textSpan: '*',
              textSpanColor: AppColors.red),
          SizedBox(height: 10),
          CommonTextFormField(
            controller: OffBoardingController.to.description,
            isBlackColors: true,
            maxlines: 3,
            keyboardType: TextInputType.name,
            validator: (String? data) {
              if (data == "" || data == null) {
                print("Empty data");
                return "required_description";
              } else {
                return null;
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: Obx (() => CommonButton(
                  text: "edit_template",
                  textColor: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  buttonLoader: CommonController.to.buttonLoader,
                  onPressed: () async{
                    if (formKey.currentState!.validate()) {
                      CommonController.to.buttonLoader = true;
                      await OffBoardingController.to.editTemplate(index);
                      CommonController.to.buttonLoader = false;
                    }
                  },
                )),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          BackToScreen(
            text: "cancel",
            arrowIcon: false,
            onPressed: () {
              OffBoardingController.to.clearValues();
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  deleteDialogBox(int deleteIndex) {
    return Get.defaultDialog(
        title: "",
        content: Container(
          width: Get.width,
          height: Get.height * 0.30,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Icon(
                Icons.delete_outline,
                color: AppColors.blue,
              ),
              SizedBox(
                height: 18,
              ),
              CustomText(
                  text: 'delete_template ?',
                  color: AppColors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
              SizedBox(
                height: 18,
              ),
              CustomText(
                  text: 'all_details_in_this_template_will_be_deleted.',
                  color: AppColors.grey,
                  fontSize: 14,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w400),
              SizedBox(
                height: 18,
              ),
              Row(
                children: [
                  Expanded(
                    child: CommonButton(
                      text: "delete",
                      textColor: AppColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      onPressed: () async{
                        CommonController.to.buttonLoader = true;
                        await OffBoardingController.to
                                .deleteTemplate(deleteIndex);
                        CommonController.to.buttonLoader = false;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              BackToScreen(
                text: "cancel",
                arrowIcon: false,
                onPressed: () {
                  Get.back();
                },
              ),
            ],
          ),
        ));
  }
}
