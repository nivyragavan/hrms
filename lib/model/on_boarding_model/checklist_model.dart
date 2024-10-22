// To parse this JSON data, do
//
//     final checklistModel = checklistModelFromJson(jsonString);

import 'dart:convert';

ChecklistModel checklistModelFromJson(String str) => ChecklistModel.fromJson(json.decode(str));

String checklistModelToJson(ChecklistModel data) => json.encode(data.toJson());

class ChecklistModel {
  String? code;
  String? message;
  Data? data;

  ChecklistModel({
    this.code,
    this.message,
    this.data,
  });

  factory ChecklistModel.fromJson(Map<String, dynamic> json) => ChecklistModel(
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
  List<Datum>? data;

  Data({
    this.data,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
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
  int? datumImport;
  DateTime? createdAt;
  dynamic deviceToken;
  dynamic fcmToken;
  String? userUniqueId;
  Department? department;
  JobPosition? jobPosition;
  PersonalInfo? personalInfo;

  Datum({
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
    this.datumImport,
    this.createdAt,
    this.deviceToken,
    this.fcmToken,
    this.userUniqueId,
    this.department,
    this.jobPosition,
    this.personalInfo,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    emailId: json["email_id"],
    gender: json["gender"],
    maritalStatus: json["marital_status"],
    country: json["country"] == null ? json["country"] : Country.fromJson(json["country"]),
    dateOfBirth: json["date_of_birth"] == null ? json["date_of_birth"] : DateTime.parse(json["date_of_birth"]),
    state: json["state"] == null ? json["state"] : State.fromJson(json["state"]),
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
    employeeType: json["employee_type"] == null ? json["employee_type"] : Employe.fromJson(json["employee_type"]),
    status: json["status"],
    datumImport: json["import"],
    createdAt:json["created_at"] == null ? json["created_at"] : DateTime.parse(json["created_at"]),
    deviceToken: json["device_token"],
    fcmToken: json["fcm_token"],
    userUniqueId: json["user_unique_id"],
    department: json["department"] == null ? json["department"] : Department.fromJson(json["department"]),
    jobPosition: json["job_position"] == null ? json["job_position"] : JobPosition.fromJson(json["job_position"]),
    personalInfo: json["personal_info"] == null ? json["personal_info"] : PersonalInfo.fromJson(json["personal_info"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "email_id": emailId,
    "gender": gender,
    "marital_status": maritalStatus,
    "country": country?.toJson(),
    "date_of_birth": "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
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
    "import": datumImport,
    "created_at": createdAt?.toIso8601String(),
    "device_token": deviceToken,
    "fcm_token": fcmToken,
    "user_unique_id": userUniqueId,
    "department": department?.toJson(),
    "job_position": jobPosition?.toJson(),
    "personal_info": personalInfo?.toJson(),
  };
}

class City {
  int? id;
  String? name;
  int? stateId;
  String? stateCode;
  int? countryId;
  String? countryCode;
  String? latitude;
  String? longitude;

  City({
    this.id,
    this.name,
    this.stateId,
    this.stateCode,
    this.countryId,
    this.countryCode,
    this.latitude,
    this.longitude,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"],
    name: json["name"],
    stateId: json["state_id"],
    stateCode: json["state_code"],
    countryId: json["country_id"],
    countryCode: json["country_code"],
    latitude: json["latitude"],
    longitude: json["longitude"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "state_id": stateId,
    "state_code": stateCode,
    "country_id": countryId,
    "country_code": countryCode,
    "latitude": latitude,
    "longitude": longitude,
  };
}

class Country {
  int? id;
  String? name;
  String? iso3;
  String? iso2;
  String? phoneCode;
  String? capital;
  String? currency;
  String? native;
  String? emoji;
  String? emojiU;
  DateTime? createdAt;

  Country({
    this.id,
    this.name,
    this.iso3,
    this.iso2,
    this.phoneCode,
    this.capital,
    this.currency,
    this.native,
    this.emoji,
    this.emojiU,
    this.createdAt,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json["id"],
    name: json["name"],
    iso3: json["iso3"],
    iso2: json["iso2"],
    phoneCode: json["phone_code"],
    capital: json["capital"],
    currency: json["currency"],
    native: json["native"],
    emoji: json["emoji"],
    emojiU: json["emojiU"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "iso3": iso3,
    "iso2": iso2,
    "phone_code": phoneCode,
    "capital": capital,
    "currency": currency,
    "native": native,
    "emoji": emoji,
    "emojiU": emojiU,
    "created_at": createdAt?.toIso8601String(),
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

class Employe {
  String? id;
  String? type;

  Employe({
    this.id,
    this.type,
  });

  factory Employe.fromJson(Map<String, dynamic> json) => Employe(
    id: json["id"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
  };
}

class JobPosition {
  int? id;
  int? userId;
  int? positionId;
  DateTime? createdAt;
  Company? company;
  String? lineManager;
  Position? position;

  JobPosition({
    this.id,
    this.userId,
    this.positionId,
    this.createdAt,
    this.company,
    this.lineManager,
    this.position,
  });

  factory JobPosition.fromJson(Map<String, dynamic> json) => JobPosition(
    id: json["id"],
    userId: json["user_id"],
    positionId: json["position_id"],
    createdAt: DateTime.parse(json["created_at"]),
    company: json["company"]==null?json["company"]:Company.fromJson(json["company"]),
    lineManager: json["line_manager"],
    position: Position.fromJson(json["position"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "position_id": positionId,
    "created_at": createdAt?.toIso8601String(),
    "company": company?.toJson(),
    "line_manager": lineManager,
    "position": position?.toJson(),
  };
}

class Company {
  int? id;
  String? domain;
  String? tenantId;
  String? firstName;
  String? lastName;
  String? email;
  dynamic jobTitle;
  dynamic phoneNumber;
  dynamic address;
  dynamic employeeCount;
  int? countryId;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;

  Company({
    this.id,
    this.domain,
    this.tenantId,
    this.firstName,
    this.lastName,
    this.email,
    this.jobTitle,
    this.phoneNumber,
    this.address,
    this.employeeCount,
    this.countryId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    id: json["id"],
    domain: json["domain"],
    tenantId: json["tenant_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    jobTitle: json["job_title"],
    phoneNumber: json["phone_number"],
    address: json["address"],
    employeeCount: json["employee_count"],
    countryId: json["country_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    deletedAt: json["deleted_at"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    deletedBy: json["deleted_by"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "domain": domain,
    "tenant_id": tenantId,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "job_title": jobTitle,
    "phone_number": phoneNumber,
    "address": address,
    "employee_count": employeeCount,
    "country_id": countryId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "deleted_by": deletedBy,
  };
}

class Position {
  int? id;
  int? departmentId;
  String? positionName;
  int? grade;
  DateTime? createdAt;

  Position({
    this.id,
    this.departmentId,
    this.positionName,
    this.grade,
    this.createdAt,
  });

  factory Position.fromJson(Map<String, dynamic> json) => Position(
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

class PersonalInfo {
  int? id;
  int? userId;
  String? branchId;
  String? employeeId;
  DateTime? effectiveDate;
  int? employementType;
  int? shiftId;
  String? shiftTime;
  int? status;
  int? probationPeriod;
  DateTime? probationStartDate;
  DateTime? probationEndDate;
  DateTime? createdAt;
  Employe? employementTypeData;

  PersonalInfo({
    this.id,
    this.userId,
    this.branchId,
    this.employeeId,
    this.effectiveDate,
    this.employementType,
    this.shiftId,
    this.shiftTime,
    this.status,
    this.probationPeriod,
    this.probationStartDate,
    this.probationEndDate,
    this.createdAt,
    this.employementTypeData,
  });

  factory PersonalInfo.fromJson(Map<String, dynamic> json) => PersonalInfo(
    id: json["id"],
    userId: json["user_id"],
    branchId: json["branch_id"],
    employeeId: json["employee_id"],
    effectiveDate: DateTime.parse(json["effective_date"]),
    employementType: json["employement_type"],
    shiftId: json["shift_id"],
    shiftTime: json["shift_time"],
    status: json["status"],
    probationPeriod: json["probation_period"],
    probationStartDate: DateTime.parse(json["probation_start_date"]),
    probationEndDate: DateTime.parse(json["probation_end_date"]),
    createdAt: DateTime.parse(json["created_at"]),
    employementTypeData: Employe.fromJson(json["employement_type_data"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "branch_id": branchId,
    "employee_id": employeeId,
    "effective_date": "${effectiveDate!.year.toString().padLeft(4, '0')}-${effectiveDate!.month.toString().padLeft(2, '0')}-${effectiveDate!.day.toString().padLeft(2, '0')}",
    "employement_type": employementType,
    "shift_id": shiftId,
    "shift_time": shiftTime,
    "status": status,
    "probation_period": probationPeriod,
    "probation_start_date": "${probationStartDate!.year.toString().padLeft(4, '0')}-${probationStartDate!.month.toString().padLeft(2, '0')}-${probationStartDate!.day.toString().padLeft(2, '0')}",
    "probation_end_date": "${probationEndDate!.year.toString().padLeft(4, '0')}-${probationEndDate!.month.toString().padLeft(2, '0')}-${probationEndDate!.day.toString().padLeft(2, '0')}",
    "created_at": createdAt?.toIso8601String(),
    "employement_type_data": employementTypeData?.toJson(),
  };
}

class State {
  int? id;
  String? name;
  int? countryId;
  String? countryCode;
  String? stateCode;

  State({
    this.id,
    this.name,
    this.countryId,
    this.countryCode,
    this.stateCode,
  });

  factory State.fromJson(Map<String, dynamic> json) => State(
    id: json["id"],
    name: json["name"],
    countryId: json["country_id"],
    countryCode: json["country_code"],
    stateCode: json["state_code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "country_id": countryId,
    "country_code": countryCode,
    "state_code": stateCode,
  };
}
