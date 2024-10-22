// To parse this JSON data, do
//
//     final leaveRequest = leaveRequestFromJson(jsonString);

import 'dart:convert';

import '../employee_list_model.dart';

LeaveRequest leaveRequestFromJson(String str) =>
    LeaveRequest.fromJson(json.decode(str));

String leaveRequestToJson(LeaveRequest data) => json.encode(data.toJson());

class LeaveRequest {
  String? code;
  String? message;
  Data? data;

  LeaveRequest({
    this.code,
    this.message,
    this.data,
  });

  factory LeaveRequest.fromJson(Map<String, dynamic> json) => LeaveRequest(
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
  List<RequestList>? requestList;

  Data({
    this.requestList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        requestList: List<RequestList>.from(
            json["request_list"].map((x) => RequestList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "request_list": List<dynamic>.from(requestList!.map((x) => x.toJson())),
      };
}

class RequestList {
  String? id;
  String? leaveFrom;
  String? leaveTo;
  String? leaveTypeId;
  String? userId;
  dynamic teamLeadId;
  dynamic leaveDays;
  String? reasonForLeave;
  dynamic attachment;
  String? leaveType;
  String? requestType;
  dynamic permissionDate;
  dynamic fromTime;
  dynamic toTime;
  dynamic permissionHour;
  dynamic reasonForPermission;
  String? status;
  dynamic reasonForRejected;
  DateTime? createdAt;
  dynamic remainingLeave;
  dynamic approvedBy;
  Users? users;
  LeaveTypes? leaveTypes;

  RequestList({
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
    this.leaveTypes,
  });

  factory RequestList.fromJson(Map<String, dynamic> json) => RequestList(
        id: json["id"],
        leaveFrom: json["leave_from"],
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
      //  leaveTypes: LeaveTypes.fromJson(json["leave_types"]),
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
       // "leave_types": leaveTypes?.toJson(),
      };
}

class LeaveTypes {
  String? id;
  String? leaveType;
  String? leaveDays;
  String? hoursPerDay;
  String? hoursPerMonth;
  String? leaveStatus;
  String? status;
  DateTime? createdAt;

  LeaveTypes({
    this.id,
    this.leaveType,
    this.leaveDays,
    this.hoursPerDay,
    this.hoursPerMonth,
    this.leaveStatus,
    this.status,
    this.createdAt,
  });

  factory LeaveTypes.fromJson(Map<String, dynamic> json) => LeaveTypes(
        id: json["id"],
        leaveType: json["leave_type"],
        leaveDays: json["leave_days"],
        hoursPerDay: json["hours_per_day"],
        hoursPerMonth: json["hours_per_month"],
        leaveStatus: json["leave_status"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "leave_type": leaveType,
        "leave_days": leaveDays,
        "hours_per_day": hoursPerDay,
        "hours_per_month": hoursPerMonth,
        "leave_status": leaveStatus,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
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
  dynamic jobTitleId;
  int? branchId;
  int? departmentId;
  int? shiftId;
  int? reportingToId;
  int? role;
  String? mobileNumber;
  dynamic inviteRef;
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
