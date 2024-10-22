import '../../employee_list_model.dart';

class CompanySettingsListModel {
  final String? code;
  final String? message;
  final Data? data;

  CompanySettingsListModel({
    this.code,
    this.message,
    this.data,
  });

  CompanySettingsListModel.fromJson(Map<String, dynamic> json)
      : code = json['code'] as String?,
        message = json['message'] as String?,
        data = json['data'] != null && json['data']!=[] && json['data'] is List ? null: Data.fromJson(json['data']);

  Map<String, dynamic> toJson() => {
    'code' : code,
    'message' : message,
    'data' : data?.toJson()
  };
}

class Data {
  final int? id;
  final int? branchId;
  final String? companyName;
  final String? companyLogo;
  final String? legalName;
  final dynamic website;
  final dynamic registration;
  final String? address;
  final Country? country;
  final State? state;
  final City? city;
  final int? postalCode;
  final String? email;
  final String? phoneNumber;
  final String? mobileNumber;
  final dynamic fax;
  final String? status;
  final int? createdBy;
  final String? createdAt;
  final String? updatedAt;
  final dynamic deletedAt;
  final dynamic updatedBy;
  final OwnerDetails? ownerDetails;
  final Branch? branch;
  final List<Schedule>? schedule;

  Data({
    this.id,
    this.branchId,
    this.companyName,
    this.companyLogo,
    this.legalName,
    this.website,
    this.registration,
    this.address,
    this.country,
    this.state,
    this.city,
    this.postalCode,
    this.email,
    this.phoneNumber,
    this.mobileNumber,
    this.fax,
    this.status,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.updatedBy,
    this.ownerDetails,
    this.branch,
    this.schedule,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        branchId = json['branch_id'] as int?,
        companyName = json['company_name'] as String?,
        companyLogo = json['company_logo'] as String?,
        legalName = json['legal_name'] as String?,
        website = json['website'],
        registration = json['registration'],
        address = json['address'] as String?,
        country = Country.fromJson(json['country'] as Map<String,dynamic>),
        state = (json['state'] as Map<String,dynamic>?) != null ? State.fromJson(json['state'] as Map<String,dynamic>) : null,
        city = (json['city'] as Map<String,dynamic>?) != null ? City.fromJson(json['city'] as Map<String,dynamic>) : null,
        postalCode = json['postal_code'] as int?,
        email = json['email'] as String?,
        phoneNumber = json['phone_number'] as String?,
        mobileNumber = json['mobile_number'] as String?,
        fax = json['fax'],
        status = json['status'] as String?,
        createdBy = json['created_by'] as int?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        deletedAt = json['deleted_at'],
        updatedBy = json['updated_by'],
        ownerDetails = (json['owner_details'] as Map<String,dynamic>?) != null ? OwnerDetails.fromJson(json['owner_details'] as Map<String,dynamic>) : null,
        branch = (json['branch'] as Map<String,dynamic>?) != null ? Branch.fromJson(json['branch'] as Map<String,dynamic>) : null,
        schedule = (json['schedule'] as List?)?.map((dynamic e) => Schedule.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'id' : id,
    'branch_id' : branchId,
    'company_name' : companyName,
    'company_logo' : companyLogo,
    'legal_name' : legalName,
    'website' : website,
    'registration' : registration,
    'address' : address,
    'country' : country?.toJson(),
    'state' : state?.toJson(),
    'city' : city?.toJson(),
    'postal_code' : postalCode,
    'email' : email,
    'phone_number' : phoneNumber,
    'mobile_number' : mobileNumber,
    'fax' : fax,
    'status' : status,
    'created_by' : createdBy,
    'created_at' : createdAt,
    'updated_at' : updatedAt,
    'deleted_at' : deletedAt,
    'updated_by' : updatedBy,
    'owner_details' : ownerDetails?.toJson(),
    'branch' : branch?.toJson(),
    'schedule' : schedule?.map((e) => e.toJson()).toList()
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

class OwnerDetails {
  final int? id;
  final String? domain;
  final String? tenantId;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? jobTitle;
  final String? phoneNumber;
  final dynamic address;
  final String? employeeCount;
  final int? countryId;
  final String? createdAt;
  final String? updatedAt;
  final dynamic deletedAt;
  final int? createdBy;
  final dynamic updatedBy;
  final dynamic deletedBy;

  OwnerDetails({
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

  OwnerDetails.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        domain = json['domain'] as String?,
        tenantId = json['tenant_id'] as String?,
        firstName = json['first_name'] as String?,
        lastName = json['last_name'] as String?,
        email = json['email'] as String?,
        jobTitle = json['job_title'] as String?,
        phoneNumber = json['phone_number'] as String?,
        address = json['address'],
        employeeCount = json['employee_count'] as String?,
        countryId = json['country_id'] as int?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        deletedAt = json['deleted_at'],
        createdBy = json['created_by'] as int?,
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

class Branch {
  final int? id;
  final String? officeName;
  final String? officeFulladdress;
  final dynamic officeImage;
  final int? geofencingStatus;
  final String? officeAddress;
  final ClockLimitRadius? clockLimitRadius;
  final int? allowArea;
  final int? setHq;
  final String? createdAt;
  final dynamic deletedAt;

  Branch({
    this.id,
    this.officeName,
    this.officeFulladdress,
    this.officeImage,
    this.geofencingStatus,
    this.officeAddress,
    this.clockLimitRadius,
    this.allowArea,
    this.setHq,
    this.createdAt,
    this.deletedAt,
  });

  Branch.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        officeName = json['office_name'] as String?,
        officeFulladdress = json['office_fulladdress'] as String?,
        officeImage = json['office_image'],
        geofencingStatus = json['geofencing_status'] as int?,
        officeAddress = json['office_address'] as String?,
        clockLimitRadius = (json['clock_limit_radius'] as Map<String,dynamic>?) != null ? ClockLimitRadius.fromJson(json['clock_limit_radius'] as Map<String,dynamic>) : null,
        allowArea = json['allow_area'] as int?,
        setHq = json['set_hq'] as int?,
        createdAt = json['created_at'] as String?,
        deletedAt = json['deleted_at'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'office_name' : officeName,
    'office_fulladdress' : officeFulladdress,
    'office_image' : officeImage,
    'geofencing_status' : geofencingStatus,
    'office_address' : officeAddress,
    'clock_limit_radius' : clockLimitRadius?.toJson(),
    'allow_area' : allowArea,
    'set_hq' : setHq,
    'created_at' : createdAt,
    'deleted_at' : deletedAt
  };
}

class ClockLimitRadius {
  final String? id;
  final String? distance;

  ClockLimitRadius({
    this.id,
    this.distance,
  });

  ClockLimitRadius.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        distance = json['distance'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'distance' : distance
  };
}

class Schedule {
  final int? id;
  final int? companyId;
  final String? days;
  final String? customHours;
  final String? startTime;
  final String? endTime;
  final String? workingHrs;
  final String? createdAt;
  final String? updatedAt;
  final dynamic deletedAt;

  Schedule({
    this.id,
    this.companyId,
    this.days,
    this.customHours,
    this.startTime,
    this.endTime,
    this.workingHrs,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  Schedule.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        companyId = json['company_id'] as int?,
        days = json['days'] as String?,
        customHours = json['custom_hours'] as String?,
        startTime = json['start_time'] as String?,
        endTime = json['end_time'] as String?,
        workingHrs = json['working_hrs'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        deletedAt = json['deleted_at'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'company_id' : companyId,
    'days' : days,
    'custom_hours' : customHours,
    'start_time' : startTime,
    'end_time' : endTime,
    'working_hrs' : workingHrs,
    'created_at' : createdAt,
    'updated_at' : updatedAt,
    'deleted_at' : deletedAt
  };
}