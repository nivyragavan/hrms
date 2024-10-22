// To parse this JSON data, do
//
//     final adminAssetsListModel = adminAssetsListModelFromJson(jsonString);

import 'dart:convert';

AdminAssetsListModel adminAssetsListModelFromJson(String str) =>
    AdminAssetsListModel.fromJson(json.decode(str));

String adminAssetsListModelToJson(AdminAssetsListModel data) =>
    json.encode(data.toJson());

class AdminAssetsListModel {
  final String? code;
  final String? message;
  final Data? data;

  AdminAssetsListModel({
    this.code,
    this.message,
    this.data,
  });

  AdminAssetsListModel.fromJson(Map<String, dynamic> json)
      : code = json['code'] as String?,
        message = json['message'] as String?,
        data = (json['data'] as Map<String,dynamic>?) != null ? Data.fromJson(json['data'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'code' : code,
    'message' : message,
    'data' : data?.toJson()
  };
}

class Data {
  final List<Data1>? data;

  Data({
    this.data,
  });

  Data.fromJson(Map<String, dynamic> json)
      : data = (json['data'] as List?)?.map((dynamic e) => Data1.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'data' : data?.map((e) => e.toJson()).toList()
  };
}

class Data1 {
  final String? id;
  final String? name;
  final String? assetId;
  final String? category;
  final String? brand;
  final String? model;
  final String? warrantyExpiryDate;
  final Status? status;
  final String? serialNumber;
  final String? supplier;
  final String? purchaseDate;
  final String? currency;
  final String? cost;
  final String? notes;
  final String? createdAt;
  final AssetAttachment? attachment;
  final List<Assign>? assign;
  final List<Activity>? activity;

  Data1({
    this.id,
    this.name,
    this.assetId,
    this.category,
    this.brand,
    this.model,
    this.warrantyExpiryDate,
    this.status,
    this.serialNumber,
    this.supplier,
    this.purchaseDate,
    this.currency,
    this.cost,
    this.notes,
    this.createdAt,
    this.attachment,
    this.assign,
    this.activity,
  });

  Data1.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        name = json['name'] as String?,
        assetId = json['asset_id'] as String?,
        category = json['category'] as String?,
        brand = json['brand'] as String?,
        model = json['model'] as String?,
        warrantyExpiryDate = json['warranty_expiry_date'] as String?,
        status = (json['status'] as Map<String,dynamic>?) != null ? Status.fromJson(json['status'] as Map<String,dynamic>) : null,
        serialNumber = json['serial_number'] as String?,
        supplier = json['supplier'] as String?,
        purchaseDate = json['purchase_date'] as String?,
        currency = json['currency'] as String?,
        cost = json['cost'] as String?,
        notes = json['notes'] as String?,
        createdAt = json['created_at'] as String?,
        attachment =
             (json['attachment'] != "" ||
                    json['attachment'] is Map<String, dynamic>)
                ? AssetAttachment.fromJson(
                    json['attachment'] as Map<String, dynamic>)
                : null,
        assign = json['assign'] != null
            ? (json['assign'] as List?)
                ?.map((dynamic e) => Assign.fromJson(e as Map<String, dynamic>))
                .toList()
            : json['assign'],
        activity = (json['activity'] as List?)
            ?.map((dynamic e) => Activity.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'asset_id' : assetId,
    'category' : category,
    'brand' : brand,
    'model' : model,
    'warranty_expiry_date' : warrantyExpiryDate,
    'status' : status?.toJson(),
    'serial_number' : serialNumber,
    'supplier' : supplier,
    'purchase_date' : purchaseDate,
    'currency' : currency,
    'cost' : cost,
    'notes' : notes,
    'created_at' : createdAt,
    'attachment' : attachment,
    'assign' : assign?.map((e) => e.toJson()).toList(),
    'activity' : activity?.map((e) => e.toJson()).toList()
  };
}

class Status {
  final String? id;
  final String? name;
  final String? createdAt;

  Status({
    this.id,
    this.name,
    this.createdAt,
  });

  Status.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        name = json['name'] as String?,
        createdAt = json['created_at'] as String?;

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'created_at': createdAt};
}

class AssetAttachment {
  final String? id;
  final String? assetId;
  final String? fileName;
  final String? createdAt;

  AssetAttachment({
    this.id,
    this.assetId,
    this.fileName,
    this.createdAt,
  });

  AssetAttachment.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        assetId = json['asset_id'] as String?,
        fileName = json['file_name'] as String?,
        createdAt = json['created_at'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'asset_id': assetId,
        'file_name': fileName,
        'created_at': createdAt
      };
}

class Assign {
  final String? id;
  final String? assetId;
  final EmployeeId? employeeId;
  final String? assignDate;
  final String? expectedReturnDate;
  final String? createdAt;
  final CreatedBy? createdBy;

  Assign({
    this.id,
    this.assetId,
    this.employeeId,
    this.assignDate,
    this.expectedReturnDate,
    this.createdAt,
    this.createdBy,
  });

  Assign.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        assetId = json['asset_id'] as String?,
        employeeId = (json['employee_id'] as Map<String,dynamic>?) != null ? EmployeeId.fromJson(json['employee_id'] as Map<String,dynamic>) : null,
        assignDate = json['assign_date'] as String?,
        expectedReturnDate = json['expected_return_date'] as String?,
        createdAt = json['created_at'] as String?,
        createdBy = (json['created_by'] as Map<String,dynamic>?) != null ? CreatedBy.fromJson(json['created_by'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'asset_id' : assetId,
    'employee_id' : employeeId?.toJson(),
    'assign_date' : assignDate,
    'expected_return_date' : expectedReturnDate,
    'created_at' : createdAt,
    'created_by' : createdBy?.toJson()
  };
}

class EmployeeId {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? emailId;
  final String? gender;
  final String? maritalStatus;
  final Country? country;
  final String? dateOfBirth;
  final State? state;
  final City? city;
  final String? personalEmail;
  final String? bloodGroup;
  final String? profileImage;
  final int? companyId;
  final dynamic jobTitleId;
  final int? branchId;
  final int? departmentId;
  final int? shiftId;
  final int? reportingToId;
  final int? role;
  final String? mobileNumber;
  final dynamic inviteRef;
  final EmployeeType? employeeType;
  final int? status;
  final int? import;
  final String? createdAt;
  final String? deviceToken;
  final dynamic fcmToken;
  final String? userUniqueId;
  final Department? department;
  final JobPosition? jobPosition;

