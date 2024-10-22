class CityModel {
  final String? code;
  final String? message;
  final List<Data>? data;

  CityModel({
    this.code,
    this.message,
    this.data,
  });

  CityModel.fromJson(Map<String, dynamic> json)
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
  final int? stateId;
  final String? stateCode;
  final int? countryId;
  final String? countryCode;
  final String? latitude;
  final String? longitude;

  Data({
    this.id,
    this.name,
    this.stateId,
    this.stateCode,
    this.countryId,
    this.countryCode,
    this.latitude,
    this.longitude,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        stateId = json['state_id'] ,
        stateCode = json['state_code'] as String?,
        countryId = json['country_id'] ,
        countryCode = json['country_code'] as String?,
        latitude = json['latitude'] as String?,
        longitude = json['longitude'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'state_id' : stateId,
    'state_code' : stateCode,
    'country_id' : countryId,
    'country_code' : countryCode,
    'latitude' : latitude,
    'longitude' : longitude
  };
}