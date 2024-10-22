import 'dart:convert';

BranchRadiusList BranchRadiusListFromJson(String str) =>
    BranchRadiusList.fromJson(json.decode(str));

String BranchRadiusListToJson(BranchRadiusList data) =>
    json.encode(data.toJson());

class BranchRadiusList {
  final String? code;
  final String? message;
  final List<Data>? data;

  BranchRadiusList({
    this.code,
    this.message,
    this.data,
  });

  BranchRadiusList.fromJson(Map<String, dynamic> json)
      : code = json['code'] as String?,
        message = json['message'] as String?,
        data = (json['data'] as List?)
            ?.map((dynamic e) => Data.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'code': code,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList()
      };
}

class Data {
  final String? id;
  final String? distance;

  Data({
    this.id,
    this.distance,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        distance = json['distance'] as String?;

  Map<String, dynamic> toJson() => {'id': id, 'distance': distance};
}