  EmployeeId({
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
    this.import,
    this.createdAt,
    this.deviceToken,
    this.fcmToken,
    this.userUniqueId,
    this.department,
    this.jobPosition,
  });

  EmployeeId.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        firstName = json['first_name'] as String?,
        lastName = json['last_name'] as String?,
        emailId = json['email_id'] as String?,
        gender = json['gender'] as String?,
        maritalStatus = json['marital_status'] as String?,
        country = (json['country'] as Map<String,dynamic>?) != null ? Country.fromJson(json['country'] as Map<String,dynamic>) : null,
        dateOfBirth = json['date_of_birth'] as String?,
        state = (json['state'] as Map<String,dynamic>?) != null ? State.fromJson(json['state'] as Map<String,dynamic>) : null,
        city = (json['city'] as Map<String,dynamic>?) != null ? City.fromJson(json['city'] as Map<String,dynamic>) : null,
        personalEmail = json['personal_email'] as String?,
        bloodGroup = json['blood_group'] as String?,
        profileImage = json['profile_image'] as String?,
        companyId = json['company_id'] as int?,
        jobTitleId = json['job_title_id'],
        branchId = json['branch_id'] as int?,
        departmentId = json['department_id'] as int?,
        shiftId = json['shift_id'] as int?,
        reportingToId = json['reporting_to_id'] as int?,
        role = json['role'] as int?,
        mobileNumber = json['mobile_number'] as String?,
        inviteRef = json['invite_ref'],
        employeeType = (json['employee_type'] as Map<String,dynamic>?) != null ? EmployeeType.fromJson(json['employee_type'] as Map<String,dynamic>) : null,
        status = json['status'] as int?,
        import = json['import'] as int?,
        createdAt = json['created_at'] as String?,
        deviceToken = json['device_token'] as String?,
        fcmToken = json['fcm_token'],
        userUniqueId = json['user_unique_id'] as String?,
        department = (json['department'] as Map<String,dynamic>?) != null ? Department.fromJson(json['department'] as Map<String,dynamic>) : null,
        jobPosition = (json['job_position'] as Map<String,dynamic>?) != null ? JobPosition.fromJson(json['job_position'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'first_name' : firstName,
    'last_name' : lastName,
    'email_id' : emailId,
    'gender' : gender,
    'marital_status' : maritalStatus,
    'country' : country?.toJson(),
    'date_of_birth' : dateOfBirth,
    'state' : state?.toJson(),
    'city' : city?.toJson(),
    'personal_email' : personalEmail,
    'blood_group' : bloodGroup,
    'profile_image' : profileImage,
    'company_id' : companyId,
    'job_title_id' : jobTitleId,
    'branch_id' : branchId,
    'department_id' : departmentId,
    'shift_id' : shiftId,
    'reporting_to_id' : reportingToId,
    'role' : role,
    'mobile_number' : mobileNumber,
    'invite_ref' : inviteRef,
    'employee_type' : employeeType?.toJson(),
    'status' : status,
    'import' : import,
    'created_at' : createdAt,
    'device_token' : deviceToken,
    'fcm_token' : fcmToken,
    'user_unique_id' : userUniqueId,
    'department' : department?.toJson(),
    'job_position' : jobPosition?.toJson()
  };
}

class Country {
  final int? id;
  final String? name;
  final String? iso3;
  final String? iso2;
  final String? phoneCode;
  final String? capital;
  final String? currency;
  final String? native;
  final String? emoji;
  final String? emojiU;
  final String? createdAt;

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

  Country.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        iso3 = json['iso3'] as String?,
        iso2 = json['iso2'] as String?,
        phoneCode = json['phone_code'] as String?,
        capital = json['capital'] as String?,
        currency = json['currency'] as String?,
        native = json['native'] as String?,
        emoji = json['emoji'] as String?,
        emojiU = json['emojiU'] as String?,
        createdAt = json['created_at'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'iso3' : iso3,
    'iso2' : iso2,
    'phone_code' : phoneCode,
    'capital' : capital,
    'currency' : currency,
    'native' : native,
    'emoji' : emoji,
    'emojiU' : emojiU,
    'created_at' : createdAt
  };
}

class State {
  final int? id;
  final String? name;
  final int? countryId;
  final String? countryCode;
  final String? stateCode;

  State({
    this.id,
    this.name,
    this.countryId,
    this.countryCode,
    this.stateCode,
  });

  State.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        countryId = json['country_id'] as int?,
        countryCode = json['country_code'] as String?,
        stateCode = json['state_code'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'country_id' : countryId,
    'country_code' : countryCode,
    'state_code' : stateCode
  };
}

class City {
  final int? id;
  final String? name;
  final int? stateId;
  final String? stateCode;
  final int? countryId;
  final String? countryCode;
  final String? latitude;
  final String? longitude;

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

  City.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        stateId = json['state_id'] as int?,
        stateCode = json['state_code'] as String?,
        countryId = json['country_id'] as int?,
        countryCode = json['country_code'] as String?,
        latitude = json['latitude'] as String?,
        longitude = json['longitude'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'state_id' : stateId,
    'state_code' : stateCode,
    'country_id' : countryId,
    'country_code' : countryCode,
    'latitude' : latitude,
    'longitude' : longitude
  };
}

class EmployeeType {
  final String? id;
  final String? type;

  EmployeeType({
    this.id,
    this.type,
  });

  EmployeeType.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        type = json['type'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'type' : type
  };
}

class Department {
  final int? id;
  final String? departmentName;
  final String? description;
  final String? departmentIcon;
  final int? status;
  final String? createdAt;

  Department({
    this.id,
    this.departmentName,
    this.description,
    this.departmentIcon,
    this.status,
    this.createdAt,
  });

