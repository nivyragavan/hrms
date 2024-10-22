class GradeModel {
  final String? code;
  final String? message;
  final List<Data>? data;

  GradeModel({
    this.code,
    this.message,
    this.data,
  });

  GradeModel.fromJson(Map<String, dynamic> json)
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
  final String? gradeName;

  Data({
    this.id,
    this.gradeName,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        gradeName = json['grade_name'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'grade_name' : gradeName
  };
}