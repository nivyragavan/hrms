class AssetGetCodeModel {
  final String? code;
  final String? message;
  final Data? data;

  AssetGetCodeModel({
    this.code,
    this.message,
    this.data,
  });

  AssetGetCodeModel.fromJson(Map<String, dynamic> json)
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
  final String? data;

  Data({
    this.data,
  });

  Data.fromJson(Map<String, dynamic> json)
      : data = json['data'] as String?;

  Map<String, dynamic> toJson() => {
    'data' : data
  };
}