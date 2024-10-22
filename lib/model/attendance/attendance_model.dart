class AttendanceModel {
  final String? code;
  final String? message;
  final Data? data;

  AttendanceModel({
    this.code,
    this.message,
    this.data,
  });

  AttendanceModel.fromJson(Map<String, dynamic> json)
      : code = json['code'] as String?,
        message = json['message'] as String?,
        data = (json['data'] as Map<String,dynamic>?) != null ? Data.fromJson(json['data'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'code' : code,
    'message' : message,
    'data' : data?.toJson()
  };
}

class Data {
  final List<WorkedHours>? workedHours;
  final HeaderCalculation? headerCalculation;

  Data({
    this.workedHours,
    this.headerCalculation,
  });

  Data.fromJson(Map<String, dynamic> json)
      : workedHours = (json['worked_hours'] as List?)?.map((dynamic e) => WorkedHours.fromJson(e as Map<String,dynamic>)).toList(),
        headerCalculation = (json['header_calculation'] as Map<String,dynamic>?) != null ? HeaderCalculation.fromJson(json['header_calculation'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'worked_hours' : workedHours?.map((e) => e.toJson()).toList(),
    'header_calculation' : headerCalculation?.toJson()
  };
}

class WorkedHours {
  final String? date;
  final String? username;
  final String? profileImage;
  final String? position;
  final String? department;
  final String? empCode;
  final String? login;
  final String? logOut;
  final String? breakHours;
  final String? workedHours;
  final String? lateHours;
  final String? status;
  final String? shiftName;

  WorkedHours({
    this.date,
    this.username,
    this.profileImage,
    this.position,
    this.department,
    this.empCode,
    this.login,
    this.logOut,
    this.breakHours,
    this.workedHours,
    this.lateHours,
    this.status,
    this.shiftName,
  });

  WorkedHours.fromJson(Map<String, dynamic> json)
      : date = json['date'] as String?,
        username = json['username'] as String?,
        profileImage = json['profile_image'] as String?,
        position = json['position'] as String?,
        department = json['department'] as String?,
        empCode = json['emp_code'] as String?,
        login = json['login'] as String?,
        logOut = json['log_out'] as String?,
        breakHours = json['break_hours'] as String?,
        workedHours = json['worked_hours'] as String?,
        lateHours = json['late_hours'] as String?,
        status = json['status'] as String?,
        shiftName = json['shift_name'] as String?;

  Map<String, dynamic> toJson() => {
    'date' : date,
    'username' : username,
    'profile_image' : profileImage,
    'position' : position,
    'department' : department,
    'emp_code' : empCode,
    'login' : login,
    'log_out' : logOut,
    'break_hours' : breakHours,
    'worked_hours' : workedHours,
    'late_hours' : lateHours,
    'status' : status,
    'shift_name' : shiftName
  };
}

class HeaderCalculation {
  final String? totalRecords;
  final String? usersCount;
  final String? femaleUsers;
  final String? maleUsers;
  final String? absentUsers;
  final String? presentUsers;
  final String? permissionUsers;
  final String? lateEntryUsers;
  final String? liveAttendanceAbsentUsers;
  final String? liveAttendancePresentUsers;
  final String? prevPresentUserPercentage;
  final String? prevAbsentUserPercentage;
  final String? prevPermissionUserPercentage;
  final String? prevLateUserPercentage;

  HeaderCalculation({
    this.totalRecords,
    this.usersCount,
    this.femaleUsers,
    this.maleUsers,
    this.absentUsers,
    this.presentUsers,
    this.permissionUsers,
    this.lateEntryUsers,
    this.liveAttendanceAbsentUsers,
    this.liveAttendancePresentUsers,
    this.prevPresentUserPercentage,
    this.prevAbsentUserPercentage,
    this.prevPermissionUserPercentage,
    this.prevLateUserPercentage,
  });

  HeaderCalculation.fromJson(Map<String, dynamic> json)
      : totalRecords = json['total_records'] as String?,
        usersCount = json['users_count'] as String?,
        femaleUsers = json['female_users'] as String?,
        maleUsers = json['male_users'] as String?,
        absentUsers = json['absent_users'] as String?,
        presentUsers = json['present_users'] as String?,
        permissionUsers = json['permission_users'] as String?,
        lateEntryUsers = json['late_entry_users'] as String?,
        liveAttendanceAbsentUsers = json['live_attendance_absent_users'] as String?,
        liveAttendancePresentUsers = json['live_attendance_present_users'] as String?,
        prevPresentUserPercentage = json['prev_present_user_percentage'] as String?,
        prevAbsentUserPercentage = json['prev_absent_user_percentage'] as String?,
        prevPermissionUserPercentage = json['prev_permission_user_percentage'] as String?,
        prevLateUserPercentage = json['prev_late_user_percentage'] as String?;

  Map<String, dynamic> toJson() => {
    'total_records' : totalRecords,
    'users_count' : usersCount,
    'female_users' : femaleUsers,
    'male_users' : maleUsers,
    'absent_users' : absentUsers,
    'present_users' : presentUsers,
    'permission_users' : permissionUsers,
    'late_entry_users' : lateEntryUsers,
    'live_attendance_absent_users' : liveAttendanceAbsentUsers,
    'live_attendance_present_users' : liveAttendancePresentUsers,
    'prev_present_user_percentage' : prevPresentUserPercentage,
    'prev_absent_user_percentage' : prevAbsentUserPercentage,
    'prev_permission_user_percentage' : prevPermissionUserPercentage,
    'prev_late_user_percentage' : prevLateUserPercentage
  };
}