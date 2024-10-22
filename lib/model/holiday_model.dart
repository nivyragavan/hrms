class HolidayListModel {
  final String? code;
  final String? message;
  final List<Data>? data;

  HolidayListModel({
    this.code,
    this.message,
    this.data,
  });

  HolidayListModel.fromJson(Map<String, dynamic> json)
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
  final String? holidayName;
  final String? holidayDate;
  // final String? createdAt;
  // final String? updatedAt;
  // final dynamic deletedAt;
  // final int? createdBy;
  // final dynamic updatedBy;
  // final dynamic deletedBy;
  final String? day;

  Data({
    this.id,
    this.holidayName,
    this.holidayDate,
    // this.createdAt,
    // this.updatedAt,
    // this.deletedAt,
    // this.createdBy,
    // this.updatedBy,
    // this.deletedBy,
    this.day,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        holidayName = json['holiday_name'] as String?,
        holidayDate = json['holiday_date'] as String?,
        // createdAt = json['created_at'] as String?,
        // updatedAt = json['updated_at'] as String?,
        // deletedAt = json['deleted_at'],
        // createdBy = json['created_by'] as int?,
        // updatedBy = json['updated_by'],
        // deletedBy = json['deleted_by'],
        day = json['day'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'holiday_name' : holidayName,
    'holiday_date' : holidayDate,
    // 'created_at' : createdAt,
    // 'updated_at' : updatedAt,
    // 'deleted_at' : deletedAt,
    // 'created_by' : createdBy,
    // 'updated_by' : updatedBy,
    // 'deleted_by' : deletedBy,
    'day' : day
  };
}