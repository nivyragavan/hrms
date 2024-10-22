class EmployeeAttendanceModel {
  final String? code;
  final String? message;
  final Data? data;

  EmployeeAttendanceModel({
    this.code,
    this.message,
    this.data,
  });

  EmployeeAttendanceModel.fromJson(Map<String, dynamic> json)
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
  final List<WorkedHour>? workedHours;
  final String? totalRecords;
  final String? noOfWorkingDays;
  final String? preNoOfWorkingDaysPercentage;
  final String? overallWorkingHours;
  final String? preOverallWorkingHoursPercentage;
  final String? averageHours;
  final String? preAverageHoursPercentage;
  final String? lateloginHours;
  final String? preLateloginHoursPercentage;
  final String? overtimeHours;
  final String? preOvertimeHoursPercentage;
  final String? todayUserWorkedHours;
  final String? todayUserBreakHours;
  final String? shiftTotalHours;
  final String? livePunchIn;
  final String? livePunchOut;
  final String? shiftBreakHours;

  Data({
    this.workedHours,
    this.totalRecords,
    this.noOfWorkingDays,
    this.preNoOfWorkingDaysPercentage,
    this.overallWorkingHours,
    this.preOverallWorkingHoursPercentage,
    this.averageHours,
    this.preAverageHoursPercentage,
    this.lateloginHours,
    this.preLateloginHoursPercentage,
    this.overtimeHours,
    this.preOvertimeHoursPercentage,
    this.todayUserWorkedHours,
    this.todayUserBreakHours,
    this.shiftTotalHours,
    this.livePunchIn,
    this.livePunchOut,
    this.shiftBreakHours,
  });

  Data.fromJson(Map<String, dynamic> json)
      : workedHours = (json['worked_hours'] as List?)?.map((dynamic e) => WorkedHour.fromJson(e as Map<String,dynamic>)).toList(),
        totalRecords = json['total_records'] as String?,
        noOfWorkingDays = json['no_of_working_days'] as String?,
        preNoOfWorkingDaysPercentage = json['pre_no_of_working_days_percentage'] as String?,
        overallWorkingHours = json['overall_working_hours'] as String?,
        preOverallWorkingHoursPercentage = json['pre_overall_working_hours_percentage'] as String?,
        averageHours = json['average_hours'] as String?,
        preAverageHoursPercentage = json['pre_average_hours_percentage'] as String?,
        lateloginHours = json['latelogin_hours'] as String?,
        preLateloginHoursPercentage = json['pre_latelogin_hours_percentage'] as String?,
        overtimeHours = json['overtime_hours'] as String?,
        preOvertimeHoursPercentage = json['pre_overtime_hours_percentage'] as String?,
        todayUserWorkedHours = json['today_user_worked_hours'] as String?,
        todayUserBreakHours = json['today_user_break_hours'] as String?,
        shiftTotalHours = json['shift_total_hours'] as String?,
        livePunchIn = json['live_punch_in'] as String?,
        livePunchOut = json['live_punch_out'] as String?,
        shiftBreakHours = json['shift_break_hours'] as String?;

  Map<String, dynamic> toJson() => {
    'worked_hours' : workedHours?.map((e) => e.toJson()).toList(),
    'total_records' : totalRecords,
    'no_of_working_days' : noOfWorkingDays,
    'pre_no_of_working_days_percentage' : preNoOfWorkingDaysPercentage,
    'overall_working_hours' : overallWorkingHours,
    'pre_overall_working_hours_percentage' : preOverallWorkingHoursPercentage,
    'average_hours' : averageHours,
    'pre_average_hours_percentage' : preAverageHoursPercentage,
    'latelogin_hours' : lateloginHours,
    'pre_latelogin_hours_percentage' : preLateloginHoursPercentage,
    'overtime_hours' : overtimeHours,
    'pre_overtime_hours_percentage' : preOvertimeHoursPercentage,
    'today_user_worked_hours' : todayUserWorkedHours,
    'today_user_break_hours' : todayUserBreakHours,
    'shift_total_hours' : shiftTotalHours,
    'live_punch_in' : livePunchIn,
    'live_punch_out' : livePunchOut,
    'shift_break_hours' : shiftBreakHours
  };
}

class WorkedHour {
  final String? date;
  final String? login;
  final String? logOut;
  final String? breakHours;
  final String? workedHours;
  final String? overTime;
  final String? lateStatus;
  final String? lateTime;
  final String? status;
  final String? shiftName;

  WorkedHour({
    this.date,
    this.login,
    this.logOut,
    this.breakHours,
    this.workedHours,
    this.overTime,
    this.lateStatus,
    this.lateTime,
    this.status,
    this.shiftName,
  });

  WorkedHour.fromJson(Map<String, dynamic> json)
      : date = json['date'] as String?,
        login = json['login'] as String?,
        logOut = json['log_out'] as String?,
        breakHours = json['break_hours'] as String?,
        workedHours = json['worked_hours'] as String?,
        overTime = json['over_time'] as String?,
        lateStatus = json['late_status'] as String?,
        lateTime = json['late_time'] as String?,
        status = json['status'] as String?,
        shiftName = json['shift_name'] as String?;

  Map<String, dynamic> toJson() => {
    'date' : date,
    'login' : login,
    'log_out' : logOut,
    'break_hours' : breakHours,
    'worked_hours' : workedHours,
    'over_time' : overTime,
    'late_status' : lateStatus,
    'late_time' : lateTime,
    'status' : status,
    'shift_name' : shiftName
  };
}