  Department.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        departmentName = json['department_name'] as String?,
        description = json['description'] as String?,
        departmentIcon = json['department_icon'] as String?,
        status = json['status'] as int?,
        createdAt = json['created_at'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'department_name' : departmentName,
    'description' : description,
    'department_icon' : departmentIcon,
    'status' : status,
    'created_at' : createdAt
  };
}

class JobPosition {
  final int? id;
  final int? userId;
  final int? positionId;
  final String? createdAt;
  final Company? company;
  final String? lineManager;
  final Position? position;

  JobPosition({
    this.id,
    this.userId,
    this.positionId,
    this.createdAt,
    this.company,
    this.lineManager,
    this.position,
  });

  JobPosition.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        userId = json['user_id'] as int?,
        positionId = json['position_id'] as int?,
        createdAt = json['created_at'] as String?,
        company = (json['company'] as Map<String,dynamic>?) != null ? Company.fromJson(json['company'] as Map<String,dynamic>) : null,
        lineManager = json['line_manager'] as String?,
        position = (json['position'] as Map<String,dynamic>?) != null ? Position.fromJson(json['position'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'user_id' : userId,
    'position_id' : positionId,
    'created_at' : createdAt,
    'company' : company?.toJson(),
    'line_manager' : lineManager,
    'position' : position?.toJson()
  };
}

class Company {
  final int? id;
  final String? domain;
  final String? tenantId;
  final String? firstName;
  final String? lastName;
  final String? email;
  final dynamic jobTitle;
  final dynamic phoneNumber;
  final dynamic address;
  final dynamic employeeCount;
  final int? countryId;
  final dynamic createdAt;
  final dynamic updatedAt;
  final dynamic deletedAt;
  final dynamic createdBy;
  final dynamic updatedBy;
  final dynamic deletedBy;

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

  Company.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        domain = json['domain'] as String?,
        tenantId = json['tenant_id'] as String?,
        firstName = json['first_name'] as String?,
        lastName = json['last_name'] as String?,
        email = json['email'] as String?,
        jobTitle = json['job_title'],
        phoneNumber = json['phone_number'],
        address = json['address'],
        employeeCount = json['employee_count'],
        countryId = json['country_id'] as int?,
        createdAt = json['created_at'],
        updatedAt = json['updated_at'],
        deletedAt = json['deleted_at'],
        createdBy = json['created_by'],
        updatedBy = json['updated_by'],
        deletedBy = json['deleted_by'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'domain' : domain,
    'tenant_id' : tenantId,
    'first_name' : firstName,
    'last_name' : lastName,
    'email' : email,
    'job_title' : jobTitle,
    'phone_number' : phoneNumber,
    'address' : address,
    'employee_count' : employeeCount,
    'country_id' : countryId,
    'created_at' : createdAt,
    'updated_at' : updatedAt,
    'deleted_at' : deletedAt,
    'created_by' : createdBy,
    'updated_by' : updatedBy,
    'deleted_by' : deletedBy
  };
}

class Position {
  final int? id;
  final int? departmentId;
  final String? positionName;
  final Grade? grade;
  final String? createdAt;

  Position({
    this.id,
    this.departmentId,
    this.positionName,
    this.grade,
    this.createdAt,
  });

  Position.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        departmentId = json['department_id'] as int?,
        positionName = json['position_name'] as String?,
        grade = (json['grade'] as Map<String,dynamic>?) != null ? Grade.fromJson(json['grade'] as Map<String,dynamic>) : null,
        createdAt = json['created_at'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'department_id' : departmentId,
    'position_name' : positionName,
    'grade' : grade?.toJson(),
    'created_at' : createdAt
  };
}

class Grade {
  final int? id;
  final String? gradeName;

  Grade({
    this.id,
    this.gradeName,
  });

  Grade.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        gradeName = json['grade_name'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'grade_name' : gradeName
  };
}

class CreatedBy {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? emailId;
  final String? gender;
  final String? maritalStatus;
  final Country? country;
  final String? dateOfBirth;
  final State? state;
  final City? city;
  final String? personalEmail;
  final String? bloodGroup;
  final String? profileImage;
  final int? companyId;
  final int? jobTitleId;
  final int? branchId;
  final int? departmentId;
  final int? shiftId;
  final dynamic reportingToId;
  final int? role;
  final String? mobileNumber;
  final dynamic inviteRef;
  final EmployeeType? employeeType;
  final int? status;
  final int? import;
  final String? createdAt;
  final dynamic deviceToken;
  final dynamic fcmToken;
  final String? userUniqueId;
  final Department? department;
  final JobPosition? jobPosition;

  CreatedBy({
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
    this.import,
    this.createdAt,
    this.deviceToken,
    this.fcmToken,
    this.userUniqueId,
    this.department,
    this.jobPosition,
  });

