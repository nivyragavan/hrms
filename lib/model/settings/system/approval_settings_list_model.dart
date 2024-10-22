class ApprovalSettingsListModel {
  final String? code;
  final String? message;
  final Datum? data;

  ApprovalSettingsListModel({
    this.code,
    this.message,
    this.data,
  });

  ApprovalSettingsListModel.fromJson(Map<String, dynamic> json)
      : code = json['code'] as String?,
        message = json['message'] as String?,
        data = (json['data'] as Map<String,dynamic>?) != null ? Datum.fromJson(json['data'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'code' : code,
    'message' : message,
    'data' : data?.toJson()
  };
}

class Datum {
  final List<ApprovalDataList>? approvalListData;

  Datum({
    this.approvalListData,
  });

  Datum.fromJson(Map<String, dynamic> json)
      : approvalListData = (json['data'] as List?)?.map((dynamic e) => ApprovalDataList.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'data' : approvalListData?.map((e) => e.toJson()).toList()
  };
}

class ApprovalDataList {
  final int? id;
  final int? branchId;
  final int? defaultLeaveApproval;
  int? approverLevel;
  final int? approverId;
  final String? createdAt;
    String? firstName;
   String? lastName;
  final String? updatedAt;
  final dynamic deletedAt;
  final dynamic createdBy;
  final dynamic updatedBy;
  final dynamic deletedBy;

  ApprovalDataList({
    this.id,
    this.branchId,
    this.defaultLeaveApproval,
    this.approverLevel,
    this.approverId,
    this.createdAt,
    this.firstName = '',
    this.lastName = '',
    this.updatedAt,
    this.deletedAt,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
  });

  ApprovalDataList.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        branchId = json['branch_id'] as int?,
        defaultLeaveApproval = json['default_leave_approval'] as int?,
        approverLevel = json['approver_level'] as int?,
        approverId = json['approver_id'] as int?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        firstName = json['first_name'] as String?,
        lastName = json['last_name'] as String?,
        deletedAt = json['deleted_at'],
        createdBy = json['created_by'],
        updatedBy = json['updated_by'],
        deletedBy = json['deleted_by'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'branch_id' : branchId,
    'default_leave_approval' : defaultLeaveApproval,
    'approver_level' : approverLevel,
    'approver_id' : approverId,
    'created_at' : createdAt,
    'updated_at' : updatedAt,
    'first_name' : firstName,
    'last_name' : lastName,
    'deleted_at' : deletedAt,
    'created_by' : createdBy,
    'updated_by' : updatedBy,
    'deleted_by' : deletedBy
  };
}