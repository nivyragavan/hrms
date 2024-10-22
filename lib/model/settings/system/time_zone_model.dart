class TimeZoneListModel {
  final String? code;
  final String? message;
  final List<Data>? data;

  TimeZoneListModel({
    this.code,
    this.message,
    this.data,
  });

  TimeZoneListModel.fromJson(Map<String, dynamic> json)
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
  final String? timezoneName;
  final String? standardName;
  final int? utcOffset;
  final String? aliasName;
  final String? countryName;
  final int? status;
  final dynamic createdBy;
  final dynamic updatedBy;
  final String? createdAt;
  final String? updatedAt;
  final dynamic deletedAt;

  Data({
    this.id,
    this.timezoneName,
    this.standardName,
    this.utcOffset,
    this.aliasName,
    this.countryName,
    this.status,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        timezoneName = json['timezone_name'] as String?,
        standardName = json['standard_name'] as String?,
        utcOffset = json['utc_offset'] as int?,
        aliasName = json['alias_name'] as String?,
        countryName = json['country_name'] as String?,
        status = json['status'] as int?,
        createdBy = json['created_by'],
        updatedBy = json['updated_by'],
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        deletedAt = json['deleted_at'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'timezone_name' : timezoneName,
    'standard_name' : standardName,
    'utc_offset' : utcOffset,
    'alias_name' : aliasName,
    'country_name' : countryName,
    'status' : status,
    'created_by' : createdBy,
    'updated_by' : updatedBy,
    'created_at' : createdAt,
    'updated_at' : updatedAt,
    'deleted_at' : deletedAt
  };
}