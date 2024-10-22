import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:dreamhrms/controller/employee/employee_controller.dart';
import 'package:dreamhrms/controller/login_controller.dart';
import 'package:dreamhrms/screen/admin_assets/admin_assets_list.dart';
import 'package:dreamhrms/screen/admin_assets/assign_asset.dart';
import 'package:dreamhrms/screen/attendance/employee_attendance_screen.dart';
import 'package:dreamhrms/screen/branch/branch_screen.dart';
import 'package:dreamhrms/screen/department/deparment.dart';
import 'package:dreamhrms/screen/employee/add_employee_screen.dart';
import 'package:dreamhrms/screen/holidays/holiday_screen.dart';
import 'package:dreamhrms/screen/leave/leave.dart';
import 'package:dreamhrms/screen/off_boarding/off_boarding_screen.dart';
import 'package:dreamhrms/screen/on_boarding/on_boarding_screen.dart';
import 'package:dreamhrms/screen/permission/permission.dart';
import 'package:dreamhrms/screen/policies/policies_screen.dart';
import 'package:dreamhrms/screen/schedule/schedule.dart';
import 'package:dreamhrms/screen/shift/shift.dart';
import 'package:dreamhrms/screen/splash.dart';
import 'package:dreamhrms/screen/theme_settings.dart';
import 'package:dreamhrms/screen/ticket/ticket_details_tabs/ticket_details.dart';
import 'package:dreamhrms/screen/time_sheet/admin_timesheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

import '../screen/announcement/announcement.dart';
import '../screen/attendance/attendance_screen.dart';
import '../screen/change_password.dart';
import '../screen/drawer.dart';
import '../screen/emp_announcement/emp_announcement.dart';
import '../screen/employee/employee_details.dart';
import '../screen/employee/employee_details/assets.dart';
import '../screen/employee/employee_details/time_sheet.dart';
import '../screen/face_attendance/face_emp_list.dart';
import '../screen/face_reco/face_list.dart';
import '../screen/teamList.dart';
import '../screen/ticket/ticket_list.dart';
import '../services/HttpHelper.dart';
import '../services/api_service.dart';
import '../services/utils.dart';

class CommonController extends GetxController {
  static CommonController get to => Get.put(CommonController());

  BuildContext? context = Get.context;
  static final HttpHelper _http = HttpHelper();

  TextEditingController search = TextEditingController();

  final _imageLoader=false.obs;

  get imageLoader => _imageLoader.value;

  set imageLoader(value) {
    _imageLoader.value = value;
  }

  final _imageBase64="".obs;

  get imageBase64 => _imageBase64.value;

  set imageBase64(value) {
    _imageBase64.value = value;
  }
  final _fileLoader=false.obs;

  get fileLoader => _fileLoader.value;

  set fileLoader(value) {
    _fileLoader.value = value;
  }

  final _buttonLoader=false.obs;

  get buttonLoader => _buttonLoader.value;

  set buttonLoader(value) {
    _buttonLoader.value = value;
  }

  final _toggleLoader=false.obs;

  get toggleLoader => _toggleLoader.value;

  set toggleLoader(value) {
    _toggleLoader.value = value;
  }

  final _commonTextLoader = false.obs;

  get commonTextLoader => _commonTextLoader.value;

  set commonTextLoader(value) {
    _commonTextLoader.value = value;
  }

  int officeImageSize = 0;

  clearValues(){
    officeImageSize = 0;
  }

