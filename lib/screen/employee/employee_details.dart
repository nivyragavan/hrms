import 'package:dreamhrms/controller/department/add_department_controller.dart';
import 'package:dreamhrms/controller/employee_details_controller/profile_controller.dart';
import 'package:dreamhrms/screen/employee/employee_details/profile.dart';
import 'package:dreamhrms/screen/employee/employee_details/teams.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localization/localization.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

import '../../constants/colors.dart';
import '../../controller/common_controller.dart';
import '../../controller/employee/employee_controller.dart';
import '../../controller/employee/personal_controller.dart';
import '../../services/provision_check.dart';
import '../../widgets/Custom_text.dart';
import '../../widgets/common.dart';
import '../../widgets/image_picker.dart';
import '../employee_screen/dependency_employee.dart';
import '../employee_screen/education_employee.dart';
import '../employee_screen/emergency_contact.dart';
import '../employee_screen/work_history_employee.dart';
import '../teamList.dart';
import 'employee_details/assets.dart';
import 'employee_details/documents.dart';
import 'employee_details/time_off.dart';
import 'employee_details/time_sheet.dart';

class EmployeeDetails extends StatelessWidget {
   EmployeeDetails({Key? key}) : super(key: key);
 final  List<String> tabKeys = ["profile", "teams", "assets", "time_off", "documents", "timesheet"];

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((value) {
      CommonController.to.imageBase64 = "";
    });
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        // leading: Icon(Icons.arrow_back_ios_new_outlined,color: AppColors.black),
        title: Row(
          children: [
            navBackButton(),
            SizedBox(width: 8),
            CustomText(
              text: "emp_details",
              color: AppColors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Stack(
                  children: [
                    Center(
                      child: ProfileController.to.showProfileList ||
                              CommonController.to.imageLoader == true
                          ? Container(
                              height: 92,
                              width: 92,
                              child: Skeleton(),
                            )
                          : ProvisionsWithIgnorePointer(
                        provision:'All Employees',type:"create",
                            child: InkWell(
                                onTap: () async {
                                  print("on Pressed image Picker");
                                  await _onImageSelectedFromGallery(
                                    PersonalController.to.imageController,
                                  );
                                  if (PersonalController
                                              .to.imageController.text !=
                                          "" &&
                                      AddDepartmentController.to.isNetworkImage(
                                              PersonalController
                                                  .to.imageController.text) ==
                                          false) {
                                    await PersonalController.to
                                        .employeeImageUpload(
                                            EmployeeController.to.selectedUserId);
                                    await ProfileController.to.getProfileList();
                                    await EmployeeController.to.getEmployeeList();
                                  }
                                },
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 92,
                                        width: 92,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: Image.network(
                                                commonNetworkImageDisplay(
                                                    '${ProfileController.to.profileModel?.data?.data?.profileImage}'),
                                                fit: BoxFit.cover,
                                                errorBuilder:
                                                    (BuildContext? context,
                                                        Object? exception,
                                                        StackTrace? stackTrace) {
                                                  return Image.asset(
                                                    "assets/images/user.jpeg",
                                                    fit: BoxFit.contain,
                                                  );
                                                },
                                              ).image,
                                            ),
                                            color: AppColors.white,
                                            border: Border.all(
                                              color: AppColors.grey,
                                            ),
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(14))),
                                      ),
                                      Positioned(
                                          left: 70,
                                          top: 70,
                                          child: Container(
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              gradient: AppColors.primaryColor1,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30)),
                                            ),
                                            child: Icon(
                                              Icons.camera_alt_outlined,
                                              color: AppColors.white,
                                              size: 16,
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                          ),
                    ),
                  ],
                ),
                CustomText(
                  text:
                      '${ProfileController.to.profileModel?.data?.data?.firstName ?? '-'} ${ProfileController.to.profileModel?.data?.data?.lastName ?? '-'}',
                  color: AppColors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 5),
                CustomText(
                  text:
                      '${ProfileController.to.profileModel?.data?.data?.jobPosition?.position?.positionName ?? "-"}',
                  color: AppColors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
          tabList()
        ],
      ),
    );
  }

  _onImageSelectedFromGallery(controller) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      CommonController.to.imageLoader = true;
      controller.text = pickedFile.path ?? "";
      print("pickedFile path${pickedFile.path}");
      CommonController.to.imageBase64 = await convertImageToBase64(pickedFile);
      CommonController.to.imageLoader = false;
    }
  }
}

tabList() {
  return Padding(
    padding: EdgeInsets.only(top: Get.height * 0.25),
    child: GetStorage().read("role")=="employee"?
    DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          elevation: 0,
          flexibleSpace: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 10),
                child: TabBar(
                  isScrollable: true,
                  indicatorColor: AppColors.secondaryColor,
                  labelColor: AppColors.secondaryColor,
                  unselectedLabelColor: AppColors.grey,
                  tabs: [
                    Tab(text: "emp_details"),
                    Tab(text: "emergency_contact"),
                    Tab(text: "depend_1"),
                    Tab(text: "education"),
                    Tab(text: "work_history"),
                  ],
                ),
              ),
              // Divider()
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Profile(),
            EmergencyContactEmployee(),
            DependenceEmployee(),
            EducationEmployee(),
            WorkHistoryEmployee(),
          ],
        ),
      ),
    )
        :DefaultTabController(
    length: 6,
    child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: TabBar(
                isScrollable: true,
                indicatorColor: AppColors.secondaryColor,
                labelColor: AppColors.secondaryColor,
                unselectedLabelColor: AppColors.grey,
                tabs: [
                  Tab(text: "profile"),
                  Tab(text: "teams"),
                  Tab(text: "assets"),
                  Tab(text: "time_off"),
                  Tab(text: "documents"),
                  Tab(text: "timesheet"),
                ],
              ),
            ),
            // Divider()
          ],
        ),
      ),
      body: TabBarView(
        children: [
          Profile(),
          EmployeeTeams(),
          Assets(),
          TimeOff(type:"admin"),
          Documents(),
          TimeSheet(),
        ],
      ),
    ),
  ),
  );
}
getTransWord(String key) async {
  var values=await CommonController.to.getTranslateKeyword(key);
  return values.toString();
}