  CreatedBy.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        firstName = json['first_name'] as String?,
        lastName = json['last_name'] as String?,
        emailId = json['email_id'] as String?,
        gender = json['gender'] as String?,
        maritalStatus = json['marital_status'] as String?,
        country = (json['country'] as Map<String,dynamic>?) != null ? Country.fromJson(json['country'] as Map<String,dynamic>) : null,
        dateOfBirth = json['date_of_birth'] as String?,
        state = (json['state'] as Map<String,dynamic>?) != null ? State.fromJson(json['state'] as Map<String,dynamic>) : null,
        city = (json['city'] as Map<String,dynamic>?) != null ? City.fromJson(json['city'] as Map<String,dynamic>) : null,
        personalEmail = json['personal_email'] as String?,
        bloodGroup = json['blood_group'] as String?,
        profileImage = json['profile_image'] as String?,
        companyId = json['company_id'] as int?,
        jobTitleId = json['job_title_id'] as int?,
        branchId = json['branch_id'] as int?,
        departmentId = json['department_id'] as int?,
        shiftId = json['shift_id'] as int?,
        reportingToId = json['reporting_to_id'],
        role = json['role'] as int?,
        mobileNumber = json['mobile_number'] as String?,
        inviteRef = json['invite_ref'],
        employeeType = (json['employee_type'] as Map<String,dynamic>?) != null ? EmployeeType.fromJson(json['employee_type'] as Map<String,dynamic>) : null,
        status = json['status'] as int?,
        import = json['import'] as int?,
        createdAt = json['created_at'] as String?,
        deviceToken = json['device_token'],
        fcmToken = json['fcm_token'],
        userUniqueId = json['user_unique_id'] as String?,
        department = (json['department'] as Map<String,dynamic>?) != null ? Department.fromJson(json['department'] as Map<String,dynamic>) : null,
        jobPosition = (json['job_position'] as Map<String,dynamic>?) != null ? JobPosition.fromJson(json['job_position'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'first_name' : firstName,
    'last_name' : lastName,
    'email_id' : emailId,
    'gender' : gender,
    'marital_status' : maritalStatus,
    'country' : country?.toJson(),
    'date_of_birth' : dateOfBirth,
    'state' : state?.toJson(),
    'city' : city?.toJson(),
    'personal_email' : personalEmail,
    'blood_group' : bloodGroup,
    'profile_image' : profileImage,
    'company_id' : companyId,
    'job_title_id' : jobTitleId,
    'branch_id' : branchId,
    'department_id' : departmentId,
    'shift_id' : shiftId,
    'reporting_to_id' : reportingToId,
    'role' : role,
    'mobile_number' : mobileNumber,
    'invite_ref' : inviteRef,
    'employee_type' : employeeType?.toJson(),
    'status' : status,
    'import' : import,
    'created_at' : createdAt,
    'device_token' : deviceToken,
    'fcm_token' : fcmToken,
    'user_unique_id' : userUniqueId,
    'department' : department?.toJson(),
    'job_position' : jobPosition?.toJson()
  };
}

// class Country {
//   final int? id;
//   final String? name;
//   final String? iso3;
//   final String? iso2;
//   final String? phoneCode;
//   final String? capital;
//   final String? currency;
//   final String? native;
//   final String? emoji;
//   final String? emojiU;
//   final String? createdAt;
//
//   Country({
//     this.id,
//     this.name,
//     this.iso3,
//     this.iso2,
//     this.phoneCode,
//     this.capital,
//     this.currency,
//     this.native,
//     this.emoji,
//     this.emojiU,
//     this.createdAt,
//   });
//
//   Country.fromJson(Map<String, dynamic> json)
//       : id = json['id'] as int?,
//         name = json['name'] as String?,
//         iso3 = json['iso3'] as String?,
//         iso2 = json['iso2'] as String?,
//         phoneCode = json['phone_code'] as String?,
//         capital = json['capital'] as String?,
//         currency = json['currency'] as String?,
//         native = json['native'] as String?,
//         emoji = json['emoji'] as String?,
//         emojiU = json['emojiU'] as String?,
//         createdAt = json['created_at'] as String?;
//
//   Map<String, dynamic> toJson() => {
//     'id' : id,
//     'name' : name,
//     'iso3' : iso3,
//     'iso2' : iso2,
//     'phone_code' : phoneCode,
//     'capital' : capital,
//     'currency' : currency,
//     'native' : native,
//     'emoji' : emoji,
//     'emojiU' : emojiU,
//     'created_at' : createdAt
//   };
// }
//
// class State {
//   final int? id;
//   final String? name;
//   final int? countryId;
//   final String? countryCode;
//   final String? stateCode;
//
//   State({
//     this.id,
//     this.name,
//     this.countryId,
//     this.countryCode,
//     this.stateCode,
//   });
//
//   State.fromJson(Map<String, dynamic> json)
//       : id = json['id'] as int?,
//         name = json['name'] as String?,
//         countryId = json['country_id'] as int?,
//         countryCode = json['country_code'] as String?,
//         stateCode = json['state_code'] as String?;
//
//   Map<String, dynamic> toJson() => {
//     'id' : id,
//     'name' : name,
//     'country_id' : countryId,
//     'country_code' : countryCode,
//     'state_code' : stateCode
//   };
// }
//
// class City {
//   final int? id;
//   final String? name;
//   final int? stateId;
//   final String? stateCode;
//   final int? countryId;
//   final String? countryCode;
//   final String? latitude;
//   final String? longitude;
//
//   City({
//     this.id,
//     this.name,
//     this.stateId,
//     this.stateCode,
//     this.countryId,
//     this.countryCode,
//     this.latitude,
//     this.longitude,
//   });
//
//   City.fromJson(Map<String, dynamic> json)
//       : id = json['id'] as int?,
//         name = json['name'] as String?,
//         stateId = json['state_id'] as int?,
//         stateCode = json['state_code'] as String?,
//         countryId = json['country_id'] as int?,
//         countryCode = json['country_code'] as String?,
//         latitude = json['latitude'] as String?,
//         longitude = json['longitude'] as String?;
//
//   Map<String, dynamic> toJson() => {
//     'id' : id,
//     'name' : name,
//     'state_id' : stateId,
//     'state_code' : stateCode,
//     'country_id' : countryId,
//     'country_code' : countryCode,
//     'latitude' : latitude,
//     'longitude' : longitude
//   };
// }
//
// class EmployeeType {
//   final String? id;
//   final String? type;
//
//   EmployeeType({
//     this.id,
//     this.type,
//   });
//
//   EmployeeType.fromJson(Map<String, dynamic> json)
//       : id = json['id'] as String?,
//         type = json['type'] as String?;
//
//   Map<String, dynamic> toJson() => {
//     'id' : id,
//     'type' : type
//   };
// }
//
// class Department {
//   final int? id;
//   final String? departmentName;
//   final String? description;
//   final String? departmentIcon;
//   final int? status;
//   final String? createdAt;
//
//   Department({
//     this.id,
//     this.departmentName,
//     this.description,
//     this.departmentIcon,
//     this.status,
//     this.createdAt,
//   });
//
//   Department.fromJson(Map<String, dynamic> json)
//       : id = json['id'] as int?,
//         departmentName = json['department_name'] as String?,
//         description = json['description'] as String?,
//         departmentIcon = json['department_icon'] as String?,
//         status = json['status'] as int?,
//         createdAt = json['created_at'] as String?;
//
//   Map<String, dynamic> toJson() => {
//     'id' : id,
//     'department_name' : departmentName,
//     'description' : description,
//     'department_icon' : departmentIcon,
//     'status' : status,
//     'created_at' : createdAt
//   };
// }
//
// class JobPosition {
//   final int? id;
//   final int? userId;
//   final int? positionId;
//   final String? createdAt;
//   final Company? company;
//   final String? lineManager;
//   final Position? position;
//
//   JobPosition({
//     this.id,
//     this.userId,
//     this.positionId,
//     this.createdAt,
//     this.company,
//     this.lineManager,
//     this.position,
//   });
//
//   JobPosition.fromJson(Map<String, dynamic> json)
//       : id = json['id'] as int?,
//         userId = json['user_id'] as int?,
//         positionId = json['position_id'] as int?,
//         createdAt = json['created_at'] as String?,
//         company = (json['company'] as Map<String,dynamic>?) != null ? Company.fromJson(json['company'] as Map<String,dynamic>) : null,
//         lineManager = json['line_manager'] as String?,
//         position = (json['position'] as Map<String,dynamic>?) != null ? Position.fromJson(json['position'] as Map<String,dynamic>) : null;
//
//   Map<String, dynamic> toJson() => {
//     'id' : id,
//     'user_id' : userId,
//     'position_id' : positionId,
//     'created_at' : createdAt,
//     'company' : company?.toJson(),
//     'line_manager' : lineManager,
//     'position' : position?.toJson()
//   };
// }
//
// class Company {
//   final int? id;
//   final String? domain;
//   final String? tenantId;
//   final String? firstName;
//   final String? lastName;
//   final String? email;
//   final dynamic jobTitle;
//   final dynamic phoneNumber;
//   final dynamic address;
//   final dynamic employeeCount;
//   final int? countryId;
//   final dynamic createdAt;
//   final dynamic updatedAt;
//   final dynamic deletedAt;
//   final dynamic createdBy;
//   final dynamic updatedBy;
//   final dynamic deletedBy;
//
//   Company({
//     this.id,
//     this.domain,
//     this.tenantId,
//     this.firstName,
//     this.lastName,
//     this.email,
//     this.jobTitle,
//     this.phoneNumber,
//     this.address,
//     this.employeeCount,
//     this.countryId,
//     this.createdAt,
//     this.updatedAt,
//     this.deletedAt,
//     this.createdBy,
//     this.updatedBy,
//     this.deletedBy,
//   });
//
//   Company.fromJson(Map<String, dynamic> json)
//       : id = json['id'] as int?,
//         domain = json['domain'] as String?,
//         tenantId = json['tenant_id'] as String?,
//         firstName = json['first_name'] as String?,
//         lastName = json['last_name'] as String?,
//         email = json['email'] as String?,
//         jobTitle = json['job_title'],
//         phoneNumber = json['phone_number'],
//         address = json['address'],
//         employeeCount = json['employee_count'],
//         countryId = json['country_id'] as int?,
//         createdAt = json['created_at'],
//         updatedAt = json['updated_at'],
//         deletedAt = json['deleted_at'],
//         createdBy = json['created_by'],
//         updatedBy = json['updated_by'],
//         deletedBy = json['deleted_by'];
//
//   Map<String, dynamic> toJson() => {
//     'id' : id,
//     'domain' : domain,
//     'tenant_id' : tenantId,
//     'first_name' : firstName,
//     'last_name' : lastName,
//     'email' : email,
//     'job_title' : jobTitle,
//     'phone_number' : phoneNumber,
//     'address' : address,
//     'employee_count' : employeeCount,
//     'country_id' : countryId,
//     'created_at' : createdAt,
//     'updated_at' : updatedAt,
//     'deleted_at' : deletedAt,
//     'created_by' : createdBy,
//     'updated_by' : updatedBy,
//     'deleted_by' : deletedBy
//   };
// }
//
// class Position {
//   final int? id;
//   final int? departmentId;
//   final String? positionName;
//   final Grade? grade;
//   final String? createdAt;
//
//   Position({
//     this.id,
//     this.departmentId,
//     this.positionName,
//     this.grade,
//     this.createdAt,
//   });
//
//   Position.fromJson(Map<String, dynamic> json)
//       : id = json['id'] as int?,
//         departmentId = json['department_id'] as int?,
//         positionName = json['position_name'] as String?,
//         grade = (json['grade'] as Map<String,dynamic>?) != null ? Grade.fromJson(json['grade'] as Map<String,dynamic>) : null,
//         createdAt = json['created_at'] as String?;
//
//   Map<String, dynamic> toJson() => {
//     'id' : id,
//     'department_id' : departmentId,
//     'position_name' : positionName,
//     'grade' : grade?.toJson(),
//     'created_at' : createdAt
//   };
// }
//
// class Grade {
//   final int? id;
//   final String? gradeName;
//
//   Grade({
//     this.id,
//     this.gradeName,
//   });
//
//   Grade.fromJson(Map<String, dynamic> json)
//       : id = json['id'] as int?,
//         gradeName = json['grade_name'] as String?;
//
//   Map<String, dynamic> toJson() => {
//     'id' : id,
//     'grade_name' : gradeName
//   };
// }

class Activity {
  final int? id;
  final String? logName;
  final String? description;
  final String? subjectType;
  final String? event;
  final int? subjectId;
  final String? causerType;
 // final CauserId? causerId;
  final Properties? properties;
  final dynamic batchUuid;
  final String? createdAt;
  final String? updatedAt;