  List<MenuItem> adminMenuList = [
    MenuItem(
      title: "department",
      icon: "assets/icons/menu/department.svg",
      onPressed: () {
        Get.to(() => Department());
      },
    ),
    MenuItem(
      title: "teams",
      icon: "assets/icons/menu/teams.svg",
      onPressed: () {
        Get.to(() => AdminTeams());
      },
    ),
    MenuItem(
      title: "timesheet",
      icon: "assets/icons/menu/timesheet.svg",
      onPressed: () {
        Get.to(() => AdminTimeSheet());
      },
    ),
    MenuItem(
      title: "attendance",
      icon: "assets/icons/menu/attendance.svg",
      onPressed: () {
        Get.to(() => AttendanceScreen(backNavigation: true));
      },
    ),
    MenuItem(
      title: "add_emp",
      icon: "assets/icons/menu/attendance.svg",
      onPressed: () {
        EmployeeController.to.isEmployee = "";
        Get.to(() => AddEmployeeScreen());
      },
    ),
    MenuItem(
      title: "shift",
      icon: "assets/icons/menu/shift_schedule.svg",
      onPressed: () {
        Get.to(() => Shift());
      },
    ),
    MenuItem(
      title: "schedule",
      icon: "assets/icons/menu/shift_schedule.svg",
      onPressed: () {
        Get.to(() => Schedule());
      },
    ),
    MenuItem(
      title: "leave",
      icon: "assets/icons/menu/department.svg",
      onPressed: () {
        Get.to(() => Leave());
      },
    ),
    MenuItem(
      title: "permission",
      icon: "assets/icons/menu/leave.svg",
      onPressed: () {
        Get.to(() => PermissionScreen());
      },
    ),
    MenuItem(
      title: "holidays",
      icon: "assets/icons/menu/holiday.svg",
      onPressed: () {
        Get.to(() => HolidaysScreen());
      },
    ),
    MenuItem(
      title: "onboarding",
      icon: "assets/icons/menu/onboarding.svg",
      onPressed: () {
        Get.to(() => OnBoardingScreen());
      },
    ),
    MenuItem(
      title: "offboarding",
      icon: "assets/icons/menu/offboarding.svg",
      onPressed: () {
        Get.to(() => OffBoardingScreen());
      },
    ),
    MenuItem(
      title: "branch",
      icon: "assets/icons/menu/location.svg",
      onPressed: () {
        Get.to(() => BranchScreen());
      },
    ),
    MenuItem(
      title: "assets",
      icon: "assets/icons/menu/asset.svg",
      onPressed: () {
        Get.to(() => AdminAssets());
      },
    ),
    MenuItem(
      title: "assign_assets",
      icon: "assets/icons/menu/asset.svg",
      onPressed: () {
        Get.to(() => AssignAsset());
      },
    ),
    MenuItem(
      title: "tickets",
      icon: "assets/icons/menu/asset.svg",
      onPressed: () {
        Get.to(() => TicketList());
      },
    ),
    MenuItem(
      title: "announcement",
      icon: "assets/icons/menu/asset.svg",
      onPressed: () {
        Get.to(() => AnnouncementScreen());
      },
    ),
    MenuItem(
      title: "face_list",
      icon: "assets/icons/menu/people.svg",
      onPressed: () {
        Get.to(() => FaceList());
      },
    ),
    MenuItem(
      title: "face_reg_emp_list",
      icon: "assets/icons/menu/people.svg",
      onPressed: () {
        Get.to(() => FaceRegisterEmployeeList());
      },
    ),
    MenuItem(
      title: "policies",
      icon: "assets/icons/menu/calendar_filled.svg",
      onPressed: () {
        Get.to(() => PoliciesScreen());
      },
    ),
    MenuItem(
      title: "change_password",
      icon: "assets/icons/menu/calendar_filled.svg",
      onPressed: () {
        Get.to(() => ChangePassword());
      },
    ),
    MenuItem(
      title: "log_out",
      icon: "assets/icons/menu/offboarding.svg",
      onPressed: () {
        LoginController.to.clearLocalStorage();
        Get.offAll(() => Splash());
      },
    ),
  ];

