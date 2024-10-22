// To parse this JSON data, do
//
//     final branchListModel = branchListModelFromJson(jsonString);

import 'dart:convert';

BranchListModel branchListModelFromJson(String str) => BranchListModel.fromJson(json.decode(str));

String branchListModelToJson(BranchListModel data) => json.encode(data.toJson());

class BranchListModel {
  String? code;
  String? message;
  List<Datum>? data;

  BranchListModel({
    this.code,
    this.message,
    this.data,
  });

  factory BranchListModel.fromJson(Map<String, dynamic> json) => BranchListModel(
    code: json["code"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? id;
  String? officeName;
  String? officeFullAddress;
  dynamic officeImage;
  int? geofencingStatus;
  String? officeAddress;
  ClockLimitRadius? clockLimitRadius;
  int? allowArea;
  int? setHq;
  DateTime? createdAt;
  dynamic deletedAt;
  int? branchUserCount;
  dynamic latitude;
  dynamic longitude;

  Datum({
    this.id,
    this.officeName,
    this.officeFullAddress,
    this.officeImage,
    this.geofencingStatus,
    this.officeAddress,
    this.clockLimitRadius,
    this.allowArea,
    this.setHq,
    this.createdAt,
    this.deletedAt,
    this.branchUserCount,
    this.latitude,
    this.longitude
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    officeName: json["office_name"],
    officeFullAddress: json["office_fulladdress"],
    officeImage: json["office_image"],
    geofencingStatus: json["geofencing_status"],
    officeAddress: json["office_address"],
    clockLimitRadius: ClockLimitRadius.fromJson(json["clock_limit_radius"]),
    allowArea: json["allow_area"],
    setHq: json["set_hq"],
    createdAt: DateTime.parse(json["created_at"]),
    deletedAt: json["deleted_at"],
    branchUserCount: json["branch_user_count"],
    latitude: json["latitude"],
    longitude: json["longitude"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "office_name": officeName,
    "office_fulladdress": officeFullAddress,
    "office_image": officeImage,
    "geofencing_status": geofencingStatus,
    "office_address": officeAddress,
    "clock_limit_radius": clockLimitRadius?.toJson(),
    "allow_area": allowArea,
    "set_hq": setHq,
    "created_at": createdAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "branch_user_count": branchUserCount,
    "latitude": latitude,
    "longitude": longitude,
  };
}

class ClockLimitRadius {
  String? id;
  String? distance;

  ClockLimitRadius({
    this.id,
    this.distance,
  });

  factory ClockLimitRadius.fromJson(Map<String, dynamic> json) => ClockLimitRadius(
    id: json["id"],
    distance: json["distance"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "distance": distance,
  };
}
