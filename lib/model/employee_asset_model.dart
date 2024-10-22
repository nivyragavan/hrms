import '../screen/employee/asset_details/attachment.dart';

class EmployeeAssetModel {
  final String? code;
  final String? message;
  final Data1? data;

  EmployeeAssetModel({
    this.code,
    this.message,
    this.data,
  });

  EmployeeAssetModel.fromJson(Map<String, dynamic> json)
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
  final List<Data2>? data;

  Data1({
    this.data,
  });

  Data1.fromJson(Map<String, dynamic> json)
      : data = (json['data'] as List?)?.map((dynamic e) => Data2.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'data' : data?.map((e) => e.toJson()).toList()
  };
}

class Data2 {
  final Data? data;
  final Employee? employee;
  final AssignedBy? assignedBy;

  Data2({
    this.data,
    this.employee,
    this.assignedBy,
  });

  Data2.fromJson(Map<String, dynamic> json)
      : data = (json['data'] as Map<String,dynamic>?) != null ? Data.fromJson(json['data'] as Map<String,dynamic>) : null,
        employee = (json['employee'] as Map<String,dynamic>?) != null ? Employee.fromJson(json['employee'] as Map<String,dynamic>) : null,
        assignedBy = (json['assigned_by'] as Map<String,dynamic>?) != null ? AssignedBy.fromJson(json['assigned_by'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'data' : data?.toJson(),
    'employee' : employee?.toJson(),
    'assigned_by' : assignedBy?.toJson()
  };
}

class Data {
  final String? id;
  final String? assetId;
  final String? employeeId;
  final String? assignDate;
  final String? expectedReturnDate;
  final String? createdAt;
  final String? createdBy;
  final Asset? asset;

  Data({
    this.id,
    this.assetId,
    this.employeeId,
    this.assignDate,
    this.expectedReturnDate,
    this.createdAt,
    this.createdBy,
    this.asset,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        assetId = json['asset_id'] as String?,
        employeeId = json['employee_id'] as String?,
        assignDate = json['assign_date'] as String?,
        expectedReturnDate = json['expected_return_date'] as String?,
        createdAt = json['created_at'] as String?,
        createdBy = json['created_by'] as String?,
        asset = (json['asset'] as Map<String,dynamic>?) != null ? Asset.fromJson(json['asset'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'asset_id' : assetId,
    'employee_id' : employeeId,
    'assign_date' : assignDate,
    'expected_return_date' : expectedReturnDate,
    'created_at' : createdAt,
    'created_by' : createdBy,
    'asset' : asset?.toJson()
  };
}

class Asset {
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
  final dynamic attachment;

  Asset({
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
  });

  Asset.fromJson(Map<String, dynamic> json)
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
        attachment =json['attachment'] ;

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
    'attachment' : attachment
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

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'created_at' : createdAt
  };
}

class Employee {
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

  Employee({
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

  Employee.fromJson(Map<String, dynamic> json)
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




class AssignedBy {
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

  AssignedBy({
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

  AssignedBy.fromJson(Map<String, dynamic> json)
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