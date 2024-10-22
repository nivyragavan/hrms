import 'dart:convert';

TaskTypeModel taskTypeModelFromJson(String str) => TaskTypeModel.fromJson(json.decode(str));

String taskTypeModelToJson(TaskTypeModel data) => json.encode(data.toJson());

class TaskTypeModel {
  String? code;
  String? message;
  Data? data;

  TaskTypeModel({
    this.code,
    this.message,
    this.data,
  });

  factory TaskTypeModel.fromJson(Map<String, dynamic> json) => TaskTypeModel(
    code: json["code"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  List<Datum>? data;

  Data({
    this.data,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? id;
  String? type;

  Datum({
    this.id,
    this.type,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
  };
}
