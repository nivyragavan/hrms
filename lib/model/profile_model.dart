// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

import 'employee_list_model.dart';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModelData? data;

  ProfileModel({
    this.data,
  });



  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    data: ProfileModelData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class ProfileModelData {
  DataData? data;

  ProfileModelData({
    this.data,
  });



  factory ProfileModelData.fromJson(Map<String, dynamic> json) => ProfileModelData(
    data: DataData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class DataData {
  int? id;
  String? firstName;
  String? lastName;
  String? emailId;
  dynamic gender;
  dynamic maritalStatus;
  Country? country;
  dynamic dateOfBirth;
  State? state;
  City? city;
  dynamic personalEmail;
  dynamic bloodGroup;
  String? profileImage;
  int? companyId;
  dynamic jobTitleId;
  dynamic branchId;
  int? departmentId;
  int? shiftId;
  int? reportingToId;
  int? role;
  String? mobileNumber;
  dynamic inviteRef;
  Employe? employeeType;
  int? status;
  int? dataImport;
  DateTime? createdAt;
  Department? department;
  Company? company;
  Shedules? shedules;
  String? userUniqueId;
  List<Dependent>? emergencyContactDetails;
  List<Dependent>? dependents;
  List<EducationalDetail>? educationalDetails;
  List<dynamic>? addressDetails;
  PersonalInfo? personalInfo;
  JobPosition? jobPosition;
  List<PositionLog>? positionLogs;

  DataData({
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
    this.dataImport,
    this.createdAt,
    this.department,
    this.company,
    this.shedules,
    this.userUniqueId,
    this.emergencyContactDetails,
    this.dependents,
    this.educationalDetails,
    this.addressDetails,
    this.personalInfo,
    this.jobPosition,
    this.positionLogs,
  });

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
    id: json["id"],
    firstName: json["first_name"]==null?"-":json["first_name"],
    lastName: json["last_name"]==null?"-":json["last_name"],
    emailId: json["email_id"]==null?"-":json["email_id"],
    gender: json["gender"]==null?"-":json["gender"],
    maritalStatus:json["marital_status"]==null?"-": json["marital_status"],
    country: json["country"]==null?json["country"]:Country.fromJson(json["country"]),
    dateOfBirth: json["date_of_birth"]==null?"-":json["date_of_birth"],
    state:json["state"]==null?json["state"]:State.fromJson(json["state"]),//"-": json["state"],
    city: json["city"]==null?json["city"]:City.fromJson(json["city"]),//"-":json["city"],
    personalEmail:json["personal_email"]==null?"-": json["personal_email"],
    bloodGroup: json["blood_group"]==null?"-":json["blood_group"],
    profileImage:json["profile_image"]==null?"-": json["profile_image"],
    companyId: json["company_id"]==null?"-":json["company_id"],
    jobTitleId:json["job_title_id"]==null?"-": json["job_title_id"],
    branchId: json["branch_id"]==null?"-":json["branch_id"],
    departmentId:json["department_id"]=="null"?"-": json["department_id"],
    shiftId:json["shift_id"]=="null"?"-": json["shift_id"],
    reportingToId: json["reporting_to_id"]=="null"?"-":json["reporting_to_id"],
    role: json["role"],
    mobileNumber: json["mobile_number"]==null?"-":json["mobile_number"],
    inviteRef:json["invite_ref"]==null?"-": json["invite_ref"],
    employeeType: json["employee_type"]==null?json["employee_type"]:Employe.fromJson(json["employee_type"]),
    status: json["status"]==null?"-":json["status"],
    dataImport: json["import"]==null?"-":json["import"],
    createdAt: json["created_at"]==null?json["created_at"]:DateTime.parse(json["created_at"]),
    // createdAt: json["created_at"],
    department: json["department"]==null?json["department"]:Department.fromJson(json["department"]),
    company: json["company"]==null?json["company"]:Company.fromJson(json["company"]),
    shedules: json["shedules"]==null?json["shedules"]:Shedules.fromJson(json["shedules"]),
    userUniqueId: json["user_unique_id"]==null?"-":json["user_unique_id"],
    emergencyContactDetails: json["emergency_contact_details"]==null?json["emergency_contact_details"]:List<Dependent>.from(json["emergency_contact_details"].map((x) => Dependent.fromJson(x))),
    dependents: json["dependents"]==[]?[]:List<Dependent>.from(json["dependents"].map((x) => Dependent.fromJson(x))),
    educationalDetails: json["educational_details"]==[]?json["educational_details"]:List<EducationalDetail>.from(json["educational_details"].map((x) => EducationalDetail.fromJson(x))),
    addressDetails: json["address_details"]==[]?json["address_details"]:List<dynamic>.from(json["address_details"].map((x) => x)),
    personalInfo:json["personal_info"]==null?json["personal_info"]: PersonalInfo.fromJson(json["personal_info"]),
    jobPosition: json["job_position"]==null?json["job_position"]:JobPosition.fromJson(json["job_position"]),
    positionLogs: json["position_logs"]==[]?json["position_logs"]:List<PositionLog>.from(json["position_logs"].map((x) => PositionLog.fromJson(x))),
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
    "import": dataImport,
    "created_at": createdAt?.toIso8601String(),
    "department": department?.toJson(),
    "company": company?.toJson(),
    "shedules": shedules?.toJson(),
    "user_unique_id": userUniqueId,
    "emergency_contact_details": List<dynamic>.from(emergencyContactDetails!.map((x) => x.toJson())),
    "dependents": List<dynamic>.from(dependents!.map((x) => x.toJson())),
    "educational_details": List<dynamic>.from(educationalDetails!.map((x) => x.toJson())),
    "address_details": List<dynamic>.from(addressDetails!.map((x) => x)),
    "personal_info": personalInfo?.toJson(),
    "job_position": jobPosition?.toJson(),
    "position_logs": List<dynamic>.from(positionLogs!.map((x) => x.toJson())),
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
  String? phoneNumber;
  String? address;
  String? employeeCount;
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
    id: json["id"]==null?"-":json["id"],
    domain:json["domain"]==null?"-": json["domain"],
    tenantId:json["tenant_id"]==null?"-": json["tenant_id"],
    firstName: json["first_name"]==null?"-":json["first_name"],
    lastName: json["last_name"]==null?"-":json["last_name"],
    email: json["email"]==null?"-":json["email"],
    jobTitle: json["job_title"]==null?"-":json["job_title"],
    phoneNumber:json["phone_number"]==null?"-": json["phone_number"],
    address: json["address"]==null?"-":json["address"],
    employeeCount:json["employee_count"]==null?"-": json["employee_count"],
    countryId: json["country_id"]==null?"-":json["country_id"],
    createdAt: json["created_at"]==null?"-":json["created_at"],
    updatedAt:json["updated_at"]==null?"-": json["updated_at"],
    deletedAt:json["deleted_at"]==null?"-": json["deleted_at"],
    createdBy:json["created_by"]==null?"-": json["created_by"],
    updatedBy: json["updated_by"]==null?"-":json["updated_by"],
    deletedBy:json["deleted_by"]==null?"-": json["deleted_by"],
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

class Dependent {
  int? id;
  int? userId;
  String? firstName;
  String? lastName;
  String? gender;
  String? relationship;
  String? phoneNumber;
  String? emailAddress;
  DateTime? createdAt;

  Dependent({
    this.id,
    this.userId,
    this.firstName,
    this.lastName,
    this.gender,
    this.relationship,
    this.phoneNumber,
    this.emailAddress,
    this.createdAt,
  });


  factory Dependent.fromJson(Map<String, dynamic> json) => Dependent(
    id: json["id"]==null?"-":json["id"],
    userId:json["user_id"]==null?"-": json["user_id"],
    firstName:json["first_name"]==null?"-": json["first_name"],
    lastName: json["last_name"]==null?"-":json["last_name"],
    gender: json["gender"]==null?"-":json["gender"],
    relationship: json["relationship"]==null?"-":json["relationship"],
    phoneNumber: json["phone_number"]==null?"-":json["phone_number"],
    emailAddress:json["email_address"]==null?"-": json["email_address"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "first_name": firstName,
    "last_name": lastName,
    "gender": gender,
    "relationship": relationship,
    "phone_number": phoneNumber,
    "email_address": emailAddress,
    "created_at": createdAt?.toIso8601String(),
  };
}

class EducationalDetail {
  int? id;
  int? userId;
  String? degree;
  String? specialization;
  String? collegeName;
  String? gpa;
  DateTime? startYear;
  DateTime? endYear;
  DateTime? createdAt;

  EducationalDetail({
    this.id,
    this.userId,
    this.degree,
    this.specialization,
    this.collegeName,
    this.gpa,
    this.startYear,
    this.endYear,
    this.createdAt,
  });


  factory EducationalDetail.fromJson(Map<String, dynamic> json) => EducationalDetail(
    id: json["id"]==null?"-":json["id"],
    userId:json["user_id"]==null?"-": json["user_id"],
    degree: json["degree"]==null?"-":json["degree"],
    specialization:json["specialization"]==null?"-": json["specialization"],
    collegeName: json["college_name"]==null?"-":json["college_name"],
    gpa: json["gpa"]==null?"-":json["gpa"],
    startYear: DateTime.parse(json["start_year"]),
    endYear: DateTime.parse(json["end_year"]),
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "degree": degree,
    "specialization": specialization,
    "college_name": collegeName,
    "gpa": gpa,
    "start_year": "${startYear?.year.toString().padLeft(4, '0')}-${startYear?.month.toString().padLeft(2, '0')}-${startYear?.day.toString().padLeft(2, '0')}",
    "end_year": "${endYear?.year.toString().padLeft(4, '0')}-${endYear?.month.toString().padLeft(2, '0')}-${endYear?.day.toString().padLeft(2, '0')}",
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
  JobPositionPosition? position;

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
    id: json["id"]==null?"-":json["id"],
    userId:json["user_id"]==null?"-": json["user_id"],
    positionId:json["position_id"]==null?"-": json["position_id"],
    createdAt: DateTime.parse(json["created_at"]),
    company: json["company"]==null?json["company"]:Company.fromJson(json["company"]),
    lineManager: json["line_manager"]==null?"-":json["line_manager"],
    position: JobPositionPosition.fromJson(json["position"]),
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

class JobPositionPosition {
  int? id;
  int? departmentId;
  String? positionName;
  Grade? grade;
  DateTime? createdAt;

  JobPositionPosition({
    this.id,
    this.departmentId,
    this.positionName,
    this.grade,
    this.createdAt,
  });


  factory JobPositionPosition.fromJson(Map<String, dynamic> json) => JobPositionPosition(
    id: json["id"],
    departmentId: json["department_id"],
    positionName: json["position_name"]=="null"?"-":json["position_name"],
    grade: Grade.fromJson(json["grade"]),
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "department_id": departmentId,
    "position_name": positionName,
    "grade": grade?.toJson(),
    "created_at": createdAt?.toIso8601String(),
  };
}

class Grade {
  int? id;
  String? gradeName;

  Grade({
    this.id,
    this.gradeName,
  });

  factory Grade.fromJson(Map<String, dynamic> json) => Grade(
    id: json["id"],
    gradeName: json["grade_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "grade_name": gradeName,
  };
}

class PersonalInfo {
  int? id;
  int? userId;
  String? branchId;
  String? employeeId;
  dynamic? effectiveDate;
  int? employementType;
  int? shiftId;
  String? shiftTime;
  int? status;
  int? probationPeriod;
  String? probationStartDate;
  String? probationEndDate;
  String? createdAt;
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
    effectiveDate:json["effective_date"],
    employementType: json["employement_type"],
    shiftId:json["shift_id"]==null?"-": json["shift_id"],
    shiftTime: json["shift_time"]==null?"-":json["shift_time"],
    status:json["status"]==null?"-": json["status"],
    probationPeriod: json["probation_period"],
    probationStartDate: json["probation_start_date"],
    probationEndDate: json["probation_end_date"],
    createdAt: json["created_at"],
    employementTypeData: Employe.fromJson(json["employement_type_data"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "branch_id": branchId,
    "employee_id": employeeId,
    "effective_date": "${effectiveDate?.year.toString().padLeft(4, '0')}-${effectiveDate?.month.toString().padLeft(2, '0')}-${effectiveDate?.day.toString().padLeft(2, '0')}",
    "employement_type": employementType,
    "shift_id": shiftId,
    "shift_time": shiftTime,
    "status": status,
    "probation_period": probationPeriod,
    "probation_start_date": probationStartDate,//"${probationStartDate?.year.toString().padLeft(4, '0')}-${probationStartDate?.month.toString().padLeft(2, '0')}-${probationStartDate?.day.toString().padLeft(2, '0')}",
    "probation_end_date": probationEndDate,//"${probationEndDate?.year.toString().padLeft(4, '0')}-${probationEndDate?.month.toString().padLeft(2, '0')}-${probationEndDate?.day.toString().padLeft(2, '0')}",
    "created_at": createdAt,//createdAt?.toIso8601String(),
    "employement_type_data": employementTypeData?.toJson(),
  };
}

class PositionLog {
  int? id;
  int? userId;
  int? positionId;
  DateTime? assignDate;
  PositionLogPosition? position;

  PositionLog({
    this.id,
    this.userId,
    this.positionId,
    this.assignDate,
    this.position,
  });


  factory PositionLog.fromJson(Map<String, dynamic> json) => PositionLog(
    id: json["id"],
    userId: json["user_id"],
    positionId: json["position_id"]==null?"-":json["position_id"],
    assignDate: DateTime.parse(json["assign_date"]),
    position: PositionLogPosition.fromJson(json["position"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "position_id": positionId,
    "assign_date": "${assignDate?.year.toString().padLeft(4, '0')}-${assignDate?.month.toString().padLeft(2, '0')}-${assignDate?.day.toString().padLeft(2, '0')}",
    "position": position?.toJson(),
  };
}

class PositionLogPosition {
  int? id;
  int? departmentId;
  String? positionName;
  int? grade;
  DateTime? createdAt;

  PositionLogPosition({
    this.id,
    this.departmentId,
    this.positionName,
    this.grade,
    this.createdAt,
  });

  factory PositionLogPosition.fromJson(Map<String, dynamic> json) => PositionLogPosition(
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
    "created_at": '${createdAt?.day}/${createdAt?.month}/${createdAt?.year}',
  };
}

class Shedules {
  int? id;
  String? shiftName;
  String? color;
  String? maxHours;
  int? shiftType;
  DateTime? createdAt;

  Shedules({
    this.id,
    this.shiftName,
    this.color,
    this.maxHours,
    this.shiftType,
    this.createdAt,
  });

  factory Shedules.fromJson(Map<String, dynamic> json) => Shedules(
    id: json["id"],
    shiftName: json["shift_name"],
    color: json["color"],
    maxHours: json["max_hours"],
    shiftType: json["shift_type"],
    createdAt: json["created_at"]==null?json["created_at"]:DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "shift_name": shiftName,
    "color": color,
    "max_hours": maxHours,
    "shift_type": shiftType,
    "created_at": createdAt?.toIso8601String(),
  };
}
