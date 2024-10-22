class DashboardSettingsListModel {
  final String? code;
  final String? message;
  final Data1? data;

  DashboardSettingsListModel({
    this.code,
    this.message,
    this.data,
  });

  DashboardSettingsListModel.fromJson(Map<String, dynamic> json)
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
  final String? id;
  final String? type;
  final String? branchId;
  final String? roleId;
  final String? widgetId;
   String? status;
  final String? createdAt;

  Data({
    this.id,
    this.type,
    this.branchId,
    this.roleId,
    this.widgetId,
    this.status,
    this.createdAt,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        type = json['type'] as String?,
        branchId = json['branch_id'] as String?,
        roleId = json['role_id'] as String?,
        widgetId = json['widget_id'] as String?,
        status = json['status'] as String?,
        createdAt = json['created_at'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'type' : type,
    'branch_id' : branchId,
    'role_id' : roleId,
    'widget_id' : widgetId,
    'status' : status,
    'created_at' : createdAt
  };
}