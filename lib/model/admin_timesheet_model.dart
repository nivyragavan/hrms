// To parse this JSON data, do
//
//     final adminTimeSheetModel = adminTimeSheetModelFromJson(jsonString);

import 'dart:convert';

import '../screen/department/deparment.dart';

AdminTimeSheetModel adminTimeSheetModelFromJson(String str) => AdminTimeSheetModel.fromJson(json.decode(str));

String adminTimeSheetModelToJson(AdminTimeSheetModel data) => json.encode(data.toJson());

class AdminTimeSheetModel {
  String? code;
  String? message;
  Data? data;

  AdminTimeSheetModel({
    this.code,
    this.message,
    this.data,
  });

  factory AdminTimeSheetModel.fromJson(Map<String, dynamic> json) => AdminTimeSheetModel(
    code: json["code"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  List<UserDatum>? userData;

  Data({
    this.userData,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userData: List<UserDatum>.from(json["user_data"].map((x) => UserDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "user_data": List<dynamic>.from(userData!.map((x) => x.toJson())),
  };
}

class UserDatum {
  String? id;
  String? name;
  String? email;
  String? profileImage;
  Department? department;
  JobPosition? jobPosition;
  List<WorkDatum>? workData;

  UserDatum({
    this.id,
    this.name,
    this.email,
    this.profileImage,
    this.department,
    this.jobPosition,
    this.workData,
  });

  factory UserDatum.fromJson(Map<String, dynamic> json) => UserDatum(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    profileImage: json["profile_image"],
    department: json['department'] != null  || json['department']!=""? Department.fromJson(json['department']) : json['department'],
    jobPosition: (json['job_position']!=""||  json['job_position'] is Map<String, dynamic>)?
    JobPosition.fromJson( json['job_position'] as Map<String,dynamic>):null,
    workData: List<WorkDatum>.from(json["work_data"].map((x) => WorkDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "profile_image": profileImage,
    "department": department?.toJson(),
    "job_position": jobPosition?.toJson(),
    "work_data": List<dynamic>.from(workData!.map((x) => x.toJson())),
  };
}

class DepartmentClass {
  String? id;
  DepartmentName? departmentName;
  Description? description;
  String? departmentIcon;
  String? status;
  DateTime? createdAt;

  DepartmentClass({
    this.id,
    this.departmentName,
    this.description,
    this.departmentIcon,
    this.status,
    this.createdAt,
  });

  factory DepartmentClass.fromJson(Map<String, dynamic> json) => DepartmentClass(
    id: json["id"],
    departmentName: departmentNameValues.map[json["department_name"]],
    description: descriptionValues.map[json["description"]],
    departmentIcon: json["department_icon"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "department_name": departmentNameValues.reverse[departmentName],
    "description": descriptionValues.reverse[description],
    "department_icon": departmentIcon,
    "status": status,
    "created_at": createdAt!.toIso8601String(),
  };
}

enum DepartmentName {
  DEVELOPER,
  FINANCE,
  HR
}

final departmentNameValues = EnumValues({
  "Developer": DepartmentName.DEVELOPER,
  "Finance": DepartmentName.FINANCE,
  "HR": DepartmentName.HR
});

enum Description {
  DEVELOPER,
  FINANCE,
  HR_TEAM
}

final descriptionValues = EnumValues({
  "Developer": Description.DEVELOPER,
  "Finance": Description.FINANCE,
  "HR team": Description.HR_TEAM
});

class JobPosition {
  final int? id;
  final int? departmentId;
  final String? positionName;
  final int? grade;
  final String? createdAt;

  JobPosition({
    this.id,
    this.departmentId,
    this.positionName,
    this.grade,
    this.createdAt,
  });

  JobPosition.fromJson(Map<String, dynamic> json)
      : id = json['id']??"",
        departmentId = json['department_id']??"",
        positionName = json['position_name']??"",
        grade = json['grade']??"",
        createdAt = json['created_at']??"";

  Map<String, dynamic> toJson() => {
    'id' : id,
    'department_id' : departmentId,
    'position_name' : positionName,
    'grade' : grade,
    'created_at' : createdAt
  };
}


enum PositionName {
  HR_MANAGER,
  SENIOR_DEVELOPER,
  TEST
}

final positionNameValues = EnumValues({
  "HR Manager": PositionName.HR_MANAGER,
  "Senior developer": PositionName.SENIOR_DEVELOPER,
  "test": PositionName.TEST
});

class WorkDatum {
  Day? day;
  String? date;
  String? workedHours;
  Holiday? holiday;
  ExtraWork? extraWork;

  WorkDatum({
    this.day,
    this.date,
    this.workedHours,
    this.holiday,
    this.extraWork,
  });

  factory WorkDatum.fromJson(Map<String, dynamic> json) => WorkDatum(
    day: dayValues.map[json["day"]],
    date: json["date"],
    workedHours: json["worked_hours"],
    holiday: holidayValues.map[json["holiday"]],
    extraWork: extraWorkValues.map[json["extra_work"]],
  );

  Map<String, dynamic> toJson() => {
    "day": dayValues.reverse[day],
    "date": date,
    "worked_hours": workedHours,
    "holiday": holidayValues.reverse[holiday],
    "extra_work": extraWorkValues.reverse[extraWork],
  };
}

enum Day {
  FRI,
  MON,
  SAT,
  SUN,
  THU,
  TUE,
  WED
}

class Department {
  final int? id;
  final String? departmentName;
  final String? description;
  final String? departmentIcon;
  final int? status;
  final String? createdAt;

  Department({
    this.id,
    this.departmentName,
    this.description,
    this.departmentIcon,
    this.status,
    this.createdAt,
  });

  Department.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        departmentName = json['department_name'] as String?,
        description = json['description'] as String?,
        departmentIcon = json['department_icon'] as String?,
        status = json['status'] as int?,
        createdAt = json['created_at'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'department_name' : departmentName,
    'description' : description,
    'department_icon' : departmentIcon,
    'status' : status,
    'created_at' : createdAt
  };
}


final dayValues = EnumValues({
  "Fri": Day.FRI,
  "Mon": Day.MON,
  "Sat": Day.SAT,
  "Sun": Day.SUN,
  "Thu": Day.THU,
  "Tue": Day.TUE,
  "Wed": Day.WED
});

enum ExtraWork {
  NO
}

final extraWorkValues = EnumValues({
  "no": ExtraWork.NO
});

enum Holiday {
  YES
}

final holidayValues = EnumValues({
  "yes": Holiday.YES
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
