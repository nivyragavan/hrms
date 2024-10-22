// To parse this JSON data, do
//
//     final announcementListModel = announcementListModelFromJson(jsonString);

import 'dart:convert';

AnnouncementListModel announcementListModelFromJson(String str) => AnnouncementListModel.fromJson(json.decode(str));

String announcementListModelToJson(AnnouncementListModel data) => json.encode(data.toJson());

class AnnouncementListModel {
  String? code;
  String? message;
  List<Data>? data;

  AnnouncementListModel({
    this.code,
    this.message,
    this.data,
  });

  factory AnnouncementListModel.fromJson(Map<String, dynamic> json) => AnnouncementListModel(
    data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
    code: json["code"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "code": code,
    "message": message,
  };
}

class Data {
  int? id;
  String? subject;
  String? message;
  String? attachment;
  int? publish;
  DateTime? createdAt;
  List<UserElement>? viewedData;
  List<UserElement>? users;

  Data({
    this.id,
    this.subject,
    this.message,
    this.attachment,
    this.publish,
    this.createdAt,
    this.viewedData,
    this.users,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    subject: json["subject"],
    message: json["message"],
    attachment: json["attachment"],
    publish: json["publish"],
    createdAt: DateTime.parse(json["created_at"]),
    viewedData: List<UserElement>.from(json["viewed_data"].map((x) => UserElement.fromJson(x))),
    users: List<UserElement>.from(json["users"].map((x) => UserElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "subject": subject,
    "message": message,
    "attachment": attachment,
    "publish": publish,
    "created_at": createdAt?.toIso8601String(),
    "viewed_data": List<dynamic>.from(viewedData!.map((x) => x.toJson())),
    "users": List<dynamic>.from(users!.map((x) => x.toJson())),
  };
}

class UserElement {
  int? id;
  int? userId;
  int? positionId;
  int? depId;
  int? announcementId;
  int? seen;
  DateTime? createdAt;
  UserUser? user;

  UserElement({
    this.id,
    this.userId,
    this.positionId,
    this.depId,
    this.announcementId,
    this.seen,
    this.createdAt,
    this.user,
  });

  factory UserElement.fromJson(Map<String, dynamic> json) => UserElement(
    id: json["id"],
    userId: json["user_id"],
    positionId: json["position_id"],
    depId: json["dep_id"],
    announcementId: json["announcement_id"],
    seen: json["seen"],
    createdAt: DateTime.parse(json["created_at"]),
    user: json["user"] == null ? json["user"] : UserUser.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "position_id": positionId,
    "depId": depId,
    "announcement_id": announcementId,
    "seen": seen,
    "created_at": createdAt?.toIso8601String(),
    "user": user?.toJson(),
  };
}

class UserUser {
  int? id;
  String? firstName;
  String? lastName;
  String? emailId;
  Gender? gender;
  MaritalStatus? maritalStatus;
  // int? country;
  DateTime? dateOfBirth;
  // int? state;
  // int? city;
  String? personalEmail;
  BloodGroup? bloodGroup;
  String? profileImage;
  int? companyId;
  int? jobTitleId;
  int? branchId;
  int? departmentId;
  int? positionId;
  int? userId;
  int? shiftId;
  int? reportingToId;
  int? role;
  String? mobileNumber;
  dynamic inviteRef;
  // int? employeeType;
  int? status;
  int? userImport;
  DateTime? createdAt;
  dynamic deviceToken;
  dynamic fcmToken;

  UserUser({
    this.id,
    this.firstName,
    this.lastName,
    this.emailId,
    this.gender,
    this.maritalStatus,
    // this.country,
    this.dateOfBirth,
    // this.state,
    // this.city,
    this.personalEmail,
    this.bloodGroup,
    this.profileImage,
    this.companyId,
    this.jobTitleId,
    this.branchId,
    this.departmentId,
    this.userId,
    this.positionId,
    this.shiftId,
    this.reportingToId,
    this.role,
    this.mobileNumber,
    this.inviteRef,
    // this.employeeType,
    this.status,
    this.userImport,
    this.createdAt,
    this.deviceToken,
    this.fcmToken,
  });

  factory UserUser.fromJson(Map<String, dynamic> json) => UserUser(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    emailId: json["email_id"],
    gender: genderValues.map[json["gender"]],
    maritalStatus: maritalStatusValues.map[json["marital_status"]],
    // country: json["country"],
    dateOfBirth: DateTime.parse(json["date_of_birth"]),
    // state: json["state"],
    // city: json["city"],
    personalEmail: json["personal_email"],
    bloodGroup: bloodGroupValues.map[json["blood_group"]],
    profileImage: json["profile_image"],
    companyId: json["company_id"],
    jobTitleId: json["job_title_id"],
    branchId: json["branch_id"],
    departmentId: json["department_id"],
    positionId: json["position_id"],
    userId: json["user_id"],
    shiftId: json["shift_id"],
    reportingToId: json["reporting_to_id"],
    role: json["role"],
    mobileNumber: json["mobile_number"],
    inviteRef: json["invite_ref"],
    // employeeType: json["employee_type"],
    status: json["status"],
    userImport: json["import"],
    createdAt: DateTime.parse(json["created_at"]),
    deviceToken: json["device_token"],
    fcmToken: json["fcm_token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "email_id": emailId,
    "gender": genderValues.reverse[gender],
    "marital_status": maritalStatusValues.reverse[maritalStatus],
    // "country": country,
    "date_of_birth": "${dateOfBirth?.year.toString().padLeft(4, '0')}-${dateOfBirth?.month.toString().padLeft(2, '0')}-${dateOfBirth?.day.toString().padLeft(2, '0')}",
    // "state": state,
    // "city": city,
    "personal_email": personalEmail,
    "blood_group": bloodGroupValues.reverse[bloodGroup],
    "profile_image": profileImage,
    "company_id": companyId,
    "position_id": positionId,
    "user_id": userId,
    "job_title_id": jobTitleId,
    "branch_id": branchId,
    "department_id": departmentId,
    "shift_id": shiftId,
    "reporting_to_id": reportingToId,
    "role": role,
    "mobile_number": mobileNumber,
    "invite_ref": inviteRef,
    // "employee_type": employeeType,
    "status": status,
    "import": userImport,
    "created_at": createdAt?.toIso8601String(),
    "device_token": deviceToken,
    "fcm_token": fcmToken,
  };
}

enum BloodGroup {
  A,
  A1,
  B,
  BLOOD_GROUP_O,
  O
}

final bloodGroupValues = EnumValues({
  "A+": BloodGroup.A,
  "A1+": BloodGroup.A1,
  "B+": BloodGroup.B,
  "O-": BloodGroup.BLOOD_GROUP_O,
  "O+": BloodGroup.O
});

enum Gender {
  FEMALE,
  GENDER_MALE,
  MALE
}

final genderValues = EnumValues({
  "Female": Gender.FEMALE,
  "Male": Gender.GENDER_MALE,
  "male": Gender.MALE
});

enum MaritalStatus {
  MARITAL_STATUS_MARRIED,
  MARRIED,
  SINGLE
}

final maritalStatusValues = EnumValues({
  "Married": MaritalStatus.MARITAL_STATUS_MARRIED,
  "married": MaritalStatus.MARRIED,
  "Single": MaritalStatus.SINGLE
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
