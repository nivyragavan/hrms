// To parse this JSON data, do
//
//     final leaveHistory = leaveHistoryFromJson(jsonString);

import 'dart:convert';
import '../employee_list_model.dart';

LeaveHistory leaveHistoryFromJson(String str) =>
    LeaveHistory.fromJson(json.decode(str));

String leaveHistoryToJson(LeaveHistory data) => json.encode(data.toJson());

class LeaveHistory {
  String? code;
  String? message;
  Data? data;

  LeaveHistory({
    this.code,
    this.message,
    this.data,
  });

  factory LeaveHistory.fromJson(Map<String, dynamic> json) => LeaveHistory(
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
  HistoryList? historyList;
 List<LeaveTypes>? leaveTypes;

  Data({
    this.historyList,
    this.leaveTypes,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        historyList: HistoryList.fromJson(json["history_list"]),
        leaveTypes:  json["leave_type"] != null
          ? List<LeaveTypes>.from(json["leave_type"]?.map((x) => LeaveTypes.fromJson(x)) ?? [])
      : [],
      );

  Map<String, dynamic> toJson() => {
        "history_list": historyList?.toJson(),
       "leave_types": List<dynamic>.from(leaveTypes!.map((x) => x.toJson())),
      };
}

class HistoryList {
  String? currentPage;
  List<Datum>? data;
  String? firstPageUrl;
  String? from;
  String? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  String? nextPageUrl;
  String? path;
  String? perPage;
  String? prevPageUrl;
  String? to;
  String? total;

  HistoryList({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory HistoryList.fromJson(Map<String, dynamic> json) => HistoryList(
        currentPage: json["current_page"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] != null
            ? List<Link>.from(json["links"]?.map((x) => Link.fromJson(x)) ?? [])
            : [],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Datum {
  String? id;
  String? leaveFrom;
  String? leaveTo;
  String? leaveTypeId;
  String? userId;
  String? teamLeadId;
  dynamic leaveDays;
  String? reasonForLeave;
  String? attachment;
  String? leaveType;
  String? requestType;
  String? permissionDate;
  String? fromTime;
  String? toTime;
  String? permissionHour;
  String? reasonForPermission;
  String? status;
  String? reasonForRejected;
  DateTime? createdAt;
  String? remainingLeave;
  dynamic approvedBy;
  Users? users;

//  String? leaveTypes;

  Datum({
    this.id,
    this.leaveFrom,
    this.leaveTo,
    this.leaveTypeId,
    this.userId,
    this.teamLeadId,
    this.leaveDays,
    this.reasonForLeave,
    this.attachment,
    this.leaveType,
    this.requestType,
    this.permissionDate,
    this.fromTime,
    this.toTime,
    this.permissionHour,
    this.reasonForPermission,
    this.status,
    this.reasonForRejected,
    this.createdAt,
    this.remainingLeave,
    this.approvedBy,
    this.users,

  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        leaveFrom: json["leave_from"]==null ||json["leave_from"]==""?"": json["leave_from"],
        leaveTo: json["leave_to"],
        leaveTypeId: json["leave_type_id"],
        userId: json["user_id"],
        teamLeadId: json["team_lead_id"],
        leaveDays: json["leave_days"],
        reasonForLeave: json["reason_for_leave"],
        attachment: json["attachment"],
        leaveType: json["leave_type"],
        requestType: json["request_type"],
        permissionDate: json["permission_date"],
        fromTime: json["from_time"],
        toTime: json["to_time"],
        permissionHour: json["permission_hour"],
        reasonForPermission: json["reason_for_permission"],
        status: json["status"],
        reasonForRejected: json["reason_for_rejected"],
        createdAt: DateTime.parse(json["created_at"]),
        remainingLeave: json["remaining_leave"],
        approvedBy: json["approved_by"],
        users: Users.fromJson(json["users"]),

    //leaveTypes:  json['leave_type'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "leave_from": leaveFrom,
        "leave_to": leaveTo,
        "leave_type_id": leaveTypeId,
        "user_id": userId,
        "team_lead_id": teamLeadId,
        "leave_days": leaveDays,
        "reason_for_leave": reasonForLeave,
        "attachment": attachment,
        "leave_type": leaveType,
        "request_type": requestType,
        "permission_date": permissionDate,
        "from_time": fromTime,
        "to_time": toTime,
        "permission_hour": permissionHour,
        "reason_for_permission": reasonForPermission,
        "status": status,
        "reason_for_rejected": reasonForRejected,
        "created_at": createdAt?.toIso8601String(),
        "remaining_leave": remainingLeave,
        "approved_by": approvedBy,
        "users": users?.toJson(),

      };
}

class Users {
  int? id;
  String? firstName;
  String? lastName;
  String? emailId;
  String? gender;
  String? maritalStatus;
  Country? country;
  DateTime? dateOfBirth;
  State? state;
  City? city;
  String? personalEmail;
  String? bloodGroup;
  String? profileImage;
  int? companyId;
  int? jobTitleId;
  int? branchId;
  int? departmentId;
  int? shiftId;
  int? reportingToId;
  int? role;
  String? mobileNumber;
  String? inviteRef;
  Employe? employeeType;
  int? status;
  int? usersImport;
  DateTime? createdAt;
  Department? department;

  Users({
    this.id,
    this.firstName,
    this.lastName,
    this.emailId,
    this.gender,
    this.maritalStatus,
    this.country,
    this.dateOfBirth,
    this.state,
    this.city,
    this.personalEmail,
    this.bloodGroup,
    this.profileImage,
    this.companyId,
    this.jobTitleId,
    this.branchId,
    this.departmentId,
    this.shiftId,
    this.reportingToId,
    this.role,
    this.mobileNumber,
    this.inviteRef,
    this.employeeType,
    this.status,
    this.usersImport,
    this.createdAt,
    this.department,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        emailId: json["email_id"],
        gender: json["gender"],
        maritalStatus: json["marital_status"],
        country: json["country"] == null
            ? json["country"]
            : Country.fromJson(json["country"]),
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        state: json["state"] == null
            ? json["state"]
            : State.fromJson(json["state"]),
        city: json["city"] == null ? json["city"] : City.fromJson(json["city"]),
        personalEmail: json["personal_email"],
        bloodGroup: json["blood_group"],
        profileImage: json["profile_image"],
        companyId: json["company_id"],
        jobTitleId: json["job_title_id"],
        branchId: json["branch_id"],
        departmentId: json["department_id"],
        shiftId: json["shift_id"],
        reportingToId: json["reporting_to_id"],
        role: json["role"],
        mobileNumber: json["mobile_number"],
        inviteRef: json["invite_ref"],
        employeeType: json["employee_type"] == null
            ? json["employee_type"]
            : Employe.fromJson(json["employee_type"]),
        status: json["status"],
        usersImport: json["import"],
        createdAt: DateTime.parse(json["created_at"]),
        department: Department.fromJson(json["department"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email_id": emailId,
        "gender": gender,
        "marital_status": maritalStatus,
        "country": country,
        "date_of_birth":
            "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
        "state": state,
        "city": city,
        "personal_email": personalEmail,
        "blood_group": bloodGroup,
        "profile_image": profileImage,
        "company_id": companyId,
        "job_title_id": jobTitleId,
        "branch_id": branchId,
        "department_id": departmentId,
        "shift_id": shiftId,
        "reporting_to_id": reportingToId,
        "role": role,
        "mobile_number": mobileNumber,
        "invite_ref": inviteRef,
        "employee_type": employeeType,
        "status": status,
        "import": usersImport,
        "created_at": createdAt?.toIso8601String(),
        "department": department?.toJson(),
      };
}

class Department {
  int? id;
  String? departmentName;
  String? description;
  String? departmentIcon;
  int? status;
  DateTime? createdAt;

  Department({
    this.id,
    this.departmentName,
    this.description,
    this.departmentIcon,
    this.status,
    this.createdAt,
  });

  factory Department.fromJson(Map<String, dynamic> json) => Department(
        id: json["id"],
        departmentName: json["department_name"],
        description: json["description"],
        departmentIcon: json["department_icon"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "department_name": departmentName,
        "description": description,
        "department_icon": departmentIcon,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
      };
}

class LeaveTypes {
  String? id;
  String? leaveType;
  dynamic leaveDays;
  String? empCount;
  // String? hoursPerDay;
  // String? hoursPerMonth;
  // String? leaveStatus;
  // String? status;
  // DateTime? createdAt;

  LeaveTypes({
    this.id,
    this.leaveType,
    this.leaveDays,
    // this.hoursPerDay,
    // this.hoursPerMonth,
    this.empCount,
    // this.leaveStatus,
    // this.status,
    // this.createdAt,
  });

  factory LeaveTypes.fromJson(Map<String, dynamic> json) => LeaveTypes(
        id: json["id"],
        leaveType: json["leave_type"],
        empCount: json["emp_count"],
        // leaveDays: json["leave_days"],
        // hoursPerDay: json["hours_per_day"],
        // hoursPerMonth: json["hours_per_month"],
        // leaveStatus: json["leave_status"],
        // status: json["status"],
        // createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "leave_type": leaveType,
        "leave_days": leaveDays,
        // "hours_per_day": hoursPerDay,
        // "hours_per_month": hoursPerMonth,
        "emp_count": empCount,
        // "leave_status": leaveStatus,
        // "status": status,
        // "created_at": createdAt?.toIso8601String(),
      };
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