  Activity({
    this.id,
    this.logName,
    this.description,
    this.subjectType,
    this.event,
    this.subjectId,
    this.causerType,
   // this.causerId,
    this.properties,
    this.batchUuid,
    this.createdAt,
    this.updatedAt,
  });

  Activity.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        logName = json['log_name'] as String?,
        description = json['description'] as String?,
        subjectType = json['subject_type'] as String?,
        event = json['event'] as String?,
        subjectId = json['subject_id'] as int?,
        causerType = json['causer_type'] as String?,
      //  causerId = (json['causer_id'] as Map<String,dynamic>?) != null ? CauserId.fromJson(json['causer_id'] as Map<String,dynamic>) : null,
        properties = (json['properties'] as Map<String,dynamic>?) != null ? Properties.fromJson(json['properties'] as Map<String,dynamic>) : null,
        batchUuid = json['batch_uuid'],
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'log_name' : logName,
    'description' : description,
    'subject_type' : subjectType,
    'event' : event,
    'subject_id' : subjectId,
    'causer_type' : causerType,
   // 'causer_id' : causerId?.toJson(),
    'properties' : properties?.toJson(),
    'batch_uuid' : batchUuid,
    'created_at' : createdAt,
    'updated_at' : updatedAt
  };
}

class CauserId {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? emailId;
  final String? gender;
  final String? maritalStatus;
  final Country? country;
  final String? dateOfBirth;
  final State? state;
  final City? city;
  final String? personalEmail;
  final String? bloodGroup;
  final String? profileImage;
  final int? companyId;
  final int? jobTitleId;
  final int? branchId;
  final int? departmentId;
  final int? shiftId;
  final dynamic reportingToId;
  final int? role;
  final String? mobileNumber;
  final dynamic inviteRef;
  final EmployeeType? employeeType;
  final int? status;
  final int? import;
  final String? createdAt;
  final dynamic deviceToken;
  final dynamic fcmToken;
  final String? userUniqueId;

