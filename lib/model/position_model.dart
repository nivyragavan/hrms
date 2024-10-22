class PositionModel {
  final List<Data>? data;

  PositionModel({
    this.data,
  });

  PositionModel.fromJson(Map<String, dynamic> json)
      : data = (json['data'] as List?)?.map((dynamic e) => Data.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'data' : data?.map((e) => e.toJson()).toList()
  };
}

class Data {
  final String? departmentName;
  final String? departmentId;
  final String? departmentIcon;
  final String? status;
  final String? description;
  final String? empCount;
  final List<String>? profileImage;
  final List<Positions>? positions;

  Data({
    this.departmentName,
    this.departmentId,
    this.departmentIcon,
    this.status,
    this.description,
    this.empCount,
    this.profileImage,
    this.positions,
  });

  Data.fromJson(Map<String, dynamic> json)
      : departmentName = json['department_name'] as String?,
        departmentId = json['department_id'] as String?,
        departmentIcon = json['department_icon'] as String?,
        status = json['status'] as String?,
        description = json['description'] as String?,
        empCount = json['emp_count'] as String?,
        profileImage = (json['profile_image'] as List?)?.map((dynamic e) => e as String).toList(),
        positions = (json['positions'] as List?)?.map((dynamic e) => Positions.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'department_name' : departmentName,
    'department_id' : departmentId,
    'department_icon' : departmentIcon,
    'status' : status,
    'description' : description,
    'emp_count' : empCount,
    'profile_image' : profileImage,
    'positions' : positions?.map((e) => e.toJson()).toList()
  };
}

class Positions {
  final String? id;
  final String? positionName;
  final String? grade;

  Positions({
    this.id,
    this.positionName,
    this.grade,
  });

  Positions.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        positionName = json['position_name'] as String?,
        grade = json['grade'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'position_name' : positionName,
    'grade' : grade
  };
}