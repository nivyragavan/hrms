import 'leave/leave_history_model.dart';

class EmployeeTimeOffModel {
  final String? code;
  final String? message;
  final Data1? data;

  EmployeeTimeOffModel({
    this.code,
    this.message,
    this.data,
  });

  EmployeeTimeOffModel.fromJson(Map<String, dynamic> json)
      : code = json['code'] as String?,
        message = json['message'] as String?,
        data = (json['data'] as Map<String,dynamic>?) != null ? Data1.fromJson(json['data'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'code' : code,
    'message' : message,
    'data' : data?.toJson()
  };
}

class Data1 {
  final Data? data;

  Data1({
    this.data,
  });

  Data1.fromJson(Map<String, dynamic> json)
      : data = (json['data'] as Map<String,dynamic>?) != null ? Data.fromJson(json['data'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'data' : data?.toJson()
  };
}

class Data {
  final List<UserLeaveDetails>? userLeaveDetails;
  final List<CommonLeaveDetails>? commonLeaveDetails;
  final String? annualLeave;
  final String? sickLeave;
  final String? permission;

  Data({
    this.userLeaveDetails,
    this.commonLeaveDetails,
    this.annualLeave,
    this.sickLeave,
    this.permission,
  });

  Data.fromJson(Map<String, dynamic> json)
      : userLeaveDetails =(json['user_leave_details'] as List?)?.map((dynamic e) => UserLeaveDetails.fromJson(e as Map<String,dynamic>)).toList(),// json['user_leave_details'] as List?,
        commonLeaveDetails = (json['common_leave_details'] as List?)?.map((dynamic e) => CommonLeaveDetails.fromJson(e as Map<String,dynamic>)).toList(),
        annualLeave = json['annual_leave'] as String?,
        sickLeave = json['sick_leave'] as String?,
        permission = json['permission'] as String?;

  Map<String, dynamic> toJson() => {
    'user_leave_details' : userLeaveDetails,
    'common_leave_details' : commonLeaveDetails?.map((e) => e.toJson()).toList(),
    'annual_leave' : annualLeave,
    'sick_leave' : sickLeave,
    'permission' : permission
  };
}

class CommonLeaveDetails {
  final int? id;
  final String? leaveType;
  final int? leaveDays;
  final String? hoursPerDay;
  final String? hoursPerMonth;
  final String? leaveStatus;
  final int? status;
  final String? createdAt;

  CommonLeaveDetails({
    this.id,
    this.leaveType,
    this.leaveDays,
    this.hoursPerDay,
    this.hoursPerMonth,
    this.leaveStatus,
    this.status,
    this.createdAt,
  });

  CommonLeaveDetails.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        leaveType = json['leave_type'] as String?,
        leaveDays =  json['leave_days']==null ||json['leave_days']=="null"?0:json['leave_days'] as int?,
        hoursPerDay = json['hours_per_day'] as String?,
        hoursPerMonth = json['hours_per_month'] as String?,
        leaveStatus = json['leave_status'] as String?,
        status = json['status'] as int?,
        createdAt = json['created_at'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'leave_type' : leaveType,
    'leave_days' : leaveDays,
    'hours_per_day' : hoursPerDay,
    'hours_per_month' : hoursPerMonth,
    'leave_status' : leaveStatus,
    'status' : status,
    'created_at' : createdAt
  };
}

class UserLeaveDetails {
  final int? id;
  final String? leaveFrom;
  final String? leaveTo;
  final int? leaveTypeId;
  final int? userId;
  final dynamic teamLeadId;
  final dynamic? leaveDays;
  final String? reasonForLeave;
  final String? attachment;
  final String? leaveType;
  final String? requestType;
  final dynamic permissionDate;
  final dynamic fromTime;
  final dynamic toTime;
  final dynamic permissionHour;
  final dynamic reasonForPermission;
  final String? status;
  final dynamic reasonForRejected;
  final String? createdAt;
  final dynamic approvedBy;
  final dynamic teamLead;
  final LeaveTypes? leaveTypes;

  UserLeaveDetails({
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
    this.approvedBy,
    this.teamLead,
    this.leaveTypes,
  });

  UserLeaveDetails.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        leaveFrom = json['leave_from'] as String?,
        leaveTo = json['leave_to'] as String?,
        leaveTypeId = json['leave_type_id'] as int?,
        userId = json['user_id'] as int?,
        teamLeadId = json['team_lead_id'],
        leaveDays = json['leave_days'] ,
        reasonForLeave = json['reason_for_leave'] as String?,
        attachment = json['attachment'] as String?,
        leaveType = json['leave_type'] as String?,
        requestType = json['request_type'] as String?,
        permissionDate = json['permission_date'],
        fromTime = json['from_time'],
        toTime = json['to_time'],
        permissionHour = json['permission_hour'],
        reasonForPermission = json['reason_for_permission'],
        status = json['status'] as String?,
        reasonForRejected = json['reason_for_rejected'],
        createdAt = json['created_at'] as String?,
        approvedBy = json['approved_by'],
        teamLead = json['team_lead'],
        leaveTypes = (json['leave_types'] as Map<String,dynamic>?) != null ? LeaveTypes.fromJson(json['leave_types'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'leave_from' : leaveFrom,
    'leave_to' : leaveTo,
    'leave_type_id' : leaveTypeId,
    'user_id' : userId,
    'team_lead_id' : teamLeadId,
    'leave_days' : leaveDays,
    'reason_for_leave' : reasonForLeave,
    'attachment' : attachment,
    'leave_type' : leaveType,
    'request_type' : requestType,
    'permission_date' : permissionDate,
    'from_time' : fromTime,
    'to_time' : toTime,
    'permission_hour' : permissionHour,
    'reason_for_permission' : reasonForPermission,
    'status' : status,
    'reason_for_rejected' : reasonForRejected,
    'created_at' : createdAt,
    'approved_by' : approvedBy,
    'team_lead' : teamLead,
    'leave_types' : leaveTypes?.toJson()
  };
}

class LeaveTypes {
  final int? id;
  final String? leaveType;
  final int? leaveDays;
  final String? hoursPerDay;
  final String? hoursPerMonth;
  final String? leaveStatus;
  final int? status;
  final String? createdAt;

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

  LeaveTypes.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        leaveType = json['leave_type'] as String?,
        leaveDays = json['leave_days'] as int?,
        hoursPerDay = json['hours_per_day'] as String?,
        hoursPerMonth = json['hours_per_month'] as String?,
        leaveStatus = json['leave_status'] as String?,
        status = json['status'] as int?,
        createdAt = json['created_at'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'leave_type' : leaveType,
    'leave_days' : leaveDays,
    'hours_per_day' : hoursPerDay,
    'hours_per_month' : hoursPerMonth,
    'leave_status' : leaveStatus,
    'status' : status,
    'created_at' : createdAt
  };
}