  List<MenuItem> employeeMenuList = [
    MenuItem(
      title: "profile",
      icon: "assets/icons/menu/people.svg",
      onPressed: () {
        // EmployeeController.to.selectedUserId=GetStorage().remove("login_userid") as int;
        Get.to(() => EmployeeDetails());
      },
    ),
    MenuItem(
      title: "timesheet",
      icon: "assets/icons/menu/timesheet.svg",
      onPressed: () {
        Get.to(() => TimeSheet());
      },
    ),
    MenuItem(
      title: "attendance",
      icon: "assets/icons/menu/attendance.svg",
      onPressed: () {
        Get.to(() => EmployeeAttendance(backNavigation: true));
      },
    ),
    MenuItem(
      title: "leave",
      icon: "assets/icons/menu/department.svg",
      onPressed: () {
        Get.to(() => Leave());
      },
    ),
    MenuItem(
      title: "permission",
      icon: "assets/icons/menu/department.svg",
      onPressed: () {
        Get.to(() => PermissionScreen());
      },
    ),
    MenuItem(
      title: "holidays",
      icon: "assets/icons/menu/holiday.svg",
      onPressed: () {
        Get.to(() => HolidaysScreen());
      },
    ),
    MenuItem(
      title: "assets",
      icon: "assets/icons/menu/asset.svg",
      onPressed: () {
        Get.to(() => Assets());
      },
    ),
    MenuItem(
      title: "announcement",
      icon: "assets/icons/menu/asset.svg",
      onPressed: () {
        Get.to(() => EmployeeAnnouncement());
      },
    ),
    MenuItem(
      title: "theme",
      icon: "assets/icons/menu/asset.svg",
      onPressed: () {
        Get.to(() => Theme());
      },
    ),
    MenuItem(
      title: "log_out",
      icon: "assets/icons/menu/offboarding.svg",
      onPressed: () {
        LoginController.to.clearLocalStorage();
        Get.offAll(() => Splash());
      },
    ),
  ];

  // prefs.setString('keywords', jsonEncode(resp['data'].asMap()[0]));


  getLanguageTranslator(String? languageCode) async {
    var response = await _http.post(
        "${Api.translateLanguageList}$languageCode", "",
        auth: true, contentHeader: false);
    if (response['code'].toString() == "200" ||
        response['code'].toString() == "204") {
      print("response language list $response");
      final prefs = await SharedPreferences.getInstance();
      print("condition check${response['data']} ${response['data'] != null &&
          response['data'] != []}");
      if (response['data'] != null && response['data'] != []) {
        prefs.setString('keywords', jsonEncode(response['data']));
      } else {
        print("Empty response");
        GetStorage().write("language_code", "en");
        await getLanguageTranslator(GetStorage().read("en"));
      }
    } else {
      UtilService().showToast("error", message: response['message'].toString());
    }
  }

  Future<String>? getTranslateKeyword(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('keywords');
    print("TRANSLATOR KEY INFM $key");
    // print("jsonString$jsonString");
    if (jsonString != null && jsonString != []) {
      Map<String, dynamic> jsonData = json.decode(jsonString);
      if (jsonData.containsKey(key)) {
        return jsonData[key].toString();
      } else {
        print("TRANSLATOR KEY NOT AVAIL IN PREF $key");
        return key == "null" ? "" : key.i18n().toString();
      }
    } else {
      print("TRANSLATOR PREF EMPTY $key");
      return key == "null" ? "" : key.i18n().toString();
    }
  }

  StartingDayOfWeek dayToCalendar(String day) {
    day = day.substring(0, 1).toLowerCase() + day.substring(1);
    switch (day) {
      case "monday":
        print(" Result ${StartingDayOfWeek.monday}");
        return StartingDayOfWeek.monday;
      case "tuesday":
        print(StartingDayOfWeek.tuesday);
        return StartingDayOfWeek.tuesday;
      case "wednesday":
        print(StartingDayOfWeek.wednesday);
        return StartingDayOfWeek.wednesday;
      case "thursday":
        print(StartingDayOfWeek.thursday);
        return StartingDayOfWeek.thursday;
      case "friday":
        print(StartingDayOfWeek.friday);
        return StartingDayOfWeek.friday;
      case "saturday":
        print(StartingDayOfWeek.saturday);
        return StartingDayOfWeek.saturday;
      case "sunday":
        print(StartingDayOfWeek.sunday);
        return StartingDayOfWeek.sunday;
      default:
        return StartingDayOfWeek.monday;
    }
  }

