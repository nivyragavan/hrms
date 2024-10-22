class AssetColumnListModel {
  final String? code;
  final String? message;
  final Data? data;

  AssetColumnListModel({
    this.code,
    this.message,
    this.data,
  });

  AssetColumnListModel.fromJson(Map<String, dynamic> json)
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
  final List<String>? data;

  Data({
    this.data,
  });

  Data.fromJson(Map<String, dynamic> json)
      : data = (json['data'] as List?)?.map((dynamic e) => e as String).toList();

  Map<String, dynamic> toJson() => {
    'data' : data
  };
}