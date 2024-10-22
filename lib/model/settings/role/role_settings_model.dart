// To parse this JSON data, do
//
//     final roleSettingsListModel = roleSettingsListModelFromJson(jsonString);

import 'dart:convert';

RoleSettingsListModel roleSettingsListModelFromJson(String str) => RoleSettingsListModel.fromJson(json.decode(str));

String roleSettingsListModelToJson(RoleSettingsListModel data) => json.encode(data.toJson());

class RoleSettingsListModel {
  String? code;
  String? message;
  RoleSettingsListModelData? data;

  RoleSettingsListModel({
    this.code,
    this.message,
    this.data,
  });

  factory RoleSettingsListModel.fromJson(Map<String, dynamic> json) => RoleSettingsListModel(
    code: json["code"],
    message: json["message"],
    data: RoleSettingsListModelData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data?.toJson(),
  };
}

class RoleSettingsListModelData {
  DataData? data;

  RoleSettingsListModelData({
    this.data,
  });

  factory RoleSettingsListModelData.fromJson(Map<String, dynamic> json) => RoleSettingsListModelData(
    data: json["data"]==[]?json["data"]:DataData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class DataData {
  String? overallPermissionCount;
  List<ListElement>? list;

  DataData({
    this.overallPermissionCount,
    this.list,
  });

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
    overallPermissionCount: json["overall_permission_count"],
    list: List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "overall_permission_count": overallPermissionCount,
    "list": List<dynamic>.from(list!.map((x) => x.toJson())),
  };
}

class ListElement {
  int? id;
  String? name;
  String? guardName;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? permissionsCount;
  List<Permission>? permissions;

  ListElement({
    this.id,
    this.name,
    this.guardName,
    this.createdAt,
    this.updatedAt,
    this.permissionsCount,
    this.permissions,
  });

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    id: json["id"],
    name: json["name"],
    guardName: json["guard_name"],//guardNameValues.map[json["guard_name"]],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    permissionsCount: json["permissions_count"],
    permissions: List<Permission>.from(json["permissions"].map((x) => Permission.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "guard_name":guardName,// guardNameValues.reverse[guardName],
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "permissions_count": permissionsCount,
    "permissions": List<dynamic>.from(permissions!.map((x) => x.toJson())),
  };
}

enum GuardName {
  API
}

final guardNameValues = EnumValues({
  "api": GuardName.API
});

class Permission {
  int? id;
  int? moduleId;
  String? name;
  GuardName? guardName;
  DateTime? createdAt;
  DateTime? updatedAt;
  Pivot? pivot;

  Permission({
    this.id,
    this.moduleId,
    this.name,
    this.guardName,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  factory Permission.fromJson(Map<String, dynamic> json) => Permission(
    id: json["id"],
    moduleId: json["module_id"],
    name: json["name"],
    guardName: guardNameValues.map[json["guard_name"]],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"]==null?json["updated_at"]:DateTime.parse(json["updated_at"]),
    pivot: json["pivot"]==null?json["pivot"]:Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "module_id": moduleId,
    "name": name,
    "guard_name": guardNameValues.reverse[guardName],
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "pivot": pivot?.toJson(),
  };
}

class Pivot {
  int? roleId;
  int? permissionId;

  Pivot({
    this.roleId,
    this.permissionId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    roleId: json["role_id"],
    permissionId: json["permission_id"],
  );

  Map<String, dynamic> toJson() => {
    "role_id": roleId,
    "permission_id": permissionId,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