  String formatDate(String pickedDate) {
    print("getstorage${GetStorage().read('date_format')}");
    List<String> parts = [];
    String? year;
    String? month;
    String? day;

    switch (GetStorage().read('date_format')) {
      case "d-m-Y":
        parts = pickedDate.split('-');
        year = parts[2];
        month = parts[1].padLeft(2, '0');
        day = parts[0].padLeft(2, '0');
        print("d-m-y formatted date ${'$year-$month-$day'}");
        return '$year-$month-$day';
      case "d/m/Y":
        parts = pickedDate.split('/');
        print("parts $parts");
        year = parts[2];
        month = parts[1].padLeft(2, '0');
        day = parts[0].padLeft(2, '0');
        print("d/m/Y formatted date ${'$year-$month-$day'}");
        return '$year-$month-$day';
      case "M d,Y":
        DateTime dateTime = DateFormat.yMMMMd('en_US').parse(pickedDate);

        print("dateTime$dateTime");
        int year = dateTime.year;
        int month = dateTime.month;
        int day = dateTime.day;

        // return DateFormat("MMM d, yyyy").format(DateTime.parse(pickedDate));
        print("M d,Y formatted date ${'$year-$month-$day'}");
        return '$year-$month-$day';
      case 'd M,Y':
        DateTime dateTime = DateFormat("MMMM d, y").parse(pickedDate);
        print("date, month & year parts $dateTime");
        int day = dateTime.day;
        int month = dateTime.month;
        int year = dateTime.year;
        // return DateFormat("dd MMM, yyyy").format(DateTime.parse(pickedDate));
        print("d M,Y formatted date ${'$year-$month-$day'}");
        return '$year-$month-$day';
      case 'Y-m-d':
        return pickedDate;
      default:
        return pickedDate;
    }
  }

  String dateConversion(String pickedDate, String dateFormat) {
    // DateTime originalDate = DateTime.parse(pickedDate);
    print("dateFormat: $dateFormat $pickedDate");

    List<String> parts = pickedDate.split('-');
    String year = parts[0];
    String month = parts[1].padLeft(2, '0');
    String day = parts[2].padLeft(2, '0');

    switch (dateFormat) {
      case "d-m-Y":
      // return DateFormat("dd-MM-yyyy").format(DateTime.parse(pickedDate));
        print("d-m-Y format date ${'$day-$month-$year'}");
        return '$day-$month-$year';
      case "d/m/Y":
      // return DateFormat('dd/MM/yyyy').format(DateTime.parse(pickedDate));
        print("d/m/Y format date ${'$day-$month-$year'}");
        return '$day/$month/$year';
      case "M d,Y":
        DateTime dateTime = DateTime.parse(pickedDate);

        String formattedDate = DateFormat.yMMMMd('en_US').format(dateTime);
        print("M d,Y formatted date ${'$formattedDate'}");
        return '$formattedDate';
      case 'd M,Y':
      // return DateFormat("dd MMM, yyyy").format(DateTime.parse(pickedDate));
        print("d M,Y formatted date ${'$day $month, $year'}");
        return '$day $month, $year';
      case 'Y-m-d':
      // return DateFormat("yyyy-MM-dd").format(DateTime.parse(pickedDate));
        return pickedDate;
      default:
      // return DateFormat("yyyy-MM-dd").format(DateTime.parse(pickedDate));
        return pickedDate;
    }
  }

  Future<void> checkInternetConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      print('Connected to the internet');
    } else {
      UtilService()
          .showToast(
          "error", message: "Check your internet connection".toString());
    }
  }

  String timeConversion(String pickedTime, String timeFormat) {
    print("Format $pickedTime , $timeFormat");
    int hour, minute, second = 0;
    String amPm = "";

    List<String> timeParts = pickedTime.split(' '); // Split by space to separate time and AM/PM
    String timePart = timeParts[0]; // Extract the time part

    List<String> timeComponents = timePart.split(':'); // Split the time part by ':'
    if (timeComponents.length == 3) {
      hour = int.parse(timeComponents[0]);
      minute = int.parse(timeComponents[1]);
      second = int.parse(timeComponents[2]);
    } else if (timeFormat == "h:i:A") {
      hour = int.parse(timeComponents[0]);
      minute = int.parse(timeComponents[1]);
      amPm = timeParts[1]; // Extract the AM/PM part
    } else {
      hour = int.parse(timeComponents[0]);
      minute = int.parse(timeComponents[1]);
      second = 0;
    }

    switch (timeFormat) {
      case "H:i":
        return "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";
      case "H:i:A":
        return "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $amPm";
      case "HH:mm:ss":
        return "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')}";
      case "HH:mm":
        return "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')}";
      default:
        return pickedTime;
    }
  }
}