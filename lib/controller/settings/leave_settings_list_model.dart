import '../../model/announcement/announcement_viewd_list_model.dart';

class LeaveSettingsListModel {
  final String? code;
  final String? message;
  final Data1? data;

  LeaveSettingsListModel({
    this.code,
    this.message,
    this.data,
  });

  LeaveSettingsListModel.fromJson(Map<String, dynamic> json)
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
  final List<Data>? data;

  Data1({
    this.data,
  });

  Data1.fromJson(Map<String, dynamic> json)
      : data = (json['data'] as List?)?.map((dynamic e) => Data.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'data' : data?.map((e) => e.toJson()).toList()
  };
}

class Data {
  final int? id;
  final int? branchId;
  final String? name;
  final dynamic noOfDays;
  final String? hoursPerDay;
  final String? hoursPerMonth;
   int? carryForwardStatus;
  final dynamic carryForwardDays;
   int? countWeekendStatus;
  final int? status;
  final String? createdAt;
  final String? updatedAt;
  final dynamic deletedAt;
  final int? createdBy;
  final dynamic updatedBy;
  final dynamic deletedBy;
  final CustomPolicy? customPolicy;

  Data({
    this.id,
    this.branchId,
    this.name,
    this.noOfDays,
    this.hoursPerDay,
    this.hoursPerMonth,
    this.status,
    this.carryForwardStatus,
    this.carryForwardDays,
    this.countWeekendStatus,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.customPolicy,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        branchId = json['branch_id'] as int?,
        name = json['name'] as String?,
        noOfDays = json['no_of_days'],
        hoursPerDay = json['hours_per_day'] as String?,
        hoursPerMonth = json['hours_per_month'] as String?,
        carryForwardStatus = json['carry_forward_status'] as int?,
        carryForwardDays = json['carry_forward_days'],
        countWeekendStatus = json['count_weekend_status'] as int?,
        status = json['status'] as int?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        deletedAt = json['deleted_at'],
        createdBy = json['created_by'] as int?,
        updatedBy = json['updated_by'],
        deletedBy = json['deleted_by'],
        customPolicy = json['custom_policy']==null? json['custom_policy']:CustomPolicy.fromJson( json['custom_policy']);

  Map<String, dynamic> toJson() => {
    'id' : id,
    'branch_id' : branchId,
    'name' : name,
    'no_of_days' : noOfDays,
    'hours_per_day' : hoursPerDay,
    'hours_per_month' : hoursPerMonth,
    'carry_forward_status' : carryForwardStatus,
    'carry_forward_days' : carryForwardDays,
    'count_weekend_status' : countWeekendStatus,
    'status' : status,
    'created_at' : createdAt,
    'updated_at' : updatedAt,
    'deleted_at' : deletedAt,
    'created_by' : createdBy,
    'updated_by' : updatedBy,
    'deleted_by' : deletedBy,
    'custom_policy' : customPolicy
  };
}


class CustomPolicy {
  int? id;
  int? leaveSettingsId;
  String? policyName;
  int? noOfDays;
  List<UserId>? userId;
  List<DepartmentId>? departmentId;
  List<PositionId>? positionId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;

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

  factory CustomPolicy.fromJson(Map<String, dynamic> json) => CustomPolicy(
    id: json["id"],
    leaveSettingsId: json["leave_settings_id"],
    policyName: json["policy_name"],
    noOfDays: json["no_of_days"],
    userId: List<UserId>.from(json["user_id"].map((x) => UserId.fromJson(x))),
    departmentId: List<DepartmentId>.from(json["department_id"].map((x) => DepartmentId.fromJson(x))),
    positionId: List<PositionId>.from(json["position_id"].map((x) => PositionId.fromJson(x))),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    deletedBy: json["deleted_by"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "leave_settings_id": leaveSettingsId,
    "policy_name": policyName,
    "no_of_days": noOfDays,
    "user_id": List<dynamic>.from(userId!.map((x) => x.toJson())),
    "department_id": List<dynamic>.from(departmentId!.map((x) => x.toJson())),
    "position_id": List<dynamic>.from(positionId!.map((x) => x.toJson())),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "deleted_by": deletedBy,
  };
}

class DepartmentId {
  int? id;
  String? departmentName;
  String? description;
  String? departmentIcon;
  int? status;
  DateTime? createdAt;

  DepartmentId({
     this.id,
     this.departmentName,
     this.description,
     this.departmentIcon,
     this.status,
     this.createdAt,
  });

  factory DepartmentId.fromJson(Map<String, dynamic> json) => DepartmentId(
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

class PositionId {
  int? id;
  int? departmentId;
  String? positionName;
  int? grade;
  DateTime? createdAt;

  PositionId({
     this.id,
     this.departmentId,
     this.positionName,
     this.grade,
     this.createdAt,
  });

  factory PositionId.fromJson(Map<String, dynamic> json) => PositionId(
    id: json["id"],
    departmentId: json["department_id"],
    positionName: json["position_name"],
    grade: json["grade"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "department_id": departmentId,
    "position_name": positionName,
    "grade": grade,
    "created_at": createdAt?.toIso8601String(),
  };
}

class UserId {
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
  dynamic inviteRef;
  EmployeeType? employeeType;
  int? status;
  int? userIdImport;
  DateTime? createdAt;
  String? deviceToken;
  dynamic fcmToken;
  String? userUniqueId;

  UserId({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.emailId,
    required this.gender,
    required this.maritalStatus,
    required this.country,
    required this.dateOfBirth,
    required this.state,
    required this.city,
    required this.personalEmail,
    required this.bloodGroup,
    required this.profileImage,
    required this.companyId,
    required this.jobTitleId,
    required this.branchId,
    required this.departmentId,
    required this.shiftId,
    required this.reportingToId,
    required this.role,
    required this.mobileNumber,
    required this.inviteRef,
    required this.employeeType,
    required this.status,
    required this.userIdImport,
    required this.createdAt,
    required this.deviceToken,
    required this.fcmToken,
    required this.userUniqueId,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    emailId: json["email_id"],
    gender: json["gender"],
    maritalStatus: json["marital_status"],
    country: Country.fromJson(json["country"]),
    dateOfBirth: DateTime.parse(json["date_of_birth"]),
    state: State.fromJson(json["state"]),
    city: City.fromJson(json["city"]),
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
    employeeType: EmployeeType.fromJson(json["employee_type"]),
    status: json["status"],
    userIdImport: json["import"],
    createdAt: DateTime.parse(json["created_at"]),
    deviceToken: json["device_token"],
    fcmToken: json["fcm_token"],
    userUniqueId: json["user_unique_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "email_id": emailId,
    "gender": gender,
    "marital_status": maritalStatus,
    "country": country?.toJson(),
    "date_of_birth": "${dateOfBirth?.year.toString().padLeft(4, '0')}-${dateOfBirth?.month.toString().padLeft(2, '0')}-${dateOfBirth?.day.toString().padLeft(2, '0')}",
    "state": state?.toJson(),
    "city": city?.toJson(),
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
    "employee_type": employeeType?.toJson(),
    "status": status,
    "import": userIdImport,
    "created_at": createdAt?.toIso8601String(),
    "device_token": deviceToken,
    "fcm_token": fcmToken,
    "user_unique_id": userUniqueId,
  };
}