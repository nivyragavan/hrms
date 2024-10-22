class LeaveMasterModel {
  final String? code;
  final String? message;
  final List<Data>? data;

  LeaveMasterModel({
    this.code,
    this.message,
    this.data,
  });

  LeaveMasterModel.fromJson(Map<String, dynamic> json)
      : code = json['code'] as String?,
        message = json['message'] as String?,
        data = (json['data'] as List?)?.map((dynamic e) => Data.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'code' : code,
    'message' : message,
    'data' : data?.map((e) => e.toJson()).toList()
  };
}

class Data {
  final int? id;
  final int? branchId;
  final String? name;
  final int? noOfDays;
  final int? carryForwardStatus;
  final int? carryForwardDays;
  final int? countWeekendStatus;
  final String? createdAt;
  final String? updatedAt;
  final dynamic deletedAt;
  final dynamic createdBy;
  final dynamic updatedBy;
  final dynamic deletedBy;
  final int? availableLeave;
  final CustomPolicy? customPolicy;

  Data({
    this.id,
    this.branchId,
    this.name,
    this.noOfDays,
    this.carryForwardStatus,
    this.carryForwardDays,
    this.countWeekendStatus,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.availableLeave,
    this.customPolicy,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        branchId = json['branch_id'] as int?,
        name = json['name'] as String?,
        noOfDays = json['no_of_days'] as int?,
        carryForwardStatus = json['carry_forward_status'] as int?,
        carryForwardDays = json['carry_forward_days'] as int?,
        countWeekendStatus = json['count_weekend_status'] as int?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        deletedAt = json['deleted_at'],
        createdBy = json['created_by'],
        updatedBy = json['updated_by'],
        deletedBy = json['deleted_by'],
        availableLeave = json['available_leave'] as int?,
        customPolicy = (json['custom_policy'] as Map<String,dynamic>?) != null ? CustomPolicy.fromJson(json['custom_policy'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'branch_id' : branchId,
    'name' : name,
    'no_of_days' : noOfDays,
    'carry_forward_status' : carryForwardStatus,
    'carry_forward_days' : carryForwardDays,
    'count_weekend_status' : countWeekendStatus,
    'created_at' : createdAt,
    'updated_at' : updatedAt,
    'deleted_at' : deletedAt,
    'created_by' : createdBy,
    'updated_by' : updatedBy,
    'deleted_by' : deletedBy,
    'available_leave' : availableLeave,
    'custom_policy' : customPolicy?.toJson()
  };
}

class CustomPolicy {
  final int? id;
  final int? leaveSettingsId;
  final String? policyName;
  final int? noOfDays;
  final String? userId;
  final String? departmentId;
  final String? positionId;
  final String? createdAt;
  final String? updatedAt;
  final dynamic deletedAt;
  final dynamic createdBy;
  final dynamic updatedBy;
  final dynamic deletedBy;

  CustomPolicy({
    this.id,
    this.leaveSettingsId,
    this.policyName,
    this.noOfDays,
    this.userId,
    this.departmentId,
    this.positionId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
  });

  CustomPolicy.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        leaveSettingsId = json['leave_settings_id'] as int?,
        policyName = json['policy_name'] as String?,
        noOfDays = json['no_of_days'] as int?,
        userId = json['user_id'] as String?,
        departmentId = json['department_id'] as String?,
        positionId = json['position_id'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        deletedAt = json['deleted_at'],
        createdBy = json['created_by'],
        updatedBy = json['updated_by'],
        deletedBy = json['deleted_by'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'leave_settings_id' : leaveSettingsId,
    'policy_name' : policyName,
    'no_of_days' : noOfDays,
    'user_id' : userId,
    'department_id' : departmentId,
    'position_id' : positionId,
    'created_at' : createdAt,
    'updated_at' : updatedAt,
    'deleted_at' : deletedAt,
    'created_by' : createdBy,
    'updated_by' : updatedBy,
    'deleted_by' : deletedBy
  };
}