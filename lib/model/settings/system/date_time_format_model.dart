class DateTimeFormatListModel {
  final String? code;
  final String? message;
  final Data? data;

  DateTimeFormatListModel({
    this.code,
    this.message,
    this.data,
  });

  DateTimeFormatListModel.fromJson(Map<String, dynamic> json)
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
  final List<DateFormat>? dateFormat;
  final List<Timeformat>? timeformat;

  Data({
    this.dateFormat,
    this.timeformat,
  });

  Data.fromJson(Map<String, dynamic> json)
      : dateFormat = (json['date_format'] as List?)?.map((dynamic e) => DateFormat.fromJson(e as Map<String,dynamic>)).toList(),
        timeformat = (json['timeformat'] as List?)?.map((dynamic e) => Timeformat.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'date_format' : dateFormat?.map((e) => e.toJson()).toList(),
    'timeformat' : timeformat?.map((e) => e.toJson()).toList()
  };
}

class DateFormat {
  final String? id;
  final String? format;

  DateFormat({
    this.id,
    this.format,
  });

  DateFormat.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        format = json['format'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'format' : format
  };
}

class Timeformat {
  final String? id;
  final String? format;

  Timeformat({
    this.id,
    this.format,
  });

  Timeformat.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        format = json['format'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'format' : format
  };
}