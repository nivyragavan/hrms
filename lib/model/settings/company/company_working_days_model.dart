class CompanyWorkingDaysModel {
  List<WorkingDay> workingDays;

  CompanyWorkingDaysModel({required this.workingDays});

  factory CompanyWorkingDaysModel.fromJson(Map<String, dynamic> json) {
    var workingDaysList = json['working_days'] as List;
    List<WorkingDay> daysList =
    workingDaysList.map((day) => WorkingDay.fromJson(day)).toList();

    return CompanyWorkingDaysModel(workingDays: daysList);
  }
}

class WorkingDay {
  bool? daysEnable;
  String days;
  String customHours;
  String startTime;
  String endTime;
  String workingHours;

  WorkingDay({
     this.daysEnable,
    required this.days,
    required this.customHours,
    required this.startTime,
    required this.endTime,
    required this.workingHours,
  });

  factory WorkingDay.fromJson(Map<String, dynamic> json) {
    return WorkingDay(
      daysEnable: json['daysEnable'] ?? "",
      days: json['days'] ?? "",
      customHours: json['custom_hours'] ?? "",
      startTime: json['start_time'] ?? "",
      endTime: json['end_time'] ?? "",
      workingHours: json['working_hrs'] ?? "",
    );
  }
}
