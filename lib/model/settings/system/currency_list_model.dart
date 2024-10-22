class CurrencyListModel {
  final String? code;
  final String? message;
  final List<Data>? data;

  CurrencyListModel({
    this.code,
    this.message,
    this.data,
  });

  CurrencyListModel.fromJson(Map<String, dynamic> json)
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
  final String? code;
  final String? name;
  final String? symbol;
  final dynamic description;
  final int? status;
  final dynamic orgId;
  final dynamic createdBy;
  final dynamic updatedBy;
  final dynamic createdAt;
  final dynamic updatedAt;
  final dynamic deletedAt;

  Data({
    this.id,
    this.code,
    this.name,
    this.symbol,
    this.description,
    this.status,
    this.orgId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        code = json['code'] as String?,
        name = json['name'] as String?,
        symbol = json['symbol'] as String?,
        description = json['description'],
        status = json['status'] as int?,
        orgId = json['org_id'],
        createdBy = json['created_by'],
        updatedBy = json['updated_by'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'],
        deletedAt = json['deleted_at'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'code' : code,
    'name' : name,
    'symbol' : symbol,
    'description' : description,
    'status' : status,
    'org_id' : orgId,
    'created_by' : createdBy,
    'updated_by' : updatedBy,
    'created_at' : createdAt,
    'updated_at' : updatedAt,
    'deleted_at' : deletedAt
  };
}