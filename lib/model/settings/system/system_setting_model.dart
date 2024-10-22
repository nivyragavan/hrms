class SystemSettingsListModel {
  final String? code;
  final String? message;
  final List<Data>? data;

  SystemSettingsListModel({
    this.code,
    this.message,
    this.data,
  });

  SystemSettingsListModel.fromJson(Map<String, dynamic> json)
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
  final int? branchId;
  final int? timezoneId;
  final TimezoneDateFormat? timezoneDateFormat;
  final String? firstDayOfWeek;
  final TimezoneTimeFormat? timezoneTimeFormat;
  final int? language;
  final Currency? currency;
  final int? createdBy;
  final String? createdAt;
  final String? updatedAt;
  final dynamic deletedAt;
  final Languages? languages;
  final Branch? branch;

  Data({
    this.id,
    this.branchId,
    this.timezoneId,
    this.timezoneDateFormat,
    this.firstDayOfWeek,
    this.timezoneTimeFormat,
    this.language,
    this.currency,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.languages,
    this.branch,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        branchId = json['branch_id'] as int?,
        timezoneId = json['timezone_id'] as int?,
        timezoneDateFormat = (json['timezone_date_format'] as Map<String,dynamic>?) != null ? TimezoneDateFormat.fromJson(json['timezone_date_format'] as Map<String,dynamic>) : null,
        firstDayOfWeek = json['first_day_of_week'] as String?,
        timezoneTimeFormat = (json['timezone_time_format'] as Map<String,dynamic>?) != null ? TimezoneTimeFormat.fromJson(json['timezone_time_format'] as Map<String,dynamic>) : null,
        language = json['language'] as int?,
        currency = (json['currency'] as Map<String,dynamic>?) != null ? Currency.fromJson(json['currency'] as Map<String,dynamic>) : null,
        createdBy = json['created_by'] as int?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        deletedAt = json['deleted_at'],
        languages = (json['languages'] as Map<String,dynamic>?) != null ? Languages.fromJson(json['languages'] as Map<String,dynamic>) : null,
        branch = (json['branch'] as Map<String,dynamic>?) != null ? Branch.fromJson(json['branch'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'branch_id' : branchId,
    'timezone_id' : timezoneId,
    'timezone_date_format' : timezoneDateFormat?.toJson(),
    'first_day_of_week' : firstDayOfWeek,
    'timezone_time_format' : timezoneTimeFormat?.toJson(),
    'language' : language,
    'currency' : currency?.toJson(),
    'created_by' : createdBy,
    'created_at' : createdAt,
    'updated_at' : updatedAt,
    'deleted_at' : deletedAt,
    'languages' : languages?.toJson(),
    'branch' : branch?.toJson()
  };
}

class TimezoneDateFormat {
  final int? id;
  final String? format;

  TimezoneDateFormat({
    this.id,
    this.format,
  });

  TimezoneDateFormat.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        format = json['format'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'format' : format
  };
}

class TimezoneTimeFormat {
  final int? id;
  final String? format;

  TimezoneTimeFormat({
    this.id,
    this.format,
  });

  TimezoneTimeFormat.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        format = json['format'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'format' : format
  };
}

class Currency {
  final int? id;
  final String? code;
  final String? name;
  final String? symbol;
  final dynamic description;
  final int? status;
  final dynamic orgId;
  final dynamic createdBy;
  final dynamic updatedBy;
  final dynamic createdAt;
  final dynamic updatedAt;
  final dynamic deletedAt;

  Currency({
    this.id,
    this.code,
    this.name,
    this.symbol,
    this.description,
    this.status,
    this.orgId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  Currency.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        code = json['code'] as String?,
        name = json['name'] as String?,
        symbol = json['symbol'] as String?,
        description = json['description'],
        status = json['status'] as int?,
        orgId = json['org_id'],
        createdBy = json['created_by'],
        updatedBy = json['updated_by'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'],
        deletedAt = json['deleted_at'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'code' : code,
    'name' : name,
    'symbol' : symbol,
    'description' : description,
    'status' : status,
    'org_id' : orgId,
    'created_by' : createdBy,
    'updated_by' : updatedBy,
    'created_at' : createdAt,
    'updated_at' : updatedAt,
    'deleted_at' : deletedAt
  };
}

class Languages {
  final int? id;
  final String? name;
  final String? description;
  final String? code;
  final int? status;
  final dynamic createdBy;
  final dynamic updatedBy;
  final String? createdAt;
  final dynamic updatedAt;
  final dynamic deletedAt;

  Languages({
    this.id,
    this.name,
    this.description,
    this.code,
    this.status,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  Languages.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        description = json['description'] as String?,
        code = json['code'] as String?,
        status = json['status'] as int?,
        createdBy = json['created_by'],
        updatedBy = json['updated_by'],
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'],
        deletedAt = json['deleted_at'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'description' : description,
    'code' : code,
    'status' : status,
    'created_by' : createdBy,
    'updated_by' : updatedBy,
    'created_at' : createdAt,
    'updated_at' : updatedAt,
    'deleted_at' : deletedAt
  };
}

class Branch {
  final int? id;
  final String? officeName;
  final String? officeFulladdress;
  final String? officeImage;
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
        officeImage = json['office_image'] as String?,
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