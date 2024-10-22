class RoleModel {
  final String? code;
  final String? message;
  final Data1? data;

  RoleModel({
    this.code,
    this.message,
    this.data,
  });

  RoleModel.fromJson(Map<String, dynamic> json)
      : code = json['code'] as String?,
        message = json['message'] as String?,
        data = (json['data'] as Map<String,dynamic>?) != null ? Data1.fromJson(json['data'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'code' : code,
    'message' : message,
    'data' : data?.toJson()
  };
}

class Data1 {
  final List<Data>? data;

  Data1({
    this.data,
  });

  Data1.fromJson(Map<String, dynamic> json)
      : data = (json['data'] as List?)?.map((dynamic e) => Data.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'data' : data?.map((e) => e.toJson()).toList()
  };
}

class Data {
  final int? id;
  final String? name;
  final String? guardName;
  final String? createdAt;
  final String? updatedAt;

  Data({
    this.id,
    this.name,
    this.guardName,
    this.createdAt,
    this.updatedAt,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        guardName = json['guard_name'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'guard_name' : guardName,
    'created_at' : createdAt,
    'updated_at' : updatedAt
  };
}