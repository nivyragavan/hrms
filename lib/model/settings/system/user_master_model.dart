class UserMasterModel {
  final String? code;
  final String? message;
  final List<Data>? data;

  UserMasterModel({
    this.code,
    this.message,
    this.data,
  });

  UserMasterModel.fromJson(Map<String, dynamic> json)
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
  final dynamic shiftId;
  final dynamic reportingToId;
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

  Data({
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

  Data.fromJson(Map<String, dynamic> json)
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
        shiftId = json['shift_id'],
        reportingToId = json['reporting_to_id'],
        role = json['role'] as int?,
        mobileNumber = json['mobile_number'] as String?,
        inviteRef = json['invite_ref'],
        employeeType = (json['employee_type'] as Map<String,dynamic>?) != null ? EmployeeType.fromJson(json['employee_type'] as Map<String,dynamic>) : null,
        status = json['status'] as int?,
        import = json['import'] as int?,
        createdAt = json['created_at'] as String?,
        deviceToken = json['device_token'] as String?,
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