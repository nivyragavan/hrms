import 'package:dreamhrms/screen/login.dart';
import 'package:dreamhrms/screen/teamList.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../screen/attendance/attendance_history_screen.dart';
import '../screen/department/add_department.dart';
import '../screen/employee/edit_profile/edit_dependency.dart';
import '../screen/employee/edit_profile/edit_employee_information.dart';
import '../screen/employee/edit_profile/edit_personal_information.dart';
import '../screen/main_screen.dart';
import '../screen/splash.dart';
import '../screen/team_profile.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () => Splash()),
    GetPage(name: '/login', page: () => Login()),
    GetPage(name: '/TeamProfile', page: () => TeamProfileDetails()),
    GetPage(name: '/Team', page: () => AdminTeams()),
    GetPage(name: '/EditPersonal', page: () => EditPersonalInformation()),
    GetPage(name: '/EditEmployee', page: () => EditEmployeeInformation()),
    GetPage(name: '/EditDependency', page: () => EditDependency()),
    // GetPage(name: '/AttendanceHistory', page: () => AttendanceHistoryScreen()),
    GetPage(name: '/AddDepartment', page: () => AddDepartment(option: 'Add'))
    // GetPage(name: "/name not found", page:()=> Login()),
  ];
}
