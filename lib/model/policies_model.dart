class PoliciesListModel {
  final String? code;
  final String? message;
  final List<Data>? data;

  PoliciesListModel({
    this.code,
    this.message,
    this.data,
  });

  PoliciesListModel.fromJson(Map<String, dynamic> json)
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
  final String? name;
  final String? description;
  final List<Department>? department;
  final String? attachment;
  final String? createdAt;
  final String? updatedAt;
  final dynamic deletedAt;
  final dynamic createdBy;
  final int? updatedBy;
  final dynamic deletedBy;

  Data({
    this.id,
    this.name,
    this.description,
    this.department,
    this.attachment,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        description = json['description'] as String?,
        department = (json['department'] as List?)?.map((dynamic e) => Department.fromJson(e as Map<String,dynamic>)).toList(),
        attachment = json['attachment'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        deletedAt = json['deleted_at'],
        createdBy = json['created_by'],
        updatedBy = json['updated_by'] as int?,
        deletedBy = json['deleted_by'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'description' : description,
    'department' : department?.map((e) => e.toJson()).toList(),
    'attachment' : attachment,
    'created_at' : createdAt,
    'updated_at' : updatedAt,
    'deleted_at' : deletedAt,
    'created_by' : createdBy,
    'updated_by' : updatedBy,
    'deleted_by' : deletedBy
  };
}

class Department {
  final int? id;
  final String? departmentName;
  final String? description;
  final String? departmentIcon;
  final int? status;
  final String? createdAt;

  Department({
    this.id,
    this.departmentName,
    this.description,
    this.departmentIcon,
    this.status,
    this.createdAt,
  });

  Department.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        departmentName = json['department_name'] as String?,
        description = json['description'] as String?,
        departmentIcon = json['department_icon'] as String?,
        status = json['status'] as int?,
        createdAt = json['created_at'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'department_name' : departmentName,
    'description' : description,
    'department_icon' : departmentIcon,
    'status' : status,
    'created_at' : createdAt
  };
}