class AnnouncementJobPositionModel {
  final String? code;
  final String? message;
  final List<PositionData>? data;

  AnnouncementJobPositionModel({
    this.code,
    this.message,
    this.data,
  });

  AnnouncementJobPositionModel.fromJson(Map<String, dynamic> json)
      : code = json['code'] as String?,
        message = json['message'] as String?,
        data = (json['data'] as List?)?.map((dynamic e) => PositionData.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'code' : code,
    'message' : message,
    'data' : data?.map((e) => e.toJson()).toList()
  };
}

class PositionData {
  final int? id;
  final int? departmentId;
  final String? positionName;
  final int? grade;
  final String? createdAt;

  PositionData({
    this.id,
    this.departmentId,
    this.positionName,
    this.grade,
    this.createdAt,
  });

  PositionData.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        departmentId = json['department_id'] as int?,
        positionName = json['position_name'] as String?,
        grade = json['grade'] as int?,
        createdAt = json['created_at'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'department_id' : departmentId,
    'position_name' : positionName,
    'grade' : grade,
    'created_at' : createdAt
  };
}