import 'package:dreamhrms/constants/colors.dart';
import 'package:dreamhrms/screen/employee_screen/employee_profile.dart';
import 'package:dreamhrms/screen/leave/leave.dart';
import 'package:dreamhrms/screen/settings.dart';
import 'package:dreamhrms/widgets/Custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controller/common_controller.dart';
import '../controller/employee/employee_controller.dart';
import '../controller/provision/provision_controller.dart';
import '../services/provision_check.dart';
import '../services/utils.dart';
import 'admin_assets/admin_assets_list.dart';
import 'attendance/attendance_screen.dart';
import 'attendance/employee_attendance_screen.dart';
import 'employee/add_employee_screen.dart';
import 'employee/employee_details/time_off.dart';
import 'employee/employee_list.dart';
import 'home.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  int currentTab = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero).then((value) async => await CommonController.to.checkInternetConnectivity()
    );
  }
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomeScreen();
  @override
  Widget build(BuildContext context) {
    return  GetStorage().read("role")=="employee"?
    Scaffold(
        floatingActionButton:
        Container(
          child: ProvisionsWithIgnorePointer(
            provision:'All Employees',type:"create",
            child: FloatingActionButton(
             onPressed: () {
                 EmployeeController.to.isEmployee = "";
                 Get.to(() => AddEmployeeScreen(selectedIndex: 0));
             },
             foregroundColor: Colors.black,
             backgroundColor: Colors.white,
             child: Container(
               width: 60,
               height: 60,
               child: Icon(
                 Icons.add,
                 size: 40,
                 color: Colors.white,
               ),
               decoration: BoxDecoration(
                   shape: BoxShape.circle,
                   gradient: LinearGradient(colors: [
                     Color.fromRGBO(
                         64, 190, 84, 1), // Replace with your desired color values
                     Color.fromRGBO(
                         0, 174, 235, 1), // Replace with your desired color values
                   ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
             ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          notchMargin: 10,
          shape: CircularNotchedRectangle(),
          child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    setBottomUI(
                        name: "Home",
                        icon: "assets/icons/home.svg",
                        currentTab: currentTab,
                        count: 0,
                        onPressed: () {
                          setState(() {
                            currentScreen = HomeScreen();
                            currentTab = 0;
                          });
                        }),
                    setBottomUI(
                        name: "Leave",
                        icon: "assets/icons/users.svg",
                        currentTab: currentTab,
                        count: 1,
                        onPressed: () {
                          setState(() {
                            EmployeeController.to.isLoading = true;
                            currentScreen = TimeOff(type:"employee");
                            currentTab = 1;
                          });
                        }),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    setBottomUI(
                        name: "Attendance",
                        icon: "assets/icons/files.svg",
                        currentTab: currentTab,
                        count: 2,
                        onPressed: () {
                          setState(() {
                            currentScreen =
                                EmployeeAttendance(backNavigation: false);
                            currentTab = 2;
                          });
                        }),
                    setBottomUI(
                        name: "Profile",
                        icon: "assets/icons/userCircle.svg",
                        currentTab: currentTab,
                        count: 3,
                        onPressed: () {
                          setState(() {
                            currentScreen = EmployeeProfile();
                            currentTab = 3;
                          });
                        }),
                  ],
                )
              ],
            ),
          ),
        ),
        body: PageStorage(bucket: bucket, child: currentScreen)):
    Scaffold(
        floatingActionButton: ProvisionsWithIgnorePointer(
            provision:'All Employees',type:"create",
          child: FloatingActionButton(
            onPressed: () {
              EmployeeController.to.isEmployee = "";
              Get.to(() => AddEmployeeScreen(selectedIndex: 1));
            },
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            child: Container(
              width: 60,
              height: 60,
              child: Icon(
                Icons.add,
                size: 40,
                color: Colors.white,
              ),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [
                    Color.fromRGBO(
                        64, 190, 84, 1), // Replace with your desired color values
                    Color.fromRGBO(
                        0, 174, 235, 1), // Replace with your desired color values
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          notchMargin: 10,
          shape: CircularNotchedRectangle(),
          child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    setBottomUI(
                        name: "Home",
                        icon: "assets/icons/home.svg",
                        currentTab: currentTab,
                        count: 0,
                        onPressed: () {
                          setState(() {
                            currentScreen = HomeScreen();
                            currentTab = 0;
                          });
                        }),
                    setBottomUI(
                        name: "Employee",
                        icon: "assets/icons/users.svg",
                        currentTab: currentTab,
                        count: 1,
                        onPressed: () {
                          setState(() {
                            EmployeeController.to.isLoading = true;
                            currentScreen = EmployeeList();
                            currentTab = 1;
                          });
                        }),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    setBottomUI(
                        name: "Attendance",
                        icon: "assets/icons/files.svg",
                        currentTab: currentTab,
                        count: 2,
                        onPressed: () {
                          setState(() {
                            currentScreen =
                                AttendanceScreen(backNavigation: false);
                            currentTab = 2;
                          });
                        }),
                    setBottomUI(
                        name: "Setting",
                        icon: "assets/icons/userCircle.svg",
                        currentTab: currentTab,
                        count: 3,
                        onPressed: () {
                          setState(() {
                            currentScreen = Settings();
                            currentTab = 3;
                          });
                        }),
                  ],
                )
              ],
            ),
          ),
        ),
        body: PageStorage(bucket: bucket, child: currentScreen));
  }

  setBottomUI(
      {required String icon,
      required VoidCallback onPressed,
      required String name,
      required int currentTab,
      required int count}) {
    return MaterialButton(
        minWidth: 40,
        onPressed: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(icon,
                color: currentTab == count ? AppColors.blue : AppColors.grey),
            CustomText(
                text: name,
                color: currentTab == count ? AppColors.blue : AppColors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w400)
          ],
        ));
  }
}