  CauserId({
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
    this.import,
    this.createdAt,
    this.deviceToken,
    this.fcmToken,
    this.userUniqueId,
  });

  CauserId.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        firstName = json['first_name'] as String?,
        lastName = json['last_name'] as String?,
        emailId = json['email_id'] as String?,
        gender = json['gender'] as String?,
        maritalStatus = json['marital_status'] as String?,
        country = (json['country'] as Map<String,dynamic>?) != null ? Country.fromJson(json['country'] as Map<String,dynamic>) : null,
        dateOfBirth = json['date_of_birth'] as String?,
        state = (json['state'] as Map<String,dynamic>?) != null ? State.fromJson(json['state'] as Map<String,dynamic>) : null,
        city = (json['city'] as Map<String,dynamic>?) != null ? City.fromJson(json['city'] as Map<String,dynamic>) : null,
        personalEmail = json['personal_email'] as String?,
        bloodGroup = json['blood_group'] as String?,
        profileImage = json['profile_image'] as String?,
        companyId = json['company_id'] as int?,
        jobTitleId = json['job_title_id'] as int?,
        branchId = json['branch_id'] as int?,
        departmentId = json['department_id'] as int?,
        shiftId = json['shift_id'] as int?,
        reportingToId = json['reporting_to_id'],
        role = json['role'] as int?,
        mobileNumber = json['mobile_number'] as String?,
        inviteRef = json['invite_ref'],
        employeeType = (json['employee_type'] as Map<String,dynamic>?) != null ? EmployeeType.fromJson(json['employee_type'] as Map<String,dynamic>) : null,
        status = json['status'] as int?,
        import = json['import'] as int?,
        createdAt = json['created_at'] as String?,
        deviceToken = json['device_token'],
        fcmToken = json['fcm_token'],
        userUniqueId = json['user_unique_id'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'first_name' : firstName,
    'last_name' : lastName,
    'email_id' : emailId,
    'gender' : gender,
    'marital_status' : maritalStatus,
    'country' : country?.toJson(),
    'date_of_birth' : dateOfBirth,
    'state' : state?.toJson(),
    'city' : city?.toJson(),
    'personal_email' : personalEmail,
    'blood_group' : bloodGroup,
    'profile_image' : profileImage,
    'company_id' : companyId,
    'job_title_id' : jobTitleId,
    'branch_id' : branchId,
    'department_id' : departmentId,
    'shift_id' : shiftId,
    'reporting_to_id' : reportingToId,
    'role' : role,
    'mobile_number' : mobileNumber,
    'invite_ref' : inviteRef,
    'employee_type' : employeeType?.toJson(),
    'status' : status,
    'import' : import,
    'created_at' : createdAt,
    'device_token' : deviceToken,
    'fcm_token' : fcmToken,
    'user_unique_id' : userUniqueId
  };
}

// class Country {
//   final int? id;
//   final String? name;
//   final String? iso3;
//   final String? iso2;
//   final String? phoneCode;
//   final String? capital;
//   final String? currency;
//   final String? native;
//   final String? emoji;
//   final String? emojiU;
//   final String? createdAt;
//
//   Country({
//     this.id,
//     this.name,
//     this.iso3,
//     this.iso2,
//     this.phoneCode,
//     this.capital,
//     this.currency,
//     this.native,
//     this.emoji,
//     this.emojiU,
//     this.createdAt,
//   });
//
//   Country.fromJson(Map<String, dynamic> json)
//       : id = json['id'] as int?,
//         name = json['name'] as String?,
//         iso3 = json['iso3'] as String?,
//         iso2 = json['iso2'] as String?,
//         phoneCode = json['phone_code'] as String?,
//         capital = json['capital'] as String?,
//         currency = json['currency'] as String?,
//         native = json['native'] as String?,
//         emoji = json['emoji'] as String?,
//         emojiU = json['emojiU'] as String?,
//         createdAt = json['created_at'] as String?;
//
//   Map<String, dynamic> toJson() => {
//     'id' : id,
//     'name' : name,
//     'iso3' : iso3,
//     'iso2' : iso2,
//     'phone_code' : phoneCode,
//     'capital' : capital,
//     'currency' : currency,
//     'native' : native,
//     'emoji' : emoji,
//     'emojiU' : emojiU,
//     'created_at' : createdAt
//   };
// }
//
// class State {
//   final int? id;
//   final String? name;
//   final int? countryId;
//   final String? countryCode;
//   final String? stateCode;
//
//   State({
//     this.id,
//     this.name,
//     this.countryId,
//     this.countryCode,
//     this.stateCode,
//   });
//
//   State.fromJson(Map<String, dynamic> json)
//       : id = json['id'] as int?,
//         name = json['name'] as String?,
//         countryId = json['country_id'] as int?,
//         countryCode = json['country_code'] as String?,
//         stateCode = json['state_code'] as String?;
//
//   Map<String, dynamic> toJson() => {
//     'id' : id,
//     'name' : name,
//     'country_id' : countryId,
//     'country_code' : countryCode,
//     'state_code' : stateCode
//   };
// }
//
// class City {
//   final int? id;
//   final String? name;
//   final int? stateId;
//   final String? stateCode;
//   final int? countryId;
//   final String? countryCode;
//   final String? latitude;
//   final String? longitude;
//
//   City({
//     this.id,
//     this.name,
//     this.stateId,
//     this.stateCode,
//     this.countryId,
//     this.countryCode,
//     this.latitude,
//     this.longitude,
//   });
//
//   City.fromJson(Map<String, dynamic> json)
//       : id = json['id'] as int?,
//         name = json['name'] as String?,
//         stateId = json['state_id'] as int?,
//         stateCode = json['state_code'] as String?,
//         countryId = json['country_id'] as int?,
//         countryCode = json['country_code'] as String?,
//         latitude = json['latitude'] as String?,
//         longitude = json['longitude'] as String?;
//
//   Map<String, dynamic> toJson() => {
//     'id' : id,
//     'name' : name,
//     'state_id' : stateId,
//     'state_code' : stateCode,
//     'country_id' : countryId,
//     'country_code' : countryCode,
//     'latitude' : latitude,
//     'longitude' : longitude
//   };
// }
//
// class EmployeeType {
//   final String? id;
//   final String? type;
//
//   EmployeeType({
//     this.id,
//     this.type,
//   });
//
//   EmployeeType.fromJson(Map<String, dynamic> json)
//       : id = json['id'] as String?,
//         type = json['type'] as String?;
//
//   Map<String, dynamic> toJson() => {
//     'id' : id,
//     'type' : type
//   };
// }

class Properties {
  final int? id;
  final String? assetId;
  final String? createdAt;
  final String? createdBy;
  final String? assignDate;
  final EmployeeId? employeeId;
  final String? expectedReturnDate;

