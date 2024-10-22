import 'package:dreamhrms/controller/theme_controller.dart';
import 'package:dreamhrms/screen/employee/employee_details/profile.dart';
import 'package:dreamhrms/widgets/expansion.dart';
import 'package:dreamhrms/widgets/no_record.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:localization/localization.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

import '../../constants/colors.dart';
import '../../controller/department/add_department_controller.dart';
import '../../controller/department/deparrtment_controller.dart';
import '../../services/provision_check.dart';
import '../../widgets/Custom_text.dart';
import '../../widgets/common.dart';
import '../../widgets/stacket_image_widget.dart';
import 'add_department.dart';

class Department extends StatelessWidget {
  const Department({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration(seconds: 1)).then((value) async {
    //   await DepartmentController.to.getDepartmentList();
    //   DepartmentController.to.showDepartmentList = true;
    //   await AddDepartmentController.to.getGradeList();
    //   DepartmentController.to.showDepartmentList = false;
    // });
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
                navBackButton(),
                SizedBox(width: 8),
                CustomText(
                  text: "department",
                  color: AppColors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
            Padding(
             padding: const EdgeInsets.only(right: 10),
             child: InkWell(
               onTap: () async {
                 await AddDepartmentController.to.clearData();
                 Get.to(() => AddDepartment(option: 'Add'));
               },
               child: Container(
                 height: 36,
                 width: 36,
                 decoration: BoxDecoration(
                     color: AppColors.blue,
                     borderRadius: BorderRadius.all(Radius.circular(8))),
                 child: Icon(Icons.add, color: AppColors.white),
               ),
             ),
              ),

          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Obx(
            () => ViewProvisionedWidget(
              provision: 'Department',
              type:"view",
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      color: AppColors.blue.withOpacity(0.12),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: CustomText(
                          text: GetStorage().read("comp_name")??"",
                          color: AppColors.blue,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  commonLoader(
                    loader: DepartmentController.to.showDepartmentList,
                    length: MediaQuery.of(context).size.height.toInt(),
                    singleRow: true,
                    child:
                        DepartmentController.to.departmentModel?.data?.length == 0
                            ? NoRecord()
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemCount: DepartmentController
                                        .to.departmentModel?.data?.length ??
                                    0,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SingleChildScrollView(
                                          child: ExpansionTileWidget(
                                            mainIndex: index,
                                            title: CustomText(
                                              text:
                                                  '${DepartmentController.to.departmentModel?.data?[index].departmentName}',
                                              color: AppColors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            subTitle: CustomText(
                                              textAlign: TextAlign.start,
                                              text:
                                                  "${'employees'} ${DepartmentController.to.departmentModel?.data?[index].empCount}",
                                              color: AppColors.grey,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            image: Image.network(
                                                commonNetworkImageDisplay(
                                                    '${DepartmentController.to.departmentModel?.data?[index].departmentIcon}'),
                                                fit: BoxFit.cover,
                                                width: 40.0,
                                                height: 40.0),
                                            expansionList: DepartmentController
                                                .to
                                                .departmentModel
                                                ?.data?[index]
                                                .positions,
                                            value: "Department",
                                            editOnPressed: () async {
                                              Get.to(() =>
                                                  AddDepartment(option: 'SubEdit'));
                                            },
                                            ContainerOnClick: () {
                                              _buildPopupDialog(context, index);
                                            },
                                            editIcon: SvgPicture.asset(
                                                "assets/icons/edit_out.svg"),
                                            headerEditOnPressed: () async {
                                              await AddDepartmentController.to.clearData();
                                          await AddDepartmentController.to.setControllerHeaderEdit(DepartmentController.to.departmentModel?.data?[index]);
                                          Get.to(() => AddDepartment(option: "HeaderEdit"));
                                          }
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildPopupDialog(BuildContext context, int index) {
    DepartmentController.to.departmentModel?.data?[index].status.toString() ==
            "1"
        ? DepartmentController.to.positionSwitch = true
        : DepartmentController.to.positionSwitch = false;
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
            height: 260,
            decoration: BoxDecoration(
                color: ThemeController.to.checkThemeCondition() == true ? AppColors.black : AppColors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Center(
                    child: Container(
                      width: 75,
                      height: 4,
                      decoration: BoxDecoration(
                          color: AppColors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                    ),
                  ),
                  SizedBox(height: 10),
                  CustomText(
                      text: "hr_dept",
                      color: AppColors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: Get.width * 0.40,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                                text: "employees",
                                color: AppColors.grey,
                                fontSize: 13,
                                fontWeight: FontWeight.w400),
                            SizedBox(height: 8),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildExpandedBox(
                                  color: ThemeController.to.checkThemeCondition() == true ? AppColors.black : AppColors.white,
                                  children: [
                                    buildStackedImages(
                                        images: DepartmentController
                                            .to
                                            .departmentModel
                                            ?.data?[index]
                                            .profileImage,
                                        direction: TextDirection.rtl,
                                        imgsize: 38,
                                        showCount: DepartmentController.to
                                            .checkProfileImage(
                                                DepartmentController
                                                    .to
                                                    .departmentModel
                                                    ?.data?[index]
                                                    .profileImage
                                                    ?.length)),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20),
                      commonSingleDataDisplay(
                        title1: "head_dept",
                        text1:
                            '${DepartmentController.to.departmentModel?.data?[index].departmentName}',
                        titleFontSize: 13,
                        titleFontColor: AppColors.grey,
                        titleFontWeight: FontWeight.w400,
                        textFontSize: 14,
                        textFontColor: AppColors.black,
                        textFontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: Get.width * 0.40,
                        child: commonSingleDataDisplay(
                          title1: "position",
                          text1:
                              '${DepartmentController.to.departmentModel?.data?[index].positions?.length}',
                          titleFontSize: 13,
                          titleFontColor: AppColors.grey,
                          titleFontWeight: FontWeight.w400,
                          textFontSize: 14,
                          textFontColor: AppColors.black,
                          textFontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "position",
                            color: AppColors.grey,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(height: 10),
                          ProvisionsWithIgnorePointer(
                            provision: 'Department',
                            type:"create",
                            child: positionToggle(
                                '${DepartmentController.to.departmentModel?.data?[index].departmentId}'),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  Obx positionToggle(String departmentId) {
    return Obx(
      () => DepartmentController.to.switchLoader == true
          ? Skeleton(width: 10,height: 20,)
          : FlutterSwitch(
              height: 25,
              width: 50,
              valueFontSize: 11,
              activeColor: AppColors.blue,
              activeTextColor: AppColors.grey,
              inactiveColor: AppColors.lightGrey,
              inactiveTextColor: AppColors.grey,
              value: DepartmentController.to.positionSwitch,
              onToggle: (val) async {
                DepartmentController.to.switchLoader = true;
                await DepartmentController.to
                    .PositionStatus(val == true ? 1 : 2, departmentId);
                DepartmentController.to.positionSwitch = val;
                DepartmentController.to.switchLoader = false;
              },
            ),
    );
  }
}
