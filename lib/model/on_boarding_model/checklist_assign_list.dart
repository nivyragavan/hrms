// To parse this JSON data, do
//
//     final checklistAssignListModel = checklistAssignListModelFromJson(jsonString);

import 'dart:convert';

ChecklistAssignListModel checklistAssignListModelFromJson(String str) => ChecklistAssignListModel.fromJson(json.decode(str));

String checklistAssignListModelToJson(ChecklistAssignListModel data) => json.encode(data.toJson());

class ChecklistAssignListModel {
  String? code;
  String? message;
  Data? data;

  ChecklistAssignListModel({
    this.code,
    this.message,
    this.data,
  });

  factory ChecklistAssignListModel.fromJson(Map<String, dynamic> json) => ChecklistAssignListModel(
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
  int? userId;
  int? templateId;
  int? hrId;
  int? type;
  String? process;
  int? status;
  int? createdBy;
  ProcessData? processData;
  Hr? user;
  Hr? hr;
  Template? template;

  Datum({
    this.id,
    this.userId,
    this.templateId,
    this.hrId,
    this.type,
    this.process,
    this.status,
    this.createdBy,
    this.processData,
    this.user,
    this.hr,
    this.template,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    templateId: json["template_id"],
    hrId: json["hr_id"],
    type: json["type"],
    process: json["process"],
    status: json["status"],
    createdBy: json["created_by"],
    processData: ProcessData.fromJson(json["process_data"]),
    user: json["user"] == null ? json["user"] : Hr.fromJson(json["user"]),
    hr: json["hr"] == null ? json["hr"] : Hr.fromJson(json["hr"]),
    template: json["template"] == null ? json["template"] : Template.fromJson(json["template"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "template_id": templateId,
    "hr_id": hrId,
    "type": type,
    "process": process,
    "status": status,
    "created_by": createdBy,
    "process_data": processData?.toJson(),
    "user": user?.toJson(),
    "hr": hr?.toJson(),
    "template": template?.toJson(),
  };
}

class Hr {
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
  Employe? employeeType;
  int? status;
  int? hrImport;
  DateTime? createdAt;
  dynamic deviceToken;
  dynamic fcmToken;
  String? userUniqueId;
  PersonalInfo? personalInfo;

  Hr({
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
    this.hrImport,
    this.createdAt,
    this.deviceToken,
    this.fcmToken,
    this.userUniqueId,
    this.personalInfo,
  });

  factory Hr.fromJson(Map<String, dynamic> json) => Hr(
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
    hrImport: json["import"],
    createdAt: DateTime.parse(json["created_at"]),
    deviceToken: json["device_token"],
    fcmToken: json["fcm_token"],
    userUniqueId: json["user_unique_id"],
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
    "import": hrImport,
    "created_at": createdAt?.toIso8601String(),
    "device_token": deviceToken,
    "fcm_token": fcmToken,
    "user_unique_id": userUniqueId,
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
    probationStartDate: json["probation_start_date"] == null ? json["probation_start_date"] : DateTime.parse(json["probation_start_date"]),
    probationEndDate: json["probation_end_date"] == null ? json["probation_end_date"] : DateTime.parse(json["probation_end_date"]),
    createdAt: json["created_at"] == null ? json["created_at"] : DateTime.parse(json["created_at"]),
    employementTypeData: json["employement_type_data"] == null ? json["employement_type_data"] : Employe.fromJson(json["employement_type_data"]),
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
    "probation_start_date": "${probationStartDate?.year.toString().padLeft(4, '0')}-${probationStartDate?.month.toString().padLeft(2, '0')}-${probationStartDate?.day.toString().padLeft(2, '0')}",
    "probation_end_date": "${probationEndDate?.year.toString().padLeft(4, '0')}-${probationEndDate?.month.toString().padLeft(2, '0')}-${probationEndDate?.day.toString().padLeft(2, '0')}",
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

class ProcessData {
  double? percent;
  int? currentStep;
  int? totalStep;

  ProcessData({
    this.percent,
    this.currentStep,
    this.totalStep,
  });

  factory ProcessData.fromJson(Map<String, dynamic> json) => ProcessData(
    percent: json["percent"].toDouble(),
    currentStep: json["current_step"],
    totalStep: json["total_step"],
  );

  Map<String, dynamic> toJson() => {
    "percent": percent,
    "current_step": currentStep,
    "total_step": totalStep,
  };
}

class Template {
  int? id;
  String? templateName;
  String? description;
  int? type;
  int? createdBy;
  List<Task>? task;

  Template({
    this.id,
    this.templateName,
    this.description,
    this.type,
    this.createdBy,
    this.task,
  });

  factory Template.fromJson(Map<String, dynamic> json) => Template(
    id: json["id"],
    templateName: json["template_name"],
    description: json["description"],
    type: json["type"],
    createdBy: json["created_by"],
    task: List<Task>.from(json["task"].map((x) => Task.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "template_name": templateName,
    "description": description,
    "type": type,
    "created_by": createdBy,
    "task": List<dynamic>.from(task!.map((x) => x.toJson())),
  };
}

class Task {
  int? id;
  String? taskName;
  String? taskType;
  String? assignRole;
  String? description;
  int? noOfDays;
  String? dueDate;
  int? createdBy;
  int? templateId;
  List<TaskForm>? taskForm;

  Task({
    this.id,
    this.taskName,
    this.taskType,
    this.assignRole,
    this.description,
    this.noOfDays,
    this.dueDate,
    this.createdBy,
    this.templateId,
    this.taskForm,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json["id"],
    taskName: json["task_name"],
    taskType: json["task_type"],
    assignRole: json["assign_role"],
    description: json["description"],
    noOfDays: json["no_of_days"],
    dueDate: json["due_date"],
    createdBy: json["created_by"],
    templateId: json["template_id"],
    taskForm: List<TaskForm>.from(json["task_form"].map((x) => TaskForm.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "task_name": taskName,
    "task_type": taskType,
    "assign_role": assignRole,
    "description": description,
    "no_of_days": noOfDays,
    "due_date": dueDate,
    "created_by": createdBy,
    "template_id": templateId,
    "task_form": List<dynamic>.from(taskForm!.map((x) => x.toJson())),
  };
}

class TaskForm {
  int? id;
  int? taskId;
  String? fieldType;
  String? fieldName;
  String? placeholder;
  String? options;
  int? createdBy;

  TaskForm({
    this.id,
    this.taskId,
    this.fieldType,
    this.fieldName,
    this.placeholder,
    this.options,
    this.createdBy,
  });

  factory TaskForm.fromJson(Map<String, dynamic> json) => TaskForm(
    id: json["id"],
    taskId: json["task_id"],
    fieldType: json["field_type"],
    fieldName: json["field_name"],
    placeholder: json["placeholder"],
    options: json["options"],
    createdBy: json["created_by"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "task_id": taskId,
    "field_type": fieldType,
    "field_name": fieldName,
    "placeholder": placeholder,
    "options": options,
    "created_by": createdBy,
  };
}
