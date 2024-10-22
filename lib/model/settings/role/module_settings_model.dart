class ModulesRoleSettingsModel {
  final String? code;
  final String? message;
  final Data1? data;

  ModulesRoleSettingsModel({
    this.code,
    this.message,
    this.data,
  });

  ModulesRoleSettingsModel.fromJson(Map<String, dynamic> json)
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
  final int? createdBy;
   int? createId;
   int? viewId;
   int? deleteId;
   bool? create;
   bool? view;
   bool? delete;

  Data({
    this.id,
    this.name,
    this.createdBy,
    this.createId,
    this.viewId,
    this.deleteId,
    this.create,
    this.view,
    this.delete
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        createdBy = json['created_by'] as int?,
        createId = json['createId'] as int?,
        viewId = json['viewId'] as int?,
        deleteId = json['deleteId'] as int?,
        create = json['create'] != null ? json['create'] as bool : false,
        view = json['view'] != null ? json['view'] as bool : false,
      delete = json['delete'] != null ? json['delete'] as bool : false;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'created_by' : createdBy,
    'created_by' : createdBy,
    'createId' : createId,
    'viewId' : viewId,
    'deleteId' : deleteId,
    'create' : create,
    'view' : view,
    'delete' : delete,
  };
}