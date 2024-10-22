class StateModel {
  final String? code;
  final String? message;
  final List<Data>? data;

  StateModel({
    this.code,
    this.message,
    this.data,
  });

  StateModel.fromJson(Map<String, dynamic> json)
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
  final int? countryId;
  final String? countryCode;
  final String? stateCode;

  Data({
    this.id,
    this.name,
    this.countryId,
    this.countryCode,
    this.stateCode,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        countryId = json['country_id'] as int?,
        countryCode = json['country_code'] as String?,
        stateCode = json['state_code'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'country_id' : countryId,
    'country_code' : countryCode,
    'state_code' : stateCode
  };
}