  Properties({
    this.id,
    this.assetId,
    this.createdAt,
    this.createdBy,
    this.assignDate,
    this.employeeId,
    this.expectedReturnDate,
  });

  Properties.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        assetId = json['asset_id'] as String?,
        createdAt = json['created_at'] as String?,
        createdBy = json['created_by'] as String?,
        assignDate = json['assign_date'] as String?,
        employeeId = (json['employee_id'] as Map<String,dynamic>?) != null ? EmployeeId.fromJson(json['employee_id'] as Map<String,dynamic>) : null,
        expectedReturnDate = json['expected_return_date'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'asset_id' : assetId,
    'created_at' : createdAt,
    'created_by' : createdBy,
    'assign_date' : assignDate,
    'employee_id' : employeeId?.toJson(),
    'expected_return_date' : expectedReturnDate
  };
}

// class EmployeeId {
//   final int? id;
//   final String? firstName;
//   final String? lastName;
//   final String? emailId;
//   final String? gender;
//   final String? maritalStatus;
//   final Country? country;
//   final String? dateOfBirth;
//   final State? state;
//   final City? city;
//   final String? personalEmail;
//   final String? bloodGroup;
//   final String? profileImage;
//   final int? companyId;
//   final dynamic jobTitleId;
//   final int? branchId;
//   final int? departmentId;
//   final int? shiftId;
//   final int? reportingToId;
//   final int? role;
//   final String? mobileNumber;
//   final dynamic inviteRef;
//   final EmployeeType? employeeType;
//   final int? status;
//   final int? import;
//   final String? createdAt;
//   final dynamic deviceToken;
//   final dynamic fcmToken;
//   final String? userUniqueId;
//
//   EmployeeId({
//     this.id,
//     this.firstName,
//     this.lastName,
//     this.emailId,
//     this.gender,
//     this.maritalStatus,
//     this.country,
//     this.dateOfBirth,
//     this.state,
//     this.city,
//     this.personalEmail,
//     this.bloodGroup,
//     this.profileImage,
//     this.companyId,
//     this.jobTitleId,
//     this.branchId,
//     this.departmentId,
//     this.shiftId,
//     this.reportingToId,
//     this.role,
//     this.mobileNumber,
//     this.inviteRef,
//     this.employeeType,
//     this.status,
//     this.import,
//     this.createdAt,
//     this.deviceToken,
//     this.fcmToken,
//     this.userUniqueId,
//   });
//
//   EmployeeId.fromJson(Map<String, dynamic> json)
//       : id = json['id'] as int?,
//         firstName = json['first_name'] as String?,
//         lastName = json['last_name'] as String?,
//         emailId = json['email_id'] as String?,
//         gender = json['gender'] as String?,
//         maritalStatus = json['marital_status'] as String?,
//         country = (json['country'] as Map<String,dynamic>?) != null ? Country.fromJson(json['country'] as Map<String,dynamic>) : null,
//         dateOfBirth = json['date_of_birth'] as String?,
//         state = (json['state'] as Map<String,dynamic>?) != null ? State.fromJson(json['state'] as Map<String,dynamic>) : null,
//         city = (json['city'] as Map<String,dynamic>?) != null ? City.fromJson(json['city'] as Map<String,dynamic>) : null,
//         personalEmail = json['personal_email'] as String?,
//         bloodGroup = json['blood_group'] as String?,
//         profileImage = json['profile_image'] as String?,
//         companyId = json['company_id'] as int?,
//         jobTitleId = json['job_title_id'],
//         branchId = json['branch_id'] as int?,
//         departmentId = json['department_id'] as int?,
//         shiftId = json['shift_id'] as int?,
//         reportingToId = json['reporting_to_id'] as int?,
//         role = json['role'] as int?,
//         mobileNumber = json['mobile_number'] as String?,
//         inviteRef = json['invite_ref'],
//         employeeType = (json['employee_type'] as Map<String,dynamic>?) != null ? EmployeeType.fromJson(json['employee_type'] as Map<String,dynamic>) : null,
//         status = json['status'] as int?,
//         import = json['import'] as int?,
//         createdAt = json['created_at'] as String?,
//         deviceToken = json['device_token'],
//         fcmToken = json['fcm_token'],
//         userUniqueId = json['user_unique_id'] as String?;
//
//   Map<String, dynamic> toJson() => {
//     'id' : id,
//     'first_name' : firstName,
//     'last_name' : lastName,
//     'email_id' : emailId,
//     'gender' : gender,
//     'marital_status' : maritalStatus,
//     'country' : country?.toJson(),
//     'date_of_birth' : dateOfBirth,
//     'state' : state?.toJson(),
//     'city' : city?.toJson(),
//     'personal_email' : personalEmail,
//     'blood_group' : bloodGroup,
//     'profile_image' : profileImage,
//     'company_id' : companyId,
//     'job_title_id' : jobTitleId,
//     'branch_id' : branchId,
//     'department_id' : departmentId,
//     'shift_id' : shiftId,
//     'reporting_to_id' : reportingToId,
//     'role' : role,
//     'mobile_number' : mobileNumber,
//     'invite_ref' : inviteRef,
//     'employee_type' : employeeType?.toJson(),
//     'status' : status,
//     'import' : import,
//     'created_at' : createdAt,
//     'device_token' : deviceToken,
//     'fcm_token' : fcmToken,
//     'user_unique_id' : userUniqueId
//   };
// }
//
// class Country {
//   final int? id;
//   final String? name;
//   final String? iso3;
//   final String? iso2;
//   final String? phoneCode;
//   final String? capital;
//   final String? currency;
//   final String? native;
//   final String? emoji;
//   final String? emojiU;
//   final String? createdAt;
//
//   Country({
//     this.id,
//     this.name,
//     this.iso3,
//     this.iso2,
//     this.phoneCode,
//     this.capital,
//     this.currency,
//     this.native,
//     this.emoji,
//     this.emojiU,
//     this.createdAt,
//   });
//
//   Country.fromJson(Map<String, dynamic> json)
//       : id = json['id'] as int?,
//         name = json['name'] as String?,
//         iso3 = json['iso3'] as String?,
//         iso2 = json['iso2'] as String?,
//         phoneCode = json['phone_code'] as String?,
//         capital = json['capital'] as String?,
//         currency = json['currency'] as String?,
//         native = json['native'] as String?,
//         emoji = json['emoji'] as String?,
//         emojiU = json['emojiU'] as String?,
//         createdAt = json['created_at'] as String?;
//
//   Map<String, dynamic> toJson() => {
//     'id' : id,
//     'name' : name,
//     'iso3' : iso3,
//     'iso2' : iso2,
//     'phone_code' : phoneCode,
//     'capital' : capital,
//     'currency' : currency,
//     'native' : native,
//     'emoji' : emoji,
//     'emojiU' : emojiU,
//     'created_at' : createdAt
//   };
// }
//
// class State {
//   final int? id;
//   final String? name;
//   final int? countryId;
//   final String? countryCode;
//   final String? stateCode;
//
//   State({
//     this.id,
//     this.name,
//     this.countryId,
//     this.countryCode,
//     this.stateCode,
//   });
//
//   State.fromJson(Map<String, dynamic> json)
//       : id = json['id'] as int?,
//         name = json['name'] as String?,
//         countryId = json['country_id'] as int?,
//         countryCode = json['country_code'] as String?,
//         stateCode = json['state_code'] as String?;
//
//   Map<String, dynamic> toJson() => {
//     'id' : id,
//     'name' : name,
//     'country_id' : countryId,
//     'country_code' : countryCode,
//     'state_code' : stateCode
//   };
// }
//
// class City {
//   final int? id;
//   final String? name;
//   final int? stateId;
//   final String? stateCode;
//   final int? countryId;
//   final String? countryCode;
//   final String? latitude;
//   final String? longitude;
//
//   City({
//     this.id,
//     this.name,
//     this.stateId,
//     this.stateCode,
//     this.countryId,
//     this.countryCode,
//     this.latitude,
//     this.longitude,
//   });
//
//   City.fromJson(Map<String, dynamic> json)
//       : id = json['id'] as int?,
//         name = json['name'] as String?,
//         stateId = json['state_id'] as int?,
//         stateCode = json['state_code'] as String?,
//         countryId = json['country_id'] as int?,
//         countryCode = json['country_code'] as String?,
//         latitude = json['latitude'] as String?,
//         longitude = json['longitude'] as String?;
//
//   Map<String, dynamic> toJson() => {
//     'id' : id,
//     'name' : name,
//     'state_id' : stateId,
//     'state_code' : stateCode,
//     'country_id' : countryId,
//     'country_code' : countryCode,
//     'latitude' : latitude,
//     'longitude' : longitude
//   };
// }
//
// class EmployeeType {
//   final String? id;
//   final String? type;
//
//   EmployeeType({
//     this.id,
//     this.type,
//   });
//
//   EmployeeType.fromJson(Map<String, dynamic> json)
//       : id = json['id'] as String?,
//         type = json['type'] as String?;
//
//   Map<String, dynamic> toJson() => {
//     'id' : id,
//     'type' : type
//   };
// }

enum Agent { DART_31_DART_IO, GUZZLE_HTTP_7, POSTMAN_RUNTIME_7323 }

final agentValues = EnumValues({
  "Dart/3.1 (dart:io)": Agent.DART_31_DART_IO,
  "GuzzleHttp/7": Agent.GUZZLE_HTTP_7,
  "PostmanRuntime/7.32.3": Agent.POSTMAN_RUNTIME_7323
});

enum Method { POST }

final methodValues = EnumValues({"POST": Method.POST});

enum Subject { ASSETS_ADD, ASSETS_IMAGE_ADD, ASSET_ASSIGNED }

final subjectValues = EnumValues({
  "Assets add.": Subject.ASSETS_ADD,
  "Assets image add.": Subject.ASSETS_IMAGE_ADD,
  "Asset assigned.": Subject.ASSET_ASSIGNED
});

enum Name { ACTIVE }

final nameValues = EnumValues({"Active": Name.ACTIVE});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
